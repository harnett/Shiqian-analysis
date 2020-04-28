function plotResults(results_datafile_path)
    % load datafile and extract data
    try
        [fName, fPath] = uigetfile('.sig', 'Please select file containing imaging data.');
    catch
        waitfor(msgbox('Error: Please select valid .sig file.'));
        error('Please select valid .sig file.');
    end
    fName = strtok(fName, '.');
    sigfile = strcat(fPath, fName, '.sig');
%     dfffile = strcat(fPath, fName, '.dff');
    extrafile = strcat(fPath, fName, '.extra');
%     
%     sigfile = [results_datafile_path,'.sig'];
%     dfffile = [results_datafile_path,'.dff'];
%     extrafile = [results_datafile_path,'.extra'];

%     dff = calculateDFF(roiFluorescences);

    roiFluorescences = load(sigfile);
    load(extrafile, '-mat');
    
    roiFluorescences = roiFluorescences(:,1:(size(roiFluorescences,2)/2)); % crop neuropil columns
    dff = calculateDFF(roiFluorescences);

    num_transients = zeros((size(dff,2)),1);
    
    figure;
    ax2 = subplot(523);
    
    
    roi_transients = {};
    std_threshold = 6;
    for i=1:size(dff,2)
        roi_std = nanstd(dff(dff(:,i) < prctile(dff(:,i),50),i));
        roi_mean = nanmean(dff(dff(:,i) < prctile(dff(:,i),50),i));
        transient_high = find(dff(:,i) > (std_threshold*roi_std)+roi_mean);
        
        idx_diff = diff(transient_high);
        idx_diff = vertcat(1,idx_diff);

        gap_tolerance_frames = 3;
        min_transient_length = 5;

        onset_idx = transient_high(idx_diff>gap_tolerance_frames)-1;
        offset_idx = transient_high(find(idx_diff>gap_tolerance_frames)-1)+1;
        offset_idx = circshift(offset_idx,-1);
        
        % calculate the length of each transient and reject those too short to be considered
        index_adjust = 0;
        for j=1:size(onset_idx,1)
            temp_length = offset_idx(j-index_adjust) - onset_idx(j-index_adjust);
            if temp_length < min_transient_length
                onset_idx(j-index_adjust) = [];
                offset_idx(j-index_adjust) = [];
                index_adjust = index_adjust + 1;
            end
        end
        
        roi_transients{end+1} = [onset_idx, offset_idx];
        
        num_transients(i) = size(onset_idx,1);
    
        plot(1:size(dff,1),dff(:,i), 'LineStyle','-','Color','k');
        if size(onset_idx) > 0
            hold on;
            for j=1:size(onset_idx,1)
                plot(onset_idx(j):offset_idx(j),dff(onset_idx(j):offset_idx(j),i),'Color','r');
            end
            hold off;
        end

    end
    
    % calculate how many rois are active concurrently at any given time
    active_rois = zeros(size(dff,1),1);
    for i=1:size(dff,1)
        for j=1:size(roi_transients,2)
            for k=1:size(roi_transients{j},1)
                cur_transient = roi_transients{j};
                if size(cur_transient) > 0
                    transient_idx = cur_transient(k,1):cur_transient(k,2);
                    is_active = find(transient_idx == i, 1);
                    if ~isempty(is_active)
                        active_rois(i) = active_rois(i) + 1;
                    end
                end
            end
        end
    end
    ylabel('dF/F');
    
    
    
    active_rois = (active_rois ./ size(dff,2)) * 100;
    ax8 = subplot(5,2,10);
    hold on;
    idx_high = find(active_rois > 30);
    for i=1:size(idx_high,1)
        plot([idx_high(i),idx_high(i)], [1,100], 'Color','g');
    end
    plot(1:size(active_rois,1), active_rois, 'LineWidth',2, 'Color','r');
    hold off;
    xlim([0 size(dff,1)]);
    
    disp(size(idx_high));
    
    mean_FOV_brigthness = mean(meanBrightness);
    std_FOV_brightness = std(meanBrightness);

    mean_shifts_x = mean(mean(shifts_x));
    std_shifts_x = mean(std(shifts_x));

    mean_shifts_y = mean(mean(shifts_y));
    std_shifts_y = mean(std(shifts_y));

    brightness_shift_std = 3;
    registration_shift_std = 3;
    min_num_shifts = size(shifts_x) * 0.5;
    min_num_shifts = min_num_shifts(2);
    
    
    ax1 = subplot(521);
    plot(roiFluorescences(2:end,:));
    ylabel('ROI brightness');
    
    ax3 = subplot(525);
    plot(meanBrightness(2:end));
    ylabel('FOV brightness');
    yline(mean_FOV_brigthness-brightness_shift_std*std_FOV_brightness, '--');
    ax4 = subplot(527);
    plot(shifts_x(2:end,:));
    yline(mean_shifts_x - registration_shift_std*std_shifts_x, '--');
    yline(mean_shifts_x + registration_shift_std*std_shifts_x, '--');
    ylabel('shifts x');
    ax5 = subplot(529);
    plot(shifts_y(2:end,:));
    ylabel('shifts y');
    yline(mean_shifts_y - registration_shift_std*std_shifts_y, '--');
    yline(mean_shifts_y + registration_shift_std*std_shifts_y, '--');
    linkaxes([ax1,ax3,ax4,ax5],'x');
    ax6 = subplot(5,2,[2,4,6]);
    ax6 = heatmap(transpose(dff),'GridVisible','off','Colormap',parula);
    
    x_tl = num2cell(linspace(1,size(dff,1),size(dff,1)))';
    for i=1:1:length(x_tl)
        if ~mod(i,500) == 0
            x_tl{i} = {''};
        end
    end
    ax6.XDisplayLabels = x_tl;
    
    y_tl = num2cell(linspace(1,size(dff,2),size(dff,2)))';
    for i=1:1:length(y_tl)
        if ~mod(i,5) == 0
            y_tl{i} = {''};
        end
    end
    ax6.YDisplayLabels = y_tl;
    
    
    
    caxis([0,max(max(dff))]);
    ylabel('ROI #');
    xlabel('FRAME #');
    ax7 = subplot(5,2,8);
    plot(mean(dff.'));
    ylabel('mean DF/F');
    xlabel('FRAME #');
    
    xlim([0 size(dff,1)]);
    
end