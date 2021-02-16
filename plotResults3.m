function plotResults2(varargin)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% CHANGE ANALYSIS PARAMETERS BELOW %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % threshold defining how many neurons in % of total have to be active simultaneously for something to be considered a 'global event'
    GUIHandles.event_threshold = 0.4;
    
    % define how many transients a neuron has to have at least to be included in the results
    GUIHandles.transient_num_threshold = 5;
    
    % number of standard deviations above the mean the signal has to be to be detected as a transient (among some other parameters)
    GUIHandles.transient_baseline_percentile = 20;
    GUIHandles.std_threshold = 6;           % number of standard deviations outside which a datapoint has to lie to be considered part of a transient
    GUIHandles.gap_tolerance_frames = 3;    % if two transiensts are less than gap_tolerance_frames apart, they will be joined into one transient
    GUIHandles.min_transient_length = 3;    % minimum number of datapoints a transient has to be long to be included in the results
    
    % data acquisition rate. This might be something we want to be able to change later
    GUIHandles.fs = 5.5; % Hz

    % lowpass filter cutoff (you have to re-loead the .sig file for this to take effect)
    GUIHandles.lowpass_filter_cutoff = 0.3;
    
    % linewidth for traces
    GUIHandles.trace_linewidth = 1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% IN-DEPTH PARAMETERS %%%
    
    % parameter defining by which amount we weigh the neuropil to be subtracted from the roi signal
    GUIHandles.neuropil_weight = 0.8;
    
    
    
    % Create main window.
    GUI = figure('Units', 'Normalized', 'Position', [0.1,0.2,0.8,0.7]);
    % button to load dataset
    GUIHandles.loadButton = uicontrol('Style', 'pushbutton', 'String', 'Load .sig or .mat File', 'Units', 'normalized', 'Position', [0.01, 0.9, 0.1, 0.05], 'Callback', @load_experiment); 
    % provide some status feedback
    GUIHandles.statusText = uicontrol('Style', 'text', 'String', 'Please load .sig or .mat file.', 'HorizontalAlignment','left', 'Units', 'normalized', 'Position', [0.01, 0.01, 0.98, 0.03]); 
    % axis object for fluorescence/dff traces
    GUIHandles.roiTrace = axes('Parent',GUI, 'Units', 'Normalized', 'Visible','off','Position', [0.04, 0.64, 0.4, 0.26]);
    GUIHandles.FOVBrightness = axes('Units', 'Normalized', 'Visible','off','Position', [0.04, 0.1, 0.4, 0.16]);
    GUIHandles.roiAUC = axes('Parent',GUI, 'Units', 'Normalized', 'Visible','off','Position', [0.04, 0.33, 0.18, 0.24]);
    GUIHandles.dffvfrac = axes('Parent',GUI, 'Units', 'Normalized', 'Visible','off','Position', [0.26, 0.33, 0.18, 0.24]);
    
    GUIHandles.roi_heatmap = axes('Parent',GUI,'Visible','off','Position',[0.5 0.5 0.47 0.432]);
    GUIHandles.meanRoidff = axes('Units', 'Normalized', 'Visible','off','Position', [0.5, 0.28, 0.47, 0.15]);
    GUIHandles.coordEventProb = axes('Units', 'Normalized', 'Visible','off','Position', [0.5, 0.1, 0.47, 0.15]);
    xticklabels(GUIHandles.meanRoidff, {});
    
    % set start and stop frames
    GUIHandles.startLabel = uicontrol('Style', 'text', 'Visible','off', 'String', 'Start Frame:', 'HorizontalAlignment','left', 'Units', 'normalized', 'Position', [0.01, 0.96, 0.055, 0.03]); 
    GUIHandles.startEdit = uicontrol('Style', 'edit', 'Visible','off', 'String', '', 'BackgroundColor','w', 'HorizontalAlignment','center', 'Units', 'normalized', 'Position', [0.06, 0.96, 0.03, 0.03], 'Callback', @update_frame_limits);  
    GUIHandles.stopLabel = uicontrol('Style', 'text', 'Visible','off', 'String', 'Stop Frame:', 'HorizontalAlignment','left', 'Units', 'normalized', 'Position', [0.1, 0.96, 0.06, 0.03]); 
    GUIHandles.stopEdit = uicontrol('Style', 'edit', 'Visible','off', 'String', '', 'BackgroundColor','w', 'HorizontalAlignment','center', 'Units', 'normalized', 'Position', [0.155, 0.96, 0.03, 0.03], 'Callback', @update_frame_limits);  
    GUIHandles.updateView = uicontrol('Style', 'pushbutton', 'Visible','off', 'String', 'Update Plot', 'Units', 'normalized', 'Position', [0.76, 0.94, 0.07, 0.05], 'Callback', @update_plots); 
    GUIHandles.resetView = uicontrol('Style', 'pushbutton', 'Visible','off', 'String', 'Reset Plot', 'Units', 'normalized', 'Position', [0.69, 0.94, 0.07, 0.05], 'Callback', @reset_plots); 
    
    GUIHandles.roiListLabel = uicontrol('Style', 'text', 'Visible','off', 'String', 'Exclude ROI:', 'HorizontalAlignment','left', 'Units', 'normalized', 'Position', [0.5, 0.96, 0.06, 0.03]);  
    GUIHandles.roiList = uicontrol('Style', 'edit', 'Visible','off', 'String', 'all', 'BackgroundColor','w', 'HorizontalAlignment','left', 'Units', 'normalized', 'Position', [0.553, 0.96, 0.1, 0.03]);  
    
    % set min and max y
    GUIHandles.minYLabel = uicontrol('Style', 'text', 'Visible','off', 'String', 'min. Y:', 'HorizontalAlignment','left', 'Units', 'normalized', 'Position', [0.21, 0.96, 0.055, 0.03]); 
    GUIHandles.minYEdit = uicontrol('Style', 'edit', 'Visible','off', 'Enable', 'off', 'String', '', 'BackgroundColor','w', 'HorizontalAlignment','center', 'Units', 'normalized', 'Position', [0.243, 0.96, 0.04, 0.03], 'Callback', @fix_limits);  
    GUIHandles.maxYLabel = uicontrol('Style', 'text', 'Visible','off', 'String', 'max. Y:', 'HorizontalAlignment','left', 'Units', 'normalized', 'Position', [0.285, 0.96, 0.06, 0.03]); 
    GUIHandles.maxYEdit = uicontrol('Style', 'edit', 'Visible','off',  'Enable', 'off', 'String', '', 'BackgroundColor','w', 'HorizontalAlignment','center', 'Units', 'normalized', 'Position', [0.32, 0.96, 0.04, 0.03], 'Callback', @fix_limits);
    GUIHandles.yEditCheckbox = uicontrol('Style', 'checkbox', 'Visible','off', 'String', 'Fix Y Scale', 'HorizontalAlignment','center', 'Units', 'normalized', 'Position', [0.36, 0.96, 0.08, 0.03], 'Callback', @fix_limits);
    
    % toggle low-pass filtering of signal
    GUIHandles.filterCheckbox = uicontrol('Style', 'checkbox', 'Visible','off', 'String', 'Filter', 'HorizontalAlignment','center', 'Units', 'normalized', 'Position', [0.43, 0.96, 0.06, 0.03], 'Callback', @filter_signal);
    
    % button to analyse results
%     GUIHandles.showResults = uicontrol('Style', 'pushbutton', 'Visible','off','String', 'Save Results', 'Units', 'normalized', 'Position', [0.872, 0.94, 0.1, 0.05], 'Callback', @show_results); 
    
    % button to analyze video
    GUIHandles.analyzeAUC = uicontrol('Style', 'pushbutton', 'Visible','off','String', 'AUC', 'Units', 'normalized', 'Position', [0.912, 0.94, 0.04, 0.05], 'Callback', @analyze_AUC); 
    GUIHandles.analyzeCORR = uicontrol('Style', 'pushbutton', 'Visible','off','String', 'CORR', 'Units', 'normalized', 'Position', [0.872, 0.94, 0.04, 0.05], 'Callback', @analyze_CORR); 
    
    % keep track of start and stop frame
    GUIHandles.startFrame = 1;
    GUIHandles.stopFrame = 1;
    
    % keep track of min and max Y-Limits
    GUIHandles.minY = 0;
    GUIHandles.maxY = 0;
    
    % percentile of datapoints used to calculate baseline for df/f 
    GUIHandles.baseline_percentile = 5;   
    
    % flag indicating whether to plot the real or smoothed data
    GUIHandles.showFiltered = false;
    
    % list of rois excluded from analysis
    GUIHandles.exc_rois = [];
    
    guidata(GUI, GUIHandles);
end

function load_experiment(GUI, ~)
    % this loads data that is stored as part of the GUI so it can be used in different functions.
    GUIHandles = guidata(GUI);
    
    % load datafile
    try
        [fPath,fName] = uigetfile({'*.mat;*.sig'}, 'Please select file containing imaging data.');
    catch
        waitfor(msgbox('Error: Please select valid .sig or .mat file.'));
        error('Please select valid .sig or .mat file.');
    end
    
    if fName ~= 0 
        GUIHandles.statusText.String = 'Loading data...';
        pause(0.001);  
        full_path = strcat(fName,fPath);
        [fPath,fName,fType] = fileparts(full_path);
        fPath = strcat(fPath, filesep);
        
        % check if a analyzed or raw fluorescence file has been selected by the user
        if strcmp(fType,'.mat')
            % load analyzed data
            GUIHandles.statusText.String = 'Loading analyzed data...';
            pause(0.001);
            loaded_data = load(full_path, '-mat');
            GUIHandles.dff = loaded_data.dff_temp;
            GUIHandles.dff_filtered = loaded_data.dff_filtered_temp;
            GUIHandles.roiFluorescences = loaded_data.roiFluorescences_temp;
            GUIHandles.metadata = loaded_data.metadata_temp;
            GUIHandles.foopsi_filtered = loaded_data.foopsi_filtered;
            GUIHandles.foopsi_events = loaded_data.foopsi_events;
            GUIHandles.foopsi_options = loaded_data.foopsi_options;
%             GUIHandles.roi_transients = loaded_data.roi_transients_temp;
            GUIHandles.stopFrame = size(GUIHandles.dff,1);
            GUIHandles.stopEdit.String = num2str(GUIHandles.stopFrame);
            GUIHandles.startEdit.String = '1';    
            
            
        else
            % load raw fluorescence and metadata
            sigfile = strcat(fPath, fName, '.sig');
            extrafile = strcat(fPath, fName, '.extra');
            roimaskfile = strcat(fPath, fName, '.rois');
            roiFluorescences = load(sigfile);
            GUIHandles.metadata = load(extrafile, '-mat');
            try
                GUIHandles.roimaskdata = load(roimaskfile, '-mat');
            catch
                [roifPath,roifName] = uigetfile({'*.rois'}, 'Please select .rois file');
                GUIHandles.roimaskdata = load(strcat(roifName,roifPath), '-mat');
            end
                          
            % crop neuropil columns
            GUIHandles.roiFluorescences = roiFluorescences(:,1:(size(roiFluorescences,2)/2)); 
            GUIHandles.roiFluorescences_PIL = roiFluorescences(:,(size(roiFluorescences,2)/2)+1:end); 
            
            GUIHandles.statusText.String = 'Calculating flourescence transients (this can take a few minutes)...';
            pause(0.001);
            
            % determine location of rois and order by them
            roiMask = GUIHandles.roimaskdata.roiMask; % just pull that out to make the code more readable
            roi_centers = zeros(size(GUIHandles.roiFluorescences,2),2);
            for i=1:max(max(roiMask))
                [row,col]=ind2sub(size(roiMask),find(roiMask==i));
                row_mid = floor(min(row)+max(row));
                col_mid = floor(min(col)+max(col));
                roi_centers(i,1) = row_mid;
                roi_centers(i,2) = col_mid;
            end
            roi_centers = sortrows(roi_centers);
            
            % TODO insert ROI-IDs and sort the columns of roiFluorescences accordingly.
            
            
            % eliminate NaN values at the start and the end
            crop_start = 0;
            crop_end = 0;
            i = 1;
            while any(isnan(GUIHandles.roiFluorescences(i,:)))
                i = i + 1;
                crop_start = crop_start + 1;
            end
            i = 0;
            while any(isnan(GUIHandles.roiFluorescences(end-i,:)))
                i = i + 1;
                crop_end = crop_end + 1;
            end
            GUIHandles.roiFluorescences = GUIHandles.roiFluorescences(crop_start+1:end-crop_end,:);
            GUIHandles.roiFluorescences_PIL = GUIHandles.roiFluorescences_PIL(crop_start+1:end-crop_end,:);
            GUIHandles.metadata.meanBrightness = GUIHandles.metadata.meanBrightness(:,crop_start+1:end-crop_end);
            
            % analyze DFF data and store
            baseline_fit = robustfit(linspace(1,size(GUIHandles.roiFluorescences,1),size(GUIHandles.roiFluorescences,1)),GUIHandles.metadata.meanBrightness');
            dff_background = baseline_fit(1) + linspace(1,size(GUIHandles.roiFluorescences,1),size(GUIHandles.roiFluorescences,1)) * baseline_fit(2);
            GUIHandles.dff = calculateDFF2((GUIHandles.roiFluorescences-(GUIHandles.neuropil_weight*GUIHandles.roiFluorescences_PIL))+dff_background', GUIHandles.baseline_percentile);
            
            %GUIHandles.dff = calculateDFF(GUIHandles.roiFluorescences);
            GUIHandles.stopFrame = size(GUIHandles.dff,1);
            GUIHandles.stopEdit.String = num2str(GUIHandles.stopFrame);
            GUIHandles.startEdit.String = '1';
                  
            % prep matrizes for deconvolution
            GUIHandles.foopsi_filtered = zeros(size(GUIHandles.dff));
            GUIHandles.foopsi_events = zeros(size(GUIHandles.dff));
            GUIHandles.foopsi_options = {};
            % low pass filter signal
            GUIHandles.statusText.String = 'Smoothing data...';
            pause(0.001);
            GUIHandles.dff_filtered = zeros(size(GUIHandles.dff));
            for i=1:size(GUIHandles.dff,2)
                % linearly inteprolate any NaN datapoints
                isnan_idx = find(isnan(GUIHandles.dff(:,i)));
                real_idx = find(~isnan(GUIHandles.dff(:,i)));
                GUIHandles.dff_filtered(real_idx,i) = GUIHandles.dff(real_idx,i);
                GUIHandles.dff_filtered(isnan_idx,i) = interp1(real_idx,GUIHandles.dff_filtered(real_idx,i),isnan_idx);
                GUIHandles.dff(isnan_idx,i) = interp1(real_idx,GUIHandles.dff(real_idx,i),isnan_idx);
                GUIHandles.dff_filtered(:,i) = lowpass(GUIHandles.dff_filtered(:,i),GUIHandles.lowpass_filter_cutoff,GUIHandles.fs);
                
                [c, s, options] = deconvolveCa(GUIHandles.dff(:,i), 'foopsi', 'ar1', 'smin', -3, 'optimize_pars', true, 'optimize_b', true); % ar2, smin -1
                GUIHandles.foopsi_filtered(:,i) = c;
                GUIHandles.foopsi_events(:,i) = s;
                GUIHandles.foopsi_options{end+1} = options;
            end

            
            % identify transients
            GUIHandles.statusText.String = 'Identifying transients...';
            pause(0.001);

            dff_temp = GUIHandles.dff;
            dff_filtered_temp = GUIHandles.dff_filtered;
            roiFluorescences_temp = GUIHandles.roiFluorescences;
            metadata_temp = GUIHandles.metadata;
            foopsi_filtered = GUIHandles.foopsi_filtered;
            foopsi_events = GUIHandles.foopsi_events;
            foopsi_options = GUIHandles.foopsi_options;
            save(strcat(fPath,fName,'_analyzed.mat'), 'dff_temp', 'roiFluorescences_temp', 'full_path', 'dff_filtered_temp', 'metadata_temp', 'foopsi_filtered', 'foopsi_events', 'foopsi_options');
            
%             GUIHandles.roi_transients = id_transients(GUIHandles.dff_filtered,GUIHandles.std_threshold,GUIHandles.transient_baseline_percentile, GUIHandles.gap_tolerance_frames, GUIHandles.min_transient_length);
        end
        
        %GUIHandles.roi_transients = id_transients(GUIHandles.dff_filtered,GUIHandles.std_threshold,GUIHandles.transient_baseline_percentile, GUIHandles.gap_tolerance_frames, GUIHandles.min_transient_length);
        
        GUIHandles.roi_transients = id_transients_foopsi(GUIHandles.dff_filtered,GUIHandles.foopsi_events,GUIHandles.foopsi_filtered);
        
        GUIHandles.inc_rois = linspace(1,size(GUIHandles.dff,2),size(GUIHandles.dff,2));
        
        % make GUI elements visible/invisible
        GUIHandles.startLabel.Visible = true;
        GUIHandles.startEdit.Visible = true;  
        GUIHandles.stopLabel.Visible = true; 
        GUIHandles.stopEdit.Visible = true;  
        GUIHandles.updateView.Visible = true; 
        GUIHandles.resetView.Visible = true; 
        
        GUIHandles.minYEdit.Visible = true;
        GUIHandles.maxYEdit.Visible = true;
        GUIHandles.minYLabel.Visible = true;
        GUIHandles.maxYLabel.Visible = true;
        GUIHandles.yEditCheckbox.Visible = true;
        GUIHandles.filterCheckbox.Visible = true;
          
        GUIHandles.loadButton.Visible = false;
        GUIHandles.roiTrace.Visible = true;
        GUIHandles.roi_heatmap.Visible = true;
        GUIHandles.meanRoidff.Visible = true;
        GUIHandles.coordEventProb.Visible = true;
        GUIHandles.roiAUC.Visible = true;
        GUIHandles.dffvfrac.Visible = true;
        
        GUIHandles.showResults.Visible = true;
        GUIHandles.analyzeAUC.Visible = true;
        GUIHandles.analyzeCORR.Visible = true;
        
        GUIHandles.roiListLabel.Visible = true;
        GUIHandles.roiList.Visible = true;
        
        % Display heatmap
        if GUIHandles.yEditCheckbox.Value == 1
            imagesc(GUIHandles.roi_heatmap,transpose(GUIHandles.dff),[GUIHandles.minY,GUIHandles.maxY]);
        else
            imagesc(GUIHandles.roi_heatmap,transpose(GUIHandles.dff));
        end 
        xlabel(GUIHandles.roi_heatmap, 'Frame Number');
        ylabel(GUIHandles.roi_heatmap, 'Roi Number');
        
        GUIHandles.roiTraceSlider = uicontrol('Parent',GUIHandles.loadButton.Parent, 'Style', 'slider','Min',1,'Max',size(GUIHandles.dff,2),'Value',1,'SliderStep', [1/size(GUIHandles.dff,2),10/size(GUIHandles.dff,2)], 'Units', 'Normalized', 'Visible','on','Position', [0.04, 0.9, 0.4, 0.05],'Callback', @roiTraceSliderCallback);
        GUIHandles.statusText.String = 'Displaying ROI: 1';
        pause(0.001);
        
        % plot mean df/f across ROIs
        roi_mean = mean(GUIHandles.dff.');
        plot(roi_mean(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'Parent', GUIHandles.meanRoidff);
        ylabel(GUIHandles.meanRoidff, 'mean dF/F');
        xlim(GUIHandles.meanRoidff,[1, GUIHandles.stopFrame-GUIHandles.startFrame]);
        xticklabels(GUIHandles.meanRoidff, {});
        
        % calculate how many cells are active at any given point in time and separate transients into global and individual
        [roi_transients_individual, roi_transients_global] = transient_event(GUIHandles.dff,GUIHandles.roi_transients,GUIHandles.event_threshold,GUIHandles.startFrame,GUIHandles.stopFrame,1);
       
        plot(GUIHandles.dff(GUIHandles.startFrame:GUIHandles.stopFrame,GUIHandles.roiTraceSlider.Value), 'LineWidth', GUIHandles.trace_linewidth, 'Parent', GUIHandles.roiTrace, 'LineStyle','-','Color','k');
        hold(GUIHandles.roiTrace,'on');
        plot(GUIHandles.foopsi_filtered(GUIHandles.startFrame:GUIHandles.stopFrame,GUIHandles.roiTraceSlider.Value), 'LineWidth', GUIHandles.trace_linewidth, 'Parent', GUIHandles.roiTrace, 'LineStyle','-','Color','b');
        plot(GUIHandles.foopsi_events(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'LineStyle','-','Color','m', 'Parent', GUIHandles.roiTrace);
        
        % grab Y-values and display them
        ylims_temp = ylim(GUIHandles.roiTrace);
        GUIHandles.minY = ylims_temp(1);
        GUIHandles.maxY = ylims_temp(2);
        GUIHandles.minYEdit.String = num2str(GUIHandles.minY);
        GUIHandles.maxYEdit.String = num2str(GUIHandles.maxY);
        
        xlabel(GUIHandles.roiTrace, 'Frame Number');
        ylabel(GUIHandles.roiTrace, 'dF/F');
        xlim(GUIHandles.roiTrace, [GUIHandles.startFrame, GUIHandles.stopFrame]);
        % plot identified transients in a different color
        if size(roi_transients_individual) > 0
            transient_idx = roi_transients_individual;
            onset_idx = transient_idx(:,1);
            offset_idx = transient_idx(:,2);  
            if size(onset_idx) > 0
                for j=1:size(onset_idx,1)
                    if onset_idx(j) > GUIHandles.startFrame && offset_idx(j) < GUIHandles.stopFrame
                        onidx = onset_idx(j) - GUIHandles.startFrame + 1;
                        offidx = offset_idx(j) - GUIHandles.startFrame + 1;
                        plot(onidx:offidx,GUIHandles.dff(onset_idx(j):offset_idx(j),1),'Color','r', 'LineWidth', GUIHandles.trace_linewidth,'Parent',GUIHandles.roiTrace);
                    end
                end

            end
        end
        hold(GUIHandles.roiTrace,'off');
        
        % plot mean frame brightness
        plot(GUIHandles.metadata.meanBrightness(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'Parent',GUIHandles.FOVBrightness);
        xlim(GUIHandles.FOVBrightness, [GUIHandles.startFrame, GUIHandles.stopFrame]);
        xlabel(GUIHandles.FOVBrightness, 'Frame Number');
        ylabel(GUIHandles.FOVBrightness, 'mean frame brightness (a.u.)');
        
        % plot fraction of simultaenously active neurons and shade event periods green
        [GUIHandles.fraction_active, GUIHandles.event_idx] = calc_fraction_active(GUIHandles.dff, GUIHandles.roi_transients, GUIHandles.event_threshold);
        hold(GUIHandles.coordEventProb,'on');
        for i=1:size(GUIHandles.event_idx,1)
            if GUIHandles.event_idx(i) > 0
                plot([i,i], [0,1], 'Color','g', 'LineWidth', GUIHandles.trace_linewidth, 'Parent', GUIHandles.coordEventProb);
            end
        end
        plot(GUIHandles.fraction_active(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'Parent', GUIHandles.coordEventProb,'Color','r');
        xlim(GUIHandles.coordEventProb, [GUIHandles.startFrame, GUIHandles.stopFrame]);
        ylabel(GUIHandles.coordEventProb, 'Fraction Active');
        xlabel(GUIHandles.coordEventProb, 'Frame Number');
        hold(GUIHandles.coordEventProb,'off');
        
        % plot transients that are part of a global event in green
        hold(GUIHandles.roiTrace,'on');
        if size(roi_transients_global) > 0
            transient_idx = roi_transients_global;
            onset_idx = transient_idx(:,1);
            offset_idx = transient_idx(:,2);  
            if size(onset_idx) > 0
                for j=1:size(onset_idx,1)
                    if onset_idx(j) > GUIHandles.startFrame && offset_idx(j) < GUIHandles.stopFrame
                        if size(intersect(onset_idx(j):offset_idx(j),find(GUIHandles.event_idx)),1) > 1 
                            onidx = onset_idx(j) - GUIHandles.startFrame + 1;
                            offidx = offset_idx(j) - GUIHandles.startFrame + 1;
                            plot(onidx:offidx,GUIHandles.dff(onset_idx(j):offset_idx(j),1),'Color','g', 'LineWidth', GUIHandles.trace_linewidth,'Parent',GUIHandles.roiTrace);
                        end
                    end
                end 
            end    
        end
        hold(GUIHandles.roiTrace,'off'); 
        
        if size(roi_transients_individual,1) > 0
            transient_AUC_individual = calc_transient_AUC(GUIHandles.dff_filtered(:,1), roi_transients_individual, 1, size(GUIHandles.dff,1), GUIHandles.fs);
        end
        if size(roi_transients_global,1) > 0
            transient_AUC_global = calc_transient_AUC(GUIHandles.dff_filtered(:,1), roi_transients_global, 1, size(GUIHandles.dff,1), GUIHandles.fs);
        end
        if size(roi_transients_individual,1) > 0 && size(roi_transients_global,1) > 0
            transient_max = max(vertcat(transient_AUC_individual, transient_AUC_global));
        else if size(roi_transients_individual,1) > 0
                transient_max = max(transient_AUC_individual);
            else
                transient_max = max(transient_AUC_global);
            end
        end
        
        bin_edges = linspace(0,transient_max,10);
        if size(roi_transients_individual,1) > 0
            histogram(GUIHandles.roiAUC, transient_AUC_individual, bin_edges, 'FaceColor','r');
        end
        hold(GUIHandles.roiAUC,'on');
        if size(roi_transients_global,1) > 0
            histogram(GUIHandles.roiAUC, transient_AUC_global,bin_edges, 'FaceColor','g');
        end
        hold(GUIHandles.roiAUC,'off');
        xlabel(GUIHandles.roiAUC, 'AUC');
        ylabel(GUIHandles.roiAUC, 'Number of Transients');
        
        scatter(GUIHandles.dffvfrac,GUIHandles.fraction_active,GUIHandles.dff_filtered(:,1), 'MarkerEdgeColor', 'k');
        hold(GUIHandles.dffvfrac,'on');
        for j=1:size(roi_transients_individual,1)
            scatter(GUIHandles.dffvfrac,GUIHandles.fraction_active(roi_transients_individual(j,1):roi_transients_individual(j,2)),GUIHandles.dff_filtered(roi_transients_individual(j,1):roi_transients_individual(j,2),1), 'MarkerEdgeColor', 'r');
        end
        for j=1:size(roi_transients_global,1)
            scatter(GUIHandles.dffvfrac,GUIHandles.fraction_active(roi_transients_global(j,1):roi_transients_global(j,2)),GUIHandles.dff_filtered(roi_transients_global(j,1):roi_transients_global(j,2),1), 'MarkerEdgeColor', 'g');
        end
        hold(GUIHandles.dffvfrac,'off');
        xlabel(GUIHandles.dffvfrac, 'Fraction Active');
        ylabel(GUIHandles.dffvfrac, 'DF/F');
        
        GUIHandles.fPath = fPath;
        GUIHandles.fName = fName;
    end
    
    % put UI focus on slider
    uicontrol(GUIHandles.roiTraceSlider);
    
    % this saves data that is stored as part of the GUI so it can be used in different functions
    guidata(GUI, GUIHandles);
        
end

function [local_transients, global_transients] = transient_event(dff,roi_transients,event_threshold,start_frame, stop_frame, roi_idx)
    global_transients = [];
    local_transients = [];
    [~,event_idx] = calc_fraction_active(dff, roi_transients, event_threshold);
    transient_idx = roi_transients{roi_idx};
    onset_idx = transient_idx(:,1);
    offset_idx = transient_idx(:,2);  
    if size(onset_idx) > 0
        for j=1:size(onset_idx,1)
            if onset_idx(j) >= start_frame && offset_idx(j) <= stop_frame
                if size(intersect(onset_idx(j):offset_idx(j),find(event_idx)),1) > 1 
                    global_transients = vertcat(global_transients,[onset_idx(j), offset_idx(j)]);
                else
                    local_transients = vertcat(local_transients,[onset_idx(j), offset_idx(j)]);
                end
            end
        end
    end
end

function roi_transients = id_transients(dff,std_threshold,baseline_percentile, gap_tolerance_frames, min_transient_length)
    roi_transients = {};
    
    for i=1:size(dff,2)
        % calculate percentile threshold only from values around the mean
        full_roi_std = nanstd(dff(:,i));
        dff_for_prctile = dff(dff(:,i)>(-2*full_roi_std) & dff(:,i)<(2*full_roi_std),i);
        prctile_threshold = prctile(dff_for_prctile,baseline_percentile);
        
        roi_std = nanstd(dff(dff(:,i) < prctile_threshold,i));
        roi_mean = nanmean(dff(dff(:,i) < prctile_threshold,i));
        transient_high = find(dff(:,i) > (std_threshold*roi_std)+roi_mean);
        
%         roi_std = nanstd(dff(dff(:,i) < prctile(dff(:,i),baseline_percentile),i));
%         roi_mean = nanmean(dff(dff(:,i) < prctile(dff(:,i),baseline_percentile),i));
%         transient_high = find(dff(:,i) > (std_threshold*roi_std)+roi_mean);

        idx_diff = diff(transient_high);
        if size(transient_high,1) > 0
            idx_diff = vertcat(transient_high(1),idx_diff);

    %         onset_idx = transient_high(idx_diff>gap_tolerance_frames)-1;
    %         offset_idx = transient_high(find(idx_diff>gap_tolerance_frames)-1)+1;
    %         offset_idx = circshift(offset_idx,-1);

            % below is an ugly way to identify transients
            j = 1;
            onset_idx = [];
            offset_idx = [];
            dff_max = [];
            while j <= size(dff(:,i),1)
                transient_start = j;
                end_transient = false;
                transient_OK = false;

                if dff(j,i) > (std_threshold*roi_std)+roi_mean
                    while ~end_transient && (j<=size(dff,1))
                        if (dff(j,i) <= (std_threshold*roi_std)+roi_mean) || (j >= size(dff,1))
                            end_transient = true;
                        end
                        j = j+1;
                    end
                    transient_end = j;

                    % check if transient is at lesat min_transient_length long
                    if (transient_end - transient_start) > min_transient_length
                        transient_OK = true;
                    end

                    % check if the last transient is at least gap_tolerance away, if no: combine transients
                    if size(offset_idx) > 0
                        if transient_OK && (transient_start - offset_idx(end) < gap_tolerance_frames)
                            offset_idx(end) = transient_end;
                            transient_OK = false;
                        end
                    end

                    if transient_OK
                        onset_idx = vertcat(onset_idx,transient_start);
                        offset_idx = vertcat(offset_idx, transient_end);
                        dff_max = vertcat(dff_max, max(dff(onset_idx:offset_idx,i)));
                    end
                end
                j = j+1;
            end

            % calculate the length of each transient and reject those too short to be considered
    %         index_adjust = 0;
    %         for j=1:size(onset_idx,1)
    %             temp_length = offset_idx(j-index_adjust) - onset_idx(j-index_adjust);
    %             if temp_length < min_transient_length
    %                 onset_idx(j-index_adjust) = [];
    %                 offset_idx(j-index_adjust) = [];
    %                 index_adjust = index_adjust + 1;
    %             end
    %         end

            roi_transients{end+1} = [onset_idx, offset_idx, dff_max];
            num_transients(i) = size(onset_idx,1);
        else
            roi_transients{end+1} = [];
            num_transients(i) = 0;
        end
    end
end

function roi_transients = id_transients_foopsi(dff,foopsi_events,foopsi_filtered)
    roi_transients = {};
    
    for i=1:size(dff,2)
        cr_foopsi_events = foopsi_events(:,i);
        cr_foopsi_filtered = foopsi_filtered(:,i);
        transient_start = [];
        transient_end = [];
        transient_maxdf = [];
        
        for j=1:size(find(cr_foopsi_events))
            event_idx = find(cr_foopsi_events);
            
            % determine start of transient
            k = event_idx(j);
            while cr_foopsi_filtered(k) > 0.01 && k > 1
                k = k - 1;
            end
            
            % only add this transient if its not equal to the previous one
            if size(transient_start) > 0 
                if k ~= transient_start(end)
                    transient_start = [transient_start; k];
                    % determine end of transient
                    k = event_idx(j);
                    while cr_foopsi_filtered(k) > 0.01 && k < size(cr_foopsi_filtered,1)
                        k = k + 1;
                    end
                    transient_end = [transient_end; k];
                    % determine max amplitude of transient
                    transient_maxdf = [transient_maxdf; max(dff(transient_start:transient_end,i))];
                end
            else
                transient_start = [transient_start; k];
                % determine end of transient
                k = event_idx(j);
                while cr_foopsi_filtered(k) > 0.01 && k < size(cr_foopsi_filtered,1)
                    k = k + 1;
                end
                transient_end = [transient_end; k];
                % determine max amplitude of transient
                transient_maxdf = [transient_maxdf; max(dff(transient_start:transient_end,i))];
            end
        end
        roi_transients{end+1} = [transient_start, transient_end, transient_maxdf];
    end
end

function transient_AUC = calc_transient_AUC(dff, transient_idx, start_idx, stop_idx, fs)
    transient_AUC = zeros(size(transient_idx,1),1);  % AUC for each transient of each neuron
    
    onset_idx = transient_idx(:,1);
    offset_idx = transient_idx(:,2);        
    if size(onset_idx) > 0
        for j=1:size(onset_idx,1)
            if onset_idx(j) > start_idx && offset_idx(j) < stop_idx
                x_vals = linspace(0,(offset_idx(j)-onset_idx(j))/fs, offset_idx(j)-onset_idx(j)+1);
                y_vals = dff(onset_idx(j):offset_idx(j))';
                t_auc = trapz(x_vals, y_vals);
                if ~isnan(t_auc)
                    transient_AUC(j) = t_auc;
                end
            end
        end
    end
    
end

function [fraction_active, evend_idx] = calc_fraction_active(dff, transients, event_threshold)
    rois_active = zeros(size(dff));
    fraction_active = zeros(size(dff,1),1);
    evend_idx = zeros(size(dff,1),1);
    
    for i=1:size(dff,2)
        roi_t = transients{i};
        for j=1:size(roi_t,1)
            rois_active(roi_t(j,1):roi_t(j,2),i) = 1;
        end
    end
    
    for i=1:size(dff,1)
        fraction_active(i) = sum(rois_active(i,:))/size(dff,2);
    end
    
    evend_idx(fraction_active > event_threshold) = 1;
%     disp('test');
end

function roiTraceSliderCallback(GUI, ~)
    GUIHandles = guidata(GUI);
    roi_idx = int16(GUIHandles.roiTraceSlider.Value);
    foopsi_trace = GUIHandles.foopsi_filtered(:,roi_idx);
    if GUIHandles.showFiltered
        roi_trace = GUIHandles.dff_filtered(:,roi_idx);
    else
        roi_trace = GUIHandles.dff(:,roi_idx);
    end
    GUIHandles.statusText.String = strcat('Displaying ROI: ', string(roi_idx));
    pause(0.001);
    plot(roi_trace(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'LineStyle','-','Color','k', 'Parent', GUIHandles.roiTrace);
    hold(GUIHandles.roiTrace,'on');
    plot(foopsi_trace(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'LineStyle','-','Color','b', 'Parent', GUIHandles.roiTrace);
%     plot(foopsi_filtered(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'LineStyle','-','Color','m', 'Parent', GUIHandles.roiTrace);

    % get local and global transients
    if size(GUIHandles.roi_transients{roi_idx},1) > 0
        [roi_transients_individual, roi_transients_global] = transient_event(GUIHandles.dff,GUIHandles.roi_transients,GUIHandles.event_threshold,GUIHandles.startFrame,GUIHandles.stopFrame,roi_idx);
    else
        roi_transients_individual = [];
        roi_transients_global = [];
    end
    
    % set Y limits
    if GUIHandles.yEditCheckbox.Value == 1
        ylim(GUIHandles.roiTrace,[GUIHandles.minY,GUIHandles.maxY])
    else
        ylims_temp = ylim(GUIHandles.roiTrace);
        GUIHandles.minY = ylims_temp(1);
        GUIHandles.maxY = ylims_temp(2);
        GUIHandles.minYEdit.String = num2str(GUIHandles.minY);
        GUIHandles.maxYEdit.String = num2str(GUIHandles.maxY);
    end
    
    xlabel(GUIHandles.roiTrace, 'Frame Number');
    ylabel(GUIHandles.roiTrace, 'dF/F');
    xlim(GUIHandles.roiTrace,[1, GUIHandles.stopFrame-GUIHandles.startFrame]);
    transient_idx = roi_transients_individual;
    if size(roi_transients_individual,1) > 0
        onset_idx = transient_idx(:,1);
        offset_idx = transient_idx(:,2);

        if size(onset_idx) > 0
            for j=1:size(onset_idx,1)
                if onset_idx(j) > GUIHandles.startFrame && offset_idx(j) < GUIHandles.stopFrame
                    onidx = onset_idx(j) - GUIHandles.startFrame + 1;
                    offidx = offset_idx(j) - GUIHandles.startFrame + 1;
                    plot(onidx:offidx,roi_trace(onset_idx(j):offset_idx(j)),'Color','r', 'LineWidth', GUIHandles.trace_linewidth,'Parent',GUIHandles.roiTrace);
                end
            end
        end
    end
    % plot transients that are part of a global event in green
        
    
    if size(roi_transients_global) > 0
        transient_idx = roi_transients_global;
        onset_idx = transient_idx(:,1);
        offset_idx = transient_idx(:,2);
        if size(onset_idx) > 0
            for j=1:size(onset_idx,1)
                if onset_idx(j) > GUIHandles.startFrame && offset_idx(j) < GUIHandles.stopFrame
                    onidx = onset_idx(j) - GUIHandles.startFrame + 1;
                    offidx = offset_idx(j) - GUIHandles.startFrame + 1;
                    plot(onidx:offidx,roi_trace(onset_idx(j):offset_idx(j)),'Color','g', 'LineWidth', GUIHandles.trace_linewidth,'Parent',GUIHandles.roiTrace);
                end
            end
        end
    end
    hold(GUIHandles.roiTrace,'off');
    
    if size(roi_transients_individual,1) > 0
        transient_AUC_individual = calc_transient_AUC(GUIHandles.dff_filtered(:,1), roi_transients_individual, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
    else
        transient_AUC_individual = [];
    end
    if size(roi_transients_global,1) > 0
        transient_AUC_global = calc_transient_AUC(GUIHandles.dff_filtered(:,1), roi_transients_global, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
    else
        transient_AUC_global = [];
    end
    if size(roi_transients_individual,1) > 0 && size(roi_transients_global,1) > 0
        transient_max = max(vertcat(transient_AUC_individual, transient_AUC_global));
    elseif size(transient_AUC_individual,1) > 0
        transient_max = max(transient_AUC_individual);
    elseif size(transient_AUC_global,1) > 0
        transient_max = max(transient_AUC_global);
    else
        transient_max = 1;
    end

    bin_edges = linspace(0,transient_max,10);
    if size(roi_transients_individual,1) > 0
        histogram(GUIHandles.roiAUC, transient_AUC_individual, bin_edges, 'FaceColor','r');
    end
    hold(GUIHandles.roiAUC,'on');
    if size(roi_transients_global,1) > 0
        histogram(GUIHandles.roiAUC, transient_AUC_global,bin_edges, 'FaceColor','g');
    end
    hold(GUIHandles.roiAUC,'off');
    xlabel(GUIHandles.roiAUC, 'AUC');
    ylabel(GUIHandles.roiAUC, 'Number of Transients');
    
    scatter(GUIHandles.dffvfrac,GUIHandles.fraction_active(GUIHandles.startFrame:GUIHandles.stopFrame),GUIHandles.dff_filtered(GUIHandles.startFrame:GUIHandles.stopFrame,roi_idx), 'MarkerEdgeColor', 'k');
    hold(GUIHandles.dffvfrac,'on');
    for j=1:size(roi_transients_individual,1)
        scatter(GUIHandles.dffvfrac,GUIHandles.fraction_active(roi_transients_individual(j,1):roi_transients_individual(j,2)),GUIHandles.dff_filtered(roi_transients_individual(j,1):roi_transients_individual(j,2),roi_idx), 'MarkerEdgeColor', 'r');
    end
    for j=1:size(roi_transients_global,1)
        scatter(GUIHandles.dffvfrac,GUIHandles.fraction_active(roi_transients_global(j,1):roi_transients_global(j,2)),GUIHandles.dff_filtered(roi_transients_global(j,1):roi_transients_global(j,2),roi_idx), 'MarkerEdgeColor', 'g');
    end
    hold(GUIHandles.dffvfrac,'off');
    xlabel(GUIHandles.dffvfrac, 'Fraction Active');
    ylabel(GUIHandles.dffvfrac, 'DF/F');
    
    hold(GUIHandles.roiTrace,'off');
    guidata(GUI, GUIHandles);
end

function update_plots(GUI, ~)
    GUIHandles = guidata(GUI);
    
    inc_rois = linspace(1,size(GUIHandles.dff,2),size(GUIHandles.dff,2));
    exc_rois = GUIHandles.exc_rois;
    temp_str = GUIHandles.roiList.String;
    if ~strcmp(temp_str, 'all')
        text_rois = strsplit(temp_str,',');
        for j=1:length(text_rois)
            roinum = str2double(text_rois{j});
            if ~isnan(roinum)
                exc_rois = [exc_rois,int16(roinum)];
                inc_rois(inc_rois == roinum) = [];
            end
        end
        GUIHandles.roiList.String = num2str(inc_rois,'%d,');
    end
    GUIHandles.inc_rois = inc_rois;
    
    roi_idx = int16(GUIHandles.roiTraceSlider.Value);
    foopsi_trace = GUIHandles.foopsi_filtered(:,roi_idx);
    if GUIHandles.showFiltered
        roi_trace = GUIHandles.dff_filtered(:,roi_idx);
        all_rois_data = GUIHandles.dff_filtered(:,inc_rois);
    else
        roi_trace = GUIHandles.dff(:,roi_idx);
        all_rois_data = GUIHandles.dff(:,inc_rois);
    end
    
    [roi_transients_individual, roi_transients_global] = transient_event(GUIHandles.dff(:,inc_rois),GUIHandles.roi_transients(inc_rois),GUIHandles.event_threshold,GUIHandles.startFrame,GUIHandles.stopFrame,roi_idx);
    
    GUIHandles.statusText.String = strcat('Displaying ROI: ', string(roi_idx));
    pause(0.001);
    
    roi_mean = mean(GUIHandles.dff(:,inc_rois).');
    plot(roi_mean(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'Parent', GUIHandles.meanRoidff);
    ylabel(GUIHandles.meanRoidff, 'mean dF/F');
    xlim(GUIHandles.meanRoidff,[1, GUIHandles.stopFrame-GUIHandles.startFrame]);
    xticklabels(GUIHandles.meanRoidff, {});
    
    plot(roi_trace(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineStyle','-','Color','k', 'LineWidth', GUIHandles.trace_linewidth, 'Parent', GUIHandles.roiTrace);
    hold(GUIHandles.roiTrace,'on');
    plot(foopsi_trace(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineStyle','-','Color','b', 'LineWidth', GUIHandles.trace_linewidth, 'Parent', GUIHandles.roiTrace);
%     plot(foopsi_filtered(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'LineStyle','-','Color','m', 'Parent', GUIHandles.roiTrace);
    
    
    % set Y limits
    if GUIHandles.yEditCheckbox.Value == 1
        ylim(GUIHandles.roiTrace,[GUIHandles.minY,GUIHandles.maxY])
    else
        ylims_temp = ylim(GUIHandles.roiTrace);
        GUIHandles.minY = ylims_temp(1);
        GUIHandles.maxY = ylims_temp(2);
        GUIHandles.minYEdit.String = num2str(GUIHandles.minY);
        GUIHandles.maxYEdit.String = num2str(GUIHandles.maxY);
    end
    
    xlabel(GUIHandles.roiTrace, 'Frame Number');
    ylabel(GUIHandles.roiTrace, 'dF/F');
    xlim(GUIHandles.roiTrace,[1, GUIHandles.stopFrame-GUIHandles.startFrame]);
    if size(roi_transients_individual,1) > 0
        onset_idx = roi_transients_individual(:,1);
        offset_idx = roi_transients_individual(:,2);

        if size(onset_idx) > 0
            for j=1:size(onset_idx,1)
                if onset_idx(j) > GUIHandles.startFrame && offset_idx(j) < GUIHandles.stopFrame
                    onidx = onset_idx(j) - GUIHandles.startFrame + 1;
                    offidx = offset_idx(j) - GUIHandles.startFrame + 1;
                    plot(onidx:offidx,roi_trace(onset_idx(j):offset_idx(j)),'Color','r', 'LineWidth', GUIHandles.trace_linewidth,'Parent',GUIHandles.roiTrace);
                end
            end
        end
    end
    hold(GUIHandles.roiTrace,'off');
    
    
    % plot mean FOV brightness
    plot(GUIHandles.metadata.meanBrightness(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'Parent',GUIHandles.FOVBrightness);
    xlim(GUIHandles.FOVBrightness, [1, GUIHandles.stopFrame-GUIHandles.startFrame]);
    xlabel(GUIHandles.FOVBrightness, 'Frame Number');
    ylabel(GUIHandles.FOVBrightness, 'mean frame brightness (a.u.)');
    
    % plot fraction of simultaenously active neurons
    [GUIHandles.fraction_active, GUIHandles.event_idx] = calc_fraction_active(GUIHandles.dff(:, inc_rois), GUIHandles.roi_transients, GUIHandles.event_threshold);
    event_idx_temp = GUIHandles.event_idx(GUIHandles.startFrame:GUIHandles.stopFrame);
    cla(GUIHandles.coordEventProb);
    hold(GUIHandles.coordEventProb,'on');
    for i=1:size(event_idx_temp,1)
        if event_idx_temp(i) > 0
            plot([i,i], [0,1], 'Color','g', 'Parent', GUIHandles.coordEventProb);
        end
    end
    plot(GUIHandles.fraction_active(GUIHandles.startFrame:GUIHandles.stopFrame), 'LineWidth', GUIHandles.trace_linewidth, 'Parent', GUIHandles.coordEventProb,'Color','r');
    xlim(GUIHandles.coordEventProb, [1, GUIHandles.stopFrame-GUIHandles.startFrame]);
    ylabel(GUIHandles.coordEventProb, 'Fraction Active');
    xlabel(GUIHandles.coordEventProb, 'Frame Number');
    hold(GUIHandles.coordEventProb,'off');
    
    % plot transients that are part of a global event in green
    hold(GUIHandles.roiTrace,'on');
    if size(roi_transients_global) > 0
        transient_idx = roi_transients_global;
        onset_idx = transient_idx(:,1);
        offset_idx = transient_idx(:,2);
        if size(onset_idx) > 0
            for j=1:size(onset_idx,1)
                if onset_idx(j) > GUIHandles.startFrame && offset_idx(j) < GUIHandles.stopFrame 
                    onidx = onset_idx(j) - GUIHandles.startFrame + 1;
                    offidx = offset_idx(j) - GUIHandles.startFrame + 1;
                    plot(onidx:offidx,roi_trace(onset_idx(j):offset_idx(j)),'Color','g', 'LineWidth', GUIHandles.trace_linewidth,'Parent',GUIHandles.roiTrace);
                end
            end

        end
    end
    hold(GUIHandles.roiTrace,'off');
    % update the heatmap
    if GUIHandles.yEditCheckbox.Value == 1
        imagesc(GUIHandles.roi_heatmap,transpose(all_rois_data(GUIHandles.startFrame:GUIHandles.stopFrame,:)),[GUIHandles.minY,GUIHandles.maxY]);
    else
        imagesc(GUIHandles.roi_heatmap,transpose(all_rois_data(GUIHandles.startFrame:GUIHandles.stopFrame,:)));
    end 
    xlabel(GUIHandles.roi_heatmap, 'Frame Number');
    ylabel(GUIHandles.roi_heatmap, 'Roi Number');
    
    %calculate and plot AUC for individual and global events
    if size(roi_transients_individual,1) > 0
        transient_AUC_individual = calc_transient_AUC(GUIHandles.dff_filtered(:,1), roi_transients_individual, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
    else
        transient_AUC_individual = [];
    end
    if size(roi_transients_global,1) > 0
        transient_AUC_global = calc_transient_AUC(GUIHandles.dff_filtered(:,1), roi_transients_global, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
    else
        transient_AUC_global = [];
    end
    if size(roi_transients_individual,1) > 0 && size(roi_transients_global,1) > 0
        transient_max = max(vertcat(transient_AUC_individual, transient_AUC_global));
    elseif size(transient_AUC_individual,1) > 0
        transient_max = max(transient_AUC_individual);
    elseif size(transient_AUC_global,1) > 0
        transient_max = max(transient_AUC_global);
    else
        transient_max = 1;
    end
    
    
    bin_edges = linspace(0,transient_max,10);
    cla(GUIHandles.roiAUC);
    if size(roi_transients_individual,1) > 0
        histogram(GUIHandles.roiAUC, transient_AUC_individual, bin_edges, 'FaceColor','r');
    end
    hold(GUIHandles.roiAUC,'on');
    if size(roi_transients_global,1) > 0
        histogram(GUIHandles.roiAUC, transient_AUC_global,bin_edges, 'FaceColor','g');
    end
    hold(GUIHandles.roiAUC,'off');
    xlabel(GUIHandles.roiAUC, 'AUC');
    ylabel(GUIHandles.roiAUC, 'Number of Transients');
    
    cla(GUIHandles.dffvfrac);
    scatter(GUIHandles.dffvfrac,GUIHandles.fraction_active(GUIHandles.startFrame:GUIHandles.stopFrame),GUIHandles.dff_filtered(GUIHandles.startFrame:GUIHandles.stopFrame,roi_idx), 'MarkerEdgeColor', 'k');
    hold(GUIHandles.dffvfrac,'on');
    for j=1:size(roi_transients_individual,1)
        scatter(GUIHandles.dffvfrac,GUIHandles.fraction_active(roi_transients_individual(j,1):roi_transients_individual(j,2)),GUIHandles.dff_filtered(roi_transients_individual(j,1):roi_transients_individual(j,2),roi_idx), 'MarkerEdgeColor', 'r');
    end
    for j=1:size(roi_transients_global,1)
        scatter(GUIHandles.dffvfrac,GUIHandles.fraction_active(roi_transients_global(j,1):roi_transients_global(j,2)),GUIHandles.dff_filtered(roi_transients_global(j,1):roi_transients_global(j,2),roi_idx), 'MarkerEdgeColor', 'g');
    end
    hold(GUIHandles.dffvfrac,'off');
    xlabel(GUIHandles.dffvfrac, 'Fraction Active');
    ylabel(GUIHandles.dffvfrac, 'DF/F');
    
    % put UI focus on slider
    uicontrol(GUIHandles.roiTraceSlider);
    guidata(GUI, GUIHandles);    
end

function reset_plots(GUI, eventdata)
    GUIHandles = guidata(GUI);
    GUIHandles.startFrame = 1;
    GUIHandles.stopFrame = size(GUIHandles.dff,1);
    GUIHandles.startEdit.String = '1';
    GUIHandles.stopEdit.String = num2str(GUIHandles.stopFrame);
    
    % set Y limits
    GUIHandles.yEditCheckbox.Value = 0;
    GUIHandles.minYEdit.Enable = 'off';
    GUIHandles.maxYEdit.Enable = 'off';
    ylims_temp = ylim(GUIHandles.roiTrace);
    GUIHandles.minY = ylims_temp(1);
    GUIHandles.maxY = ylims_temp(2);
    GUIHandles.minYEdit.String = num2str(GUIHandles.minY);
    GUIHandles.maxYEdit.String = num2str(GUIHandles.maxY);
    
    GUIHandles.roiList.String = 'all';
    
    guidata(GUI, GUIHandles);
    update_plots(GUI, eventdata);
    uicontrol(GUIHandles.roiTraceSlider);
    guidata(GUI, GUIHandles);
end

function update_frame_limits(GUI, ~)
    GUIHandles = guidata(GUI);
    GUIHandles.startFrame = int16(str2double(GUIHandles.startEdit.String));
    GUIHandles.stopFrame = int16(str2double(GUIHandles.stopEdit.String));
    uicontrol(GUIHandles.roiTraceSlider);
    guidata(GUI, GUIHandles);
end

function fix_limits(GUI,~)
    GUIHandles = guidata(GUI);
    if GUIHandles.yEditCheckbox.Value == 1
        GUIHandles.minYEdit.Enable = 'on';
        GUIHandles.maxYEdit.Enable = 'on';
        GUIHandles.minY = str2double(GUIHandles.minYEdit.String );
        GUIHandles.maxY = str2double(GUIHandles.maxYEdit.String );
    else
        GUIHandles.minYEdit.Enable = 'off';
        GUIHandles.maxYEdit.Enable = 'off';
    end
    guidata(GUI, GUIHandles);    
end

function filter_signal(GUI, ~)
    GUIHandles = guidata(GUI);
    if GUIHandles.showFiltered
        GUIHandles.showFiltered = false;
    else
        GUIHandles.showFiltered = true;
    end
    
    guidata(GUI, GUIHandles); 
end

function show_results(GUI, ~)
    GUIHandles = guidata(GUI);
    % specify variables that will keep track of results
    GUIHandles.tot_num_transients = zeros(size(GUIHandles.dff,2),1);      % number of transients 
    GUIHandles.num_global_transients = zeros(size(GUIHandles.dff,2),1);   % number of transients that are part of global events
    GUIHandles.fraction_global_transients = zeros(size(GUIHandles.dff,2),1);   % number of transients that are part of global events
    GUIHandles.transient_AUC = cell(size(GUIHandles.roi_transients));  % AUC for each transient of each neuron
    
    for i=1:size(GUIHandles.dff,2) % run through every neuron and count how many transients it has and how many of those are part of a global event
        transient_idx = GUIHandles.roi_transients{i};
        if size(transient_idx,1) > 0
            onset_idx = transient_idx(:,1);
            offset_idx = transient_idx(:,2);  
        else
            onset_idx = [];
            offset_idx = [];
        end
        
        if size(onset_idx) > 0
            for j=1:size(onset_idx,1)
                if onset_idx(j) > GUIHandles.startFrame && offset_idx(j) < GUIHandles.stopFrame
                    if size(intersect(onset_idx(j):offset_idx(j),find(GUIHandles.event_idx)),1) > 1 
                        GUIHandles.num_global_transients(i) = GUIHandles.num_global_transients(i) + 1;
                    end
                    GUIHandles.tot_num_transients(i) = GUIHandles.tot_num_transients(i) + 1;
                end
            end
        end    
    end
    
    for i=1:size(GUIHandles.dff,2) % calculate the fraction of transients that are part of global events
        if GUIHandles.tot_num_transients(i) > GUIHandles.transient_num_threshold
            GUIHandles.fraction_global_transients(i) = GUIHandles.num_global_transients(i)/GUIHandles.tot_num_transients(i);
        else
            GUIHandles.fraction_global_transients(i) = NaN;
        end
    end
    
    AUC_ind = {};
    AUC_global = {};
    for i=1:size(GUIHandles.dff,2) % calculate AUC for each neuron
        if size(GUIHandles.roi_transients{i},1) > 0
            [roi_transients_individual, roi_transients_global] = transient_event(GUIHandles.dff,GUIHandles.roi_transients,GUIHandles.event_threshold,GUIHandles.startFrame,GUIHandles.stopFrame,i);
            if size(roi_transients_individual) > 0
                transient_AUC_individual = calc_transient_AUC(GUIHandles.dff(:,i), roi_transients_individual, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
                AUC_ind{end+1} = transient_AUC_individual(~isnan(transient_AUC_individual));
            else
                AUC_ind{end+1} = {};
            end
            if size(roi_transients_global) > 0
                transient_AUC_global = calc_transient_AUC(GUIHandles.dff(:, i), roi_transients_global, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
                AUC_global{end+1} = transient_AUC_global(~isnan(transient_AUC_global));
            else
                AUC_global{end+1} = {};
            end     
        end
        
    end
    
%     for i=1:size(GUIHandles.dff,2) % calculate AUC for each neuron
%         transient_idx = GUIHandles.roi_transients{i};
%         GUIHandles.transient_AUC{i} = zeros(size(transient_idx,1),1);
%         onset_idx = transient_idx(:,1);
%         offset_idx = transient_idx(:,2);        
%         if size(onset_idx) > 0
%             for j=1:size(onset_idx,1)
%                 if onset_idx(j) > GUIHandles.startFrame && offset_idx(j) < GUIHandles.stopFrame
%                     x_vals = linspace(0,(offset_idx(j)-onset_idx(j))/GUIHandles.fs, offset_idx(j)-onset_idx(j)+1);
%                     y_vals = GUIHandles.dff(onset_idx(j):offset_idx(j),i)';
%                     GUIHandles.transient_AUC{i}(j) = trapz(x_vals, y_vals);
%                 end
%             end
%         end
%     end
    % create results table
    results_table = table(linspace(1,size(GUIHandles.dff,2),size(GUIHandles.dff,2))',...
                          GUIHandles.tot_num_transients,...
                          GUIHandles.num_global_transients,...
                          GUIHandles.fraction_global_transients,...
                          'VariableNames', {'roi number','total number of transients', 'global event transients', 'fraction transients global'});
                      
    % write to excel file
    writetable(results_table, strcat(GUIHandles.fPath, GUIHandles.fName, '_results.xlsx'));
    save(strcat(GUIHandles.fPath, GUIHandles.fName, '_results.mat'), 'AUC_ind', 'AUC_global');
    GUIHandles.statusText.String = strcat('saved: ', strcat(GUIHandles.fPath, GUIHandles.fName, '_results.xlsx/mat'));
    
    guidata(GUI, GUIHandles);
end

function analyze_AUC(GUI, ~)
    GUIHandles = guidata(GUI);
    
    % pull out rois and data to do analysis on
    inc_rois = GUIHandles.inc_rois;
    roi_dff = GUIHandles.dff(:,inc_rois);
    
    roi_transients = id_transients(GUIHandles.dff_filtered(:,inc_rois),GUIHandles.std_threshold,GUIHandles.transient_baseline_percentile, GUIHandles.gap_tolerance_frames, GUIHandles.min_transient_length);
    roi_transients = id_transients_foopsi(GUIHandles.dff_filtered(:,inc_rois),GUIHandles.foopsi_events,GUIHandles.foopsi_filtered);
    
    AUC_ind = [];
    AUC_global = [];
    AUC_all = [];
    
    tot_AUC_ind = [];
    tot_AUC_global = [];
    
    for i=1:size(roi_dff,2) % calculate AUC for each neuron
        if size(roi_transients{i},1) > 0
            [roi_transients_individual, roi_transients_global] = transient_event(roi_dff,roi_transients(inc_rois),GUIHandles.event_threshold,GUIHandles.startFrame,GUIHandles.stopFrame,i);
            if size(roi_transients_individual) > 0
                transient_AUC_individual = calc_transient_AUC(roi_dff(:,i), roi_transients_individual, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
            else
                transient_AUC_individual = [];
            end
            
            if size(roi_transients_global) > 0
                transient_AUC_global = calc_transient_AUC(roi_dff(:,i), roi_transients_global, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
%                 transient_AUC_global = transient_AUC_global / max(transient_AUC_global);
            else
                transient_AUC_global = [];
            end 
            
            auc_max = max(vertcat(transient_AUC_individual,transient_AUC_global));
            
            tot_AUC_ind = vertcat(tot_AUC_ind, sum(transient_AUC_individual));
            tot_AUC_global = vertcat(tot_AUC_global, sum(transient_AUC_global));
            
            transient_AUC_individual = transient_AUC_individual / auc_max; % normalize transients of one cell
            transient_AUC_global = transient_AUC_global / auc_max;
            AUC_ind = vertcat(AUC_ind,transient_AUC_individual(~isnan(transient_AUC_individual)));
            AUC_global = vertcat(AUC_global,transient_AUC_global(~isnan(transient_AUC_global)));
            
%             AUC_all = vertcat(AUC_all,transient_AUC_individual(~isnan(transient_AUC_individual)));
%             AUC_all = vertcat(AUC_all,transient_AUC_global(~isnan(transient_AUC_global)));
        else
            tot_AUC_ind = vertcat(tot_AUC_ind, 0);
            tot_AUC_global = vertcat(tot_AUC_global, 0);
        end    
    end
    
    auc_figure = figure();
    
    typeAUC = subplot(2,2,1);
    allFrac = subplot(2,2,2);
    totAUC = subplot(2,2,3);
    tot_transient = subplot(2,2,4);
    
    boxplot_data = horzcat(tot_AUC_ind(inc_rois),tot_AUC_global(inc_rois));
    x_data = ones(size(boxplot_data,1),2);
    x_data(:,2) = 2;
    h = boxplot(totAUC,boxplot_data, 'Colors',['r','g'],'Widths',0.5, 'Symbol','');
    hold(totAUC,'on');
    set(h,{'linew'},{2});
    scatter(totAUC,x_data(:,1), boxplot_data(:,1), 'MarkerEdgeColor','r');
    scatter(totAUC,x_data(:,2), boxplot_data(:,2), 'MarkerEdgeColor','g');
    
    xticklabels(totAUC,{'independent';'global'});
    xtickangle(totAUC,45);
    ylabel(totAUC,'total AUC');
    hold(totAUC,'off');
    
    transient_max = max(vertcat(AUC_ind, AUC_global));
    bin_edges = linspace(0,transient_max,40);
    histogram(typeAUC, AUC_ind, bin_edges, 'FaceColor','r');
    hold(typeAUC,'on');
    histogram(typeAUC, AUC_global,bin_edges, 'FaceColor','g');
    hold(typeAUC,'off');
    xlabel(typeAUC, 'AUC');
    ylabel(typeAUC, 'Number of Transients');
    
%     histogram(allAUC, AUC_all, bin_edges, 'FaceColor','k');
    
    % specify variables that will keep track of results
    GUIHandles.tot_num_transients = zeros(size(roi_dff,2),1);      % number of transients 
    GUIHandles.num_global_transients = zeros(size(roi_dff,2),1);   % number of transients that are part of global events
    GUIHandles.fraction_global_transients = zeros(size(roi_dff,2),1);   % number of transients that are part of global events
    
    for i=1:size(roi_dff,2) % run through every neuron and count how many transients it has and how many of those are part of a global event
        transient_idx = roi_transients{i};
        if size(transient_idx,1) > 0
            onset_idx = transient_idx(:,1);
            offset_idx = transient_idx(:,2);  
        else
            onset_idx = [];
            offset_idx = [];
        end
        
        if size(onset_idx) > 0
            for j=1:size(onset_idx,1)
                if onset_idx(j) > GUIHandles.startFrame && offset_idx(j) < GUIHandles.stopFrame
                    if size(intersect(onset_idx(j):offset_idx(j),find(GUIHandles.event_idx)),1) > 1 
                        GUIHandles.num_global_transients(i) = GUIHandles.num_global_transients(i) + 1;
                    end
                    GUIHandles.tot_num_transients(i) = GUIHandles.tot_num_transients(i) + 1;
                end
            end
        end    
    end
    
    for i=1:size(roi_dff,2) % calculate the fraction of transients that are part of global events
        if GUIHandles.tot_num_transients(i) > GUIHandles.transient_num_threshold
            GUIHandles.fraction_global_transients(i) = GUIHandles.num_global_transients(i)/GUIHandles.tot_num_transients(i);
        else
            GUIHandles.fraction_global_transients(i) = NaN;
        end
    end
    
     % calculate AUC for each neuron to save in results file and plot in scatterplot
    AUC_ind = {};
    AUC_global = {};
    AUC_ind_scatter = [];
    AUC_global_scatter = [];
    AUC_ind_fraction_active = [];
    AUC_global_fraction_active = [];
    for i=1:size(roi_dff,2)
        if size(roi_transients{i},1) > 0
            [roi_transients_individual, roi_transients_global] = transient_event(roi_dff,roi_transients,GUIHandles.event_threshold,GUIHandles.startFrame,GUIHandles.stopFrame,i);
            if size(roi_transients_individual) > 0
                transient_AUC_individual = calc_transient_AUC(roi_dff(:,i), roi_transients_individual, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
                AUC_ind{end+1} = transient_AUC_individual(~isnan(transient_AUC_individual));
                AUC_ind_scatter = vertcat(AUC_ind_scatter,transient_AUC_individual(~isnan(transient_AUC_individual)));
            else
                AUC_ind{end+1} = {};
            end
            if size(roi_transients_global) > 0
                transient_AUC_global = calc_transient_AUC(roi_dff(:, i), roi_transients_global, GUIHandles.startFrame, GUIHandles.stopFrame, GUIHandles.fs);
                AUC_global{end+1} = transient_AUC_global(~isnan(transient_AUC_global));
                AUC_global_scatter = vertcat(AUC_global_scatter,transient_AUC_global(~isnan(transient_AUC_global)));
            else
                AUC_global{end+1} = {};
            end     
        end
        
    end
    
    tot_num_transients = GUIHandles.tot_num_transients;
    num_global_transients = GUIHandles.num_global_transients;
    fraction_global_transients = GUIHandles.fraction_global_transients;
    transient_data = horzcat(tot_num_transients-num_global_transients,num_global_transients);

    scatter(allFrac,tot_num_transients,fraction_global_transients, 'MarkerEdgeColor','k');
    ylabel(allFrac,'fraction of global transients');
    xlabel(allFrac,'total number of transients');
    
    x_data = ones(size(transient_data,1),2);
    x_data(:,2) = 2;
    h = boxplot(tot_transient,transient_data, 'Colors',['r','g'],'Widths',0.5, 'Symbol','');
    hold(tot_transient,'on');
    set(h,{'linew'},{2});
    scatter(tot_transient,x_data(:,1), transient_data(:,1), 'MarkerEdgeColor','r');
    scatter(tot_transient, x_data(:,2), transient_data(:,2), 'MarkerEdgeColor','g');
    
    xticklabels(tot_transient,{'independent';'global'});
    xtickangle(tot_transient,45);
    ylabel(tot_transient,'number of transients');
    hold(tot_transient,'off');
    
    disp(sum(tot_AUC_ind) + sum(tot_AUC_global));
    
    % create results table
    results_table = table(linspace(1,size(roi_dff,2),size(roi_dff,2))',...
                          GUIHandles.tot_num_transients,...
                          GUIHandles.num_global_transients,...
                          GUIHandles.fraction_global_transients,...
                          'VariableNames', {'roi number','total number of transients', 'global event transients', 'fraction transients global'});
                      
    % write to excel file
    writetable(results_table, strcat(GUIHandles.fPath, GUIHandles.fName, '_results.xlsx'));
    
    save(strcat(GUIHandles.fPath, GUIHandles.fName, '_AUC.mat'), 'AUC_ind', 'AUC_global','tot_AUC_ind','tot_AUC_global','tot_num_transients','num_global_transients','fraction_global_transients');
    GUIHandles.statusText.String = strcat('saved: ', strcat(GUIHandles.fPath, GUIHandles.fName, '_AUC.xlsx/mat'));
    
    guidata(GUI, GUIHandles);
end

function analyze_CORR(GUI, ~)
    GUIHandles = guidata(GUI);
    % pull out rois and data to do analysis on
    inc_rois = GUIHandles.inc_rois;
    roi_dff = GUIHandles.dff(:,inc_rois);
    roi_foopsi = GUIHandles.foopsi_events(:,inc_rois);
    
    pairwise_corr = zeros(size(roi_dff,2),size(roi_dff,2));
    geom_mean = zeros(size(roi_dff,2),size(roi_dff,2));
    
    for i=1:size(roi_dff,2) % calculate pairwise correlation for each neuron
        for j=1:size(roi_dff,2)
            if i ~= j
                pairwise_corr(i,j) = corr(roi_dff(:,i),roi_dff(:,j),'Type','Spearman');
                mean_event_i = length(find(roi_foopsi(:,i)))/size(roi_foopsi,1)*GUIHandles.fs;
                mean_event_j = length(find(roi_foopsi(:,j)))/size(roi_foopsi,1)*GUIHandles.fs;
                roi_geomean(i,j) = geo_mean( [mean_event_i, mean_event_j] );
            else
                pairwise_corr(i,j) = NaN;
            end
        end
    end
    
    corr_figure = figure();
    corr_heatmap = subplot(1,2,1);
    corr_scatterplot = subplot(1,2,2);
        
    imagesc(corr_heatmap,pairwise_corr);
    colorbar();
    ylabel('Neuron #');
    xlabel('Neuron #');
    
    scatter(corr_scatterplot,ones(size(pairwise_corr(:))) + (rand(size(pairwise_corr(:))) .* 0.5), pairwise_corr(:));
    xlim(corr_scatterplot,[0,2]);
    
    save(strcat(GUIHandles.fPath, GUIHandles.fName, '_CORR.mat'), 'pairwise_corr', 'roi_geomean');
    GUIHandles.statusText.String = strcat('saved: ', strcat(GUIHandles.fPath, GUIHandles.fName, '_CORR.xlsx/mat'));
    
    guidata(GUI, GUIHandles);
end