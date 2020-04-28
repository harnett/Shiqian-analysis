function id_pupil()
    try
        [sbxNames, sbxPath] = uigetfile('.mat', 'Please select file containing imaging data.','MultiSelect','off');
    catch
        waitfor(msgbox('Error: Please select valid .mat file.'));
        error('Please select valid .mat file.');
    end
    
    disp('Loading eye tracking data...');
    load([sbxPath,sbxNames], 'abstime', 'data', 'time');
    maxIndex = size(data,4);
    data = flip(data,1);
    disp('Data loaded');
    
    GUI = figure('Name', 'Pupil tracker', 'MenuBar', 'none', 'Position', [300 300 1000 500]);
    % figure handles are passed from function to function
    GUIHandles = guihandles(GUI);
    
    GUIHandles.fpath = sbxPath;
    GUIHandles.fname = sbxNames;
    
    GUIHandles.data = data;
    GUIHandles.time = time;
    GUIHandles.abstime = abstime;
    GUIHandles.maxIndex = maxIndex;
    
    GUIHandles.pixelMaxVal = 50;    % max value for image colour scale
    GUIHandles.pixelThreshold = 0.6;  % max (normalized) value for binarized image
    
    GUIHandles.currentFrameIdx = 1;
    
    GUIHandles.imageAxes2 = axes('Units', 'normalized', 'Position', [0.6, 0.15, 0.35, 0.75]);
    GUIHandles.pupilImage = [];
    set(GUIHandles.imageAxes2,'YTickLabel',[]);
    set(GUIHandles.imageAxes2,'XTickLabel',[]);
    
    GUIHandles.imageAxes = axes('Units', 'normalized', 'Position', [0.05, 0.15, 0.5, 0.75]);
    GUIHandles.displayedImage = imagesc(data(:,:,:,1), 'Parent', GUIHandles.imageAxes, [0, GUIHandles.pixelMaxVal]);    
    
    GUIHandles.frameSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', maxIndex-1, 'Value', 0, 'SliderStep', [1/maxIndex, 50/maxIndex], 'Units', 'normalized', 'Position', [0.05, 0.05, 0.9, 0.04], 'Callback', @frameSliderCallback);
    GUIHandles.roiButton = uicontrol('Style', 'pushbutton', 'String', 'Refine ROI', 'Units', 'normalized', 'Position', [0.05, 0.92, 0.15, 0.05], 'Callback', @refineROI);
    GUIHandles.extractAreaButton = uicontrol('Style', 'pushbutton', 'String', 'Extract Timecourse', 'Units', 'normalized', 'Position', [0.8, 0.92, 0.15, 0.05], 'Callback', @ExtractTimecourse);
    GUIHandles.extractAreaButton = uicontrol('Style', 'pushbutton', 'String', 'Extract Frames', 'Units', 'normalized', 'Position', [0.6, 0.92, 0.15, 0.05], 'Callback', @ExtractTif);
    GUIHandles.framenumberDisplay = uicontrol('Style', 'text', 'String', 'Frame: 1', 'HorizontalAlignment', 'left', 'Units', 'normalized', 'Position', [0.22, 0.91, 0.2, 0.05]);
    GUIHandles.areaDisplay = uicontrol('Style', 'text', 'String', 'Area: ', 'HorizontalAlignment', 'left','Units', 'normalized', 'Position', [0.3, 0.91, 0.3, 0.05]);
    

    GUIHandles.roiRect = [ceil(GUIHandles.imageAxes.XLim(1)),ceil(GUIHandles.imageAxes.YLim(1)),floor(GUIHandles.imageAxes.XLim(2)),floor(GUIHandles.imageAxes.YLim(2))];
    GUIHandles.roiRect = [GUIHandles.roiRect(1),GUIHandles.roiRect(2),GUIHandles.roiRect(3)-GUIHandles.roiRect(1),GUIHandles.roiRect(4)-GUIHandles.roiRect(2)]; % this line is just there to make the outermost frame be withing boundaries
    GUIHandles = drawROIrect(GUIHandles);
    
    update_frame(GUIHandles, 1, true);
    
    guidata(GUI, GUIHandles);
    
end

function frameSliderCallback(GUI, eventdata)
    GUIHandles = guidata(GUI);
    cur_frame = int32(GUIHandles.frameSlider.Value) + 1;
    update_frame(GUIHandles, cur_frame, true);
    guidata(GUI, GUIHandles);
end

function [a,b,Xc,Yc] = update_frame(GUIHandles, cur_frame, update_display)
    
    GUIHandles.framenumberDisplay.String = strcat('Frame: ', int2str(cur_frame));
    
    if update_display
        GUIHandles.displayedImage = imagesc(GUIHandles.data(:,:,:,cur_frame), 'Parent', GUIHandles.imageAxes, [0, GUIHandles.pixelMaxVal]);
    end
    pupil_data = squeeze(GUIHandles.data(:,:,:,cur_frame));
    
    pupil_data = pupil_data(GUIHandles.roiRect(2):GUIHandles.roiRect(2)+GUIHandles.roiRect(4),GUIHandles.roiRect(1):GUIHandles.roiRect(1)+GUIHandles.roiRect(3));
    
    pupil_data = double(pupil_data - min(min(pupil_data)));
    pupil_data = pupil_data ./ max(max(pupil_data));
    %pupil_data = int16(pupil_data);
    
    pupil_data(pupil_data >= GUIHandles.pixelThreshold) = 1;
    pupil_data(pupil_data < GUIHandles.pixelThreshold) = 0;
    
    
    if update_display
        GUIHandles.pupilImage = imagesc(pupil_data, 'Parent', GUIHandles.imageAxes2);
    end
    
    s = regionprops(pupil_data, {'Centroid','MajorAxisLength', 'MinorAxisLength','Orientation'});
    t = linspace(0,2*pi,50);
    hold on
    for k = 1:length(s)
        a = s(k).MajorAxisLength/2;
        b = s(k).MinorAxisLength/2;
        Xc = s(k).Centroid(1);
        Yc = s(k).Centroid(2);
        phi = deg2rad(-s(k).Orientation);
        x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
        y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
        x = x + double(GUIHandles.roiRect(1)-1);
        y = y + double(GUIHandles.roiRect(2)-1);
        if update_display
            
            plot(x,y,'r','Linewidth',2, 'Color','r');
            
            scatter(Xc + double(GUIHandles.roiRect(1)-1), Yc + double(GUIHandles.roiRect(2)-1),'filled', 'MarkerEdgeColor','r', 'MarkerFaceColor', 'r');
        end
    end
    hold off
    
    if update_display
        GUIHandles.areaDisplay.String = strcat('Ellipse area: ', int2str(pi * a * b));
    end
    
%     [centers, radii, ~] = imfindcircles(pupil_data,[12,32], 'Sensitivity',1);
%     best_circle_center = centers(1,:);
%     best_circle_radius = radii(1,:);
%     best_circle_center(1) = best_circle_center(1) + GUIHandles.roiRect(1);
%     best_circle_center(2) = best_circle_center(2) + GUIHandles.roiRect(2);
%     
%     viscircles(best_circle_center, best_circle_radius, 'Color','w');
    
    if update_display
        GUIHandles = drawROIrect(GUIHandles);
    end
end   

function refineROI(GUI, eventdata)
    GUIHandles = guidata(GUI);
    GUIHandles.roiRect = int16(getrect(GUIHandles.imageAxes));
    GUIHandles = drawROIrect(GUIHandles);
    cur_frame = int32(GUIHandles.frameSlider.Value) + 1;
    update_frame(GUIHandles, cur_frame, true);
    guidata(GUI, GUIHandles);
end

function GUIHandles = drawROIrect(GUIHandles)
    if isfield(GUIHandles, 'roiRectangleHandle')
        delete(GUIHandles.roiRectangleHandle)
    end
    GUIHandles.roiRectangleHandle = rectangle('Position',GUIHandles.roiRect , 'EdgeColor','w','LineWidth',3);
end

function ExtractTimecourse(GUI, eventdata)
    GUIHandles = guidata(GUI);
    disp('Extracting timecourse...');
    pupil_area_timecourse = zeros(GUIHandles.maxIndex,1);
    pupil_center_timecourse = zeros(GUIHandles.maxIndex,2);
    for i = 1:GUIHandles.maxIndex
        [a,b,xc,yc] = update_frame(GUIHandles, i, false);
        pupil_area_timecourse(i) = pi * a * b;
        pupil_center_timecourse(i,1) = xc;
        pupil_center_timecourse(i,2) = yc;
    end
    disp('Done extracting timecourse...');
    figure();
    ax1 = subplot(221);
    plot(pupil_area_timecourse);
    ax2 = subplot(223);
    hold on;
    plot(pupil_center_timecourse(:,1) - median(pupil_center_timecourse(:,1)), 'Color','b');
    plot(pupil_center_timecourse(:,2) - median(pupil_center_timecourse(:,2)), 'Color','g');
    hold off;
    linkaxes([ax1,ax2], 'x');
    
    ax3 = subplot(222);
    scatter(pupil_area_timecourse, pupil_center_timecourse(:,1), 'MarkerEdgeColor','b');
    ax4 = subplot(224);
    scatter(pupil_area_timecourse, pupil_center_timecourse(:,2), 'MarkerEdgeColor','g');
    
    fname = strtok(GUIHandles.fname,'.');
    roiRect = GUIHandles.roiRect;
    save(strcat(GUIHandles.fpath,fname,'_analyzed.mat'),'pupil_area_timecourse','pupil_center_timecourse','roiRect');
    disp(strcat('saved:', strcat(GUIHandles.fpath,fname,'_analyzed.mat')));
    
    guidata(GUI, GUIHandles);
end


function ExtractTif(GUI, eventdata)
disp('Start extracting TIF...');
    GUIHandles = guidata(GUI);
    from_frame = int32(GUIHandles.frameSlider.Value) + 1;
    k = from_frame;
    to_frame = from_frame + 50;
    while(k <= to_frame)
        frame = squeeze(GUIHandles.data(:,:,:,k));
        if(k==from_frame)
            imwrite(frame,[GUIHandles.fpath GUIHandles.fname '.tif'],'tif');
        else
            imwrite(frame,[GUIHandles.fpath GUIHandles.fname '.tif'],'tif','writemode','append');
        end
        k = k+1;
    end
    disp('Done extracting TIF...');
end





