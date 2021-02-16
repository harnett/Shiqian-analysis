function sbxAnalysis2()

    %SBXANALYSIS Graphic interface for analyzing calcium imaging data.
    %   SBXANALYSIS() creates a graphic interface for processing and analyzing calcium imaging data in .sbx format.

    GUI = figure('Name', 'Scanbox Analysis', 'NumberTitle', 'off', 'MenuBar', 'none', 'Color', 'w', 'Units', 'normalized', 'Position', [0,0.1,0.85,0.85]);

    zoom(GUI, 'off');
    pan(GUI, 'off');
    
    % figure handles are passed from function to function
    GUIHandles = guihandles(GUI);
    
    % set display adjustment default values
    GUIHandles.defaultResonantOffset = 0;
    GUIHandles.defaultBrightness = 0.0;
    GUIHandles.defaultContrast = 1.0;
    
    % specify number of frames on each side for rolling average
    GUIHandles.rollingWindowSize = [1, 1];
    
    % set the kernel for different gaussian filters
    GUIHandles.motionCorrectGaussianFilter = 2.0;
    GUIHandles.computeGaussianFilter = 0.0;
    GUIHandles.displayGaussianFilter = 1.0;
    GUIHandles.extractionGaussianFilter = 1.0;
    
    % set minimum size of isolated region in ROI
    GUIHandles.roiDrawing.defaultMinIslandSize = 30;
    GUIHandles.roiDrawing.minIslandSize = GUIHandles.roiDrawing.defaultMinIslandSize;
    GUIHandles.roiDrawing.maxMinIslandSize = 100;
    
    % initialize roi hierarchy
    GUIHandles.roiDrawing.roiTreeID = {};
    GUIHandles.roiDrawing.roiTreeCurrentParent = '0';
    GUIHandles.roiDrawing.previousRoiTree = {};
        
    % set neuropil size
    GUIHandles.roiDrawing.neuropilSize = 7;
    GUIHandles.roiDrawing.maxNeuropilSize = 15;

    % set neuropil correction weight
    GUIHandles.roiDrawing.neuropilCorrection = 0.75;
    
    % set default setting for number of pixels to include in flood filling
    GUIHandles.roiDrawing.defaultFloodPixels = 250;
    GUIHandles.roiDrawing.floodPixels = GUIHandles.roiDrawing.defaultFloodPixels;
    
    % set default pixel intensity below which to remove pixels;
    GUIHandles.roiDrawing.pruneThreshold = 0;
    
    % set the threshold for correlation coefficient at which ROIs should be clustered
    GUIHandles.roiDrawing.correlationThreshold = 0.95;
    
    % add tag for roi masks so its easy to have multiple masks for each FOV
    GUIHandles.roiMaskTag = '';
    
    GUIHandles.parentFigure = GUI;
           
    GUIHandles.loadSBXButton = uicontrol('Style', 'pushbutton', 'String', 'Load SBX Imaging Data', 'Units', 'normalized', 'Position', [0.013, 0.92, 0.074, 0.05], 'Callback', @loadSBXCallback);
    GUIHandles.loadTIFButton = uicontrol('Style', 'pushbutton', 'String', 'Load TIF Imaging Data', 'Units', 'normalized', 'Position', [0.013, 0.865, 0.074, 0.05], 'Callback', @loadTIFCallback);
    
    % save handles to figure
    guidata(GUI, GUIHandles);
    
end

function loadTIFCallback(GUI, ~)
    try
        [tifName, tifPath] = uigetfile('.tif', 'Please select file containing imaging data.');
    catch
        waitfor(msgbox('Error: Please select valid .tif file.'));
        error('Please select valid .tif file.');
    end
    
    % pull off the file extension
    tifName = strtok(tifName, '.');

    Info.sz = [128,512];
    
    Info.isTif = 1;
    Info.nChannels = 1;
    Info.volscan = 0;
    Info.otwave_um = [];
    Info.otwave = [];
    Info.otparam = [];
    Info.otwavestyle = [];
    Info.scanbox_version = 2;
    Info.scanmode = 1;
    %Info.Directory = tifPath;
    Info.Directory.folder = tifPath;
    Info.Directory.name = tifName;
    Info.tifName = tifName;
    
    % we currently load the entire tifstack into memory
%     tifData = zeros(Info.sz(1),Info.sz(2),Info.maxIndex, 'uint16');
    tifObject = Tiff([tifPath, tifName,'.tif'],'r');
    
    
    tifData(:,:,1) = tifObject.read(); % Read the first image to get the array dimensions correct.
    if tifObject.lastDirectory()
         return; % If the file only contains one page, we do not need to continue.
    end
    % Read all remaining pages (directories) in the file
    tifObject.nextDirectory();
    while true
        tifData(:,:,end+1) = tifObject.read();
        if tifObject.lastDirectory()
            break;
        else
            tifObject.nextDirectory();
        end
    end
    
    Info.maxIndex = size(tifData);
    Info.maxIndex = Info.maxIndex(3);
    
%     for i=1:Info.maxIndex
%         tifObject.setDirectory(i);
%         tifData(:,:,i) = tifObject.read();
%     end
    
    if max(max(max(tifData(:,:,:)))) < 4096 % check if range is 4096 (i.e. 8 bit uint) and scale it to 16 bit uint
        for i=1:Info.maxIndex
            tifData(:,:,i) = tifData(:,:,i) * (intmax('uint16')/4096);
        end
    end
    
    GUIHandles = guidata(GUI);
    
    GUIHandles.tifData = tifData;
    GUIHandles.tifObject = tifObject;
    %tifObject.close()

    GUIHandles.parentFigure.Name = ['Scanbox Analysis: ', tifName];
    disp(['Loading ', tifPath, tifName, '.tif']);
    
    % make load data button invisible to replace with load new data button
    GUIHandles.loadSBXButton.Visible = 'off';

    GUIHandles.modeTabGroup = uitabgroup('Parent', GUIHandles.parentFigure, 'SelectionChangedFcn', @modeTabGroupSelectionFunction);
    GUIHandles.imageProcessingTab = uitab('Parent', GUIHandles.modeTabGroup, 'Title', 'Image Processing', 'BackgroundColor', 'w');
    GUIHandles.roiDrawingTab = uitab('Parent', GUIHandles.modeTabGroup, 'Title', 'ROI Drawing', 'BackgroundColor', 'w');
    GUIHandles.roiPairingTab = uitab('Parent', GUIHandles.modeTabGroup, 'Title', 'ROI Pairing', 'BackgroundColor', 'w');
    
    % start ROI tabs as invisible
    GUIHandles.roiDrawingTab.Parent = [];
    GUIHandles.roiPairingTab.Parent = [];
    
    % save details about the .sbx file
    GUIHandles.tifPath = tifPath;
    GUIHandles.tifName = tifName;
    GUIHandles.Info = Info;
    
    GUIHandles.imageSize = Info.sz;
    
    GUIHandles.mode = 'Image Processing';
    GUIHandles.resonantOffset = GUIHandles.defaultResonantOffset;
    GUIHandles.zoomCenter = [];
    GUIHandles.frameSliderValue = 0;
    
    GUIHandles.motionCorrected = false;
    
    % check if data has already been motion corrected
    if exist([tifPath, tifName, '.rigid'], 'file')
        load([tifPath, tifName, '.rigid'], '-mat', 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop', 'shifts_x', 'shifts_y');
        
        GUIHandles.phaseDifferences = phaseDifferences;
        GUIHandles.rowShifts = rowShifts;
        GUIHandles.columnShifts = columnShifts;
        GUIHandles.frameCrop = frameCrop;
        
        GUIHandles.imageSize = [Info.sz(1) - frameCrop(3) - frameCrop(4), Info.sz(2) - frameCrop(1) - frameCrop(2)];
        
        GUIHandles.motionCorrected = true;
        GUIHandles.shifts_x = shifts_x;
        GUIHandles.shifts_y = shifts_y;
    
        % if cross-correlation and other stuff has been computed, make Analyze tab visible
        if exist([tifPath, tifName, '.pre'], 'file')
            GUIHandles.roiDrawingTab.Parent = GUIHandles.modeTabGroup;

            GUIHandles.preLoaded = false;
            GUIHandles.localCCLoaded = false;
        end
    % this is an older naming convention of the rigid alignment data
    elseif exist([tifPath, tifName, '.align'], 'file')
        load([tifPath, tifName, '.align'], '-mat', 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop');
        
        GUIHandles.phaseDifferences = phaseDifferences;
        GUIHandles.rowShifts = rowShifts;
        GUIHandles.columnShifts = columnShifts;
        GUIHandles.frameCrop = frameCrop;
        
        GUIHandles.imageSize = [Info.sz(1) - frameCrop(3) - frameCrop(4), Info.sz(2) - frameCrop(1) - frameCrop(2)];
        
        GUIHandles.motionCorrected = true;
    
        if exist([tifPath, tifName, '.pre'], 'file')
            GUIHandles.roiDrawingTab.Parent = GUIHandles.modeTabGroup;

            GUIHandles.preLoaded = false;
            GUIHandles.localCCLoaded = false;
        end
    elseif isfield(Info, 'gathered') && Info.gathered == 1
        GUIHandles.roiPairingTab.Parent = GUIHandles.modeTabGroup;
        
        % package up figure handles before calling a new function...
        guidata(GUI, GUIHandles);
       
        setupROIPairingTab(GUI);
       
        % ... then update them if they were modified
        GUIHandles = guidata(GUI);
    end
    
    guidata(GUI, GUIHandles);
    
    setupImageProcessingTab(GUI);
    
    GUIHandles = guidata(GUI);
    
    % attach customized functions to figure
    set(GUIHandles.parentFigure, 'WindowScrollWheelFcn', @scrollFunction);
    set(GUIHandles.parentFigure, 'KeyPressFcn', @keyPressFunction);
    set(GUIHandles.parentFigure, 'KeyReleaseFcn', @keyReleaseFunction);
    
    guidata(GUI, GUIHandles);
    
    updateImageDisplay(GUI);
end

function loadSBXCallback(GUI, ~)
    
    try
        [sbxName, sbxPath] = uigetfile('.sbx', 'Please select file containing imaging data.');
    catch
        waitfor(msgbox('Error: Please select valid .sbx file.'));
        error('Please select valid .sbx file.');
    end
    
    % pull off the file extension
    sbxName = strtok(sbxName, '.');
    
    Info = sbxInfo([sbxPath, sbxName]);
    Info.isTif = 0; 
    
    GUIHandles = guidata(GUI);
    

    GUIHandles.parentFigure.Name = ['Scanbox Analysis: ', sbxName];
    disp(['Loading ', sbxPath, sbxName, '.sbx']);
    
    % make load data button invisible to replace with load new data button
    GUIHandles.loadSBXButton.Visible = 'off';

    GUIHandles.modeTabGroup = uitabgroup('Parent', GUIHandles.parentFigure, 'SelectionChangedFcn', @modeTabGroupSelectionFunction);
    GUIHandles.imageProcessingTab = uitab('Parent', GUIHandles.modeTabGroup, 'Title', 'Image Processing', 'BackgroundColor', 'w');
    GUIHandles.roiDrawingTab = uitab('Parent', GUIHandles.modeTabGroup, 'Title', 'ROI Drawing', 'BackgroundColor', 'w');
    GUIHandles.roiPairingTab = uitab('Parent', GUIHandles.modeTabGroup, 'Title', 'ROI Pairing', 'BackgroundColor', 'w');
    
    % start ROI tabs as invisible
    GUIHandles.roiDrawingTab.Parent = [];
    GUIHandles.roiPairingTab.Parent = [];
    
    % save details about the .sbx file
    GUIHandles.sbxPath = sbxPath;
    GUIHandles.sbxName = sbxName;
    GUIHandles.Info = Info;
    
    GUIHandles.imageSize = Info.sz;
    
    GUIHandles.mode = 'Image Processing';
    GUIHandles.resonantOffset = GUIHandles.defaultResonantOffset;
    GUIHandles.zoomCenter = [];
    GUIHandles.frameSliderValue = 0;
    
    GUIHandles.motionCorrected = false;
    
    % check if data has already been motion corrected
    if exist([sbxPath, sbxName, '.rigid'], 'file')
        load([sbxPath, sbxName, '.rigid'], '-mat', 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop');
        
        GUIHandles.phaseDifferences = phaseDifferences;
        GUIHandles.rowShifts = rowShifts;
        GUIHandles.columnShifts = columnShifts;
        GUIHandles.frameCrop = frameCrop;
        
        GUIHandles.imageSize = [Info.sz(1) - frameCrop(3) - frameCrop(4), Info.sz(2) - frameCrop(1) - frameCrop(2)];
        
        GUIHandles.motionCorrected = true;
    
        % if cross-correlation and other stuff has been computed, make Analyze tab visible
        if exist([sbxPath, sbxName, '.pre'], 'file')
            GUIHandles.roiDrawingTab.Parent = GUIHandles.modeTabGroup;

            GUIHandles.preLoaded = false;
            GUIHandles.localCCLoaded = false;
        end
        
    % this is an older naming convention of the rigid alignment data
    elseif exist([sbxPath, sbxName, '.align'], 'file')
        load([sbxPath, sbxName, '.align'], '-mat', 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop');
        
        GUIHandles.phaseDifferences = phaseDifferences;
        GUIHandles.rowShifts = rowShifts;
        GUIHandles.columnShifts = columnShifts;
        GUIHandles.frameCrop = frameCrop;
        
        GUIHandles.imageSize = [Info.sz(1) - frameCrop(3) - frameCrop(4), Info.sz(2) - frameCrop(1) - frameCrop(2)];
        
        GUIHandles.motionCorrected = true;
    
        if exist([sbxPath, sbxName, '.pre'], 'file')
            GUIHandles.roiDrawingTab.Parent = GUIHandles.modeTabGroup;

            GUIHandles.preLoaded = false;
            GUIHandles.localCCLoaded = false;
        end
    elseif isfield(Info, 'gathered') && Info.gathered == 1
        GUIHandles.roiPairingTab.Parent = GUIHandles.modeTabGroup;
        
        % package up figure handles before calling a new function...
        guidata(GUI, GUIHandles);
       
        setupROIPairingTab(GUI);
       
        % ... then update them if they were modified
        GUIHandles = guidata(GUI);
    end
    
    guidata(GUI, GUIHandles);
    
    setupImageProcessingTab(GUI);
    
    GUIHandles = guidata(GUI);
    
    % attach customized functions to figure
    set(GUIHandles.parentFigure, 'WindowScrollWheelFcn', @scrollFunction);
    set(GUIHandles.parentFigure, 'KeyPressFcn', @keyPressFunction);
    set(GUIHandles.parentFigure, 'KeyReleaseFcn', @keyReleaseFunction);
    
    guidata(GUI, GUIHandles);
    
    updateImageDisplay(GUI);
   
end

function modeTabGroupSelectionFunction(GUI, eventdata)

    GUIHandles = guidata(GUI);
    
    GUIHandles.mode = eventdata.NewValue.Title;
    
    if strcmp(GUIHandles.mode, 'ROI Drawing')
        
        % the first time the Analyze tab is clicked on, load the .pre data (if it is not yet loaded)
        if ~GUIHandles.preLoaded          
            if GUIHandles.Info.isTif == 1
                temp = who('-file', [GUIHandles.tifPath, GUIHandles.tifName, '.pre']);
                fPath = GUIHandles.tifPath;
                fName = GUIHandles.tifName;
            else
                temp = who('-file', [GUIHandles.sbxPath, GUIHandles.sbxName, '.pre']);
                fPath = GUIHandles.sbxPath;
                fName = GUIHandles.sbxName;
            end
            
            % accomodate multiple previous versions
            if ismember('meanImage', temp)
                load([fPath, fName, '.pre'], '-mat', 'meanImage', 'maxIntensityImage', 'crossCorrelationImage', 'pcaImage')

                GUIHandles.roiDrawing.meanImage = meanImage/double(intmax('uint16'));
                GUIHandles.roiDrawing.maxIntensityImage = maxIntensityImage/double(intmax('uint16'));        
                GUIHandles.roiDrawing.crossCorrelationImage = crossCorrelationImage;
                GUIHandles.roiDrawing.pcaImage = pcaImage/max(pcaImage(:));
            elseif ismember('mean ', temp)
                load([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], '-mat', 'meanReference', 'maxIntensityProjection', 'ccImage', 'pcaImage')

                GUIHandles.roiDrawing.meanImage = meanReference/double(intmax('uint16'));
                GUIHandles.roiDrawing.maxIntensityImage = maxIntensityProjection/double(intmax('uint16'));        
                GUIHandles.roiDrawing.crossCorrelationImage = ccImage;
                GUIHandles.roiDrawing.pcaImage = pcaImage/max(pcaImage(:));
            elseif ismember('meanref', temp)
                load([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], '-mat', 'meanref', 'ccimage', 'pcaimage', 'mean_brightness')

                GUIHandles.roiDrawing.meanImage = meanref;
                GUIHandles.roiDrawing.crossCorrelationImage = ccimage;
                GUIHandles.roiDrawing.pcaImage = pcaimage;
            end

            GUIHandles.preLoaded = true;
            GUIHandles.localCCLoaded = false;
            
            guidata(GUI, GUIHandles);
            
            setupROIDrawingTab(GUI);
            
            GUIHandles = guidata(GUI);
        end
    end
    
    guidata(GUI, GUIHandles);
    
    frameSliderCallback(GUI);
    
end

function setupImageProcessingTab(GUI)

    GUIHandles = guidata(GUI);
    
    GUIHandles.imageProcessing.imageAxes = axes('Parent', GUIHandles.imageProcessingTab, 'Units', 'normalized', 'Position', [0.1, 0.0, 0.8, 1.0]);
    GUIHandles.imageProcessing.displayedImage = imagesc(zeros(GUIHandles.imageSize), 'Parent', GUIHandles.imageProcessing.imageAxes, [0, 1]);    
    GUIHandles.imageProcessing.imageAxes.CLimMode = 'manual';
    axis(GUIHandles.imageProcessing.imageAxes, 'image');
    axis(GUIHandles.imageProcessing.imageAxes, 'off');
    
%     colormap(GUIHandles.imageProcessing.imageAxes, gray);
    
    GUIHandles.XLim = GUIHandles.imageProcessing.imageAxes.XLim;
    GUIHandles.YLim = GUIHandles.imageProcessing.imageAxes.YLim;
    GUIHandles.maxWindowSize = (GUIHandles.XLim(2) - GUIHandles.XLim(1))/2;
    GUIHandles.windowSize = GUIHandles.maxWindowSize;
    GUIHandles.windowRatio = (GUIHandles.YLim(2) - GUIHandles.YLim(1))/(GUIHandles.XLim(2) - GUIHandles.XLim(1));
    
    GUIHandles.imageProcessing.imageType = 'Rolling Average';

    GUIHandles.imageProcessing.loadNewSBXButton = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'pushbutton', 'String', 'Load New Data', 'Units', 'normalized', 'Position', [0.013, 0.93, 0.074, 0.05], 'Callback', @loadNewSBXCallback);
    
    GUIHandles.imageProcessing.saveScreenshotButton = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'pushbutton', 'String', 'Save Screenshot', 'Units', 'normalized', 'Position', [(0.1 - 0.068)/2, 0.85, 0.068, 0.05], 'Callback', @saveScreenshotCallback);

    GUIHandles.imageProcessing.imageTypeButtonGroup = uibuttongroup('Parent', GUIHandles.imageProcessingTab, 'Title', 'Display', 'TitlePosition', 'centertop', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.7495, 0.085, 0.063], 'SelectionChangedFcn', @imageTypeButtonGroupSelectionFunction);
    GUIHandles.imageProcessing.rollingButton = uicontrol('Parent', GUIHandles.imageProcessing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'Rolling Average', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 0.5, 0.9, 0.5]);
    GUIHandles.imageProcessing.frameButton = uicontrol('Parent', GUIHandles.imageProcessing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'Frame-by-Frame', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 0.0, 0.9, 0.5]);
    GUIHandles.imageProcessing.frameSlider = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'slider', 'Min', 0, 'Max', GUIHandles.Info.maxIndex, 'Value', 0, 'SliderStep', [1/GUIHandles.Info.maxIndex, 50/GUIHandles.Info.maxIndex], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.imageProcessing.imageTypeButtonGroup.Position(2) - 0.0175, 0.085, 0.015], 'Callback', @frameSliderCallback);
    
    GUIHandles.imageProcessing.displayChannel = 'green channel';
    GUIHandles.imageProcessing.channelButtonGroup = uibuttongroup('Parent', GUIHandles.imageProcessingTab, 'Title', 'Channel', 'TitlePosition', 'centertop', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.58, 0.085, 0.063], 'SelectionChangedFcn', @channelButtonGroupSelectionFunction);
    GUIHandles.imageProcessing.greenChannelButton = uicontrol('Parent', GUIHandles.imageProcessing.channelButtonGroup, 'Style', 'radiobutton', 'String', 'green channel', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 0.5, 0.9, 0.5]);
    GUIHandles.imageProcessing.redChannelButton = uicontrol('Parent', GUIHandles.imageProcessing.channelButtonGroup, 'Style', 'radiobutton', 'String', 'red channel', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 0.0, 0.9, 0.5]);
    if GUIHandles.Info.nChannels < 2
        set(GUIHandles.imageProcessing.redChannelButton,'Enable','off');
    end
    
    GUIHandles.imageProcessing.heatVisionButton = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'checkbox', 'String', 'Heat Vision', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [(0.1 - 0.06)/2, GUIHandles.imageProcessing.frameSlider.Position(2) - 0.075, 0.06, 0.025], 'Callback', @heatVisionCallback);
    
    GUIHandles.imageProcessing.resetButton = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'pushbutton', 'String', 'Reset', 'Units', 'normalized', 'Position', [(0.1 - 0.04)/2, 0.128, 0.04, 0.025], 'Callback', @resetCallback);
    
    GUIHandles.imageProcessing.resonantOffsetText = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'text', 'String', 'Resonant Offset', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.11, 0.085, 0.0175]);
    GUIHandles.imageProcessing.resonantOffsetSlider = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'slider', 'Min', -5, 'Max', 5, 'Value', GUIHandles.defaultResonantOffset, 'SliderStep', [1/10, 4/10], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.imageProcessing.resonantOffsetText.Position(2) - 0.015, 0.085, 0.015], 'Callback', @resonantOffsetSliderCallback);

    GUIHandles.imageProcessing.brightnessText = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'text', 'String', 'Brightness', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.07, 0.085, 0.0175]);
    GUIHandles.imageProcessing.brightnessSlider = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'slider', 'Min', -0.9, 'Max', 0.9, 'Value', GUIHandles.defaultBrightness, 'SliderStep', [0.01, 0.2], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.imageProcessing.brightnessText.Position(2) - 0.015, 0.085, 0.015], 'Callback', @brightnessSliderCallback);

    GUIHandles.imageProcessing.contrastText = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'text', 'String', 'Contrast', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.03, 0.085, 0.0175]);
    GUIHandles.imageProcessing.contrastSlider = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'slider', 'Min', 0.5, 'Max', 10.0, 'Value', GUIHandles.defaultContrast, 'SliderStep', [0.05, 0.25], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.imageProcessing.contrastText.Position(2) - 0.015, 0.085, 0.015], 'Callback', @contrastSliderCallback);
        
    GUIHandles.roiDrawing.exportTifraw = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'pushbutton', 'String', 'Export .tif', 'Units', 'normalized', 'Position', [0.013, 0.33, 0.074, 0.05], 'Callback', @exportTif);
    GUIHandles.roiDrawing.exportTifFromraw = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'edit', 'String', 'from', 'BackgroundColor', 'w', 'Visible', 'on', 'Units', 'normalized', 'Position', [0.013, 0.31, 0.035, 0.0175]);
    GUIHandles.roiDrawing.exportTifToraw = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'edit', 'String', 'to', 'BackgroundColor', 'w', 'Visible', 'on', 'Units', 'normalized', 'Position', [0.052, 0.31, 0.035, 0.0175]);
    
    GUIHandles.imageProcessing.saveMovieButton = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'pushbutton', 'String', 'Save Movie', 'Units', 'normalized', 'Position', [0.9 + (0.1 - 0.068)/2, 0.93, 0.068, 0.05], 'Callback', @saveMovieCallback);
    
    GUIHandles.imageProcessing.gatherButton = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'pushbutton', 'String', 'Gather Image Stacks', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9 + (0.1 - 0.082)/2, 0.865, 0.082, 0.05], 'Callback', @gatherCallback);
    
    GUIHandles.imageProcessing.splitButton = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'pushbutton', 'String', 'Split Scanning Planes', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9 + (0.1 - 0.082)/2, 0.865, 0.082, 0.05], 'Callback', @splitCallback);
            
    if GUIHandles.Info.volscan == 1
        if ~isempty(GUIHandles.Info.otwave_um)
            temp = GUIHandles.Info.otwave_um;
        else
            temp = GUIHandles.Info.otwave;
        end
    
        if length(temp) > 7
            if ~isfield(GUIHandles.Info, 'gathered')
                GUIHandles.imageProcessing.gatherButton.Visible = 'on';
            end
        else
            if ~isfield(GUIHandles.Info, 'split')
                GUIHandles.imageProcessing.splitButton.Visible = 'on';
            end
        end
    end
    
    GUIHandles.imageProcessing.motionCorrectButton = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'pushbutton', 'String', 'Align Frames', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9 + (0.1 - 0.068)/2, 0.8, 0.068, 0.05], 'Callback', @motionCorrectCallback);
    
    if ~GUIHandles.motionCorrected
        if GUIHandles.Info.volscan == 1
            if isfield(GUIHandles.Info, 'split') && GUIHandles.Info.split
                GUIHandles.imageProcessing.motionCorrectButton.Visible = 'on';
            end
        else
            GUIHandles.imageProcessing.motionCorrectButton.Visible = 'on';
        end
    end
    
    GUIHandles.imageProcessing.computeButton = uicontrol('Parent', GUIHandles.imageProcessingTab, 'Style', 'pushbutton', 'String', 'Process Data', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9 + (0.1 - 0.068)/2, 0.735, 0.068, 0.05], 'Callback', @computeCallback);

    if GUIHandles.Info.isTif == 1
        if GUIHandles.motionCorrected
            if ~exist([GUIHandles.tifPath, GUIHandles.tifName, '.pre'], 'file')
                GUIHandles.imageProcessing.computeButton.Visible = 'on';
            end
        end
    else
        if GUIHandles.motionCorrected
            if ~exist([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], 'file')
                GUIHandles.imageProcessing.computeButton.Visible = 'on';
            end
        end
    end
    
    guidata(GUI, GUIHandles);

end

function setupROIDrawingTab(GUI)
            
    GUIHandles = guidata(GUI);

    % initialize currently selected ROI
    GUIHandles.roiDrawing.selectedROI = 0;

    GUIHandles.roiDrawing.imageAxes = axes('Parent', GUIHandles.roiDrawingTab, 'Units', 'normalized', 'Position', [0.1, 0.0, 0.8, 1.0]);
    GUIHandles.roiDrawing.displayedImage = imagesc(GUIHandles.roiDrawing.meanImage, 'Parent', GUIHandles.roiDrawing.imageAxes, [0, 1]);
    GUIHandles.roiDrawing.imageAxes.CLimMode = 'manual';
    axis(GUIHandles.roiDrawing.imageAxes, 'image');
    axis(GUIHandles.roiDrawing.imageAxes, 'off');
    
%     colormap(GUIHandles.roiDrawing.imageAxes, gray);
    
    % set the starting settings
    GUIHandles.roiDrawing.imageType = 'Mean';
    GUIHandles.roiDrawing.manipulateType = 'Draw';
    GUIHandles.roiDrawing.drawType = 'Pixel';
    
    % this is for the play function
    GUIHandles.roiDrawing.cancel = false;

    % initialize various masks
    GUIHandles.roiDrawing.roiMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.previousROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.overlapMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.previousOverlapMask = zeros(GUIHandles.imageSize);

    hold(GUIHandles.roiDrawing.imageAxes, 'on');

    % initialize the different ROI images that will be overlaid onto the calcium images - overlap is at the bottom so it has lowest priority
    GUIHandles.roiDrawing.overlapImage = image(GUIHandles.roiDrawing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0, 1, 0], [1, 1, 3])));
    GUIHandles.roiDrawing.roiImage = image(GUIHandles.roiDrawing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.6, 0, 0], [1, 1, 3])));
    GUIHandles.roiDrawing.candidateROIImage = image(GUIHandles.roiDrawing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0, 0, 1], [1, 1, 3])));
    GUIHandles.roiDrawing.selectedROIImage = image(GUIHandles.roiDrawing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.294, 0, 0.51], [1, 1, 3])));
    GUIHandles.roiDrawing.neuropilImage = image(GUIHandles.roiDrawing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.294, 0, 0.51], [1, 1, 3])));
    GUIHandles.roiDrawing.islandImage = image(GUIHandles.roiDrawing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.5, 0.5, 0.5], [1, 1, 3])));

    hold(GUIHandles.roiDrawing.imageAxes, 'off');

    GUIHandles.roiDrawing.candidateROIImage.Visible = 'off';
    GUIHandles.roiDrawing.selectedROIImage.Visible = 'off';
    GUIHandles.roiDrawing.overlapImage.Visible = 'on';
    GUIHandles.roiDrawing.neuropilImage.Visible = 'off';
    GUIHandles.roiDrawing.islandImage.Visible = 'off';

    % you have to do this after axes initialization and adding any image
    axis(GUIHandles.roiDrawing.imageAxes, 'image');
    axis(GUIHandles.roiDrawing.imageAxes, 'off');

    GUIHandles.roiDrawing.loadNewSBXButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Load New Data', 'Units', 'normalized', 'Position', [0.013, 0.93, 0.074, 0.05], 'Callback', @loadNewSBXCallback);

    GUIHandles.roiDrawing.saveScreenshotButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Save Screenshot', 'Units', 'normalized', 'Position', [(0.1 - 0.068)/2, 0.85, 0.068, 0.05], 'Callback', @saveScreenshotCallback);

    GUIHandles.roiDrawing.imageTypeButtonGroup = uibuttongroup('Parent', GUIHandles.roiDrawingTab, 'Title', 'Display', 'TitlePosition', 'centertop', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.6625, 0.085, 0.15], 'SelectionChangedFcn', @imageTypeButtonGroupSelectionFunction);
    GUIHandles.roiDrawing.meanButton = uicontrol('Parent', GUIHandles.roiDrawing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'Mean', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 5.0/6.0, 0.9, 1.0/6.0]);
    GUIHandles.roiDrawing.maxButton = uicontrol('Parent', GUIHandles.roiDrawing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'Max Intensity', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 4.0/6.0, 0.9, 1.0/6.0]);
    GUIHandles.roiDrawing.ccButton = uicontrol('Parent', GUIHandles.roiDrawing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'Cross-Correlation', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 3.0/6.0, 0.9, 1.0/6.0]);
    GUIHandles.roiDrawing.pcaButton = uicontrol('Parent', GUIHandles.roiDrawing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'PCA', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 2.0/6.0, 0.9, 1.0/6.0]);
    GUIHandles.roiDrawing.rollingButton = uicontrol('Parent', GUIHandles.roiDrawing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'Rolling Average', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 1.0/6.0, 0.9, 1.0/6.0]);
    GUIHandles.roiDrawing.frameButton = uicontrol('Parent', GUIHandles.roiDrawing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'Frame-by-Frame', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 0.0, 0.9, 1.0/6.0]);
    GUIHandles.roiDrawing.frameSlider = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'slider', 'Min', 0, 'Max', GUIHandles.Info.maxIndex, 'Value', 0, 'SliderStep', [1/GUIHandles.Info.maxIndex, 10/GUIHandles.Info.maxIndex], 'Interruptible', 'on', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.0075, GUIHandles.roiDrawing.imageTypeButtonGroup.Position(2) - 0.0175, 0.085, 0.015], 'Callback', @frameSliderCallback);
    GUIHandles.roiDrawing.framenumberDisplay = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'text', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.0075, 0.54, 0.08, 0.019]);
    GUIHandles.roiDrawing.playButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Play', 'Interruptible', 'on', 'Visible', 'off', 'Units', 'normalized', 'Position', [(0.1 - 0.04)/2, 0.61, 0.04, 0.025], 'Callback', @playCallback);
    GUIHandles.roiDrawing.cancelPlayButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Cancel', 'Visible', 'off', 'Units', 'normalized', 'Position', [(0.1 - 0.04)/2, 0.61, 0.04, 0.025], 'Callback', @cancelCallback);
    GUIHandles.roiDrawing.sweepButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Sweep', 'Interruptible', 'on', 'Visible', 'off', 'Units', 'normalized', 'Position', [(0.1 - 0.04)/2, 0.58, 0.04, 0.025], 'Callback', @sweepCallback);
    GUIHandles.roiDrawing.cancelSweepButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Cancel', 'Visible', 'off', 'Units', 'normalized', 'Position', [(0.1 - 0.04)/2, 0.58, 0.04, 0.025], 'Callback', @cancelCallback);

    GUIHandles.roiDrawing.resetButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Reset', 'Units', 'normalized', 'Position', [(0.1 - 0.04)/2, 0.128, 0.04, 0.025], 'Callback', @resetCallback);
    
    GUIHandles.roiDrawing.resonantOffsetText = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'text', 'String', 'Resonant Offset', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.11, 0.085, 0.0175]);
    GUIHandles.roiDrawing.resonantOffsetSlider = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'slider', 'Min', -5, 'Max', 5, 'Value', GUIHandles.defaultResonantOffset, 'SliderStep', [1/10, 4/10], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.roiDrawing.resonantOffsetText.Position(2) - 0.015, 0.085, 0.015], 'Callback', @resonantOffsetSliderCallback);

    GUIHandles.roiDrawing.brightnessText = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'text', 'String', 'Brightness', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.07, 0.085, 0.0175]);
    GUIHandles.roiDrawing.brightnessSlider = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'slider', 'Min', -0.9, 'Max', 0.9, 'Value', GUIHandles.defaultBrightness, 'SliderStep', [0.01, 0.2], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.roiDrawing.brightnessText.Position(2) - 0.015, 0.085, 0.015], 'Callback', @brightnessSliderCallback);

    GUIHandles.roiDrawing.contrastText = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'text', 'String', 'Contrast', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.03, 0.085, 0.0175]);
    GUIHandles.roiDrawing.contrastSlider = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'slider', 'Min', 0.5, 'Max', 10.0, 'Value', GUIHandles.defaultContrast, 'SliderStep', [0.05, 0.25], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.roiDrawing.contrastText.Position(2) - 0.015, 0.085, 0.015], 'Callback', @contrastSliderCallback);
        
    GUIHandles.roiDrawing.loadROIMaskButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Load ROI Mask', 'Units', 'normalized', 'Position', [0.916, 0.93, 0.068, 0.05], 'Callback', @loadROIMaskCallback);
    GUIHandles.roiDrawing.newROIMaskButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'New ROI Mask', 'Units', 'normalized', 'Position', [0.916, 0.88, 0.068, 0.05], 'Callback', @newROIMaskCallback);

    GUIHandles.roiDrawing.extractFluorescencesButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Extract Fluorescences', 'Units', 'normalized', 'Position', [0.909, 0.805, 0.082, 0.04], 'Callback', @extractFluorescencesCallback);
    GUIHandles.roiDrawing.identifyROIsButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Identify Clusters', 'Units', 'normalized', 'Position', [0.915, 0.765, 0.07, 0.04], 'Callback', @identifyROIsCallback);
    GUIHandles.roiDrawing.undoButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Undo', 'Units', 'normalized', 'Position', [0.925, 0.725, 0.05, 0.04], 'Callback', @undoCallback);
    GUIHandles.roiDrawing.redoButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Redo', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.925, 0.725, 0.05, 0.04], 'Callback', @undoCallback);
    GUIHandles.roiDrawing.deleteROIsButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Delete ROI', 'Units', 'normalized', 'Position', [0.925, 0.685, 0.05, 0.04], 'Callback', @deleteROIsCallback);
    GUIHandles.roiDrawing.saveROIsButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Save ROIs', 'Units', 'normalized', 'Position', [0.925, 0.645, 0.05, 0.04], 'Callback', @saveROIsCallback);
    GUIHandles.roiDrawing.roiMaskTagTitle = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'text', 'String', 'Mask tag:', 'HorizontalAlignment','Center', 'Units', 'normalized', 'Position', [0.905, 0.625, 0.03, 0.02]);
    GUIHandles.roiDrawing.roiMaskTag = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'edit', 'String', '', 'HorizontalAlignment','Left', 'Units', 'normalized', 'Position', [0.936, 0.625, 0.06, 0.019]);
    
    
    GUIHandles.roiDrawing.hideROIsButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'checkbox', 'String', 'Hide ROIs', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.925, 0.6, 0.05, 0.025], 'Callback', @hideROIsCallback);
    
    GUIHandles.roiDrawing.ccLocalButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'checkbox', 'String', 'Local Cross-Correlation', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.9025, 0.575, 0.095, 0.025], 'Callback', @ccLocalCallback);

    GUIHandles.roiDrawing.manipulateROIsButtonGroup = uibuttongroup('Parent', GUIHandles.roiDrawingTab, 'Title', 'ROI Manipulation', 'TitlePosition', 'centertop', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.9125, 0.475, 0.075, 0.0849], 'SelectionChangedFcn', @manipulateROIsButtonGroupSelectionFunction);
    GUIHandles.roiDrawing.drawButton = uicontrol('Parent', GUIHandles.roiDrawing.manipulateROIsButtonGroup, 'Style', 'radiobutton', 'String', 'Draw', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.25, 2/3, 0.5, 1/3]);
    GUIHandles.roiDrawing.selectButton = uicontrol('Parent', GUIHandles.roiDrawing.manipulateROIsButtonGroup, 'Style', 'radiobutton', 'String', 'Select', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.25, 1/3, 0.5, 1/3]);
    GUIHandles.roiDrawing.pruneButton = uicontrol('Parent', GUIHandles.roiDrawing.manipulateROIsButtonGroup, 'Style', 'radiobutton', 'String', 'Prune', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.25, 0.0, 0.5, 1/3]);

    GUIHandles.roiDrawing.drawShapeButtonGroup = uibuttongroup('Parent', GUIHandles.roiDrawingTab, 'Title', 'ROI Draw Method', 'TitlePosition', 'centertop', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.9125, 0.3317, 0.075, 0.1283], 'SelectionChangedFcn', @drawTypeButtonGroupSelectionFunction);
    GUIHandles.roiDrawing.floodfillButton = uicontrol('Parent', GUIHandles.roiDrawing.drawShapeButtonGroup, 'Style', 'radiobutton', 'String', 'Pixel', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.15, 0.8, 0.7, 0.2]);
    GUIHandles.roiDrawing.freeHandButton = uicontrol('Parent', GUIHandles.roiDrawing.drawShapeButtonGroup, 'Style', 'radiobutton', 'String', 'Free Hand', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.15, 0.6, 0.7, 0.2]);
    GUIHandles.roiDrawing.polygonButton = uicontrol('Parent', GUIHandles.roiDrawing.drawShapeButtonGroup, 'Style', 'radiobutton', 'String', 'Polygon', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.15, 0.4, 0.7, 0.2]);
    GUIHandles.roiDrawing.ellipseButton = uicontrol('Parent', GUIHandles.roiDrawing.drawShapeButtonGroup, 'Style', 'radiobutton', 'String', 'Ellipse', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.15, 0.2, 0.7, 0.2]);
    GUIHandles.roiDrawing.rectangleButton = uicontrol('Parent', GUIHandles.roiDrawing.drawShapeButtonGroup, 'Style', 'radiobutton', 'String', 'Rectangle', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.15, 0.0, 0.7, 0.2]);

    % add a listview that displays the ROI hierarchy
    GUIHandles.roiDrawing.roiTree = uicontrol('Parent', GUIHandles.roiDrawingTab,'Style','listbox','Visible', 'on', 'BackgroundColor',[1 1 1],'Enable','on','Units', 'normalized',  'Position', [0.912,0.045,0.075,0.255]);
    GUIHandles.roiDrawing.roiTree.String = GUIHandles.roiDrawing.roiTreeID;
    GUIHandles.roiDrawing.roiTreeLevel = uicontrol('Parent', GUIHandles.roiDrawingTab,'Style','text','Visible', 'on', 'BackgroundColor',[1 1 1],'Enable','on','Units', 'normalized',  'Position', [0.912,0.3,0.075,0.02]);
    GUIHandles.roiDrawing.roiTreeLevel.String = strcat('Parent: ', GUIHandles.roiDrawing.roiTreeCurrentParent);
    GUIHandles.roiDrawing.roiTreeLevel.HorizontalAlignment = 'left'; 
    GUIHandles.roiDrawing.roiTreeLevel0 = uicontrol('Parent', GUIHandles.roiDrawingTab,'Style','pushbutton','Visible', 'on', 'String', 'parent=0', 'Enable','on','Units', 'normalized',  'Position', [0.9115,0.025,0.037,0.02], 'Callback', @roiTreeParent0Callback);
    GUIHandles.roiDrawing.roiTreeLevelParent = uicontrol('Parent', GUIHandles.roiDrawingTab,'Style','pushbutton','Visible', 'on', 'String', 'set parent', 'Enable','on','Units', 'normalized',  'Position', [0.949,0.025,0.037,0.02], 'Callback', @roiTreeSetParentCallback);
    
    GUIHandles.roiDrawing.leftButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Left', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9125, 0.33, 0.025, 0.025], 'Callback', @moveCallback);
    GUIHandles.roiDrawing.rightButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Right', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9625, 0.33, 0.025, 0.025], 'Callback', @moveCallback);
    GUIHandles.roiDrawing.upButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Up', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9375, 0.355, 0.025, 0.025], 'Callback', @moveCallback);
    GUIHandles.roiDrawing.downButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Down', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9375, 0.305, 0.025, 0.025], 'Callback', @moveCallback);

    GUIHandles.roiDrawing.findROIButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Find ROI', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9275, 0.25, 0.045, 0.04], 'Callback', @findROICallback);

    GUIHandles.roiDrawing.fillROIButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Fill ROI', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9275, 0.195, 0.045, 0.04], 'Callback', @fillROICallback);
    GUIHandles.roiDrawing.clusterROIsButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Cluster ROIs', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.925, 0.195, 0.05, 0.04], 'Callback', @clusterROIsCallback);

    GUIHandles.roiDrawing.viewClusteredROIsButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'View Clustered ROIs', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.91, 0.0985, 0.08, 0.05], 'Callback', @showClusteredROIsCallback);
        
    GUIHandles.roiDrawing.histogramAxes = axes('Parent', GUIHandles.roiDrawingTab, 'Units', 'normalized', 'Position', [0.9175, 0.254, 0.065, 0.125]);
    GUIHandles.roiDrawing.histogramPlot = histogram(GUIHandles.roiDrawing.histogramAxes, [], 'Visible', 'off', 'FaceColor', 'k');
    GUIHandles.roiDrawing.histogramAxes.XLim = [0, 1];
    GUIHandles.roiDrawing.histogramAxes.YLim = [0, 1];    
    GUIHandles.roiDrawing.histogramAxes.XLabel.String = 'Pixel Intensity';
    GUIHandles.roiDrawing.histogramAxes.FontName = 'MS Sans Serif';
    GUIHandles.roiDrawing.histogramAxes.FontSize = 8;
    GUIHandles.roiDrawing.histogramAxes.Visible = 'off';

    GUIHandles.roiDrawing.predictFluorescenceButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Predict Fluorescence', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.909, 0.1655, 0.082, 0.04], 'Callback', @predictFluorescenceCallback);

    GUIHandles.roiDrawing.islandSizeText = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'text', 'String', 'Minimum Region Size', 'BackgroundColor', 'w', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9075, 0.1445, 0.085, 0.0175]);
    GUIHandles.roiDrawing.islandSizeSlider = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'slider', 'Visible', 'off', 'Min', 0, 'Max', GUIHandles.roiDrawing.maxMinIslandSize, 'Value', GUIHandles.roiDrawing.minIslandSize, 'SliderStep', [1/GUIHandles.roiDrawing.maxMinIslandSize, 50/GUIHandles.roiDrawing.maxMinIslandSize], 'Units', 'normalized', 'Position', [0.9075, 0.127, 0.085, 0.015], 'Callback', @islandSizeSliderCallback);

    GUIHandles.roiDrawing.viewNeuropilButton = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'checkbox', 'String', 'View Neuropil', 'BackgroundColor', 'w', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9125, 0.0985, 0.075, 0.025], 'Callback', @viewNeuropilCallback);

    GUIHandles.roiDrawing.neuropilSizeText = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'text', 'String', 'Neuropil Size', 'BackgroundColor', 'w', 'Visible', 'off', 'Units', 'normalized', 'Position', [0.9075, 0.0835, 0.085, 0.0175]);
    GUIHandles.roiDrawing.neuropilSizeSlider = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'slider', 'Visible', 'off', 'Min', 1, 'Max', GUIHandles.roiDrawing.maxNeuropilSize, 'Value', GUIHandles.roiDrawing.neuropilSize, 'SliderStep', [1/GUIHandles.roiDrawing.maxNeuropilSize, 5/GUIHandles.roiDrawing.maxNeuropilSize], 'Units', 'normalized', 'Position', [0.9075, 0.066, 0.085, 0.015], 'Callback', @neuropilSizeSliderCallback);
        
    GUIHandles.roiDrawing.exportTif = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'pushbutton', 'String', 'Export .tif', 'Units', 'normalized', 'Position', [0.013, 0.33, 0.074, 0.05], 'Callback', @exportTif);
    GUIHandles.roiDrawing.exportTifFrom = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'edit', 'String', 'from', 'BackgroundColor', 'w', 'Visible', 'on', 'Units', 'normalized', 'Position', [0.013, 0.31, 0.035, 0.0175]);
    GUIHandles.roiDrawing.exportTifTo = uicontrol('Parent', GUIHandles.roiDrawingTab, 'Style', 'edit', 'String', 'to', 'BackgroundColor', 'w', 'Visible', 'on', 'Units', 'normalized', 'Position', [0.052, 0.31, 0.035, 0.0175]);
        
    set(GUIHandles.parentFigure, 'ButtonDownFcn', @roiImageClickFunction);
    set(GUIHandles.parentFigure, 'WindowButtonMotionFcn', @mouseOverFunction);

    % attach click callbacks to images and masks
    set(GUIHandles.roiDrawing.roiImage, 'ButtonDownFcn', @roiImageClickFunction);
    set(GUIHandles.roiDrawing.candidateROIImage, 'ButtonDownFcn', @candidateROIImageClickFunction);
    set(GUIHandles.roiDrawing.selectedROIImage, 'ButtonDownFcn', @selectedROIImageClickFunction);
    set(GUIHandles.roiDrawing.overlapImage, 'ButtonDownFcn', @roiImageClickFunction);
    set(GUIHandles.roiDrawing.neuropilImage, 'ButtonDownFcn', @selectedROIImageClickFunction);
    set(GUIHandles.roiDrawing.islandImage, 'ButtonDownFcn', @selectedROIImageClickFunction);

    temp = GUIHandles.mode;
    
    GUIHandles.mode = 'ROI Drawing';
    
    guidata(GUI, GUIHandles);

    updateROIImage(GUI);
    updateOverlapImage(GUI);
    
    GUIHandles = guidata(GUI);
    
    GUIHandles.mode = temp;
    
    guidata(GUI, GUIHandles);

end

function setupROIPairingTab(GUI)

    GUIHandles = guidata(GUI);

    % initialize currently selected ROIs
    GUIHandles.roiPairing.selectedSomaROI = 0;
    GUIHandles.roiPairing.selectedDendriteROI = 0;
    GUIHandles.roiPairing.selectedMask = 'Somas';
    
    % first column is a soma ROI, second are corresponding paired dendrite ROIs
    GUIHandles.roiPairing.pairedROIs = [];

    GUIHandles.roiPairing.imageAxes = axes('Parent', GUIHandles.roiPairingTab, 'Units', 'normalized', 'Position', [0.1, 0.0, 0.8, 1.0]);
    GUIHandles.roiPairing.displayedImage = imagesc(zeros(GUIHandles.imageSize), 'Parent', GUIHandles.roiPairing.imageAxes, [0, 1]);
    GUIHandles.roiPairing.imageAxes.CLimMode = 'manual';
    axis(GUIHandles.roiPairing.imageAxes, 'image');
    axis(GUIHandles.roiPairing.imageAxes, 'off');

%     colormap(GUIHandles.roiPairing.imageAxes, gray);
    
    GUIHandles.roiPairing.imageType = 'Plane-by-Plane';

    % initialize various masks
    GUIHandles.roiPairing.somaROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiPairing.dendriteROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiPairing.selectedSomaROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiPairing.selectedDendriteROIMask = zeros(GUIHandles.imageSize);

    hold(GUIHandles.roiPairing.imageAxes, 'on');

    % initialize the different ROI images that will be overlaid onto the calcium images
    GUIHandles.roiPairing.somaROIImage = image(GUIHandles.roiPairing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.6, 0, 0], [1, 1, 3])));
    GUIHandles.roiPairing.dendriteROIImage = image(GUIHandles.roiPairing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0, 0, 1], [1, 1, 3])));
    GUIHandles.roiPairing.selectedSomaROIImage = image(GUIHandles.roiPairing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.294, 0.5, 0.51], [1, 1, 3])));
    GUIHandles.roiPairing.selectedDendriteROIImage = image(GUIHandles.roiPairing.imageAxes, bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.294, 0, 0.51], [1, 1, 3])));
    
    hold(GUIHandles.roiPairing.imageAxes, 'off');

    GUIHandles.roiPairing.selectedSomaROIImage.Visible = 'off';
    GUIHandles.roiPairing.selectedDendriteROIImage.Visible = 'off';

    % you have to do this after axes initialization and adding any image
    axis(GUIHandles.roiPairing.imageAxes, 'image');
    axis(GUIHandles.roiPairing.imageAxes, 'off');

    GUIHandles.roiPairing.loadNewSBXButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Load New Data', 'Units', 'normalized', 'Position', [0.013, 0.93, 0.074, 0.05], 'Callback', @loadNewSBXCallback);

    GUIHandles.roiPairing.saveScreenshotButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Save Screenshot', 'Units', 'normalized', 'Position', [(0.1 - 0.068)/2, 0.85, 0.068, 0.05], 'Callback', @saveScreenshotCallback);

    GUIHandles.roiPairing.imageTypeButtonGroup = uibuttongroup('Parent', GUIHandles.roiPairingTab, 'Title', 'Display', 'TitlePosition', 'centertop', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.7495, 0.085, 0.063], 'SelectionChangedFcn', @imageTypeButtonGroupSelectionFunction);
    GUIHandles.roiPairing.rollingButton = uicontrol('Parent', GUIHandles.roiPairing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'Rolling Average', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 0.5, 0.9, 0.5]);
    GUIHandles.roiPairing.planeButton = uicontrol('Parent', GUIHandles.roiPairing.imageTypeButtonGroup, 'Style', 'radiobutton', 'String', 'Plane-by-Plane', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 0.0, 0.9, 0.5]);
    GUIHandles.roiPairing.frameSlider = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'slider', 'Min', 0, 'Max', GUIHandles.Info.maxIndex, 'Value', 0, 'SliderStep', [1/GUIHandles.Info.maxIndex, 50/GUIHandles.Info.maxIndex], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.roiPairing.imageTypeButtonGroup.Position(2) - 0.0175, 0.085, 0.015], 'Callback', @frameSliderCallback);

    GUIHandles.roiPairing.heatVisionButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'checkbox', 'String', 'Heat Vision', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [(0.1 - 0.06)/2, GUIHandles.roiPairing.frameSlider.Position(2) - 0.075, 0.06, 0.025], 'Callback', @heatVisionCallback);

    GUIHandles.roiPairing.resetButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Reset', 'Units', 'normalized', 'Position', [(0.1 - 0.04)/2, 0.128, 0.04, 0.025], 'Callback', @resetCallback);

    GUIHandles.roiPairing.resonantOffsetText = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'text', 'String', 'Resonant Offset', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.11, 0.085, 0.0175]);
    GUIHandles.roiPairing.resonantOffsetSlider = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'slider', 'Min', -5, 'Max', 5, 'Value', GUIHandles.defaultResonantOffset, 'SliderStep', [1/10, 4/10], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.roiPairing.resonantOffsetText.Position(2) - 0.015, 0.085, 0.015], 'Callback', @resonantOffsetSliderCallback);

    GUIHandles.roiPairing.brightnessText = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'text', 'String', 'Brightness', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.07, 0.085, 0.0175]);
    GUIHandles.roiPairing.brightnessSlider = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'slider', 'Min', -0.9, 'Max', 0.9, 'Value', GUIHandles.defaultBrightness, 'SliderStep', [0.01, 0.2], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.roiPairing.brightnessText.Position(2) - 0.015, 0.085, 0.015], 'Callback', @brightnessSliderCallback);

    GUIHandles.roiPairing.contrastText = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'text', 'String', 'Contrast', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.0075, 0.03, 0.085, 0.0175]);
    GUIHandles.roiPairing.contrastSlider = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'slider', 'Min', 0.5, 'Max', 10.0, 'Value', GUIHandles.defaultContrast, 'SliderStep', [0.05, 0.25], 'Units', 'normalized', 'Position', [0.0075, GUIHandles.roiPairing.contrastText.Position(2) - 0.015, 0.085, 0.015], 'Callback', @contrastSliderCallback);

    GUIHandles.roiPairing.loadSomaROIsButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Load Soma ROIs', 'Units', 'normalized', 'Position', [0.9 + (0.1 - 0.068)/2, 0.93, 0.068, 0.05], 'Callback', @loadSomaROIsCallback);
    GUIHandles.roiPairing.loadDendriteROIsButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Load Dendrite ROIs', 'Units', 'normalized', 'Position', [0.9 + (0.1 - 0.075)/2, 0.88, 0.075, 0.05], 'Callback', @loadDendriteROIsCallback);
    GUIHandles.roiPairing.clearROIMasksButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Clear ROI Masks', 'Units', 'normalized', 'Position', [0.916, 0.83, 0.068, 0.05], 'Callback', @clearROIMasksCallback);
    GUIHandles.roiPairing.pairROIsButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'Visible', 'off', 'String', 'Pair ROIs', 'Units', 'normalized', 'Position', [0.916, 0.78, 0.068, 0.05], 'Callback', @pairROIsCallback);
    GUIHandles.roiPairing.savePairedROIsButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'Visible', 'off', 'String', 'Save Paired ROIs', 'Units', 'normalized', 'Position', [0.916, 0.73, 0.068, 0.05], 'Callback', @savePairedROIsCallback);
    GUIHandles.roiPairing.clearPairedROIsButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'Visible', 'off', 'String', 'Clear Paired ROIs', 'Units', 'normalized', 'Position', [0.916, 0.68, 0.068, 0.05], 'Callback', @clearPairedROIsCallback);
    
    GUIHandles.roiPairing.hideROIsButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'checkbox', 'String', 'Hide ROIs', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.925, 0.525, 0.05, 0.025], 'Callback', @hideROIsCallback);
    
    GUIHandles.roiPairing.selectedMaskButtonGroup = uibuttongroup('Parent', GUIHandles.roiPairingTab, 'Title', 'Masks', 'TitlePosition', 'centertop', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.9 + (0.1 - 0.085)/2, 0.45, 0.085, 0.063], 'SelectionChangedFcn', @selectedMaskButtonGroupSelectionFunction);
    GUIHandles.roiPairing.somaButton = uicontrol('Parent', GUIHandles.roiPairing.selectedMaskButtonGroup, 'Style', 'radiobutton', 'String', 'Somas', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 0.5, 0.9, 0.5]);
    GUIHandles.roiPairing.dendriteButton = uicontrol('Parent', GUIHandles.roiPairing.selectedMaskButtonGroup, 'Style', 'radiobutton', 'String', 'Dendrites', 'BackgroundColor', 'w', 'Units', 'normalized', 'Position', [0.05, 0.0, 0.9, 0.5]);

    GUIHandles.roiPairing.leftButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Left', 'Units', 'normalized', 'Position', [0.9125, 0.33, 0.025, 0.025], 'Callback', @moveCallback);
    GUIHandles.roiPairing.rightButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Right', 'Units', 'normalized', 'Position', [0.9625, 0.33, 0.025, 0.025], 'Callback', @moveCallback);
    GUIHandles.roiPairing.upButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Up', 'Units', 'normalized', 'Position', [0.9375, 0.355, 0.025, 0.025], 'Callback', @moveCallback);
    GUIHandles.roiPairing.downButton = uicontrol('Parent', GUIHandles.roiPairingTab, 'Style', 'pushbutton', 'String', 'Down', 'Units', 'normalized', 'Position', [0.9375, 0.305, 0.025, 0.025], 'Callback', @moveCallback);

    set(GUIHandles.parentFigure, 'ButtonDownFcn', @roiImageClickFunction);
    set(GUIHandles.parentFigure, 'WindowButtonMotionFcn', @mouseOverFunction);

    % attach click callbacks to images and masks
    set(GUIHandles.roiPairing.somaROIImage, 'ButtonDownFcn', @roiImageClickFunction);
    set(GUIHandles.roiPairing.dendriteROIImage, 'ButtonDownFcn', @roiImageClickFunction);
    set(GUIHandles.roiPairing.selectedSomaROIImage, 'ButtonDownFcn', @selectedROIImageClickFunction);
    set(GUIHandles.roiPairing.selectedDendriteROIImage, 'ButtonDownFcn', @selectedROIImageClickFunction);

    temp = GUIHandles.mode;
    
    GUIHandles.mode = 'ROI Pairing';
    
    guidata(GUI, GUIHandles);

    updateROIImage(GUI);
    updateOverlapImage(GUI);
    
    GUIHandles = guidata(GUI);
    
    GUIHandles.mode = temp;
    
    guidata(GUI, GUIHandles);

end

function loadNewSBXCallback(GUI, ~)

    try
        [sbxName, sbxPath] = uigetfile('.sbx', 'Please select file containing imaging data.');
    catch
        waitfor(msgbox('Error: Please select valid .sbx file.'));
        error('Please select valid .sbx file.');
    end
    
    % pull off the file extension
    sbxName = strtok(sbxName, '.');

    Info = sbxInfo([sbxPath, sbxName]);

    GUIHandles = guidata(GUI);

    GUIHandles.parentFigure.Name = ['Scanbox Analysis: ', sbxName];
    disp(['Loading ', sbxPath, sbxName, '.sbx']);
    
    % save details about the .sbx file
    GUIHandles.sbxPath = sbxPath;
    GUIHandles.sbxName = sbxName;
    GUIHandles.Info = Info;
    
    GUIHandles.imageSize = Info.sz;
    
    GUIHandles.motionCorrected = false;
    
    GUIHandles.imageProcessing.gatherButton.Visible = 'off';
    GUIHandles.imageProcessing.splitButton.Visible = 'off';
    GUIHandles.imageProcessing.motionCorrectButton.Visible = 'off';
    GUIHandles.imageProcessing.computeButton.Visible = 'off';
    
    % check if data has already been motion corrected
    if exist([sbxPath, sbxName, '.rigid'], 'file')
        load([sbxPath, sbxName, '.rigid'], '-mat', 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop');
        
        GUIHandles.phaseDifferences = phaseDifferences;
        GUIHandles.rowShifts = rowShifts;
        GUIHandles.columnShifts = columnShifts;
        GUIHandles.frameCrop = frameCrop;
        
        GUIHandles.imageSize = [Info.sz(1) - frameCrop(3) - frameCrop(4), Info.sz(2) - frameCrop(1) - frameCrop(2)];
        
        GUIHandles.motionCorrected = true;
    elseif exist([sbxPath, sbxName, '.align'], 'file')
        load([sbxPath, sbxName, '.align'], '-mat', 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop');
        
        GUIHandles.phaseDifferences = phaseDifferences;
        GUIHandles.rowShifts = rowShifts;
        GUIHandles.columnShifts = columnShifts;
        GUIHandles.frameCrop = frameCrop;
        
        GUIHandles.imageSize = [Info.sz(1) - frameCrop(3) - frameCrop(4), Info.sz(2) - frameCrop(1) - frameCrop(2)];
        
        GUIHandles.motionCorrected = true;
        
    end
    
    % if cross-correlation and other stuff has been computed, keep Analyze tab visible and load new data
    if exist([sbxPath, sbxName, '.pre'], 'file')
        GUIHandles.roiDrawingTab.Parent = GUIHandles.modeTabGroup;
        GUIHandles.roiPairingTab.Parent = [];
            
        % have to redefine GUI object if we're deleting the current tab
        if strcmp(GUIHandles.mode, 'ROI Pairing')
            guidata(GUI, GUIHandles);
            
            GUI = GUIHandles.parentFigure;
            
            GUIHandles = guidata(GUI);
        end
        
        if isfield(GUIHandles, 'preLoaded') && GUIHandles.preLoaded            
            temp = who('-file', [GUIHandles.sbxPath, GUIHandles.sbxName, '.pre']);
            
            if ismember('meanImage', temp)
                load([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], '-mat', 'meanImage', 'maxIntensityImage', 'crossCorrelationImage', 'pcaImage')

                GUIHandles.roiDrawing.meanImage = meanImage/double(intmax('uint16'));
                GUIHandles.roiDrawing.maxIntensityImage = maxIntensityImage/double(intmax('uint16'));        
                GUIHandles.roiDrawing.crossCorrelationImage = crossCorrelationImage;
                GUIHandles.roiDrawing.pcaImage = pcaImage/max(pcaImage(:));
            elseif ismember('meanReference', temp)
                load([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], '-mat', 'meanReference', 'maxIntensityProjection', 'ccImage', 'pcaImage')

                GUIHandles.roiDrawing.meanImage = meanReference/double(intmax('uint16'));
                GUIHandles.roiDrawing.maxIntensityImage = maxIntensityProjection/double(intmax('uint16'));        
                GUIHandles.roiDrawing.crossCorrelationImage = ccImage;
                GUIHandles.roiDrawing.pcaImage = pcaImage/max(pcaImage(:));
            elseif ismember('meanref', temp)
                load([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], '-mat', 'meanref', 'ccimage', 'pcaimage')

                GUIHandles.roiDrawing.meanImage = meanref;
                GUIHandles.roiDrawing.crossCorrelationImage = ccimage;
                GUIHandles.roiDrawing.pcaImage = pcaimage;
            end
            
            GUIHandles.localCCLoaded = false;
            
            GUIHandles.roiDrawing.selectedROI = 0;
            
            while size(GUIHandles.roiDrawing.roiMask, 1) ~= GUIHandles.imageSize(1)
                if size(GUIHandles.roiDrawing.roiMask, 1) > GUIHandles.imageSize(1)
                    if ~any(GUIHandles.roiDrawing.roiMask(1, :))
                        GUIHandles.roiDrawing.roiMask(1, :) = [];
                        GUIHandles.roiDrawing.overlapMask(1, :) = [];
                    elseif ~any(GUIHandles.roiDrawing.roiMask(end, :))
                        GUIHandles.roiDrawing.roiMask(end, :) = [];
                        GUIHandles.roiDrawing.overlapMask(end, :) = [];
                    else
                        warning('Previous ROI information will be lost due to cropping.')
                        GUIHandles.roiDrawing.roiMask(end, :) = [];
                        GUIHandles.roiDrawing.overlapMask(end, :) = [];
                    end
                else
                    GUIHandles.roiDrawing.roiMask(end + 1, :) = 0;
                    GUIHandles.roiDrawing.overlapMask(end + 1, :) = 0;
                end
            end
            while size(GUIHandles.roiDrawing.roiMask, 2) ~= GUIHandles.imageSize(2)
                if size(GUIHandles.roiDrawing.roiMask, 2) > GUIHandles.imageSize(2)
                    if ~any(GUIHandles.roiDrawing.roiMask(:, 1))
                        GUIHandles.roiDrawing.roiMask(:, 1) = [];
                        GUIHandles.roiDrawing.overlapMask(:, 1) = [];
                    elseif ~any(GUIHandles.roiDrawing.roiMask(:, end))
                        GUIHandles.roiDrawing.roiMask(:, end) = [];
                        GUIHandles.roiDrawing.overlapMask(:, end) = [];
                    else
                        warning('Previous ROI information will be lost due to cropping.')
                        GUIHandles.roiDrawing.roiMask(:, end) = [];
                        GUIHandles.roiDrawing.overlapMask(:, end) = [];
                    end
                else
                    GUIHandles.roiDrawing.roiMask(:, end + 1) = 0;
                    GUIHandles.roiDrawing.overlapMask(:, end + 1) = [];
                end
            end
    
            GUIHandles.roiDrawing.previousROIMask = GUIHandles.roiDrawing.roiMask;
            GUIHandles.roiDrawing.allROIsMask = GUIHandles.roiDrawing.roiMask > 0;

            GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);
            GUIHandles.roiDrawing.previousROIMask = zeros(GUIHandles.imageSize);
            
            GUIHandles.roiDrawing.previousOverlapMask = GUIHandles.roiDrawing.overlapMask;
    
            GUIHandles.roiDrawing.roiImage.CData = bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.6, 0, 0], [1, 1, 3]));
            GUIHandles.roiDrawing.roiImage.AlphaData = 0.5*(GUIHandles.roiDrawing.roiMask > 0);

            GUIHandles.roiDrawing.candidateROIImage.CData = bsxfun(@times, ones(GUIHandles.imageSize), reshape([0, 0, 1], [1, 1, 3]));
            GUIHandles.roiDrawing.candidateROIImage.AlphaData = zeros(GUIHandles.imageSize);

            GUIHandles.roiDrawing.selectedROIImage.CData = bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.294, 0, 0.51], [1, 1, 3]));
            GUIHandles.roiDrawing.selectedROIImage.AlphaData = zeros(GUIHandles.imageSize);

            GUIHandles.roiDrawing.overlapImage.CData = bsxfun(@times, ones(GUIHandles.imageSize), reshape([0, 1, 0], [1, 1, 3]));
            GUIHandles.roiDrawing.overlapImage.AlphaData = 0.5*(GUIHandles.roiDrawing.overlapMask > 0);

            GUIHandles.roiDrawing.neuropilImage.CData = bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.294, 0, 0.51], [1, 1, 3]));
            GUIHandles.roiDrawing.neuropilImage.AlphaData = zeros(GUIHandles.imageSize);

            GUIHandles.roiDrawing.islandImage.CData = bsxfun(@times, ones(GUIHandles.imageSize), reshape([0.5, 0.5, 0.5], [1, 1, 3]));
            GUIHandles.roiDrawing.islandImage.AlphaData = zeros(GUIHandles.imageSize);

            GUIHandles.roiDrawing.frameSlider.Max = Info.maxIndex;
            GUIHandles.roiDrawing.frameSlider.Value = 0;
            GUIHandles.roiDrawing.frameSlider.SliderStep = [1/Info.maxIndex, 50/Info.maxIndex];
        else
            GUIHandles.preLoaded = false;
            GUIHandles.localCCLoaded = false;
        end
    elseif isfield(Info, 'gathered') && Info.gathered == 1
        GUIHandles.roiDrawingTab.Parent = [];
        GUIHandles.roiPairingTab.Parent = GUIHandles.modeTabGroup;
            
        % have to redefine GUI object if we're deleting the current tab
        if strcmp(GUIHandles.mode, 'ROI Drawing')
            guidata(GUI, GUIHandles);
            
            GUI = GUIHandles.parentFigure;
            
            GUIHandles = guidata(GUI);
        end
        
        guidata(GUI, GUIHandles);
        
        setupROIPairingTab(GUI)

        GUIHandles = guidata(GUI);
    else
        GUIHandles.roiDrawingTab.Parent = [];
        GUIHandles.roiPairingTab.Parent = [];
            
        % have to redefine GUI object if we're deleting the current tab
        if strcmp(GUIHandles.mode, 'ROI Drawing') || strcmp(GUIHandles.mode, 'ROI Pairing')
            guidata(GUI, GUIHandles);
            
            GUI = GUIHandles.parentFigure;
            
            GUIHandles = guidata(GUI);
        end
    end

    GUIHandles.zoomCenter = [];
    
    % you have to do this after axes initialization and adding any image
    axis(GUIHandles.imageProcessing.imageAxes, 'image');
    
    GUIHandles.XLim = GUIHandles.imageProcessing.imageAxes.XLim;
    GUIHandles.YLim = GUIHandles.imageProcessing.imageAxes.YLim;
    GUIHandles.maxWindowSize = (GUIHandles.XLim(2) - GUIHandles.XLim(1))/2;
    GUIHandles.windowSize = GUIHandles.maxWindowSize;
    GUIHandles.windowRatio = (GUIHandles.YLim(2) - GUIHandles.YLim(1))/(GUIHandles.XLim(2) - GUIHandles.XLim(1));
    
    if GUIHandles.Info.volscan == 1
        if ~isempty(GUIHandles.Info.otwave_um)
            temp = GUIHandles.Info.otwave_um;
        else
            temp = GUIHandles.Info.otwave;
        end
    
        if length(temp) > 3
            if ~isfield(GUIHandles.Info, 'gathered')
                GUIHandles.imageProcessing.gatherButton.Visible = 'on';
            end
        else
            if ~isfield(GUIHandles.Info, 'split')
                GUIHandles.imageProcessing.splitButton.Visible = 'on';
            end
        end
    end
    
    if ~GUIHandles.motionCorrected
        if GUIHandles.Info.volscan == 1
            if isfield(GUIHandles.Info, 'split') && GUIHandles.Info.split
                GUIHandles.imageProcessing.motionCorrectButton.Visible = 'on';
            end
        else
            GUIHandles.imageProcessing.motionCorrectButton.Visible = 'on';
        end
    else
        if ~exist([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], 'file')
            GUIHandles.imageProcessing.computeButton.Visible = 'on';
        end
    end
    
    GUIHandles.imageProcessing.frameSlider.Max = Info.maxIndex;
    GUIHandles.imageProcessing.frameSlider.Value = 0;
    GUIHandles.imageProcessing.frameSlider.SliderStep = [1/Info.maxIndex, 50/Info.maxIndex];
    
    guidata(GUI, GUIHandles);
    
    frameSliderCallback(GUI);
    
end

function saveScreenshotCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    number = 1;
    
    while exist([GUIHandles.sbxPath, GUIHandles.sbxName, '_', int2str(number), '.png'], 'file')
        number = number + 1;
    end
    
    switch GUIHandles.mode
        case 'Image Processing'
            frame = frame2im(getframe(GUIHandles.imageProcessing.imageAxes));
        case 'ROI Drawing'
            frame = frame2im(getframe(GUIHandles.roiDrawing.imageAxes));
        case 'ROI Pairing'
            frame = frame2im(getframe(GUIHandles.roiPairing.imageAxes));
    end
        
    % make sure frames have multiple-of-two dimensions
    if mod(size(frame, 1), 2) ~= 0
        frame(1, :, :) = [];
    end
    if mod(size(frame, 2), 2) ~= 0
        frame(:, 1, :) = [];
    end
    
    imwrite(frame, [GUIHandles.sbxPath, GUIHandles.sbxName, '_', int2str(number), '.png']);

end

function channelButtonGroupSelectionFunction(GUI, eventdata)

    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode 
        case 'Image Processing'
            GUIHandles.imageProcessing.displayChannel = get(eventdata.NewValue, 'String');
    end

    guidata(GUI, GUIHandles);
    updateImageDisplay(GUI);
    
end

function imageTypeButtonGroupSelectionFunction(GUI, eventdata)

    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode 
        case 'Image Processing'
            GUIHandles.imageProcessing.imageType = get(eventdata.NewValue, 'String');
            
            GUIHandles.imageProcessing.frameSlider.Visible = 'on';
        case 'ROI Drawing'
            GUIHandles.roiDrawing.imageType = get(eventdata.NewValue, 'String');

            switch GUIHandles.roiDrawing.imageType
                case 'Mean'
                    GUIHandles.roiDrawing.frameSlider.Visible = 'off';
                    GUIHandles.roiDrawing.framenumberDisplay.Visible = 'off';
                    GUIHandles.roiDrawing.playButton.Visible = 'off';
                    GUIHandles.roiDrawing.sweepButton.Visible = 'off';
                    GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';
                case 'Max Intensity'
                    GUIHandles.roiDrawing.frameSlider.Visible = 'off';
                    GUIHandles.roiDrawing.framenumberDisplay.Visible = 'off';
                    GUIHandles.roiDrawing.playButton.Visible = 'off';
                    GUIHandles.roiDrawing.sweepButton.Visible = 'off';
                    GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';
                case 'Cross-Correlation'
                    GUIHandles.roiDrawing.frameSlider.Visible = 'off';
                    GUIHandles.roiDrawing.framenumberDisplay.Visible = 'off';
                    GUIHandles.roiDrawing.playButton.Visible = 'off';
                    GUIHandles.roiDrawing.sweepButton.Visible = 'off';
                    GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';
                case 'PCA'
                    GUIHandles.roiDrawing.frameSlider.Visible = 'off';
                    GUIHandles.roiDrawing.framenumberDisplay.Visible = 'off';
                    GUIHandles.roiDrawing.playButton.Visible = 'off';
                    GUIHandles.roiDrawing.sweepButton.Visible = 'off';
                    GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';
                case 'Rolling Average'
                    GUIHandles.roiDrawing.framenumberDisplay.Visible = 'off';
                    GUIHandles.roiDrawing.frameSlider.Visible = 'on';
                    GUIHandles.roiDrawing.playButton.Visible = 'on';
                    GUIHandles.roiDrawing.sweepButton.Visible = 'on';
        
                    if strcmp(GUIHandles.roiDrawing.manipulateType, 'Prune')
                        GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'on';
                    else
                        GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';
                    end
                case 'Frame-by-Frame'
                    GUIHandles.roiDrawing.frameSlider.Visible = 'on';
                    GUIHandles.roiDrawing.framenumberDisplay.Visible = 'on';
                    GUIHandles.roiDrawing.playButton.Visible = 'on';
                    GUIHandles.roiDrawing.sweepButton.Visible = 'on';
        
                    if strcmp(GUIHandles.roiDrawing.manipulateType, 'Prune')
                        GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'on';
                    else
                        GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';
                    end
            end
        case 'ROI Pairing'
            GUIHandles.roiPairing.frameSlider.Visible = 'on';
    end
    
    guidata(GUI, GUIHandles);
    
    updateImageDisplay(GUI);

end

function frameSliderCallback(GUI, ~)
    
    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode
        case 'Image Processing'
            GUIHandles.frameSliderValue = round(GUIHandles.imageProcessing.frameSlider.Value);
        case 'ROI Drawing'
            GUIHandles.frameSliderValue = round(GUIHandles.roiDrawing.frameSlider.Value);
        case 'ROI Pairing'
            GUIHandles.frameSliderValue = round(GUIHandles.roiPairing.frameSlider.Value);
    end
    
    guidata(GUI, GUIHandles);

    updateImageDisplay(GUI);
    
    % make the function interruptible
    drawnow;

end

function heatVisionCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode
        case 'Image Processing'
            if GUIHandles.imageProcessing.heatVisionButton.Value == 1
                colormap(GUIHandles.imageProcessing.imageAxes, hot);
            else
                colormap(GUIHandles.imageProcessing.imageAxes, gray);
            end
        case 'ROI Pairing'
            if GUIHandles.roiPairing.heatVisionButton.Value == 1
                colormap(GUIHandles.roiPairing.imageAxes, hot);
            else
                colormap(GUIHandles.roiPairing.imageAxes, gray);
            end
    end
            
    guidata(GUI, GUIHandles);

end

function playCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    cancelCallback(GUI);
    
    guidata(GUI, GUIHandles);
    
    GUIHandles.roiDrawing.playButton.Visible = 'off';
    GUIHandles.roiDrawing.cancelPlayButton.Visible = 'on';
    
    GUIHandles.roiDrawing.cancel = false;
    guidata(GUI, GUIHandles);

    for f = 0:1:GUIHandles.Info.maxIndex
        GUIHandles = guidata(GUI);

        GUIHandles.roiDrawing.frameSlider.Value = f;
        guidata(GUI, GUIHandles);
        frameSliderCallback(GUI);

        if GUIHandles.roiDrawing.cancel
            GUIHandles.roiDrawing.cancel = false;
            break
        end
    end

    GUIHandles.roiDrawing.playButton.Visible = 'on';
    GUIHandles.roiDrawing.cancelPlayButton.Visible = 'off';
    
    GUIHandles.roiDrawing.cancel = true;
    
    guidata(GUI, GUIHandles);

end

function sweepCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    cancelCallback(GUI);
    
    guidata(GUI, GUIHandles);
    
    GUIHandles.roiDrawing.sweepButton.Visible = 'off';
    GUIHandles.roiDrawing.cancelSweepButton.Visible = 'on';
    
    GUIHandles.roiDrawing.cancel = false;
    guidata(GUI, GUIHandles);

    for f = 0:60:GUIHandles.Info.maxIndex
        GUIHandles = guidata(GUI);

        GUIHandles.roiDrawing.frameSlider.Value = f;
        guidata(GUI, GUIHandles);
        frameSliderCallback(GUI);

        if GUIHandles.roiDrawing.cancel
            GUIHandles.roiDrawing.cancel = false;
            break
        end
    end

    GUIHandles.roiDrawing.sweepButton.Visible = 'on';
    GUIHandles.roiDrawing.cancelSweepButton.Visible = 'off';
    
    GUIHandles.roiDrawing.cancel = true;
    
    guidata(GUI, GUIHandles);

end

function cancelCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    GUIHandles.roiDrawing.playButton.Visible = 'on';
    GUIHandles.roiDrawing.sweepButton.Visible = 'on';
    GUIHandles.roiDrawing.cancelPlayButton.Visible = 'off';
    GUIHandles.roiDrawing.cancelSweepButton.Visible = 'off';
    
    GUIHandles.roiDrawing.cancel = true;
    
    guidata(GUI, GUIHandles);

end

function exportTif(GUI, ~)

    GUIHandles = guidata(GUI);

    switch GUIHandles.mode
        case 'Image Processing'
            from_frame = str2num(GUIHandles.roiDrawing.exportTifFromraw.String);
            to_frame = str2num(GUIHandles.roiDrawing.exportTifToraw.String);
        case 'ROI Drawing'
            from_frame = str2num(GUIHandles.roiDrawing.exportTifFrom.String);
            to_frame = str2num(GUIHandles.roiDrawing.exportTifTo.String);
    end
    
    disp('exporting tif...');
    
    %sbx2tif_mth([GUIHandles.sbxPath GUIHandles.sbxName],from_frame,to_frame);
    
    k = from_frame;
    while(k <= to_frame)
        if GUIHandles.motionCorrected
        	frame = applyMotionCorrection(GUI, k, false);
        else
            if GUIHandles.Info.isTif == 1
                frame_all_channels = GUIHandles.tifData(:,:,k + 1);
            else
                frame_all_channels = sbxRead(GUIHandles.Info, k);
            end
            num_channels = ndims(frame_all_channels);
            if num_channels > 2
                if strcmp(GUIHandles.imageProcessing.displayChannel, 'green channel')
                    disp_chan = 1;
                else
                    disp_chan = 2;
                end
                frame = squeeze(frame_all_channels(disp_chan,:,:));
            else
                frame = frame_all_channels;
            end
            
        end
        if(k==from_frame)
            imwrite(frame,[GUIHandles.sbxPath GUIHandles.sbxName '.tif'],'tif');
        else
            imwrite(frame,[GUIHandles.sbxPath GUIHandles.sbxName '.tif'],'tif','writemode','append');
        end
        k = k+1;
    end
    
    disp(['exported ' GUIHandles.sbxPath GUIHandles.sbxName  '.tif']);
end

function resonantOffsetSliderCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode
        case 'Image Processing'            
            resonantOffset = round(GUIHandles.imageProcessing.resonantOffsetSlider.Value);
            GUIHandles.roiDrawing.resonantOffsetSlider.Value = resonantOffset;
            GUIHandles.roiPairing.resonantOffsetSlider.Value = resonantOffset;
        case 'ROI Drawing'
            resonantOffset = round(GUIHandles.roiDrawing.resonantOffsetSlider.Value);
            GUIHandles.imageProcessing.resonantOffsetSlider.Value = resonantOffset;
            GUIHandles.roiPairing.resonantOffsetSlider.Value = resonantOffset;
        case 'ROI Pairing'
            resonantOffset = round(GUIHandles.roiPairing.resonantOffsetSlider.Value);
            GUIHandles.roiDrawing.resonantOffsetSlider.Value = resonantOffset;
            GUIHandles.imageProcessing.resonantOffsetSlider.Value = resonantOffset;
    end
    
    GUIHandles.resonantOffset = resonantOffset;
    
    guidata(GUI, GUIHandles);
    
    updateImageDisplay(GUI);

end

function brightnessSliderCallback(GUI, ~)
    
    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode
        case 'Image Processing'        
            brightness = GUIHandles.imageProcessing.brightnessSlider.Value;
            GUIHandles.roiDrawing.brightnessSlider.Value = brightness;
            GUIHandles.roiPairing.brightnessSlider.Value = brightness;
            
            temp = -brightness;
        case 'ROI Drawing'
            brightness = GUIHandles.roiDrawing.brightnessSlider.Value;
            GUIHandles.imageProcessing.brightnessSlider.Value = brightness;
            GUIHandles.roiPairing.brightnessSlider.Value = brightness;
            
            temp = -brightness;
        case 'ROI Pairing'
            brightness = GUIHandles.roiPairing.brightnessSlider.Value;
            GUIHandles.imageProcessing.brightnessSlider.Value = brightness;
            GUIHandles.roiDrawing.brightnessSlider.Value = brightness;
            
            temp = -brightness;
    end
    
    if temp < GUIHandles.imageProcessing.imageAxes.CLim(2)
        GUIHandles.imageProcessing.imageAxes.CLim(1) = temp;
        GUIHandles.roiDrawing.imageAxes.CLim(1) = temp;
        GUIHandles.roiPairing.imageAxes.CLim(1) = temp;
    else
        GUIHandles.imageProcessing.imageAxes.CLim(1) = GUIHandles.imageProcessing.imageAxes.CLim(2) - 0.00001;
        GUIHandles.roiDrawing.imageAxes.CLim(1) = GUIHandles.imageProcessing.imageAxes.CLim(2) - 0.00001;
        GUIHandles.roiPairing.imageAxes.CLim(1) = GUIHandles.imageProcessing.imageAxes.CLim(2) - 0.00001;
    end
    
    guidata(GUI, GUIHandles);

    updateImageDisplay(GUI);

end

function contrastSliderCallback(GUI, ~)
    
    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode
        case 'Image Processing'
            contrast = GUIHandles.imageProcessing.contrastSlider.Value;
            GUIHandles.roiDrawing.contrastSlider.Value = contrast;
            GUIHandles.roiPairing.contrastSlider.Value = contrast;
            
            temp = 1.0/contrast;
        case 'ROI Drawing'
            contrast = GUIHandles.roiDrawing.contrastSlider.Value;
            GUIHandles.imageProcessing.contrastSlider.Value = contrast;
            GUIHandles.roiPairing.contrastSlider.Value = contrast;
            
            temp = 1.0/contrast;
        case 'ROI Pairing'
            contrast = GUIHandles.roiPairing.contrastSlider.Value;
            GUIHandles.imageProcessing.contrastSlider.Value = contrast;
            GUIHandles.roiDrawing.contrastSlider.Value = contrast;
            
            temp = 1.0/contrast;
    end
    
    if temp > GUIHandles.imageProcessing.imageAxes.CLim(1)
        GUIHandles.imageProcessing.imageAxes.CLim(2) = temp;
        GUIHandles.roiDrawing.imageAxes.CLim(2) = temp;
        GUIHandles.roiPairing.imageAxes.CLim(2) = temp;
    else
        GUIHandles.imageProcessing.imageAxes.CLim(2) = GUIHandles.imageProcessing.imageAxes.CLim(1) + 0.00001;
        GUIHandles.roiDrawing.imageAxes.CLim(2) = GUIHandles.imageProcessing.imageAxes.CLim(1) + 0.00001;
        GUIHandles.roiPairing.imageAxes.CLim(2) = GUIHandles.imageProcessing.imageAxes.CLim(1) + 0.00001;
    end
    
    guidata(GUI, GUIHandles);

    updateImageDisplay(GUI);

end

function saveMovieCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    choice = questdlg('Start movie at current frame?', 'Save Movie', 'Yes', 'No', 'No');

    switch choice
        case 'Yes'
            frameOffset = round(GUIHandles.frameSliderValue);    
        case 'No'
            frameOffset = 0;
    end
    
    frameIndices = frameOffset:GUIHandles.Info.maxIndex;
    
    try
        frameTimes = GUIHandles.Info.timeStamps(frameOffset + 1:GUIHandles.Info.maxIndex);
    catch
        frameTimes = (frameIndices*512)/(GUIHandles.Info.resfreq*(2 - GUIHandles.Info.scanmode));
    end

    frameRate = length(frameTimes)/(frameTimes(end) - frameTimes(1));
    
    number = 1;
    
    while exist([GUIHandles.sbxPath, GUIHandles.sbxName, '_', int2str(number), '.mp4'], 'file')
        number = number + 1;
    end
    
    try
        imagingMovie = VideoWriter([GUIHandles.sbxPath, GUIHandles.sbxName, '_', int2str(number), '.mp4'], 'MPEG-4');
    catch
        waitfor(msgbox('Error: Cannot create imaging movie with given filename.'));
        error('Cannot create imaging movie with given filename.');
    end
    
    % movie quality is in percentage
    imagingMovie.Quality = 100;
    imagingMovie.FrameRate = frameRate;
    open(imagingMovie);
    
    GUIHandles.imageProcessing.saveMovieButton.Visible = 'off';
    
    progressBar = waitbar(0, 'Saving movie...', 'Name', [GUIHandles.sbxName, ': sbxMovie'], 'CreateCancelBtn', 'setappdata(gcbf, ''Canceling'', 1)');
    setappdata(progressBar, 'Canceling', 0);
    
    for f = 1:length(frameIndices)
        GUIHandles = guidata(GUI);
        
        GUIHandles.imageProcessing.frameSlider.Value = frameIndices(f);
        guidata(GUI, GUIHandles);
        frameSliderCallback(GUI);

        frame = frame2im(getframe(GUIHandles.imageProcessing.imageAxes));
    
        % make sure frames have multiple-of-two dimensions
        if mod(size(frame, 1), 2) ~= 0
            frame(1, :, :) = [];
        end
        if mod(size(frame, 2), 2) ~= 0
            frame(:, 1, :) = [];
        end

        writeVideo(imagingMovie, frame);
        
        if getappdata(progressBar, 'Canceling')
            GUIHandles.imageProcessing.saveMovieButton.Visible = 'on';
            
            delete(progressBar);
    
            guidata(GUI, GUIHandles);
            return
        else
            waitbar(f/length(frameIndices), progressBar);
        end
    end
    
    close(imagingMovie);
    
    GUIHandles.imageProcessing.saveMovieButton.Visible = 'on';
    
    delete(progressBar);
    
    guidata(GUI, GUIHandles);
    
end

function gatherCallback(GUI, ~)

GUIHandles = guidata(GUI);

Parameters.GUI = true;

% set pixel intensity threshold for sampling frames for reference
Parameters.threshold = 1500;
Parameters.threshold = 0;

% set sigma of Gaussian filter applied to image to smooth out pixel artefacts - 0 is no filtering
Parameters.gaussianFilter = GUIHandles.motionCorrectGaussianFilter;
Parameters.passes = 3;
Parameters.sampleSize = 1000;
Parameters.frameCrop = [0, 0, 0, 0];

if ~GUIHandles.motionCorrected
%     choice = questdlg('Crop imaging data before motion correction? BD artifact = horizontal lines on left frame border', 'Crop Frame', 'Yes', 'No', 'BD artifact only','Lou way', 'Yes');
    choice = questdlg('Crop imaging data before motion correction?', 'Crop Frame', 'Yes', 'No', 'Yes');
    
    if strcmp(choice, 'Yes')
        
        % create an adjustable rectange to specify frame cropping
        cropShape = imrect(GUIHandles.imageProcessing.imageAxes, [0.1*GUIHandles.imageSize(2), 0.1*GUIHandles.imageSize(1), 0.8*GUIHandles.imageSize(2), 0.8*GUIHandles.imageSize(1)]);
        setColor(cropShape, [0.5, 0.5, 0.5]);
        
        wait(cropShape);
        
        %1=start point horizontal, 2=start point vertical, 3distance
        %horizontal, 4=distance vertical
        temp = getPosition(cropShape);
        
        Parameters.frameCrop(1) = ceil(temp(1));
        Parameters.frameCrop(2) = ceil(GUIHandles.imageSize(2) - (temp(1) + temp(3)));
        Parameters.frameCrop(3) = ceil(temp(2));
        Parameters.frameCrop(4) = ceil(GUIHandles.imageSize(1) - (temp(2) + temp(4)));
                
        delete(cropShape)
    elseif strcmp(choice, 'Lou way')
            
        disp('Sometimes I dream of microwave chicken')
        temp=[96 27 700 485];
        Parameters.frameCrop(1) = ceil(temp(1));
        Parameters.frameCrop(2) = ceil(GUIHandles.imageSize(2) - (temp(1) + temp(3)));
        Parameters.frameCrop(3) = ceil(temp(2));
        Parameters.frameCrop(4) = ceil(GUIHandles.imageSize(1) - (temp(2) + temp(4)));
        
    elseif strcmp(choice,  'BD artifact only')
        disp('cropping BD artifact only...');
    end
 end
        
    % specify upsampling factor
    Parameters.subpixelFactor = 1;
    if strcmp(GUIHandles.imageProcessing.displayChannel, 'green channel')
        Parameters.align_chan = 1;
    else
        Parameters.align_chan = 2;
    end
    
    Parameters.gatherAlignChannel = 1;
    
    GUIHandles.imageProcessing.gatherButton.Visible = 'off';
    
    result = sbxGather(GUIHandles.Info, Parameters);
    
    if strcmp(result, 'Canceled')
        GUIHandles.imageProcessing.gatherButton.Visible = 'on';
    elseif strcmp(result, 'Completed')
        guidata(GUI, GUIHandles);
    end

end

function splitCallback(GUI, ~)

    GUIHandles = guidata(GUI);

    Parameters.GUI = true;
    
    GUIHandles.imageProcessing.splitButton.Visible = 'off';
    
    result = sbxSplit(GUIHandles.Info, Parameters);
    
    if strcmp(result, 'Canceled')
        GUIHandles.imageProcessing.splitButton.Visible = 'on';
    elseif strcmp(result, 'Completed')
        guidata(GUI, GUIHandles);

        loadNewSBXCallback(GUI);
    end

end

function motionCorrectCallback(GUI, ~)

    GUIHandles = guidata(GUI);
        
    Parameters.GUI = true;
    
    if GUIHandles.Info.isTif == 1
        % pull off the file extension
        fName = strtok(GUIHandles.Info.tifName, '.');

        N = GUIHandles.Info.maxIndex;
        Y_n = GUIHandles.tifData;
        Y = squeeze(Y_n);
        Y = single(Y);                 % convert to single precision 
        T = size(Y,ndims(Y));
        Y = Y - min(Y(:));             % remove baseline from absolute values
        
        % now try non-rigid motion correction (also in parallel)
        options_nonrigid = NoRMCorreSetParms('d1',size(Y,1),'d2',size(Y,2),'grid_size',[32,32],'mot_uf',4,'bin_width',200,'max_shift',15,'max_dev',3,'us_fac',50,'init_batch',200);
        tic; [M2,shifts2,template2,options_nonrigid] = normcorre_batch(Y,options_nonrigid); toc
        
        shifts_r = squeeze(cat(3,shifts2(:).shifts));
        shifts_nr = cat(ndims(shifts2(1).shifts)+1,shifts2(:).shifts);
        shifts_nr = reshape(shifts_nr,[],ndims(Y)-1,T);
        shifts_x = squeeze(shifts_nr(:,1,:))';
        shifts_y = squeeze(shifts_nr(:,2,:))';
        
        GUIHandles.Info.shifts_x = shifts_x;
        GUIHandles.Info.shifts_y = shifts_y;
        
        GUIHandles.shifts_x = shifts_x;
        GUIHandles.shifts_y = shifts_y;
        
        patch_id = 1:size(shifts_x,2);

%         temp_fig = gcf;
%         figure;
%         ax2 = subplot(211); plot(shifts_x); hold on; plot(shifts_r(:,1),'--k','linewidth',2); title('displacements along x','fontsize',14,'fontweight','bold')
%                 set(gca,'Xtick',[])
%         ax3 = subplot(212); plot(shifts_y); hold on; plot(shifts_r(:,2),'--k','linewidth',2); title('displacements along y','fontsize',14,'fontweight','bold')
%                 xlabel('timestep','fontsize',14,'fontweight','bold')
%         linkaxes([ax2,ax3],'x')
%         
%         set(0, 'CurrentFigure', temp_fig)
        
        fName_new = char([GUIHandles.Info.Directory.folder, GUIHandles.Info.Directory.name, '_rigid.tif']);
        %imwrite(M2, fName_new);
        tifData_reg = Tiff(fName_new,'w');
        tagstruct.ImageLength = size(M2,1);
        tagstruct.ImageWidth = size(M2,2);
        tagstruct.SampleFormat = getTag(GUIHandles.tifObject,'SampleFormat'); %1; % uint
        tagstruct.Photometric = getTag(GUIHandles.tifObject,'Photometric'); %Tiff.Photometric.MinIsBlack;
        tagstruct.BitsPerSample = 32;
        tagstruct.SamplesPerPixel = 1;
        tagstruct.YCbCrSubSampling = [1,1];
        tagstruct.Compression = getTag(GUIHandles.tifObject,'Compression'); %Tiff.Compression.None;  
        tagstruct.PlanarConfiguration = getTag(GUIHandles.tifObject,'PlanarConfiguration'); %Tiff.PlanarConfiguration.Chunky; 
        %setTag(tifData_reg,tagstruct);
        %write(tifData_reg,uint32(M2(:,:,1)));
        
        disp('writing tif data...');
        for ii=1:size(M2,3)
           setTag(tifData_reg,tagstruct);
           write(tifData_reg,uint32(M2(:,:,ii)));
           writeDirectory(tifData_reg);
        end
        close(tifData_reg);
        disp('DONE writing tif data...');
        GUIHandles.tifData = M2;
        
        disp('making dummy alignment file');
        phaseDifferences = zeros(1,GUIHandles.Info.maxIndex+1);
        rowShifts = zeros(1,GUIHandles.Info.maxIndex+1);
        columnShifts = zeros(1,GUIHandles.Info.maxIndex+1);
        frameCrop = [0,0,0,0];
        save([GUIHandles.Info.Directory.folder, GUIHandles.Info.Directory.name, '_rigid.rigid'], 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop', 'shifts_x', 'shifts_y');
        GUIHandles.Info.Directory.name = char([GUIHandles.Info.Directory.name, '_rigid']);
        %disp('sbx Process');
        %sbxPreAnalysisNew(GUIHandles.Info)
        disp('done');

        GUIHandles.imageProcessing.computeButton.Visible = 'on';

        GUIHandles.phaseDifferences = phaseDifferences;
        GUIHandles.rowShifts = rowShifts;
        GUIHandles.columnShifts = columnShifts;
        GUIHandles.frameCrop = frameCrop;

        GUIHandles.imageSize = [GUIHandles.imageSize(1) - GUIHandles.frameCrop(3) - GUIHandles.frameCrop(4), GUIHandles.imageSize(2) - GUIHandles.frameCrop(1) - GUIHandles.frameCrop(2)];

        GUIHandles.motionCorrected = true;

        guidata(GUI, GUIHandles);

        updateImageDisplay(GUI);

        GUIHandles = guidata(GUI);

        GUIHandles.XLim = GUIHandles.imageProcessing.imageAxes.XLim;
        GUIHandles.YLim = GUIHandles.imageProcessing.imageAxes.YLim;
        GUIHandles.maxWindowSize = (GUIHandles.XLim(2) - GUIHandles.XLim(1))/2;
        GUIHandles.windowSize = GUIHandles.maxWindowSize;
        GUIHandles.windowRatio = (GUIHandles.YLim(2) - GUIHandles.YLim(1))/(GUIHandles.XLim(2) - GUIHandles.XLim(1));

    else

        % set pixel intensity threshold for sampling frames for reference
        Parameters.threshold = 1500;

        % set sigma of Gaussian filter applied to image to smooth out pixel artefacts - 0 is no filtering
        Parameters.gaussianFilter = GUIHandles.motionCorrectGaussianFilter;
        Parameters.passes = 3;
        Parameters.sampleSize = 1000;
        Parameters.frameCrop = [0, 0, 0, 0];

        choice = questdlg('Crop imaging data before motion correction? BD artifact = horizontal lines on left border of frame.', 'Crop Frame', 'Yes', 'No', 'BD artifact only', 'No');

        if strcmp(choice, 'Yes')

            % create an adjustable rectange to specify frame cropping
            cropShape = imrect(GUIHandles.imageProcessing.imageAxes, [0.1*GUIHandles.imageSize(2), 0.1*GUIHandles.imageSize(1), 0.8*GUIHandles.imageSize(2), 0.8*GUIHandles.imageSize(1)]);
            setColor(cropShape, [0.5, 0.5, 0.5]);

            wait(cropShape);

            temp = getPosition(cropShape);

            Parameters.frameCrop(1) = ceil(temp(1));
            Parameters.frameCrop(2) = ceil(GUIHandles.imageSize(2) - (temp(1) + temp(3)));
            Parameters.frameCrop(3) = ceil(temp(2));
            Parameters.frameCrop(4) = ceil(GUIHandles.imageSize(1) - (temp(2) + temp(4)));

            delete(cropShape);

        elseif strcmp(choice, 'BD artifact only')
            disp('cropping BD artifact');
            Parameters.frameCrop(1) = 91;
            Parameters.frameCrop(2) = 0;
            Parameters.frameCrop(3) = 0;
            Parameters.frameCrop(4) = 0;
        end

        % specify upsampling factor
        Parameters.subpixelFactor = 1;

        GUIHandles.imageProcessing.motionCorrectButton.Visible = 'off';

        [phaseDifferences, rowShifts, columnShifts, result] = sbxRigid(GUIHandles.Info, Parameters);

        if strcmp(result, 'Canceled')
            GUIHandles.imageProcessing.motionCorrectButton.Visible = 'on';
        elseif strcmp(result, 'Completed')
            GUIHandles.imageProcessing.computeButton.Visible = 'on';

            GUIHandles.phaseDifferences = phaseDifferences;
            GUIHandles.rowShifts = rowShifts;
            GUIHandles.columnShifts = columnShifts;
            GUIHandles.frameCrop = Parameters.frameCrop;

            GUIHandles.imageSize = [GUIHandles.imageSize(1) - GUIHandles.frameCrop(3) - GUIHandles.frameCrop(4), GUIHandles.imageSize(2) - GUIHandles.frameCrop(1) - GUIHandles.frameCrop(2)];

            GUIHandles.motionCorrected = true;

            guidata(GUI, GUIHandles);

            updateImageDisplay(GUI);

            GUIHandles = guidata(GUI);

            GUIHandles.XLim = GUIHandles.imageProcessing.imageAxes.XLim;
            GUIHandles.YLim = GUIHandles.imageProcessing.imageAxes.YLim;
            GUIHandles.maxWindowSize = (GUIHandles.XLim(2) - GUIHandles.XLim(1))/2;
            GUIHandles.windowSize = GUIHandles.maxWindowSize;
            GUIHandles.windowRatio = (GUIHandles.YLim(2) - GUIHandles.YLim(1))/(GUIHandles.XLim(2) - GUIHandles.XLim(1));

            
        end
    end
    guidata(GUI, GUIHandles);
    
end

function computeCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    Parameters.GUI = true;
    Parameters.resonantOffset = GUIHandles.resonantOffset;
    
    % set pixel intensity threshold for sampling frames for reference
    Parameters.threshold = 1500;
    
    % set sigma of Gaussian filter applied to image to smooth out pixel artefacts - 0 is no filtering
    Parameters.gaussianFilter = GUIHandles.computeGaussianFilter;
    Parameters.method = 1;
    Parameters.sampleSize = 750;
    
    answer = inputdlg({'Min frame:', 'Max frame:'}, 'Frames to sample from for image stack', 1, {'0', int2str(GUIHandles.Info.maxIndex)});
    Parameters.sampleBounds(1) = str2double(answer{1});
    Parameters.sampleBounds(2) = str2double(answer{2});
    
    Parameters.maxQuantile = 0.95;
    
    GUIHandles.imageProcessing.computeButton.Visible = 'off';
    
    if GUIHandles.Info.isTif == 1
        GUIHandles.Info.tifData = GUIHandles.tifData; % add tifdata to info structure so it can be passed to preanalysis
    end
    [meanImage, maxIntensityImage, crossCorrelationImage, localCrossCorrelationImage, pcaImage, result] = sbxPreAnalysis(GUIHandles.Info, Parameters);

    if strcmp(result, 'Canceled')
        GUIHandles.imageProcessing.computeButton.Visible = 'on';
    elseif strcmp(result, 'Completed')
        GUIHandles.roiDrawing.meanImage = meanImage/double(intmax('uint16'));
        GUIHandles.roiDrawing.maxIntensityImage = maxIntensityImage/double(intmax('uint16'));        
        GUIHandles.roiDrawing.crossCorrelationImage = crossCorrelationImage;
        GUIHandles.roiDrawing.localCrossCorrelationImage = localCrossCorrelationImage;
        GUIHandles.roiDrawing.pcaImage = pcaImage/max(pcaImage(:));

        GUIHandles.preLoaded = true;
        GUIHandles.localCCLoaded = true;

        GUIHandles.roiDrawingTab.Parent = GUIHandles.modeTabGroup;

        guidata(GUI, GUIHandles);

        % set up analyze tab if we're not just loading more data
        if ~isfield(GUIHandles.roiDrawing, 'roiMask')
            setupROIDrawingTab(GUI);
        end
    end

end

function loadROIMaskCallback(GUI, ~)
    
    try
        [roiMaskName, roiMaskPath] = uigetfile({'*.rois; *.seg'}, 'Please select file containing ROI mask.');
    catch
        waitfor(msgbox('Error: Please select valid .rois file.'));
        error('Please select valid .rois file.');
    end   
    
    roiMaskName = strtok(roiMaskName, '.');
            
    try
        temp = who('-file', [roiMaskPath, roiMaskName, '.rois']);

        if ismember('overlapMask', temp)
            if ismember('roiMaskTag', temp)
                load([roiMaskPath, roiMaskName, '.rois'], '-mat', 'roiMask', 'overlapMask', 'roiMaskTag');
                if ~isempty(roiMaskTag)
                    roiMaskName = erase(roiMaskName,['_',roiMaskTag]); % delete tag from filename
                end
            else
                load([roiMaskPath, roiMaskName, '.rois'], '-mat', 'roiMask', 'overlapMask');
            end
        elseif ismember('roiMask', temp)
            if ismember('roiMaskTag', temp)
                load([roiMaskPath, roiMaskName, '.rois'], '-mat', 'roiMask', 'overlapMask', 'roiMaskTag');
                roiMaskName = erase(roiMaskName,['_',roiMaskTag]); % delete tag from filename
            else
                load([roiMaskPath, roiMaskName, '.rois'], '-mat', 'roiMask');
            end

            overlapMask = zeros(size(roiMask));
        else
            load([roiMaskPath, roiMaskName, '.rois'], '-mat', 'mask');

            roiMask = mask;
            overlapMask = zeros(size(roiMask));
        end
    catch
        temp = who('-file', [roiMaskPath, roiMaskName, '.seg']);

        if ismember('overlapMask', temp)
            load([roiMaskPath, roiMaskName, '.seg'], '-mat', 'roiMask', 'overlapMask');
        elseif ismember('roiMask', temp)
            load([roiMaskPath, roiMaskName, '.seg'], '-mat', 'roiMask');

            overlapMask = zeros(size(roiMask));
        else
            load([roiMaskPath, roiMaskName, '.seg'], '-mat', 'mask');

            roiMask = mask;
            overlapMask = zeros(size(roiMask));
        end
    end

    GUIHandles = guidata(GUI);
    
    if size(roiMask, 1) ~= GUIHandles.imageSize(1)
        while size(roiMask, 1) > GUIHandles.imageSize(1)
            if ~any(roiMask(1, :))
                roiMask(1, :) = [];
                overlapMask(1, :) = [];
            elseif ~any(roiMask(end, :))
                roiMask(end, :) = [];
                overlapMask(end, :) = [];
            else
                warning('Previous ROI information will be lost due to cropping.')
                roiMask(end, :) = [];
                overlapMask(end, :) = [];
            end
        end
        while size(roiMask, 1) < GUIHandles.imageSize(1)
            roiMask(end + 1, :) = 0;
            overlapMask(end + 1, :) = 0;
        end
    end
    if size(roiMask, 2) ~= GUIHandles.imageSize(2)
        while size(roiMask, 2) > GUIHandles.imageSize(2)
            if ~any(roiMask(:, 1))
                roiMask(:, 1) = [];
                overlapMask(:, 1) = [];
            elseif ~any(roiMask(:, end))
                roiMask(:, end) = [];
                overlapMask(:, end) = [];
            else
                warning('Previous ROI information will be lost due to cropping.')
                roiMask(:, end) = [];
                overlapMask(:, end) = [];
            end
        end
        while size(roiMask, 2) < GUIHandles.imageSize(2)
            roiMask(:, end + 1) = 0;
            overlapMask(:, end + 1) = 0;
        end
    end
    
    GUIHandles.roiDrawing.roiMask = roiMask;
    GUIHandles.roiDrawing.overlapMask = overlapMask;
    
    roiIDs = unique(roiMask);
    roiIDs = roiIDs(2:end);
    roiIDs = num2cell(num2str(roiIDs),2);
    roiIDs = cellfun(@strip, roiIDs, 'UniformOutput', false); % this is necessary as num2str introduced leading spaces
    for i=1:length(roiIDs)
        if length(roiIDs{i}) == 1
           roiIDs{i} = strcat('000',roiIDs{i});
        elseif length(roiIDs{i}) == 2
           roiIDs{i} = strcat('00',roiIDs{i});
        elseif length(roiIDs{i}) == 3
           roiIDs{i} = strcat('0',roiIDs{i});
        elseif length(roiIDs{i}) == 5
           roiIDs{i} = strcat('000',roiIDs{i});
        elseif length(roiIDs{i}) == 6
           roiIDs{i} = strcat('00',roiIDs{i});
        elseif length(roiIDs{i}) == 7
           roiIDs{i} = strcat('0',roiIDs{i});
        elseif length(roiIDs{i}) == 9
           roiIDs{i} = strcat('000',roiIDs{i});
        elseif length(roiIDs{i}) == 11
           roiIDs{i} = strcat('000',roiIDs{i});
        elseif length(roiIDs{i}) == 12
           roiIDs{i} = strcat('00',roiIDs{i});
        elseif length(roiIDs{i}) == 13
           roiIDs{i} = strcat('0',roiIDs{i});
        end
        
    end
    GUIHandles.roiDrawing.roiTree.String = roiIDs;
    GUIHandles.roiDrawing.roiTree.Value = 1;
    GUIHandles.roiDrawing.roiTree.String = order_roi_tree(GUIHandles.roiDrawing.roiTree);
    
    GUIHandles.roiDrawing.previousROIMask = GUIHandles.roiDrawing.roiMask;
    GUIHandles.roiDrawing.allROIsMask = GUIHandles.roiDrawing.roiMask > 0;
    
    GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.previousOverlapMask = GUIHandles.roiDrawing.overlapMask;
    
    GUIHandles.roiDrawing.roiMaskPath = roiMaskPath;
    GUIHandles.roiDrawing.roiMaskName = roiMaskName;
    GUIHandles.roiDrawing.roiMaskTag.String = roiMaskTag;
    
    guidata(GUI, GUIHandles);
    
    updateROIImage(GUI);
    updateSelectedROIImage(GUI);
    updateOverlapImage(GUI);
    
end

function newROIMaskCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    GUIHandles.roiDrawing.roiMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.previousROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.overlapMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.previousOverlapMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiDrawing.roiMaskTag.String = '';
    
    GUIHandles.roiDrawing.roiMaskPath = GUIHandles.sbxPath;
    GUIHandles.roiDrawing.roiMaskName = GUIHandles.sbxName;
    
    GUIHandles.roiDrawing.roiTreeID = {};
    GUIHandles.roiDrawing.roiTreeCurrentParent = '0';
    GUIHandles.roiDrawing.previousRoiTree = {};
    GUIHandles.roiDrawing.roiTree.String = GUIHandles.roiDrawing.roiTreeID;
    GUIHandles.roiDrawing.roiTreeLevel.String = strcat('Parent: ', GUIHandles.roiDrawing.roiTreeCurrentParent);
    
    guidata(GUI, GUIHandles);
    
    updateROIImage(GUI);
    updateSelectedROIImage(GUI);
    updateOverlapImage(GUI);
    
end

function extractFluorescencesCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    % make sure no ROIs are selected
    if GUIHandles.roiDrawing.selectedROI(1) > 0
        selectedROIImageClickFunction(GUI);
    end

    GUIHandles = guidata(GUI);
    
    guidata(GUI, GUIHandles);
    
    % save ROIs
    saveROIsCallback(GUI);

    GUIHandles = guidata(GUI);
    
    gaussianFilter = GUIHandles.extractionGaussianFilter;
    
    lightMask = [];
    
    interp_dff = false;
    choice = questdlg('Interpolate dF/F for rejected frames?', 'Record', 'Yes', 'No', 'No');
    if strcmp(choice, 'Yes')
        interp_dff = true;
    end
        
    
%     choice = questdlg('Record light contamination?', 'Record', 'Yes', 'No', 'No');

%     if strcmp(choice, 'Yes')
%             
%         % create an adjustable rectange to specify frame cropping
%         shape = imrect(GUIHandles.roiDrawing.imageAxes, [0.1*GUIHandles.imageSize(2), 0.1*GUIHandles.imageSize(1), 0.1*GUIHandles.imageSize(2), 0.1*GUIHandles.imageSize(1)]);
%         setColor(shape, [0.5, 0.5, 0.5]);
% 
%         wait(shape);
% 
%         lightMask = find(shape.createMask(GUIHandles.roiDrawing.displayedImage));
% 
%         delete(shape);
%     end
    
    % frame1 = sbxRead(GUIHandles.Info, 1);
    if GUIHandles.Info.isTif == 1
        
        frame1 = GUIHandles.tifData(:,:,1);
    else
        frame1 = sbxRead(GUIHandles.Info, 1);
    end
    % LF 23/02/19: add extra check for zero-value pixels and whether they
    % should be replaced
%     if ~isempty(find(frame1<5, 1))
%         zero_pixels_treatment = questdlg('low-value pixels detected. Replace with mean frame brightness?', 'Yes', 'No');
%     else
%         zero_pixels_treatment = 'No';
%     end
    zero_pixels_treatment = 'No';
    % have to update GUIHandles again
    GUIHandles = guidata(GUI);
    
    if nnz(GUIHandles.roiDrawing.roiMask) > 0
        roiMask = GUIHandles.roiDrawing.roiMask;
        overlapMask = GUIHandles.roiDrawing.overlapMask;

        numberOfROIs = length(unique(roiMask)) - 1;
        roiIDs = unique(roiMask);
        roiIDs = roiIDs(2:end); % remove zero as a ROI
        numberOfFrames = GUIHandles.Info.maxIndex;% + 1; LF08/23/19: I don't know why we would add one here?
        
        if GUIHandles.roiDrawing.neuropilCorrection > 0
            neuropilMasks = cell(1, numberOfROIs);
            
            allROIsMask = roiMask > 0;
            
            for r = 1:numberOfROIs
                currentROI = roiMask == roiIDs(r);

                % we dilate the ROI with a disk structure to create the neuropil. note the subtraction of all pixels belonging to ROIs!
                if nnz(currentROI) > 0
                    neuropilMasks{r} = (imdilate(currentROI, strel('disk', GUIHandles.roiDrawing.neuropilSize)) - allROIsMask) > 0;
                else
                    neuropilMasks{r} = zeros(GUIHandles.imageSize);
                end
            end

            neuropilFluorescences = zeros(numberOfFrames, numberOfROIs);
        end

        roiSizes = zeros(numberOfROIs);
        roiCoordinates = zeros(2, numberOfROIs);
        roiFluorescences = zeros(numberOfFrames, numberOfROIs);
        
        neuropilCorrection = GUIHandles.roiDrawing.neuropilCorrection;
        frameSize = GUIHandles.imageSize;

%         GUIHandles.roiDrawing.extractFluorescencesButton.Visible = 'off';
        
        isolatedROIs = cell(1, numberOfROIs);
        
        if neuropilCorrection > 0
            isolatedNeuropils = cell(1, numberOfROIs);
        end
        
        skipped = [];
        
        % do this first to save time
        for r = 1:numberOfROIs
            currentROI = roiMask == roiIDs(r);

            roiSizes(r) = nnz(currentROI);

            if roiSizes(r) <= 0
                warning(['ROI ', int2str(r), ' not found. Skipped.'])
                skipped(end + 1) = r;
            else
                isolatedROIs{r} = find(currentROI);

                if neuropilCorrection > 0
                    isolatedNeuropils{r} = find(neuropilMasks{r} == 1);
                end
            end
        end

        meanBrightness = zeros(1, numberOfFrames);
        
        if ~isempty(lightMask)
            lightContaminations = zeros(1, numberOfFrames);
        end
        
        if GUIHandles.Info.isTif == 1
            fName = GUIHandles.Info.tifName;
        else
            fName = GUIHandles.sbxName;
        end
        progressBar = waitbar(0, 'Extracting fluorescences...', 'Name', [fName, ': Extracting Fluorescences'], 'CreateCancelBtn', 'setappdata(gcbf, ''Canceling'', 1)');
        setappdata(progressBar, 'Canceling', 0);
        
        % special command to exclude frames that with artefactual motion
        excludeFrames = false;
        
        for f = 1:numberOfFrames
            frame = applyMotionCorrection(GUI, f - 1, excludeFrames);
            if strcmp(zero_pixels_treatment, 'Yes')
                frame(frame<5) = mean(frame(frame>5));
            end
            
            if ~isnan(frame(1, 1))
                if GUIHandles.resonantOffset ~= 0
                    frame = applyResonantOffset(frame, GUIHandles.resonantOffset);
                end

                % apply some spatial smoothing if desired
                if gaussianFilter > 0.0
                   frame = imgaussfilt(frame, gaussianFilter); 
                end

                for r = 1:numberOfROIs
                    if ~ismember(r, skipped)
                        roiFluorescences(f, r) = mean(frame(isolatedROIs{r}));
                        
                        if neuropilCorrection > 0
                            neuropilFluorescences(f, r) = trimmean(frame(isolatedNeuropils{r}), 10);
                        end
                    end
                end

                meanBrightness(f) = mean(frame(:));

                if ~isempty(lightMask)                    
                    lightContaminations(f) = mean(frame(lightMask));
                end
            else
                warning(['Large frame-shift detected at frame ', int2str(f - 1), '. Frame could be misaligned. Replacing with NaNs.']);

                roiFluorescences(f, :) = nan;
                
                if neuropilCorrection > 0
                    neuropilFluorescences(f, :) = nan;
                end
                
                meanBrightness(f) = nan;
                
                if ~isempty(lightMask)
                    lightContaminations(f) = nan;
                end
            end

            if getappdata(progressBar, 'Canceling')
                GUIHandles.roiDrawing.extractFluorescencesButton.Visible = 'on';
                
                delete(progressBar);
                
                guidata(GUI, GUIHandles);
                return
            else
                waitbar(f/numberOfFrames, progressBar);
            end
        end
        
        mean_FOV_brigthness = mean(meanBrightness);
        std_FOV_brightness = std(meanBrightness);
        
        mean_shifts_x = mean(mean(GUIHandles.shifts_x));
        std_shifts_x = mean(std(GUIHandles.shifts_x));
        
        mean_shifts_y = mean(mean(GUIHandles.shifts_y));
        std_shifts_y = mean(std(GUIHandles.shifts_y));
        
        brightness_shift_std = 3;
        registration_shift_std = 3;
        min_num_shifts = size(GUIHandles.shifts_x) * 0.5;
        min_num_shifts = min_num_shifts(2);
        
        reject_frames_brightness = find(meanBrightness < (mean_FOV_brigthness-brightness_shift_std*std_FOV_brightness));
        
        reject_frames_shift_x = find(GUIHandles.shifts_x < (mean_shifts_x - registration_shift_std*std_shifts_x) | GUIHandles.shifts_x > (mean_shifts_x + registration_shift_std*std_shifts_x));
        [rrow, ~] = ind2sub(size(GUIHandles.shifts_x), reject_frames_shift_x);
        [C, ~, ic] = unique(rrow);
        a_counts = accumarray(ic,1);
        x_shift_counts = [C, a_counts]; % get number of individual square that have
        
        reject_frames_shift_y = find(GUIHandles.shifts_y < (mean_shifts_y - registration_shift_std*std_shifts_y) | GUIHandles.shifts_y > (mean_shifts_y + registration_shift_std*std_shifts_y));
        [rrow, ~] = ind2sub(size(GUIHandles.shifts_y), reject_frames_shift_y);
        [C, ~, ic] = unique(rrow);
        a_counts = accumarray(ic,1);
        y_shift_counts = [C, a_counts];
        
        x_shift_reject = x_shift_counts(x_shift_counts(:,2) > min_num_shifts,1);
        y_shift_reject = y_shift_counts(y_shift_counts(:,2) > min_num_shifts,1);

        reject_frames_all = union(reject_frames_brightness,union(x_shift_reject,y_shift_reject));
        
        roiFluorescences(reject_frames_all,:) = nan;
        
        if interp_dff
            for r=1:size(roiFluorescences,2)
                V = roiFluorescences(:,r);
                X = ~isnan(V);
                X = X.';
                Y = cumsum(X-diff([1,X])/2);
                Y = Y.';
                roiFluorescences(:,r) = interp1(1:nnz(X),V(X),Y);
            end
        end
        
        dff = calculateDFF(roiFluorescences,50);
        
        figure;
        ax1 = subplot(521);
        plot(roiFluorescences(2:end,:));
        ylabel('ROI brightness');
        ax2 = subplot(523);
        plot(dff(2:end,:));
        ylabel('DF/F');
        ax3 = subplot(525);
        plot(meanBrightness(2:end));
        ylabel('FOV brightness');
        yline(mean_FOV_brigthness-brightness_shift_std*std_FOV_brightness, '--');
        ax4 = subplot(527);
        plot(GUIHandles.shifts_x(2:end,:));
        yline(mean_shifts_x - registration_shift_std*std_shifts_x, '--');
        yline(mean_shifts_x + registration_shift_std*std_shifts_x, '--');
        ylabel('shifts x');
        ax5 = subplot(529);
        plot(GUIHandles.shifts_y(2:end,:));
        ylabel('shifts y');
        yline(mean_shifts_y - registration_shift_std*std_shifts_y, '--');
        yline(mean_shifts_y + registration_shift_std*std_shifts_y, '--');
        linkaxes([ax1,ax2,ax3,ax4,ax5],'x');
        ax6 = subplot(5,2,[2,4,6,8]);
        heatmap(transpose(dff),'GridVisible','off','Colormap',parula);
        caxis([0,max(max(dff))])
        ylabel('ROI #');
        xlabel('FRAME #');
        
        
        ax7 = subplot(5,2,10);
        plot(mean(dff.'));
        ylabel('mean DF/F');
        xlabel('FRAME #');
        
        if GUIHandles.Info.isTif == 1
            fileName = [GUIHandles.tifPath, GUIHandles.tifName];
        else
            fileName = [GUIHandles.sbxPath, GUIHandles.sbxName];
        end

        if exist([fileName, '.raw'], 'file')
            choice = questdlg('Override old extracted fluorescences? If not, data will be saved to new file.', 'Extract Fluorescences', 'Yes', 'No', 'No');

            if strcmp(choice, 'No')
                number = 1;

                while exist([fileName, '_', int2str(number), '.raw'], 'file')
                    number = number + 1;
                end
                
                fileName = [fileName, '_', int2str(number)];
            end
        end
        
        if GUIHandles.roiDrawing.neuropilCorrection > 0
            csvwrite([fileName, '.sig'], [roiFluorescences, neuropilFluorescences]);
            csvwrite([fileName, '.dff'], dff);
            
            if ~isempty(lightMask)
                save([fileName, '.raw'], 'roiFluorescences', 'neuropilFluorescences', 'lightContaminations', 'meanBrightness', 'roiMask', 'overlapMask');
            else
                save([fileName, '.raw'], 'roiFluorescences', 'neuropilFluorescences', 'meanBrightness', 'roiMask', 'overlapMask');
            end
        else
            csvwrite([fileName, '.sig'], roiFluorescences);
            csvwrite([fileName, '.dff'], dff);
            save([fileName, '.raw'], roiFluorescences);
        end

        % version 2 introduces the new structure of the .sig file
        version = 2;
        
        if isfield(GUIHandles.Info,'timeStamps')
            timestamps = GUIHandles.Info.timeStamps;
        else
            timestamps = [];
        end
        if isempty(lightMask)
            if isfield(GUIHandles,'shifts_x')
                shifts_x = GUIHandles.shifts_x;
                shifts_y = GUIHandles.shifts_y;
                save([fileName, '.extra'], 'version', 'meanBrightness', 'roiCoordinates', 'roiSizes', 'roiIDs', 'timestamps', 'shifts_x', 'shifts_y');
            else
                save([fileName, '.extra'], 'version', 'meanBrightness', 'roiCoordinates', 'roiSizes', 'roiIDs', 'timestamps');
            end
        else
            if isfield(GUIHandles','shifts_x')
                shifts_x = GUIHandles.shifts_x;
                shifts_y = GUIHandles.shifts_y;
                save([fileName, '.extra'], 'version', 'lightContaminations', 'meanBrightness', 'roiCoordinates', 'roiSizes', 'roiIDs', 'timestamps', 'shifts_x', 'shifts_y');
            else
                save([fileName, '.extra'], 'version', 'lightContaminations', 'meanBrightness', 'roiCoordinates', 'roiSizes', 'roiIDs', 'timestamps');
            end
        end
            
        GUIHandles.roiDrawing.extractFluorescencesButton.Visible = 'on';
                
        delete(progressBar);
        
        guidata(GUI, GUIHandles);
    end
    
end

function identifyROIsCallback(GUI, ~)
    
    GUIHandles = guidata(GUI);
    
    if ~isfield(GUIHandles.roiDrawing, 'clusteredROIMask') || ~all(all(GUIHandles.roiDrawing.clusteredROIMask == GUIHandles.roiDrawing.roiMask))
    
        % make sure no ROIs are selected
        if GUIHandles.roiDrawing.selectedROI(1) > 0
            selectedROIImageClickFunction(GUI);
        end

        % have to update GUIHandles again
        GUIHandles = guidata(GUI);
        
        GUIHandles.roiDrawing.clusteredROIMask = GUIHandles.roiDrawing.roiMask;

        if nnz(GUIHandles.roiDrawing.roiMask) > 0
            frameSize = GUIHandles.imageSize;
            
            numberOfROIs = max(GUIHandles.roiDrawing.roiMask(:));
            sampleSize = 500;
        
            % read a sample of random images
            indices = randperm(GUIHandles.Info.maxIndex + 1, sampleSize) - 1;

            % create image stack
            frames = zeros(sampleSize, frameSize(1), frameSize(2), 'uint16');

            roiFluorescences = zeros(sampleSize, numberOfROIs);

            roiMask = GUIHandles.roiDrawing.roiMask;

            GUIHandles.roiDrawing.clusterROIsButton.Visible = 'off';
    
            progressBar = waitbar(0, 'Generating image stack...', 'Name', [GUIHandles.sbxName, ': Identify ROIs'], 'CreateCancelBtn', 'setappdata(gcbf, ''Canceling'', 1)');
            setappdata(progressBar, 'Canceling', 0);

            % do this first so you don't have to do it for every ROI
            for f = 1:sampleSize
                frame = applyMotionCorrection(GUI, indices(f), false);

                if GUIHandles.resonantOffset ~= 0
                    frame = applyResonantOffset(frame, GUIHandles.resonantOffset);
                end

                frames(f, :, :) = frame;

                if getappdata(progressBar, 'Canceling')
                    GUIHandles.roiDrawing.clusterROIsButton.Visible = 'on';
                    
                    delete(progressBar);
                    
                    guidata(GUI, GUIHandles);
                    return
                else
                    waitbar(f/sampleSize, progressBar);
                end
            end
            
            waitbar(0, progressBar, 'Extracting fluorescences...');

            for r = 1:numberOfROIs
                currentROI = roiMask == r;

                if nnz(currentROI) <= 0
                    warning(['ROI ', int2str(r), ' not found. Skipped.'])
                end

                if nnz(currentROI) > 0
                    roiOutline = find(currentROI);

                    % we save time by limiting the number of pixels considered for each ROI (and neuropil)
                    [roiXValues, roiYValues] = ind2sub([frameSize(1), frameSize(2)], roiOutline);

                    roiMinX = ceil(min(roiXValues));
                    roiMaxX = floor(max(roiXValues));
                    roiMinY = ceil(min(roiYValues));
                    roiMaxY = floor(max(roiYValues));

                    currentROI = uint16(currentROI(roiMinX:roiMaxX, roiMinY:roiMaxY));

                    for f = 1:sampleSize

                        % extract ROI values as means
                        roiFluorescences(f, r) = mean(mean(squeeze(frames(f, roiMinX:roiMaxX, roiMinY:roiMaxY)).*currentROI));
                    end      
                end
            
                waitbar(r/numberOfROIs, progressBar);
            end
            
            delete(progressBar);

            % calculate correlation coefficients between multiple ROIs
            correlationCoefficients = corrcoef(roiFluorescences');

            % identify ROIs to be clustered
            clusteredROIs = cell(1, numberOfROIs);

            for r = 1:numberOfROIs
                for rPrime = 1:numberOfROIs
                    if rPrime ~= r
                        if correlationCoefficients(r, rPrime) >= GUIHandles.roiDrawing.correlationThreshold
                            clusteredROIs{r}(end + 1) = rPrime;
                        end
                    end
                end
            end
            
            GUIHandles.roiDrawing.clusteredROIs = clusteredROIs;

            guidata(GUI, GUIHandles);
        end
    else
        waitfor(msgbox('Warning: Current ROI mask has already been clustered.'));
    end
    
end

function undoCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    if GUIHandles.roiDrawing.selectedROI(1) == 0
        
        % undo (or redo) the last ROI mask edit by reverting to a previously saved version of it. note that this will not undo loading of a new ROI mask
        temp = GUIHandles.roiDrawing.roiMask;
        GUIHandles.roiDrawing.roiMask = GUIHandles.roiDrawing.previousROIMask;
        GUIHandles.roiDrawing.previousROIMask = temp;
        
        temp = GUIHandles.roiDrawing.roiTree.String;
        GUIHandles.roiDrawing.roiTree.Value = 1;
        GUIHandles.roiDrawing.roiTree.String = GUIHandles.roiDrawing.previousRoiTree;
        GUIHandles.roiDrawing.previousRoiTree = temp;
        
        temp = GUIHandles.roiDrawing.overlapMask;
        GUIHandles.roiDrawing.overlapMask = GUIHandles.roiDrawing.previousOverlapMask;
        GUIHandles.roiDrawing.previousOverlapMask = temp;

        switch GUIHandles.roiDrawing.undoButton.Visible
            case 'on'
                GUIHandles.roiDrawing.undoButton.Visible = 'off';
                GUIHandles.roiDrawing.redoButton.Visible = 'on';
            case 'off'
                GUIHandles.roiDrawing.undoButton.Visible = 'on';
                GUIHandles.roiDrawing.redoButton.Visible = 'off';
        end

        guidata(GUI, GUIHandles);

        updateROIImage(GUI);
        updateOverlapImage(GUI);
    end
    
end

function deleteROIsCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    % deletes the currently selected ROI
    if GUIHandles.roiDrawing.selectedROI(1) > 0
        if ~strcmp(GUIHandles.roiDrawing.manipulateType, 'Draw')
            GUIHandles.roiDrawing.selectedROIImage.Visible = 'off';
            GUIHandles.roiDrawing.neuropilImage.Visible = 'off';
            
            for r = length(GUIHandles.roiDrawing.selectedROI):-1:1 % LF: I don't know why this is a loop, this suggests you can select more than 1 ROI at a time?
                GUIHandles.roiDrawing.previousROIMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedROI(r)) = GUIHandles.roiDrawing.selectedROI(r); % add deleted ROI to previous roi mask so we can undo this
                
                % tick down the numbering of the ROIs
                % GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask  > GUIHandles.roiDrawing.selectedROI(r)) = GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask  > GUIHandles.roiDrawing.selectedROI(r)) - 1;
            end
            
            for i=1:length(GUIHandles.roiDrawing.roiTree.String) % delete selected ROI from roilist
                if str2double(GUIHandles.roiDrawing.roiTree.String{i}) == GUIHandles.roiDrawing.selectedROI
                    GUIHandles.roiDrawing.roiTree.String(i) = [];
                    GUIHandles.roiDrawing.roiTree.Value = 1;
                    break;
                end
            end
            
            GUIHandles.roiDrawing.selectedROI = 0;
            
            GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);
            GUIHandles.roiDrawing.selectedROINeuropilMask = zeros(GUIHandles.imageSize);
    
            % since this is a "new" edit, change redo button back to undo button if necessary
            if strcmp(GUIHandles.roiDrawing.redoButton.Visible, 'on')
                GUIHandles.roiDrawing.redoButton.Visible = 'off';
                GUIHandles.roiDrawing.undoButton.Visible = 'on';
            end
    
            guidata(GUI, GUIHandles);

            updateROIImage(GUI);
            updateOverlapImage(GUI);
    
            if strcmp(GUIHandles.roiDrawing.manipulateType, 'Prune')
                updateHistogram(GUI);
            end
        end
    elseif isfield(GUIHandles.roiDrawing, 'selectedOverlap')
        if GUIHandles.roiDrawing.selectedOverlap > 0
            if ~strcmp(GUIHandles.roiDrawing.manipulateType, 'Draw')
                GUIHandles.roiDrawing.selectedROIImage.Visible = 'off';

                GUIHandles.roiDrawing.previousOverlapMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedOverlap) = GUIHandles.roiDrawing.selectedOverlap;

                % tick down the numbering of the ROIs
                GUIHandles.roiDrawing.overlapMask(GUIHandles.roiDrawing.overlapMask  > GUIHandles.roiDrawing.selectedOverlap) = GUIHandles.roiDrawing.overlapMask(GUIHandles.roiDrawing.overlapMask  > GUIHandles.roiDrawing.selectedOverlap) - 1;

                GUIHandles.roiDrawing.selectedOverlap = 0;

                GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);
                GUIHandles.roiDrawing.selectedROINeuropilMask = zeros(GUIHandles.imageSize);

                % since this is a "new" edit, change redo button back to undo button if necessary
                if strcmp(GUIHandles.roiDrawing.redoButton.Visible, 'on')
                    GUIHandles.roiDrawing.redoButton.Visible = 'off';
                    GUIHandles.roiDrawing.undoButton.Visible = 'on';
                end

                guidata(GUI, GUIHandles);

                updateROIImage(GUI);
                updateOverlapImage(GUI);
            end
        end
    end
    
end

function saveROIsCallback(GUI, ~)
    
    GUIHandles = guidata(GUI);
    
    if GUIHandles.roiDrawing.selectedROI(1) > 0
        selectedROIImageClickFunction(GUI);
    end
    
    GUIHandles = guidata(GUI);

    roiMask = GUIHandles.roiDrawing.roiMask;
    
    %numberOfROIs = max(roiMask(:));
    numberOfROIs = length(unique(roiMask)) - 1;
    
    % if any ROIs are missing, adjust the numbering
    
%     LF: removed this section as the roi numbering is important to have a
%     roi hierarchy
%     for r = numberOfROIs:-1:1
%         currentROI = roiMask == r;
% 
%         if nnz(currentROI) <= 0
%             roiMask(roiMask > r) = roiMask(roiMask  > r) - 1;
%         end
%     end
    
    % create vertices from mask    
    vertices = cell(numberOfROIs, 1);
    
    for r = 1:numberOfROIs
        try
            vertices{r} = mask2poly(roiMask == r, 'Inner', 'MinDist');
        catch
            vertices{r} = [];
        end
    end
    
    % change the name so it's correct in the .mat file
    overlapMask = GUIHandles.roiDrawing.overlapMask;
    
    if ~isfield(GUIHandles.roiDrawing, 'roiMaskName')
        if GUIHandles.Info.isTif == 1
            GUIHandles.roiDrawing.roiMaskPath = GUIHandles.tifPath;
            GUIHandles.roiDrawing.roiMaskName = GUIHandles.tifName;
        else
            GUIHandles.roiDrawing.roiMaskPath = GUIHandles.sbxPath;
            GUIHandles.roiDrawing.roiMaskName = GUIHandles.sbxName;
        end
    end
    
    if ~isempty(GUIHandles.roiDrawing.roiMaskTag.String)
        fileName = [GUIHandles.roiDrawing.roiMaskPath, GUIHandles.roiDrawing.roiMaskName,'_',GUIHandles.roiDrawing.roiMaskTag.String];
    else    
        fileName = [GUIHandles.roiDrawing.roiMaskPath, GUIHandles.roiDrawing.roiMaskName];
    end
    
%     if exist([fileName, '.rois'], 'file')
%         choice = questdlg('Override old ROI mask? If not, mask will be saved to new file.', 'Save ROIs', 'Yes', 'No', 'No');
% 
%         if strcmp(choice, 'No')
%             number = 1;
% 
%             while exist([fileName, '_', int2str(number), '.rois'], 'file')
%                 number = number + 1;
%             end
% 
%             fileName = [fileName, '_', int2str(number)];
%         end
%     end
    
    roiMaskTag = GUIHandles.roiDrawing.roiMaskTag.String;
    save([fileName, '.rois'], 'roiMask', 'overlapMask', 'vertices', 'roiMaskTag');
        
    GUIHandles.roiDrawing.roiMask = roiMask;
    
    guidata(GUI, GUIHandles);
    
end

function hideROIsCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode
        case 'ROI Drawing'
            if GUIHandles.roiDrawing.hideROIsButton.Value == 1
                GUIHandles.roiDrawing.overlapImageVisible = GUIHandles.roiDrawing.overlapImage.Visible;
                GUIHandles.roiDrawing.roiImageVisible = GUIHandles.roiDrawing.roiImage.Visible;
                GUIHandles.roiDrawing.candidateROIImageVisible = GUIHandles.roiDrawing.candidateROIImage.Visible;
                GUIHandles.roiDrawing.selectedROIImageVisible = GUIHandles.roiDrawing.selectedROIImage.Visible;
                GUIHandles.roiDrawing.neuropilImageVisible = GUIHandles.roiDrawing.neuropilImage.Visible;
                GUIHandles.roiDrawing.islandImageVisible = GUIHandles.roiDrawing.islandImage.Visible;

                GUIHandles.roiDrawing.overlapImage.Visible = 'off';
                GUIHandles.roiDrawing.roiImage.Visible = 'off';
                GUIHandles.roiDrawing.candidateROIImage.Visible = 'off';
                GUIHandles.roiDrawing.selectedROIImage.Visible = 'off';
                GUIHandles.roiDrawing.neuropilImage.Visible = 'off';
                GUIHandles.roiDrawing.islandImage.Visible = 'off';
            else
                GUIHandles.roiDrawing.overlapImage.Visible = GUIHandles.roiDrawing.overlapImageVisible;
                GUIHandles.roiDrawing.roiImage.Visible = GUIHandles.roiDrawing.roiImageVisible;
                GUIHandles.roiDrawing.candidateROIImage.Visible = GUIHandles.roiDrawing.candidateROIImageVisible;
                GUIHandles.roiDrawing.selectedROIImage.Visible = GUIHandles.roiDrawing.selectedROIImageVisible;
                GUIHandles.roiDrawing.neuropilImage.Visible = GUIHandles.roiDrawing.neuropilImageVisible;
                GUIHandles.roiDrawing.islandImage.Visible = GUIHandles.roiDrawing.islandImageVisible;
            end
        case 'ROI Pairing'
            if GUIHandles.roiPairing.hideROIsButton.Value == 1
                GUIHandles.roiPairing.somaROIImageVisible = GUIHandles.roiPairing.somaROIImage.Visible;
                GUIHandles.roiPairing.dendriteROIImageVisible = GUIHandles.roiPairing.dendriteROIImage.Visible;
                GUIHandles.roiPairing.selectedSomaROIImageVisible = GUIHandles.roiPairing.selectedSomaROIImage.Visible;
                GUIHandles.roiPairing.selectedDendriteROIImageVisible = GUIHandles.roiPairing.selectedDendriteROIImage.Visible;
                
                GUIHandles.roiPairing.somaROIImage.Visible = 'off';
                GUIHandles.roiPairing.dendriteROIImage.Visible = 'off';
                GUIHandles.roiPairing.selectedSomaROIImage.Visible = 'off';
                GUIHandles.roiPairing.selectedDendriteROIImage.Visible = 'off';
            else
                GUIHandles.roiPairing.somaROIImage.Visible = GUIHandles.roiPairing.somaROIImageVisible;
                GUIHandles.roiPairing.dendriteROIImage.Visible = GUIHandles.roiPairing.dendriteROIImageVisible;
                GUIHandles.roiPairing.selectedSomaROIImage.Visible = GUIHandles.roiPairing.selectedSomaROIImageVisible;
                GUIHandles.roiPairing.selectedDendriteROIImage.Visible = GUIHandles.roiPairing.selectedDendriteROIImageVisible;
            end
    end
    
    guidata(GUI, GUIHandles);

end

function ccLocalCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    if isfield(GUIHandles, 'localCCLoaded')
        if ~GUIHandles.localCCLoaded
            temp = who('-file', [GUIHandles.sbxPath, GUIHandles.sbxName, '.pre']);

            disp('Loading local cross-correlations...');

            if ismember('meanImage', temp)
                load([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], '-mat', 'localCrossCorrelationImage')

                GUIHandles.roiDrawing.localCrossCorrelationImage = localCrossCorrelationImage;
            elseif ismember('meanReference', temp)
                load([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], '-mat', 'ccLocal')

                GUIHandles.roiDrawing.localCrossCorrelationImage = ccLocal;
            elseif ismember('meanref', temp)
                load([GUIHandles.sbxPath, GUIHandles.sbxName, '.pre'], '-mat', 'cc_local')

                GUIHandles.roiDrawing.localCrossCorrelationImage = cc_local;
            end
            
            GUIHandles.localCCLoaded = true;
            
            % save and reload
            guidata(GUI, GUIHandles);

            GUIHandles = guidata(GUI);

            disp('Done.');
        end

        % make sure to get rid of local cross-correlation square when turned off
        if GUIHandles.roiDrawing.ccLocalButton.Value == 0        
            updateImageDisplay(GUI);
        end
    end

end

function manipulateROIsButtonGroupSelectionFunction(GUI, eventdata)

    GUIHandles = guidata(GUI);
    
    % respond to changes in selected ROI manipulation type
    GUIHandles.roiDrawing.manipulateType = get(eventdata.NewValue, 'String');
    
    switch GUIHandles.roiDrawing.manipulateType
        case 'Draw'
            GUIHandles.roiDrawing.drawShapeButtonGroup.Visible = 'on';
            
            GUIHandles.roiDrawing.leftButton.Visible = 'off';
            GUIHandles.roiDrawing.rightButton.Visible = 'off';
            GUIHandles.roiDrawing.upButton.Visible = 'off';
            GUIHandles.roiDrawing.downButton.Visible = 'off';
            
            GUIHandles.roiDrawing.findROIButton.Visible = 'off';

            GUIHandles.roiDrawing.fillROIButton.Visible = 'off';
            GUIHandles.roiDrawing.clusterROIsButton.Visible = 'off';
            
            GUIHandles.roiDrawing.viewClusteredROIsButton.Visible = 'off';
            
            GUIHandles.roiDrawing.histogramAxes.Visible = 'off';
            GUIHandles.roiDrawing.histogramPlot.Visible = 'off';
        
            GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';
            
            GUIHandles.roiDrawing.islandSizeText.Visible = 'off';
            GUIHandles.roiDrawing.islandSizeSlider.Visible = 'off';
    
            GUIHandles.roiDrawing.viewNeuropilButton.Visible = 'off';
            GUIHandles.roiDrawing.viewNeuropilButton.Value = 0;
            
            GUIHandles.roiDrawing.neuropilSizeText.Visible = 'off';
            GUIHandles.roiDrawing.neuropilSizeSlider.Visible = 'off';
            
            GUIHandles.roiDrawing.neuropilImage.Visible = 'off';
            
            GUIHandles.roiDrawing.roiTree.Visible = 1;
            GUIHandles.roiDrawing.roiTreeLevel.Visible = 'on';
            GUIHandles.roiDrawing.roiTreeLevel0.Visible = 'on';
            GUIHandles.roiDrawing.roiTreeLevelParent.Visible = 'on';
            
            % reset the number of pixels to include in flood filling to make the first flood fill feel normal
            GUIHandles.roiDrawing.floodPixels = GUIHandles.roiDrawing.defaultFloodPixels;
        case 'Select'
            GUIHandles.roiDrawing.drawShapeButtonGroup.Visible = 'off';
            
            GUIHandles.roiDrawing.leftButton.Visible = 'on';
            GUIHandles.roiDrawing.rightButton.Visible = 'on';
            GUIHandles.roiDrawing.upButton.Visible = 'on';
            GUIHandles.roiDrawing.downButton.Visible = 'on';
            
            GUIHandles.roiDrawing.findROIButton.Visible = 'on';

            if length(GUIHandles.roiDrawing.selectedROI) > 1
                GUIHandles.roiDrawing.fillROIButton.Visible = 'off';
                GUIHandles.roiDrawing.clusterROIsButton.Visible = 'on';
            
                GUIHandles.roiDrawing.viewClusteredROIsButton.Visible = 'off';
            else
                if GUIHandles.roiDrawing.selectedROI > 0
                    GUIHandles.roiDrawing.fillROIButton.Visible = 'on';
                    GUIHandles.roiDrawing.viewClusteredROIsButton.Visible = 'on';
                end
                
                GUIHandles.roiDrawing.clusterROIsButton.Visible = 'off';
            end
            
            GUIHandles.roiDrawing.histogramAxes.Visible = 'off';
            GUIHandles.roiDrawing.histogramPlot.Visible = 'off';
        
            GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';
            
            GUIHandles.roiDrawing.islandSizeText.Visible = 'off';
            GUIHandles.roiDrawing.islandSizeSlider.Visible = 'off';
    
            GUIHandles.roiDrawing.viewNeuropilButton.Visible = 'off';
            GUIHandles.roiDrawing.viewNeuropilButton.Value = 0;
            
            GUIHandles.roiDrawing.neuropilSizeText.Visible = 'off';
            GUIHandles.roiDrawing.neuropilSizeSlider.Visible = 'off';
            
            GUIHandles.roiDrawing.neuropilImage.Visible = 'off';
            
            GUIHandles.roiDrawing.roiTree.Visible = 0;
            GUIHandles.roiDrawing.roiTreeLevel.Visible = 'off';
            GUIHandles.roiDrawing.roiTreeLevel0.Visible = 'off';
            GUIHandles.roiDrawing.roiTreeLevelParent.Visible = 'off';
            
        case 'Prune'
            GUIHandles.roiDrawing.drawShapeButtonGroup.Visible = 'off';
            
            GUIHandles.roiDrawing.leftButton.Visible = 'off';
            GUIHandles.roiDrawing.rightButton.Visible = 'off';
            GUIHandles.roiDrawing.upButton.Visible = 'off';
            GUIHandles.roiDrawing.downButton.Visible = 'off';
            
            GUIHandles.roiDrawing.findROIButton.Visible = 'off';

            GUIHandles.roiDrawing.fillROIButton.Visible = 'off';
            GUIHandles.roiDrawing.clusterROIsButton.Visible = 'off';
            
            GUIHandles.roiDrawing.viewClusteredROIsButton.Visible = 'off';
            
            GUIHandles.roiDrawing.roiTree.Visible = 0;
            GUIHandles.roiDrawing.roiTreeLevel.Visible = 'off';
            GUIHandles.roiDrawing.roiTreeLevel0.Visible = 'off';
            GUIHandles.roiDrawing.roiTreeLevelParent.Visible = 'off';
            
            GUIHandles.roiDrawing.histogramAxes.Visible = 'on';
            GUIHandles.roiDrawing.histogramPlot.Visible = 'on';
        
            if strcmp(GUIHandles.roiDrawing.imageType, 'Rolling Average') || strcmp(GUIHandles.roiDrawing.imageType, 'Frame-by-Frame')
                GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'on';
            else
                GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';
            end
            
            GUIHandles.roiDrawing.islandSizeText.Visible = 'on';
            GUIHandles.roiDrawing.islandSizeSlider.Visible = 'on';
    
            GUIHandles.roiDrawing.viewNeuropilButton.Visible = 'on';
            
            % reset the pruning threshold to make the first scroll feel smooth
            GUIHandles.roiDrawing.pruneThreshold = 0;
            
            % only prune one ROI at a time
            if length(GUIHandles.roiDrawing.selectedROI) > 1
                for r = 1:length(GUIHandles.roiDrawing.selectedROI) - 1
                    GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedROI(r)) = GUIHandles.roiDrawing.selectedROI(r);
                    GUIHandles.roiDrawing.selectedROIMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedROI(r)) = 0;
                end
                
                GUIHandles.roiDrawing.selectedROI = GUIHandles.roiDrawing.selectedROI(end);
                
                guidata(GUI, GUIHandles);
                
                updateROIImage(GUI);
                updateSelectedROIImage(GUI);
                updateOverlapImage(GUI);
            end
            
            if GUIHandles.roiDrawing.selectedROI > 0
                GUIHandles.roiDrawing.selectedROIPixelValues = GUIHandles.roiDrawing.displayedImage.CData.*logical(GUIHandles.roiDrawing.selectedROIImage.AlphaData);

                GUIHandles.roiDrawing.previousROIMask = GUIHandles.roiDrawing.roiMask;
                GUIHandles.roiDrawing.previousOverlapMask = GUIHandles.overlapMask;
                GUIHandles.roiDrawing.allROIsMask = GUIHandles.roiDrawing.roiMask > 0;
            
                % very important to make sure the selected ROI has been removed from the full ROI mask
                GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask == GUIHandles.roiDrawing.selectedROI) = 0;
                
                guidata(GUI, GUIHandles);
            
                updateHistogram(GUI);
            end
    end
    
    guidata(GUI, GUIHandles);

end

function drawTypeButtonGroupSelectionFunction(GUI, eventdata)

    GUIHandles = guidata(GUI);
    
    % respond to changes in selected ROI drawing type
    GUIHandles.roiDrawing.drawType = get(eventdata.NewValue, 'String');
    
    guidata(GUI, GUIHandles);

end

function moveCallback(GUI, eventdata)

    GUIHandles = guidata(GUI);  
    
    moveDirection = get(eventdata.Source, 'String');

    switch moveDirection
        case 'Left'
            shift = [-1, 2];
        case 'Right'
            shift = [1, 2];
        case 'Up'
            shift = [-1, 1];
        case 'Down'
            shift = [1, 1];
    end
    
    switch GUIHandles.mode
        case 'ROI Drawing' 
            if strcmp(GUIHandles.roiDrawing.manipulateType, 'Select') 
        
                % if no ROI is selected, move entire mask
                if GUIHandles.roiDrawing.selectedROI(1) == 0
                    GUIHandles.roiDrawing.roiMask = circshift(GUIHandles.roiDrawing.roiMask, shift(1), shift(2));
                    GUIHandles.roiDrawing.overlapMask = circshift(GUIHandles.roiDrawing.overlapMask, shift(1), shift(2));

                    guidata(GUI, GUIHandles);

                    updateROIImage(GUI);
                    updateOverlapImage(GUI);
                else
                    GUIHandles.roiDrawing.selectedROIMask = circshift(GUIHandles.roiDrawing.selectedROIMask, shift(1), shift(2));

                    guidata(GUI, GUIHandles);

                    updateSelectedROIImage(GUI)
                end
            end
        case 'ROI Pairing' 
            if GUIHandles.roiPairing.selectedSomaROI + GUIHandles.roiPairing.selectedDendriteROI == 0
                switch GUIHandles.roiPairing.selectedMask
                    case 'Somas'
                        GUIHandles.roiPairing.somaROIMask = circshift(GUIHandles.roiPairing.somaROIMask, shift(1), shift(2));
                    case 'Dendrites'
                        GUIHandles.roiPairing.dendriteROIMask = circshift(GUIHandles.roiPairing.dendriteROIMask, shift(1), shift(2));
                end

                guidata(GUI, GUIHandles);

                updateROIImage(GUI);
                updateOverlapImage(GUI);
            else
                if GUIHandles.roiPairing.selectedSomaROI > 0
                    GUIHandles.roiPairing.selectedSomaROIMask = circshift(GUIHandles.roiDrawing.selectedSomaROIMask, shift(1), shift(2));
                end
                if GUIHandles.roiPairing.selectedDendriteROI > 0
                    GUIHandles.roiPairing.selectedDendriteROIMask = circshift(GUIHandles.roiDrawing.selectedDendriteROIMask, shift(1), shift(2));
                end

                GUIHandles.roiPairing.selectedROIMask = GUIHandles.roiPairing.selectedSomaROIMask + GUIHandles.roiPairing.selectedDendriteROIMask;

                guidata(GUI, GUIHandles);

                updateSelectedROIImage(GUI)
            end
    end

end

function findROICallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    answer = inputdlg({'Find ROI:'}, 'Input for Subthreshold Analysis', 1);
    selectedROI = str2double(answer{1});

    if length(selectedROI) > 1
        waitfor(msgbox('Error: Please search for one ROI at a time.'));
        error('Please search for one ROI at a time.');
    end
    
    % first, return any current selected ROI to the full ROI mask
    if GUIHandles.roiDrawing.selectedROI ~= 0
        for r = 1:length(GUIHandles.roiDrawing.selectedROI)        
            GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedROI(r)) = GUIHandles.roiDrawing.selectedROI(r);
        end

        GUIHandles.roiDrawing.selectedROIImage.Visible = 'off';

        GUIHandles.roiDrawing.selectedROI = 0;

        GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);

        GUIHandles.roiDrawing.fillROIButton.Visible = 'off';
        GUIHandles.roiDrawing.clusterROIsButton.Visible = 'off';
        GUIHandles.roiDrawing.viewClusteredROIsButton.Visible = 'off';

        GUIHandles.roiDrawing.deleteROIsButton.String = 'Delete ROI';

        guidata(GUI, GUIHandles);

        updateROIImage(GUI);
        updateOverlapImage(GUI);
    end
    
    if any(GUIHandles.roiDrawing.roiMask(:) == selectedROI)
        GUIHandles.roiDrawing.selectedROI = selectedROI;
    
        if GUIHandles.roiDrawing.selectedROI > 0
            GUIHandles.roiDrawing.previousROIMask = GUIHandles.roiDrawing.roiMask;
            GUIHandles.roiDrawing.allROIsMask = GUIHandles.roiDrawing.roiMask > 0;
            
            GUIHandles.roiDrawing.previousOverlapMask = GUIHandles.roiDrawing.overlapMask;

            GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);

            % move the selected ROI from the normal ROI mask to the selected ROI mask
            GUIHandles.roiDrawing.selectedROIMask(GUIHandles.roiDrawing.roiMask == GUIHandles.roiDrawing.selectedROI) = GUIHandles.roiDrawing.selectedROI;

            GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask == GUIHandles.roiDrawing.selectedROI) = 0;

            GUIHandles.roiDrawing.selectedROINeuropilMask = (imdilate(GUIHandles.roiDrawing.selectedROIMask, strel('disk', GUIHandles.roiDrawing.neuropilSize)) - GUIHandles.roiDrawing.allROIsMask) > 0;

            % reset this values so we don't start somewhere weird
            GUIHandles.roiDrawing.minIslandSize = GUIHandles.roiDrawing.defaultMinIslandSize;
            GUIHandles.roiDrawing.islandSizeSlider.Value = GUIHandles.roiDrawing.minIslandSize;

            GUIHandles.roiDrawing.selectedROIImage.Visible = 'on';

            if strcmp(GUIHandles.roiDrawing.manipulateType, 'Select')
                GUIHandles.roiDrawing.fillROIButton.Visible = 'on';
            GUIHandles.roiDrawing.viewClusteredROIsButton.Visible = 'on';
            end

            guidata(GUI, GUIHandles);

            updateROIImage(GUI);
            updateSelectedROIImage(GUI);
            updateOverlapImage(GUI);
        end
    end
    
end

function fillROICallback(GUI, ~)

    GUIHandles = guidata(GUI);

    if GUIHandles.roiDrawing.selectedROI(1) > 0
        currentROI = GUIHandles.roiDrawing.selectedROIMask;
        roiMask = GUIHandles.roiDrawing.roiMask;
        currentOverlap = GUIHandles.roiDrawing.overlapMask;
        
        if nnz(currentROI) > 0                
            roiOutline = find(currentROI);

            [roiXValues, roiYValues] = ind2sub(GUIHandles.imageSize, roiOutline);

            roiMinX = ceil(min(roiXValues));
            roiMaxX = floor(max(roiXValues));
            roiMinY = ceil(min(roiYValues));
            roiMaxY = floor(max(roiYValues));

            currentROI = currentROI(roiMinX:roiMaxX, roiMinY:roiMaxY);
            roiMask = roiMask(roiMinX:roiMaxX, roiMinY:roiMaxY);
            currentOverlap = currentOverlap(roiMinX:roiMaxX, roiMinY:roiMaxY);
        end
    end
    
    % fill in pixels that are bordered by at least 5 pixels corresponding to the ROI
    for i = 2:size(currentROI, 1) - 1
        for j = 2:size(currentROI, 2) - 1
            if roiMask(i, j) == 0
                if currentROI(i, j) + currentOverlap(i, j) == 0 && nnz(currentROI(i - 1:i + 1, j - 1:j + 1)) > 4
                    currentROI(i, j) = GUIHandles.roiDrawing.selectedROI(1);
                end
            end
        end
    end
    
    GUIHandles.roiDrawing.selectedROIMask(roiMinX:roiMaxX, roiMinY:roiMaxY) = currentROI;
    
    guidata(GUI, GUIHandles);
    
    updateSelectedROIImage(GUI);

end

function clusterROIsCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    GUIHandles.roiDrawing.selectedROI = sort(GUIHandles.roiDrawing.selectedROI);
    
    for r = 1:length(GUIHandles.roiDrawing.selectedROI)
        GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedROI(r)) = GUIHandles.roiDrawing.selectedROI(1);
    end
    
    % these loops are separated so they don't affect each other
    for r = length(GUIHandles.roiDrawing.selectedROI):-1:2
        GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask  > GUIHandles.roiDrawing.selectedROI(r)) = GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask  > GUIHandles.roiDrawing.selectedROI(r)) - 1;
    end
    
    GUIHandles.roiDrawing.selectedROI = GUIHandles.roiDrawing.selectedROI(1);

    if strcmp(GUIHandles.roiDrawing.undoButton.Visible, 'off')
        GUIHandles.roiDrawing.redoButton.Visible = 'off';
        GUIHandles.roiDrawing.undoButton.Visible = 'on';
    end

    GUIHandles.roiDrawing.clusterROIsButton.Visible = 'off';
    
    guidata(GUI, GUIHandles);

end

function showClusteredROIsCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    if GUIHandles.roiDrawing.selectedROI(1) > 0
        
        % make sure only one ROI is selected
        if length(GUIHandles.roiDrawing.selectedROI) > 1
            for r = 1:length(GUIHandles.roiDrawing.selectedROI) - 1
                GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedROI(r)) = GUIHandles.roiDrawing.selectedROI(r);
                GUIHandles.roiDrawing.selectedROIMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedROI(r)) = 0;
            end

            GUIHandles.roiDrawing.selectedROI = GUIHandles.roiDrawing.selectedROI(end);

            guidata(GUI, GUIHandles);

            updateROIImage(GUI);
            updateSelectedROIImage(GUI);
            updateOverlapImage(GUI);
            
            GUIHandles = guidata(GUI);
        end
        
        clusteredROIs = GUIHandles.roiDrawing.clusteredROIs{GUIHandles.roiDrawing.selectedROI};

        % move the selected ROI from the normal ROI mask to the selected ROI mask
        if ~isempty(clusteredROIs)
            for r = 1:length(clusteredROIs)
                GUIHandles.roiDrawing.selectedROIMask(GUIHandles.roiDrawing.roiMask == clusteredROIs(r)) = clusteredROIs(r);

                GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask == clusteredROIs(r)) = 0;

                GUIHandles.roiDrawing.selectedROI(end + 1) = clusteredROIs(r);
            end

            GUIHandles.roiDrawing.selectedROINeuropilMask = (imdilate(GUIHandles.roiDrawing.selectedROIMask, strel('disk', GUIHandles.roiDrawing.neuropilSize)) - GUIHandles.roiDrawing.allROIsMask) > 0;

            GUIHandles.roiDrawing.fillROIButton.Visible = 'off';
            GUIHandles.roiDrawing.clusterROIsButton.Visible = 'on';

            GUIHandles.roiDrawing.deleteROIsButton.String = 'Delete ROIs';

            guidata(GUI, GUIHandles);

            updateROIImage(GUI);
            updateSelectedROIImage(GUI);
            updateOverlapImage(GUI);
        end
    end
        
end

function predictFluorescenceCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    gaussianFilter = GUIHandles.extractionGaussianFilter;

    if GUIHandles.roiDrawing.selectedROI(1) > 0
        currentROI = find(logical(GUIHandles.roiDrawing.selectedROIImage.AlphaData));
        
        firstFrame = max(round(GUIHandles.roiDrawing.frameSlider.Value) - 500, 0);
        lastFrame = min(round(GUIHandles.roiDrawing.frameSlider.Value) + 500, GUIHandles.Info.maxIndex);
        
        if nnz(currentROI) > 0        
            numberOfFrames = lastFrame - firstFrame + 1;

            roiFluorescences = zeros(numberOfFrames, 1);

            if GUIHandles.roiDrawing.neuropilCorrection > 0            
                neuropilFluorescences = zeros(numberOfFrames, 1);
                correctedROIFluorescences = zeros(numberOfFrames, 1);

                currentNeuropil = find(GUIHandles.roiDrawing.selectedROINeuropilMask == 1);
            end
            
            GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'off';

            progressBar = waitbar(0, 'Extracting fluorescences...', 'Name', [GUIHandles.sbxName, ': Predicting Fluorescence'], 'CreateCancelBtn', 'setappdata(gcbf, ''Canceling'', 1)');
            setappdata(progressBar, 'Canceling', 0);

            for f = firstFrame:lastFrame        
                frame = applyMotionCorrection(GUI, f, false);

                if GUIHandles.resonantOffset ~= 0
                    frame = applyResonantOffset(frame, GUIHandles.resonantOffset);
                end
            
                % apply some spatial smoothing if desired
                if gaussianFilter > 0.0
                   frame = imgaussfilt(frame, gaussianFilter); 
                end

                roiFluorescences(f - firstFrame + 1) = mean(frame(currentROI));

                if GUIHandles.roiDrawing.neuropilCorrection > 0
                    neuropilFluorescences(f - firstFrame + 1) = trimmean(frame(currentNeuropil), 10);
                end

                if getappdata(progressBar, 'Canceling')
                    GUIHandles.roiDrawing.predictFluorescenceButton.Visible = 'on';
                    
                    delete(progressBar);
                    
                    guidata(GUI, GUIHandles);
                    return
                else
                    waitbar((f - firstFrame + 1)/numberOfFrames, progressBar);
                end
            end
            
            if GUIHandles.roiDrawing.neuropilCorrection > 0
                correctedROIFluorescences = roiFluorescences - neuropilFluorescences*GUIHandles.roiDrawing.neuropilCorrection;
                
                for i = 1:length(correctedROIFluorescences)
                    if correctedROIFluorescences(i) < 1
                        correctedROIFluorescences(i) = 1;
                    end
                end
            end

            if isfield(GUIHandles.Info, 'timeStamps')
                frameTimes = GUIHandles.Info.timeStamps(firstFrame + 1:lastFrame + 1);
                frameTimes = frameTimes - frameTimes(1);
            else
                frameIndices = 0:GUIHandles.Info.maxIndex;
                frameTimes = (frameIndices*512)/(GUIHandles.Info.resfreq*(2 - GUIHandles.Info.scanmode));
                frameTimes = frameTimes(firstFrame + 1:lastFrame + 1);
                frameTimes = frameTimes - frameTimes(1);
            end

            figure('Name', 'Fluorescence Prediction', 'Units', 'normalized', 'Position', [0.125, 0.125, 0.75, 0.75], 'Color', 'w');

            fluorescenceAxes = axes();
            fluorescenceAxes.XLim = [frameTimes(1), frameTimes(end)];
            fluorescenceAxes.XLabel.String = 'Time [s]';
            fluorescenceAxes.YLabel.String = 'Fluorescence';

            if GUIHandles.roiDrawing.neuropilCorrection > 0
                hold(fluorescenceAxes, 'on');

                plot(fluorescenceAxes, frameTimes, roiFluorescences, 'Color', 'k');
                plot(fluorescenceAxes, frameTimes, correctedROIFluorescences, 'Color', 'r');

                hold(fluorescenceAxes, 'off');            

                legend('Original', 'With Neuropil Correction');
                legend(fluorescenceAxes, 'boxoff');
            else
                plot(fluorescenceAxes, frameTimes, roiFluorescences, 'Color', 'k');
            end
            
            GUIHandles.predictFluorescenceButton.Visible = 'on';
            
            delete(progressBar)
            
            guidata(GUI,GUIHandles);
        end
    end
    
end

function islandSizeSliderCallback(GUI, ~)
    
    GUIHandles = guidata(GUI);

    GUIHandles.roiDrawing.minIslandSize = round(GUIHandles.roiDrawing.islandSizeSlider.Value);
    
    guidata(GUI, GUIHandles);

    if GUIHandles.roiDrawing.selectedROI(1) > 0
        pruneSelectedROI(GUI);
    end

end

function viewNeuropilCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    if GUIHandles.roiDrawing.viewNeuropilButton.Value == 1
        if strcmp(GUIHandles.roiDrawing.manipulateType, 'Prune')
            if GUIHandles.roiDrawing.selectedROI(1) > 0
                GUIHandles.roiDrawing.neuropilSizeText.Visible = 'on';
                GUIHandles.roiDrawing.neuropilSizeSlider.Visible = 'on';
                
                GUIHandles.roiDrawing.neuropilImage.Visible = 'on';
                
                GUIHandles.roiDrawing.selectedROINeuropilMask = (imdilate(logical(GUIHandles.roiDrawing.selectedROIImage.AlphaData), strel('disk', GUIHandles.roiDrawing.neuropilSize)) - GUIHandles.roiDrawing.allROIsMask) > 0;

                guidata(GUI, GUIHandles);

                updateNeuropilImage(GUI);
            end
        end
    else
        GUIHandles.roiDrawing.neuropilSizeText.Visible = 'off';
        GUIHandles.roiDrawing.neuropilSizeSlider.Visible = 'off';
        
        GUIHandles.roiDrawing.neuropilImage.Visible = 'off';

        guidata(GUI, GUIHandles);
    end

end

function neuropilSizeSliderCallback(GUI, ~)
    
    GUIHandles = guidata(GUI);

    GUIHandles.roiDrawing.neuropilSize = round(GUIHandles.roiDrawing.neuropilSizeSlider.Value);        
    
    GUIHandles.roiDrawing.selectedROINeuropilMask = (imdilate(logical(GUIHandles.roiDrawing.selectedROIImage.AlphaData), strel('disk', GUIHandles.roiDrawing.neuropilSize)) - GUIHandles.roiDrawing.allROIsMask) > 0;

    guidata(GUI, GUIHandles);

    if GUIHandles.roiDrawing.viewNeuropilButton.Value == 1
        updateNeuropilImage(GUI)
    end

end

function loadSomaROIsCallback(GUI, ~)
    
    try
        [roiMaskName, roiMaskPath] = uigetfile({'*.rois; *.seg'}, 'Please select file containing soma ROI mask.');
    catch
        waitfor(msgbox('Error: Please select valid .rois file.'));
        error('Please select valid .rois file.');
    end   
    
    roiMaskName = strtok(roiMaskName, '.');
    
    try
        load([roiMaskPath, roiMaskName, '.rois'], '-mat');
    catch
        load([roiMaskPath, roiMaskName, '.seg'], '-mat');
    end
    
    if ~exist('roiMask', 'var')
        roiMask = mask;
    end

    GUIHandles = guidata(GUI);
    
    if size(roiMask, 1) ~= GUIHandles.imageSize(1)
        while size(roiMask, 1) > GUIHandles.imageSize(1)
            if ~any(roiMask(1, :))
                roiMask(1, :) = [];
            elseif ~any(roiMask(end, :))
                roiMask(end, :) = [];
            else
                warning('Previous ROI information will be lost due to cropping.')
                roiMask(end, :) = [];
            end
        end
        while size(roiMask, 1) < GUIHandles.imageSize(1)
            roiMask(end + 1, :) = 0;
        end
    end
    if size(roiMask, 2) ~= GUIHandles.imageSize(2)
        while size(roiMask, 2) > GUIHandles.imageSize(2)
            if ~any(roiMask(:, 1))
                roiMask(:, 1) = [];
            elseif ~any(roiMask(:, end))
                roiMask(:, end) = [];
            else
                warning('Previous ROI information will be lost due to cropping.')
                roiMask(:, end) = [];
            end
        end
        while size(roiMask, 2) < GUIHandles.imageSize(2)
            roiMask(:, end + 1) = 0;
        end
    end
    
    GUIHandles.roiPairing.selectedSomaROI = 0;
    
    GUIHandles.roiPairing.somaROIMask = roiMask;
    GUIHandles.roiPairing.selectedSomaROIMask = zeros(GUIHandles.imageSize);
    
    GUIHandles.roiPairing.somaROIMaskPath = roiMaskPath;
    GUIHandles.roiPairing.somaROIMaskName = roiMaskName;
    
    guidata(GUI, GUIHandles);
    
    updateROIImage(GUI);
    updateSelectedROIImage(GUI);
    updateOverlapImage(GUI);
    
end

function loadDendriteROIsCallback(GUI, ~)
    
    try
        [roiMaskName, roiMaskPath] = uigetfile({'*.rois; *.seg'}, 'Please select file containing dendrite ROI mask.');
    catch
        waitfor(msgbox('Error: Please select valid .rois file.'));
        error('Please select valid .rois file.');
    end   
    
    roiMaskName = strtok(roiMaskName, '.');
    
    try
        load([roiMaskPath, roiMaskName, '.rois'], '-mat');
    catch
        load([roiMaskPath, roiMaskName, '.seg'], '-mat');
    end
    
    try
        temp = roiMask;
    catch
        roiMask = mask;
    end

    GUIHandles = guidata(GUI);
    
    if size(roiMask, 1) ~= GUIHandles.imageSize(1)
        while size(roiMask, 1) > GUIHandles.imageSize(1)
            if ~any(roiMask(1, :))
                roiMask(1, :) = [];
            elseif ~any(roiMask(end, :))
                roiMask(end, :) = [];
            else
                warning('Previous ROI information will be lost due to cropping.')
                roiMask(end, :) = [];
            end
        end
        while size(roiMask, 1) < GUIHandles.imageSize(1)
            roiMask(end + 1, :) = 0;
        end
    end
    if size(roiMask, 2) ~= GUIHandles.imageSize(2)
        while size(roiMask, 2) > GUIHandles.imageSize(2)
            if ~any(roiMask(:, 1))
                roiMask(:, 1) = [];
            elseif ~any(roiMask(:, end))
                roiMask(:, end) = [];
            else
                warning('Previous ROI information will be lost due to cropping.')
                roiMask(:, end) = [];
            end
        end
        while size(roiMask, 2) < GUIHandles.imageSize(2)
            roiMask(:, end + 1) = 0;
        end
    end
    
    GUIHandles.roiPairing.selectedDendriteROI = 0;
    
    GUIHandles.roiPairing.dendriteROIMask = roiMask;
    GUIHandles.roiPairing.selectedDendriteROIMask = zeros(GUIHandles.imageSize);
    
    GUIHandles.roiPairing.dendriteROIMaskPath = roiMaskPath;
    GUIHandles.roiPairing.dendriteROIMaskName = roiMaskName;
    
    guidata(GUI, GUIHandles);
    
    updateROIImage(GUI);
    updateSelectedROIImage(GUI);
    updateOverlapImage(GUI);
    
end

function clearROIMasksCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    GUIHandles.roiPairing.selectedSomaROI = 0;
    GUIHandles.roiPairing.selectedDendriteROI = 0;
    
    GUIHandles.roiPairing.somaROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiPairing.dendriteROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiPairing.selectedSomaROIMask = zeros(GUIHandles.imageSize);
    GUIHandles.roiPairing.selectedDendriteROIMask = zeros(GUIHandles.imageSize);
    
    guidata(GUI, GUIHandles);
    
    updateROIImage(GUI);
    updateSelectedROIImage(GUI);
    updateOverlapImage(GUI);
    
end

function pairROIsCallback(GUI, ~)

    GUIHandles = guidata(GUI);

    if GUIHandles.roiPairing.selectedSomaROI*GUIHandles.roiPairing.selectedDendriteROI > 0
        GUIHandles.roiPairing.pairedROIs(end + 1, 1) = GUIHandles.roiPairing.selectedSomaROI;
        GUIHandles.roiPairing.pairedROIs(end, 2) = GUIHandles.roiPairing.selectedDendriteROI;
        
        GUIHandles.roiPairing.savePairedROIsButton.Visible = 'on';

        guidata(GUI, GUIHandles);
    end

end

function savePairedROIsCallback(GUI, ~)

    GUIHandles = guidata(GUI);

    if size(GUIHandles.roiPairing.pairedROIs, 1) > 0
        pairedROIs = GUIHandles.roiPairing.pairedROIs;
    
        fileName = [GUIHandles.sbxPath, GUIHandles.sbxName];

        if exist([fileName, '.pairs'], 'file')
            choice = questdlg('Override old paired ROIs? If not, data will be saved to new file.', 'Save Paired ROIs', 'Yes', 'No', 'No');

            if strcmp(choice, 'No')
                number = 1;

                while exist([fileName, '_', int2str(number), '.pairs'], 'file')
                    number = number + 1;
                end

                fileName = [fileName, '_', int2str(number)];
            end
        end

        save([fileName, '.pairs'], 'pairedROIs');
    end

end

function clearPairedROIsCallback(GUI, ~)

    GUIHandles = guidata(GUI);
    
    GUIHandles.roiPairing.pairedROIs = [];
        
    GUIHandles.roiPairing.savePairedROIsButton.Visible = 'off';
        
    guidata(GUI, GUIHandles);

end

function roiTreeSetParentCallback(GUI, ~)

    GUIHandles = guidata(GUI);

    if not(isempty(GUIHandles.roiDrawing.roiTree.String))
        current_roiTree_selection = GUIHandles.roiDrawing.roiTree.String(GUIHandles.roiDrawing.roiTree.Value);
        current_roiTree_selection = current_roiTree_selection{1};   
        if contains(current_roiTree_selection,'0000')
            parentIndexLevel = strfind(current_roiTree_selection,'0000');
            parentIndexLevel = floor(parentIndexLevel(1)/4);
            current_roiTree_selection = current_roiTree_selection(1:parentIndexLevel*4);
        else
            parentIndexLevel = ceil(length(current_roiTree_selection)/4);
            current_roiTree_selection = current_roiTree_selection(1:parentIndexLevel*4);
        end
        GUIHandles.roiDrawing.roiTreeCurrentParent = current_roiTree_selection;
        GUIHandles.roiDrawing.roiTreeLevel.String = strcat('Parent: ', GUIHandles.roiDrawing.roiTreeCurrentParent);
    end

    guidata(GUI, GUIHandles);
end

function roiTreeParent0Callback(GUI, ~)
    GUIHandles = guidata(GUI);
    
    GUIHandles.roiDrawing.roiTreeCurrentParent = '0';
    GUIHandles.roiDrawing.roiTreeLevel.String = strcat('Parent: 0');
    
    guidata(GUI, GUIHandles);
end

function selectedMaskButtonGroupSelectionFunction(GUI, eventdata)

    GUIHandles = guidata(GUI);

    GUIHandles.roiPairing.selectedMask = get(eventdata.NewValue, 'String');

    guidata(GUI, GUIHandles);

end

function scrollFunction(GUI, eventdata)

    GUIHandles = guidata(GUI);

    if strcmp(get(GUI, 'CurrentModifier'), 'shift')
        floodingModifier = 0.1;
        scrollingModifier = 10;
    else
        floodingModifier = 1;
        scrollingModifier = 1;
    end
    
    if strcmp(get(GUI, 'CurrentModifier'), 'control')
        if ~isempty(GUIHandles.zoomCenter)
            GUIHandles.windowSize = min(GUIHandles.maxWindowSize, max(1, GUIHandles.windowSize + (eventdata.VerticalScrollAmount*eventdata.VerticalScrollCount)*15/3));

            XLim = [GUIHandles.zoomCenter(1) - GUIHandles.windowSize, GUIHandles.zoomCenter(1) + GUIHandles.windowSize];
            YLim = [GUIHandles.zoomCenter(2) - GUIHandles.windowSize*GUIHandles.windowRatio, GUIHandles.zoomCenter(2) + GUIHandles.windowSize*GUIHandles.windowRatio];

            if XLim(1) < GUIHandles.XLim(1)
                XLim(1) = GUIHandles.XLim(1);
                XLim(2) = GUIHandles.XLim(1) + 2*GUIHandles.windowSize;
            elseif XLim(2) > GUIHandles.XLim(2)
                XLim(1) = GUIHandles.XLim(2) - 2*GUIHandles.windowSize;
                XLim(2) = GUIHandles.XLim(2);
            end
            if YLim(1) < GUIHandles.YLim(1)
                YLim(1) = GUIHandles.YLim(1);
                YLim(2) = GUIHandles.YLim(1) + 2*GUIHandles.windowSize*GUIHandles.windowRatio;
            elseif YLim(2) > GUIHandles.YLim(2)
                YLim(1) = GUIHandles.YLim(2) - 2*GUIHandles.windowSize*GUIHandles.windowRatio;
                YLim(2) = GUIHandles.YLim(2);
            end
            
            GUIHandles.imageProcessing.imageAxes.XLim = XLim;
            GUIHandles.imageProcessing.imageAxes.YLim = YLim;

            GUIHandles.roiDrawing.imageAxes.XLim = XLim;
            GUIHandles.roiDrawing.imageAxes.YLim = YLim;

            GUIHandles.roiPairing.imageAxes.XLim = XLim;
            GUIHandles.roiPairing.imageAxes.YLim = YLim;

            guidata(GUI, GUIHandles);
        end
    else
        switch GUIHandles.mode
            case 'Image Processing'
                GUIHandles.imageProcessing.frameSlider.Value = min(GUIHandles.Info.maxIndex, max(0, GUIHandles.imageProcessing.frameSlider.Value - (eventdata.VerticalScrollAmount*eventdata.VerticalScrollCount)*50/3*scrollingModifier));

                guidata(GUI, GUIHandles);

                frameSliderCallback(GUI);
            case 'ROI Drawing'
                if strcmp(GUIHandles.roiDrawing.selectedROIImage.Visible, 'on') || strcmp(GUIHandles.roiDrawing.candidateROIImage.Visible, 'on')
                    switch GUIHandles.roiDrawing.manipulateType
                        case 'Draw'

                            % if drawing, scrolling affects the number of pixels added via flood-filling
                            GUIHandles.roiDrawing.floodPixels = max(10, GUIHandles.roiDrawing.floodPixels - (eventdata.VerticalScrollAmount*eventdata.VerticalScrollCount)*10/3*floodingModifier);

                            guidata(GUI, GUIHandles);

                            updateCandidateROIImage(GUI);
                        case 'Select'
                            if strcmp(GUIHandles.roiDrawing.imageType, 'Rolling Average') || strcmp(GUIHandles.roiDrawing.imageType, 'Frame-by-Frame')
                                GUIHandles.roiDrawing.frameSlider.Value = min(GUIHandles.Info.maxIndex, max(0, GUIHandles.roiDrawing.frameSlider.Value - (eventdata.VerticalScrollAmount*eventdata.VerticalScrollCount)*50/3*scrollingModifier));

                                guidata(GUI, GUIHandles);

                                frameSliderCallback(GUI);
                            end
                        case 'Prune'

                            % if pruning, scrolling changes the intensity threshold below which pixels are discarded from the selected ROI
                            if GUIHandles.roiDrawing.selectedROI(1) > 0
                                GUIHandles.roiDrawing.pruneThreshold = min(1, max(0, GUIHandles.roiDrawing.pruneThreshold + (eventdata.VerticalScrollAmount*eventdata.VerticalScrollCount)*0.001*floodingModifier));

                                guidata(GUI, GUIHandles);

                                pruneSelectedROI(GUI);
                            end
                    end
                end
            case 'ROI Pairing'
                GUIHandles.roiPairing.frameSlider.Value = min(GUIHandles.Info.maxIndex, max(0, GUIHandles.roiPairing.frameSlider.Value - (eventdata.VerticalScrollAmount*eventdata.VerticalScrollCount)*50/3*scrollingModifier));

                guidata(GUI, GUIHandles);

                frameSliderCallback(GUI);
        end
    end
    
end

function keyPressFunction(GUI, eventdata)
    
    GUIHandles = guidata(GUI);

    switch eventdata.Key
        case 'u'
            if strcmp(GUIHandles.mode, 'ROI Drawing')
                undoCallback(GUI);
            end
        case 'r'
            if strcmp(GUIHandles.mode, 'ROI Drawing')
                undoCallback(GUI);
            end
        case 'd'
            if strcmp(GUIHandles.mode, 'ROI Drawing')
                deleteROIsCallback(GUI);
            end
        case 'control'            
            if isempty(GUIHandles.zoomCenter)
                switch GUIHandles.mode
                    case 'Image Processing'
                        zoomCenter = get(GUIHandles.imageProcessing.imageAxes, 'CurrentPoint');
                    case 'ROI Drawing'
                        zoomCenter = get(GUIHandles.roiDrawing.imageAxes, 'CurrentPoint');
                    case 'ROI Pairing'
                        zoomCenter = get(GUIHandles.roiPairing.imageAxes, 'CurrentPoint');
                end
                
                GUIHandles.zoomCenter = zoomCenter(1, 1:2);

                guidata(GUI, GUIHandles);
            end
    end
    
end

function keyReleaseFunction(GUI, eventdata)
    
    switch eventdata.Key
        case 'control'
            GUIHandles = guidata(GUI);
            
            GUIHandles.zoomCenter = [];
            
            guidata(GUI, GUIHandles);
    end
    
end

function roiImageClickFunction(GUI, ~)

    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode
        case 'ROI Drawing'
    
            % if draw ROI option is selected, draw ROI outlines using specified method
            if strcmp(GUIHandles.roiDrawing.manipulateType, 'Draw')
                if strcmp(GUIHandles.roiDrawing.drawType, 'Pixel')
                    currentPoint = get(GUIHandles.roiDrawing.imageAxes, 'CurrentPoint');
                    currentPoint = round(currentPoint(1, 1:2)');

                    if (GUIHandles.imageSize(2) > currentPoint(1)) && (currentPoint(1) > 0) && (GUIHandles.imageSize(1) > currentPoint(2)) && (currentPoint(2) > 0)
                        GUIHandles.roiDrawing.imageToBeFlooded = GUIHandles.roiDrawing.displayedImage.CData;

                        GUIHandles.roiDrawing.floodCenter = currentPoint;

                        GUIHandles.roiDrawing.candidateROIImage.Visible = 'on';

                        guidata(GUI, GUIHandles);

                        computeROIFlood(GUI);

                        updateCandidateROIImage(GUI);
                    end
                else
                    switch GUIHandles.roiDrawing.drawType
                        case 'Free Hand'
                            shape = imfreehand;
                        case 'Polygon'
                            shape = impoly;
                        case 'Ellipse'
                            shape = imellipse;
                        case 'Rectangle'
                            shape = imrect;
                    end

                    wait(shape);

                    GUIHandles.roiDrawing.previousROIMask = GUIHandles.roiDrawing.roiMask;
                    
                    GUIHandles.roiDrawing.previousOverlapMask = GUIHandles.roiDrawing.overlapMask;

                    GUIHandles.roiDrawing.imageToBeFlooded = GUIHandles.roiDrawing.displayedImage.CData.*shape.createMask(GUIHandles.roiDrawing.displayedImage);

                    delete(shape);

                    [~, index] = max(GUIHandles.roiDrawing.imageToBeFlooded(:));
                    [row, column] = ind2sub(size(GUIHandles.roiDrawing.imageToBeFlooded), index);
                    GUIHandles.roiDrawing.floodCenter = [column, row];

                    GUIHandles.roiDrawing.candidateROIImage.Visible = 'on';

                    guidata(GUI, GUIHandles);

                    computeROIFlood(GUI);

                    updateCandidateROIImage(GUI);
                end
            else
                currentPoint = get(GUIHandles.roiDrawing.imageAxes, 'CurrentPoint');
                currentPoint = round(currentPoint(1, 1:2)');  

                if (GUIHandles.imageSize(2) > currentPoint(1)) && (currentPoint(1) > 0) && (GUIHandles.imageSize(1) > currentPoint(2)) && (currentPoint(2) > 0)
                    GUIHandles.roiDrawing.selectedROI = GUIHandles.roiDrawing.roiMask(currentPoint(2), currentPoint(1));
                    GUIHandles.roiDrawing.selectedOverlap = GUIHandles.roiDrawing.overlapMask(currentPoint(2), currentPoint(1));

                    if GUIHandles.roiDrawing.selectedROI > 0
                        disp(['ROI selected: ', int2str(GUIHandles.roiDrawing.selectedROI)]);

                        GUIHandles.roiDrawing.previousROIMask = GUIHandles.roiDrawing.roiMask;
                        GUIHandles.roiDrawing.allROIsMask = GUIHandles.roiDrawing.roiMask > 0;
                    
                        GUIHandles.roiDrawing.previousOverlapMask = GUIHandles.roiDrawing.overlapMask;

                        GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);

                        % move the selected ROI from the normal ROI mask to the selected ROI mask
                        GUIHandles.roiDrawing.selectedROIMask(GUIHandles.roiDrawing.roiMask == GUIHandles.roiDrawing.selectedROI) = GUIHandles.roiDrawing.selectedROI;

                        GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask == GUIHandles.roiDrawing.selectedROI) = 0;

                        GUIHandles.roiDrawing.selectedROINeuropilMask = (imdilate(GUIHandles.roiDrawing.selectedROIMask, strel('disk', GUIHandles.roiDrawing.neuropilSize)) - GUIHandles.roiDrawing.allROIsMask) > 0;

                        % reset this values so we don't start somewhere weird
                        GUIHandles.roiDrawing.minIslandSize = GUIHandles.roiDrawing.defaultMinIslandSize;
                        GUIHandles.roiDrawing.islandSizeSlider.Value = GUIHandles.roiDrawing.minIslandSize;

                        GUIHandles.roiDrawing.selectedROIImage.Visible = 'on';

                        if strcmp(GUIHandles.roiDrawing.manipulateType, 'Select')
                            GUIHandles.roiDrawing.fillROIButton.Visible = 'on';
                            GUIHandles.roiDrawing.viewClusteredROIsButton.Visible = 'on';
                        end

                        guidata(GUI, GUIHandles);

                        updateROIImage(GUI);
                        updateSelectedROIImage(GUI);
                        updateOverlapImage(GUI);

                        % if pruning, calculate the pixel values of the selected ROI
                        if strcmp(GUIHandles.roiDrawing.manipulateType, 'Prune')
                            GUIHandles.roiDrawing.selectedROIPixelValues = GUIHandles.roiDrawing.displayedImage.CData.*logical(GUIHandles.roiDrawing.selectedROIImage.AlphaData);

                            guidata(GUI, GUIHandles);

                            updateHistogram(GUI);
                        end

                        if GUIHandles.roiDrawing.viewNeuropilButton.Value == 1
                            GUIHandles.roiDrawing.neuropilSizeText.Visible = 'on';
                            GUIHandles.roiDrawing.neuropilSizeSlider.Visible = 'on';

                            GUIHandles.roiDrawing.neuropilImage.Visible = 'on';

                            guidata(GUI, GUIHandles);

                            updateNeuropilImage(GUI);
                        end
                    elseif GUIHandles.roiDrawing.selectedOverlap > 0
                        GUIHandles.roiDrawing.previousOverlapMask = GUIHandles.roiDrawing.overlapMask;

                        GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);

                        % move the selected ROI from the normal ROI mask to the selected ROI mask
                        GUIHandles.roiDrawing.selectedROIMask(GUIHandles.roiDrawing.overlapMask == GUIHandles.roiDrawing.selectedOverlap) = GUIHandles.roiDrawing.selectedOverlap;

                        GUIHandles.roiDrawing.overlapMask(GUIHandles.roiDrawing.overlapMask == GUIHandles.roiDrawing.selectedOverlap) = 0;

                        GUIHandles.roiDrawing.selectedROIImage.Visible = 'on';

                        guidata(GUI, GUIHandles);

                        updateROIImage(GUI);
                        updateSelectedROIImage(GUI);
                        updateOverlapImage(GUI);
                    end
                end
            end
        case 'ROI Pairing'
            currentPoint = get(GUIHandles.roiPairing.imageAxes, 'CurrentPoint');
            currentPoint = round(currentPoint(1, 1:2)');  

            if (GUIHandles.imageSize(2) > currentPoint(1)) && (currentPoint(1) > 0) && (GUIHandles.imageSize(1) > currentPoint(2)) && (currentPoint(2) > 0)
                if GUIHandles.roiPairing.somaROIMask(currentPoint(2), currentPoint(1)) > 0
                    GUIHandles.roiPairing.selectedSomaROI = GUIHandles.roiPairing.somaROIMask(currentPoint(2), currentPoint(1));

                    GUIHandles.roiPairing.selectedSomaROIMask(GUIHandles.roiPairing.somaROIMask == GUIHandles.roiPairing.selectedSomaROI) = GUIHandles.roiPairing.selectedSomaROI;
                
                    GUIHandles.roiPairing.somaROIMask(GUIHandles.roiPairing.somaROIMask == GUIHandles.roiPairing.selectedSomaROI) = 0;
                    
                    disp(['Soma ROI selected: ', int2str(GUIHandles.roiPairing.selectedSomaROI)]);
                    
                    GUIHandles.roiPairing.selectedSomaROIImage.Visible = 'on';
                end
                
                if GUIHandles.roiPairing.dendriteROIMask(currentPoint(2), currentPoint(1)) > 0
                    GUIHandles.roiPairing.selectedDendriteROI = GUIHandles.roiPairing.dendriteROIMask(currentPoint(2), currentPoint(1));

                    GUIHandles.roiPairing.selectedDendriteROIMask(GUIHandles.roiPairing.dendriteROIMask == GUIHandles.roiPairing.selectedDendriteROI) = GUIHandles.roiPairing.selectedDendriteROI;
                
                    GUIHandles.roiPairing.dendriteROIMask(GUIHandles.roiPairing.dendriteROIMask == GUIHandles.roiPairing.selectedDendriteROI) = 0;

                    disp(['Dendrite ROI selected: ', int2str(GUIHandles.roiPairing.selectedDendriteROI)]);
                    
                    GUIHandles.roiPairing.selectedDendriteROIImage.Visible = 'on';
                end
                
                if GUIHandles.roiPairing.selectedSomaROI + GUIHandles.roiPairing.selectedDendriteROI > 0

                    guidata(GUI, GUIHandles);

                    updateROIImage(GUI);
                    updateSelectedROIImage(GUI);
                end
            end
    end
    
end

function mouseOverFunction(GUI, ~)

    GUIHandles = guidata(GUI);

    % if the local cross-correlation option is selected, move the little square around with the mouse
    if strcmp(GUIHandles.mode, 'ROI Drawing')
        if GUIHandles.roiDrawing.ccLocalButton.Value == 1
            updateImageDisplay(GUI);
        end
    end
    
end

function candidateROIImageClickFunction(GUI, ~)

    GUIHandles = guidata(GUI);

    GUIHandles.roiDrawing.previousROIMask = GUIHandles.roiDrawing.roiMask;
    GUIHandles.roiDrawing.previousRoiTree = GUIHandles.roiDrawing.roiTree.String;
                    
    GUIHandles.roiDrawing.previousOverlapMask = GUIHandles.roiDrawing.overlapMask;
    
    % save the drawn ROI upon second click
    newROIMask = GUIHandles.roiDrawing.floodOrder < GUIHandles.roiDrawing.floodPixels;
    
    % if there is any overlap with other ROIs, remove overlapping pixels from all ROIs and add them to the overlap image
    original = GUIHandles.roiDrawing.roiMask;
    new = newROIMask;
    GUIHandles.roiDrawing.overlapMask(original.*new > 0) = max(GUIHandles.roiDrawing.overlapMask(:)) + 1;
    overlap = GUIHandles.roiDrawing.overlapMask;
    newROIMask((original.*new + overlap) > 0) = 0;
    GUIHandles.roiDrawing.roiMask((original.*new + overlap) > 0) = 0;
    
    if isempty(GUIHandles.roiDrawing.roiTree.String)
        newROIID = 1;
        GUIHandles.roiDrawing.roiTree.String{end+1} = sprintf('%04d',newROIID);
    else
        lastroi = find_last_in_roiTree(GUIHandles.roiDrawing.roiTree, GUIHandles.roiDrawing.roiTreeCurrentParent);   
        lastroi_length = length(lastroi);
        newROIID = str2double(lastroi) + 1;
        GUIHandles.roiDrawing.roiTree.String{end+1} = sprintf('%0*d',lastroi_length, newROIID); % ADD DYNAMIC FORMAT STRING TO ACCOMMODATE MULTIP
        GUIHandles.roiDrawing.roiTree.Value = length(GUIHandles.roiDrawing.roiTree.String);
    end
    
    GUIHandles.roiDrawing.roiTree.String = order_roi_tree(GUIHandles.roiDrawing.roiTree);
    
    GUIHandles.roiDrawing.roiMask = GUIHandles.roiDrawing.roiMask + (newROIMask*newROIID);
    % GUIHandles.roiDrawing.roiMask = GUIHandles.roiDrawing.roiMask + (max(GUIHandles.roiDrawing.roiMask(:)) + 1)*newROIMask;
    
    GUIHandles.roiDrawing.candidateROIImage.Visible = 'off';
    
    if strcmp(GUIHandles.roiDrawing.undoButton.Visible, 'off')
        GUIHandles.roiDrawing.redoButton.Visible = 'off';
        GUIHandles.roiDrawing.undoButton.Visible = 'on';
    end
    
    guidata(GUI, GUIHandles);
    
    updateROIImage(GUI);
    updateOverlapImage(GUI);
    
end

function lastroi = find_last_in_roiTree(roiTree, parentROI)
    % function that finds the last roi entry under a certain parent
    
    if strcmp(parentROI, '0')
        parentIndexLevel = 0; % level at which the new ROI is to be inserted
    else
        if contains(parentROI,'0000')
            parentIndexLevel = strfind(parentROI,'0000');
            parentIndexLevel = floor(parentIndexLevel(1)/4);
        else
            parentIndexLevel = ceil(length(parentROI)/4);
        end
    end

    num_in_parent = 0; 
    for j=1:length(roiTree.String) % loop through all entries
        roiTree_cur_id = roiTree.String{j};
        if parentIndexLevel == 0 % special case on 0-level where we just want to coun the number of length=1 roi entries
            if length(roiTree_cur_id) == 4
                num_in_parent = num_in_parent + 1;
            end
        else
            if ceil(length(roiTree_cur_id)/4) == parentIndexLevel+1 % check if current line is on the desired insertion level (n.b. this is before we check if its the right parent)
                if strcmp(roiTree_cur_id(1:parentIndexLevel*4), parentROI)
                    num_in_parent = num_in_parent + 1;
                end
            end
        end
    end
    
    if strcmp(parentROI, '0')
        lastroi = sprintf('%04d',num_in_parent);
    else
        lastroi = parentROI;
        lastroi = strcat(lastroi, sprintf('%04d',num_in_parent));
        %lastroi = str2double(lastroi);
    end
    
end

function tree_content_new = order_roi_tree(roiTree)
    % order the tree (its slightly tedious due to it being a cell-array and
    % we want children to be listed below their parent (e.g. 22 comes
    % before 3)
    
    tree_content = roiTree.String;  
   
    max_level = 0;
    for i=1:length(tree_content) % get max depth of the tree
        if length(tree_content{i})/4 > max_level
            max_level = length(tree_content{i})/4;
        end
    end   
    
    tree_content_numbers = cellfun(@str2num, tree_content);
    for i=1:length(tree_content) % multiply value on upper levels 
        tree_content_numbers(i) = tree_content_numbers(i) * (10000^(max_level - length(tree_content{i})/4));
    end
    
    tree_content_numbers = sort(tree_content_numbers);
    
    tree_content = num2cell(num2str(tree_content_numbers),2);
    tree_content = cellfun(@strip, tree_content, 'UniformOutput', false); % this is necessary as num2str introduced leading spaces
    tree_content_new = tree_content;
    for i=1:length(tree_content)      
        trimmed_tree_content = sprintf('%0*s',max_level*4,tree_content{i});
        if contains(trimmed_tree_content,'0000')
            parentIndexLevel = strfind(trimmed_tree_content,'0000');
            parentIndexLevel = floor(parentIndexLevel(end)/4);
        else
            parentIndexLevel = ceil(length(trimmed_tree_content)/4);
        end
        trimmed_tree_content = trimmed_tree_content(1:parentIndexLevel*4);
        tree_content_new{i} = sprintf('%0*s',parentIndexLevel*4,trimmed_tree_content);
    end
end
    
function selectedROIImageClickFunction(GUI, ~)

    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode
        case 'ROI Drawing'
            if strcmp(GUIHandles.roiDrawing.manipulateType, 'Select')
                if strcmp(get(GUIHandles.parentFigure, 'CurrentModifier'), 'shift')
                    currentPoint = get(GUIHandles.roiDrawing.imageAxes, 'CurrentPoint');
                    currentPoint = round(currentPoint(1, 1:2)');  

                    if (GUIHandles.imageSize(2) > currentPoint(1)) && (currentPoint(1) > 0) && (GUIHandles.imageSize(1) > currentPoint(2)) && (currentPoint(2) > 0)
                        GUIHandles.roiDrawing.selectedROI(end + 1) = GUIHandles.roiDrawing.roiMask(currentPoint(2), currentPoint(1));

                        if GUIHandles.roiDrawing.selectedOverlap == 0 && GUIHandles.roiDrawing.selectedROI(end) > 0

                            % move the selected ROI from the normal ROI mask to the selected ROI mask
                            GUIHandles.roiDrawing.selectedROIMask(GUIHandles.roiDrawing.roiMask == GUIHandles.roiDrawing.selectedROI(end)) = GUIHandles.roiDrawing.selectedROI(end);

                            GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask == GUIHandles.roiDrawing.selectedROI(end)) = 0;

                            GUIHandles.roiDrawing.selectedROINeuropilMask = (imdilate(GUIHandles.roiDrawing.selectedROIMask, strel('disk', GUIHandles.roiDrawing.neuropilSize)) - GUIHandles.roiDrawing.allROIsMask) > 0;

                            GUIHandles.roiDrawing.fillROIButton.Visible = 'off';
                            GUIHandles.roiDrawing.clusterROIsButton.Visible = 'on';
                            GUIHandles.roiDrawing.viewClusteredROIsButton.Visible = 'off';

                            GUIHandles.roiDrawing.deleteROIsButton.String = 'Delete ROIs';

                            guidata(GUI, GUIHandles);

                            updateROIImage(GUI);
                            updateSelectedROIImage(GUI);
                            updateOverlapImage(GUI);
                        end
                    end

                    selectedAdditionalROI = 1;
                else
                    % or return selected ROI to the normal ROI mask    
                    for r = 1:length(GUIHandles.roiDrawing.selectedROI)        
                        GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedROI(r)) = GUIHandles.roiDrawing.selectedROI(r);
                    end

                    selectedAdditionalROI = 0;
                end
            elseif strcmp(GUIHandles.roiDrawing.manipulateType, 'Prune')
                GUIHandles.roiDrawing.islandImage.Visible = 'off';
                GUIHandles.roiDrawing.islandMask = zeros(GUIHandles.imageSize);

                % save pruned ROI    
                GUIHandles.roiDrawing.roiMask = GUIHandles.roiDrawing.roiMask + GUIHandles.roiDrawing.selectedROI*logical(GUIHandles.roiDrawing.selectedROIImage.AlphaData);

                if nnz(GUIHandles.roiDrawing.selectedROIImage.AlphaData) == 0
                    GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask  > GUIHandles.roiDrawing.selectedROI) = GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.roiMask  > GUIHandles.roiDrawing.selectedROI) - 1;
                end

                if strcmp(GUIHandles.roiDrawing.undoButton.Visible, 'off')
                    GUIHandles.roiDrawing.redoButton.Visible = 'off';
                    GUIHandles.roiDrawing.undoButton.Visible = 'on';
                end

                selectedAdditionalROI = 0;
            else
                for r = 1:length(GUIHandles.roiDrawing.selectedROI)
                    GUIHandles.roiDrawing.roiMask(GUIHandles.roiDrawing.selectedROIMask == GUIHandles.roiDrawing.selectedROI(r)) = GUIHandles.roiDrawing.selectedROI(r);
                end

                selectedAdditionalROI = 0;
            end

            if selectedAdditionalROI == 0
                GUIHandles.roiDrawing.islandImage.Visible = 'off';
                GUIHandles.roiDrawing.selectedROIImage.Visible = 'off';

                if GUIHandles.roiDrawing.viewNeuropilButton.Value == 1
                    GUIHandles.roiDrawing.neuropilSizeText.Visible = 'off';
                    GUIHandles.roiDrawing.neuropilSizeSlider.Visible = 'off';

                    GUIHandles.roiDrawing.neuropilImage.Visible = 'off';
                end

                GUIHandles.roiDrawing.selectedROI = 0;

                GUIHandles.roiDrawing.selectedROIMask = zeros(GUIHandles.imageSize);

                GUIHandles.roiDrawing.fillROIButton.Visible = 'off';
                GUIHandles.roiDrawing.clusterROIsButton.Visible = 'off';
                GUIHandles.roiDrawing.viewClusteredROIsButton.Visible = 'off';

                GUIHandles.roiDrawing.deleteROIsButton.String = 'Delete ROI';

                guidata(GUI, GUIHandles);

                if strcmp(GUIHandles.roiDrawing.manipulateType, 'Prune')
                    updateHistogram(GUI);
                end

                updateROIImage(GUI);
                updateOverlapImage(GUI);
            end
        case 'ROI Pairing'
            currentPoint = get(GUIHandles.roiPairing.imageAxes, 'CurrentPoint');
            currentPoint = round(currentPoint(1, 1:2)');
            
            if strcmp(get(GUIHandles.parentFigure, 'CurrentModifier'), 'shift')
                if (GUIHandles.imageSize(2) > currentPoint(1)) && (currentPoint(1) > 0) && (GUIHandles.imageSize(1) > currentPoint(2)) && (currentPoint(2) > 0)
                    if GUIHandles.roiPairing.somaROIMask(currentPoint(2), currentPoint(1)) > 0
                        if GUIHandles.roiPairing.selectedSomaROI > 0
                            GUIHandles.roiPairing.somaROIMask(GUIHandles.roiPairing.selectedSomaROIMask == GUIHandles.roiPairing.selectedSomaROI) = GUIHandles.roiPairing.selectedSomaROI;

                            GUIHandles.roiPairing.selectedSomaROIMask(GUIHandles.roiPairing.selectedSomaROIMask == GUIHandles.roiPairing.selectedSomaROI) = 0;
                        else
                            GUIHandles.roiPairing.selectedSomaROIImage.Visible = 'on';
                        end

                        GUIHandles.roiPairing.selectedSomaROI = GUIHandles.roiPairing.somaROIMask(currentPoint(2), currentPoint(1));

                        GUIHandles.roiPairing.selectedSomaROIMask(GUIHandles.roiPairing.somaROIMask == GUIHandles.roiPairing.selectedSomaROI) = GUIHandles.roiPairing.selectedSomaROI;

                        GUIHandles.roiPairing.somaROIMask(GUIHandles.roiPairing.somaROIMask == GUIHandles.roiPairing.selectedSomaROI) = 0;

                        disp(['Soma ROI selected: ', int2str(GUIHandles.roiPairing.selectedSomaROI)]);
                    elseif GUIHandles.roiPairing.dendriteROIMask(currentPoint(2), currentPoint(1)) > 0
                        if GUIHandles.roiPairing.selectedDendriteROI > 0
                            GUIHandles.roiPairing.dendriteROIMask(GUIHandles.roiPairing.selectedDendriteROIMask == GUIHandles.roiPairing.selectedDendriteROI) = GUIHandles.roiPairing.selectedDendriteROI;

                            GUIHandles.roiPairing.selectedDendriteROIMask(GUIHandles.roiPairing.selectedDendriteROIMask == GUIHandles.roiPairing.selectedDendriteROI) = 0;
                        else
                            GUIHandles.roiPairing.selectedDendriteROIImage.Visible = 'on';
                        end

                        GUIHandles.roiPairing.selectedDendriteROI = GUIHandles.roiPairing.dendriteROIMask(currentPoint(2), currentPoint(1));

                        GUIHandles.roiPairing.selectedDendriteROIMask(GUIHandles.roiPairing.dendriteROIMask == GUIHandles.roiPairing.selectedDendriteROI) = GUIHandles.roiPairing.selectedDendriteROI;

                        GUIHandles.roiPairing.dendriteROIMask(GUIHandles.roiPairing.dendriteROIMask == GUIHandles.roiPairing.selectedDendriteROI) = 0;

                        disp(['Dendrite ROI selected: ', int2str(GUIHandles.roiPairing.selectedDendriteROI)]);
                    end
                end
            else
                
                % return selected ROI to the normal ROI mask    
                if GUIHandles.roiPairing.selectedSomaROI > 0      
                    GUIHandles.roiPairing.somaROIMask(GUIHandles.roiPairing.selectedSomaROIMask == GUIHandles.roiPairing.selectedSomaROI) = GUIHandles.roiPairing.selectedSomaROI;

                    GUIHandles.roiPairing.selectedSomaROIMask(GUIHandles.roiPairing.selectedSomaROIMask == GUIHandles.roiPairing.selectedSomaROI) = 0;
                end
                if GUIHandles.roiPairing.selectedDendriteROI > 0      
                    GUIHandles.roiPairing.dendriteROIMask(GUIHandles.roiPairing.selectedDendriteROIMask == GUIHandles.roiPairing.selectedDendriteROI) = GUIHandles.roiPairing.selectedDendriteROI;

                    GUIHandles.roiPairing.selectedDendriteROIMask(GUIHandles.roiPairing.selectedDendriteROIMask == GUIHandles.roiPairing.selectedDendriteROI) = 0;
                end

                GUIHandles.roiPairing.selectedSomaROIImage.Visible = 'off';

                GUIHandles.roiPairing.selectedDendriteROIImage.Visible = 'off';

                GUIHandles.roiPairing.selectedSomaROI = 0;
                GUIHandles.roiPairing.selectedDendriteROI = 0;

                GUIHandles.roiPairing.selectedSomaROIMask = zeros(GUIHandles.imageSize);
                GUIHandles.roiPairing.selectedDendriteROIMask = zeros(GUIHandles.imageSize);
            end
            
            if GUIHandles.roiPairing.selectedSomaROI*GUIHandles.roiPairing.selectedDendriteROI > 0
                GUIHandles.roiPairing.pairROIsButton.Visible = 'on';
            else
                GUIHandles.roiPairing.pairROIsButton.Visible = 'off';
            end

            guidata(GUI, GUIHandles);
            
            updateROIImage(GUI);
            updateSelectedROIImage(GUI);
    end
    
end

function updateImageDisplay(GUI)
    
    GUIHandles = guidata(GUI);
    
    gaussianFilter = GUIHandles.displayGaussianFilter;
    
    switch GUIHandles.mode
        case 'Image Processing'
            switch GUIHandles.imageProcessing.imageType
                case 'Rolling Average'
                    GUIHandles.imageProcessing.displayedImage.CData = computeRollingAverage(GUI, GUIHandles.frameSliderValue, true);
                case 'Frame-by-Frame'
                    if GUIHandles.motionCorrected
                        frame = applyMotionCorrection(GUI, GUIHandles.frameSliderValue, false);
                    else
                        if GUIHandles.Info.isTif == 1
                            frame_all_channels = GUIHandles.tifData(:,:,GUIHandles.frameSliderValue + 1);
                        else
                            frame_all_channels = sbxRead(GUIHandles.Info, GUIHandles.frameSliderValue);
                        end
                        
                        num_channels = ndims(frame_all_channels);
                        if num_channels > 2
                            if strcmp(GUIHandles.imageProcessing.displayChannel, 'green channel')
                                disp_chan = 1;
                            else
                                disp_chan = 2;
                            end
                            frame = squeeze(frame_all_channels(disp_chan,:,:));
                        else
                            frame = frame_all_channels;
                        end
                    end

                    % unity normalize each frame to intmax('uint16') to use the same color-scale as the pre-computed values
                    displayFrame = double(frame);
                    GUIHandles.imageProcessing.displayedImage.CData = displayFrame/double(intmax('uint16')); 
                    % LF 02/23/19: added code to replace 0-values with mean
                    % of non-zero values in frame
                    % displayFrame(displayFrame<5) = mean(displayFrame(displayFrame>5));
                    % displayFrame = displayFrame/double(intmax('uint16'));   
                    % GUIHandles.imageProcessing.displayedImage.CData = displayFrame;
            end
            
            if GUIHandles.resonantOffset ~= 0
                GUIHandles.imageProcessing.displayedImage.CData = applyResonantOffset(GUIHandles.imageProcessing.displayedImage.CData, GUIHandles.resonantOffset);
            end
        case 'ROI Drawing'
            switch GUIHandles.roiDrawing.imageType
                case 'Mean'            
                    GUIHandles.roiDrawing.displayedImage.CData = GUIHandles.roiDrawing.meanImage;
                case 'Max Intensity'            
                    GUIHandles.roiDrawing.displayedImage.CData = GUIHandles.roiDrawing.maxIntensityImage;
                case 'Cross-Correlation'            
                    GUIHandles.roiDrawing.displayedImage.CData = GUIHandles.roiDrawing.crossCorrelationImage;
                case 'PCA'            
                    GUIHandles.roiDrawing.displayedImage.CData = GUIHandles.roiDrawing.pcaImage;
                case 'Rolling Average'
                    rollingAverage = computeRollingAverage(GUI, GUIHandles.frameSliderValue, true);

                    % do some spatial filtering to help ROI drawing
                    rollingAverage = imgaussfilt(rollingAverage, gaussianFilter);
                    
                    GUIHandles.roiDrawing.displayedImage.CData = rollingAverage;
                case 'Frame-by-Frame'
                    if GUIHandles.motionCorrected
                        frame = applyMotionCorrection(GUI, GUIHandles.frameSliderValue, false);
                        GUIHandles.roiDrawing.framenumberDisplay.String = strcat('Frame: ', int2str(GUIHandles.frameSliderValue));
                    else
                        if GUIHandles.Info.isTif == 1
                            frame = GUIHandles.tifData(:,:,GUIHandles.frameSliderValue + 1);
                        else
                            frame = sbxRead(GUIHandles.Info, GUIHandles.frameSliderValue);
                        end
                        GUIHandles.roiDrawing.framenumberDisplay.String = strcat('Frame: ', int2str(GUIHandles.frameSliderValue));
                    end
                    
                    % do some spatial filtering to help ROI drawing
                    frame = imgaussfilt(frame, gaussianFilter);

                    % unity normalize each frame to intmax('uint16') to use the same color-scale as the pre-computed values
                    GUIHandles.roiDrawing.displayedImage.CData = double(frame)/double(intmax('uint16'));
            end
            
            if GUIHandles.resonantOffset ~= 0
                GUIHandles.roiDrawing.displayedImage.CData = applyResonantOffset(GUIHandles.roiDrawing.displayedImage.CData, GUIHandles.resonantOffset);
            end

            % if selected, show the local cross-correlation (do this after brightness and contrast adjustment so it doesn't mess those up)
            if GUIHandles.roiDrawing.ccLocalButton.Value == 1
                guidata(GUI, GUIHandles);

                overlayCrossCorrelation(GUI);
            end
        case 'ROI Pairing'
            switch GUIHandles.roiPairing.imageType
                case 'Rolling Average'
                    GUIHandles.roiPairing.displayedImage.CData = computeRollingAverage(GUI, GUIHandles.frameSliderValue, true);
                case 'Plane-by-Plane'
                    if GUIHandles.Info.isTif == 1
                        frame = GUIHandles.tifData(:,:,GUIHandles.frameSliderValue + 1);
                    else
                        frame = sbxRead(GUIHandles.Info, GUIHandles.frameSliderValue);
                    end

                    % unity normalize each frame to intmax('uint16') to use the same color-scale as the pre-computed values
                    GUIHandles.roiPairing.displayedImage.CData = double(frame)/double(intmax('uint16'));
            end
            
            if GUIHandles.resonantOffset ~= 0
                GUIHandles.roiPairing.displayedImage.CData = applyResonantOffset(GUIHandles.roiPairing.displayedImage.CData, GUIHandles.resonantOffset);
            end
    end
        
    guidata(GUI, GUIHandles);
    
end

function updateROIImage(GUI)

    GUIHandles = guidata(GUI);

    switch GUIHandles.mode
        case 'ROI Drawing'
            GUIHandles.roiDrawing.roiImage.AlphaData = 0.5*(GUIHandles.roiDrawing.roiMask > 0);
        case 'ROI Pairing'
            GUIHandles.roiPairing.somaROIImage.AlphaData = 0.5*(GUIHandles.roiPairing.somaROIMask > 0);
            GUIHandles.roiPairing.dendriteROIImage.AlphaData = 0.5*(GUIHandles.roiPairing.dendriteROIMask > 0);
    end
    
    guidata(GUI, GUIHandles);

end

function updateCandidateROIImage(GUI)

    GUIHandles = guidata(GUI);

    % adjust the flood-filling of the candidate ROI   
    GUIHandles.roiDrawing.candidateROIImage.AlphaData = 0.5*(GUIHandles.roiDrawing.floodOrder < GUIHandles.roiDrawing.floodPixels);

    guidata(GUI, GUIHandles);

end

function updateSelectedROIImage(GUI)

    GUIHandles = guidata(GUI);

    switch GUIHandles.mode
        case 'ROI Drawing'
            GUIHandles.roiDrawing.selectedROIImage.AlphaData = 0.5*(GUIHandles.roiDrawing.selectedROIMask > 0);
        case 'ROI Pairing'
            GUIHandles.roiPairing.selectedSomaROIImage.AlphaData = 0.5*(GUIHandles.roiPairing.selectedSomaROIMask > 0);
            GUIHandles.roiPairing.selectedDendriteROIImage.AlphaData = 0.5*(GUIHandles.roiPairing.selectedDendriteROIMask > 0);
    end
    
    guidata(GUI, GUIHandles);

end

function updateOverlapImage(GUI)

    GUIHandles = guidata(GUI);
    
    switch GUIHandles.mode
        case 'ROI Drawing'
            GUIHandles.roiDrawing.overlapImage.AlphaData = 0.5*(GUIHandles.roiDrawing.overlapMask > 0);
    end
    
    guidata(GUI, GUIHandles);

end

function updateHistogram(GUI)

    GUIHandles = guidata(GUI);

    % update the pixel intensity histogram
    if GUIHandles.roiDrawing.selectedROI > 0
        temp = GUIHandles.roiDrawing.displayedImage.CData.*logical(GUIHandles.roiDrawing.selectedROIImage.AlphaData);
    else
        temp = zeros(GUIHandles.imageSize);
    end

    GUIHandles.roiDrawing.histogramPlot.Data = nonzeros(temp(:));

    if max(GUIHandles.roiDrawing.histogramPlot.Values) > 0
        GUIHandles.roiDrawing.histogramAxes.YLim = [0, max(GUIHandles.roiDrawing.histogramPlot.Values)];
    else
        GUIHandles.roiDrawing.histogramAxes.YLim = [0, 1];
    end

    % rescale the histogram's bins
    GUIHandles.roiDrawing.histogramPlot.BinMethod = 'auto';

    guidata(GUI, GUIHandles);

end
    
function updateNeuropilImage(GUI)

    GUIHandles = guidata(GUI);

    GUIHandles.roiDrawing.neuropilImage.AlphaData = 0.25*(GUIHandles.roiDrawing.selectedROINeuropilMask > 0);

    guidata(GUI, GUIHandles);
    
end

function adjustedImage = applyResonantOffset(frame, resonantOffset)

    adjustedImage = frame;

    if resonantOffset > 0
        for j = 2:2:size(frame, 1)
            adjustedImage(j, 1:end) = [zeros(1, resonantOffset), frame(j, 1:end - resonantOffset)];
        end
    elseif resonantOffset < 0
        for j = 2:2:size(frame, 1)
            adjustedImage(j, 1:end) = [frame(j, 1 + -resonantOffset:end), zeros(1, -resonantOffset)];
        end
    end
    
end
    
function pruneSelectedROI(GUI)

    GUIHandles = guidata(GUI);
    
    prunedROIMask = GUIHandles.roiDrawing.selectedROIPixelValues > GUIHandles.roiDrawing.pruneThreshold;
    
    if GUIHandles.roiDrawing.minIslandSize > 0
        
        % this mask is for clusters of pixels that will be removed due to small size
        islandMask = zeros(GUIHandles.imageSize);

        prunedROIProperties = regionprops(prunedROIMask, 'Area', 'PixelList');

        for r = 1:length(prunedROIProperties)
            if prunedROIProperties(r).Area < GUIHandles.roiDrawing.minIslandSize
                for i = 1:size(prunedROIProperties(r).PixelList, 1)
                    column = prunedROIProperties(r).PixelList(i, 1);
                    row = prunedROIProperties(r).PixelList(i, 2);

                    islandMask(row, column) = prunedROIMask(row, column);
                    prunedROIMask(row, column) = 0;
                end
            end
        end

        GUIHandles.roiDrawing.islandImage.AlphaData = 0.5*(islandMask);
    
        GUIHandles.roiDrawing.islandImage.Visible = 'on';
    end
    
    GUIHandles.roiDrawing.selectedROIImage.AlphaData = 0.5*(prunedROIMask);        
    
    % don't forget to update the neuropil as ROI is pruned
    GUIHandles.roiDrawing.selectedROINeuropilMask = (imdilate(logical(GUIHandles.roiDrawing.selectedROIImage.AlphaData), strel('disk', GUIHandles.roiDrawing.neuropilSize)) - GUIHandles.roiDrawing.allROIsMask) > 0;
        
    guidata(GUI, GUIHandles);
    
    if GUIHandles.roiDrawing.viewNeuropilButton.Value == 1
        updateNeuropilImage(GUI);
    end
    
    if strcmp(GUIHandles.roiDrawing.manipulateType, 'Prune')
        updateHistogram(GUI);
    end
    
end
   
function computeROIFlood(GUI)

    GUIHandles = guidata(GUI);
    
    floodCenter = round(GUIHandles.roiDrawing.floodCenter(2:-1:1));
    
    % set the maximum region to grow
    if strcmp(GUIHandles.roiDrawing.drawType, 'Pixel')
        maxRegionSize = min(nnz(GUIHandles.roiDrawing.imageToBeFlooded), max(250, 5*GUIHandles.roiDrawing.floodPixels));
    else
        maxRegionSize = nnz(GUIHandles.roiDrawing.imageToBeFlooded);
    end
        
    [~, floodOrder] = regionGrowing(GUIHandles.roiDrawing.imageToBeFlooded, [floodCenter(1), floodCenter(2)], maxRegionSize);
    
    GUIHandles.roiDrawing.floodOrder = floodOrder;
    
    guidata(GUI, GUIHandles);
    
end
    
function overlayCrossCorrelation(GUI)

    GUIHandles = guidata(GUI);

    ccLocalSize = size(GUIHandles.roiDrawing.localCrossCorrelationImage, 3);
    
    cursor = get(GUIHandles.roiDrawing.imageAxes, 'CurrentPoint');
    cursor = round(cursor(:, 1:2)');
    
    if (GUIHandles.imageSize(2) > cursor(1)) && (cursor(1) > 1) && (GUIHandles.imageSize(1) > cursor(2)) && (cursor(2) > 1)
        originalImage = GUIHandles.roiDrawing.displayedImage.CData;

        % distance in pixels of the selected coordinate from 0/0
        dx = -floor(cursor(2:-1:1)) + ccLocalSize;
        dx(1) = dx(1) - 1;
        dx(2) = dx(2) - 1;

        % shift window we want to paste into so that it starts at 0/0
        overlaidImage = circshift(originalImage, dx);

        % pull out data from precomputed local cross-correlation matrix
        R = squeeze(GUIHandles.roiDrawing.localCrossCorrelationImage(max(floor(cursor(2)), 1), max(floor(cursor(1)), 1), :, :));

        % double resolution and convolve image with a .5, 1, .5 kernel
        R2 = conv2([.5, 1, .5], [.5, 1, .5], R, 'same');
        A = R2(2:end - 1, 2:end - 1);

        R2(ceil(end/2), ceil(end/2)) = 0;
        rg = 1:size(A, 1);

        overlaidImage(rg + floor(ccLocalSize/2), rg + floor(ccLocalSize/2)) = A/(max(R2(:)) + .01);

        % shift window back to its original position
        overlaidImage = circshift(overlaidImage, -dx);
        
        % get rid of NaNs
        overlaidImage(isnan(overlaidImage)) = originalImage(isnan(overlaidImage));
        
        GUIHandles.roiDrawing.displayedImage.CData = overlaidImage;
    end
    
end

function [floodedImage, floodOrder] = regionGrowing(originalImage, seedpoint, maxRegionSize)

    %REGIONGROWING Grow a region in an image from a specified seedpoint.
    %   [floodedImage, floodOrder] = REGIONGROWING(originalImage, seedpoint, maxRegionSize) iteratively grows a region around the seedpoint by comparing unallocated neighboring pixels to the existing region. The pixel with the smallest difference between its intensity value and the mean of the existing region is absorbed into the region. Growing ends when the size of the flooded region exceeds the specified limit.
    % 
    %   floodedImage: logical
    %       Logical matrix containing image of region.
    %
    %   floodOrder: matrix
    %       Matrix containing the order of pixels added to floodedImage.
    %
    %   originalImage: image
    %       Can be any class.
    %
    %   seedpoint: double
    %       Coordinates of seedpoint.
    %
    %   maxRegionSize: double
    %       Upper limit on pixels allowed into flooded image.
    %
    %   Original Author: D. Kroon, University of Twente
    
    floodedImage = zeros(size(originalImage));
    
    % free memory to store neighbors of the (segmented) region
    freeNeighbors = 10000; 
    neighborPositions = 0;
    neighborList = zeros(freeNeighbors, 3); 

    % neighbor locations (footprint)
    neighbors = [-1, 0; 1, 0; 0, -1; 0, 1];
    
    % number of pixels in region
    regionSize = 0; 

    % mean pixel intensity in region
    regionMean = originalImage(seedpoint(1), seedpoint(2));
    
    x = seedpoint(1);
    y = seedpoint(2);
    
    floodOrder = inf(size(originalImage));
    floodOrder(x, y) = 1;
    
    % start region growing until max region size is achieved
    while regionSize <= maxRegionSize
        
        % add the latest approved pixel
        floodedImage(x, y) = 2; 
        
        regionSize = regionSize + 1;
        
        floodOrder(x, y) = regionSize;
        
        % add new neighbors pixels
        for j = 1:4

            % calculate the neighbor coordinate
            xNeighbor = x + neighbors(j, 1); 
            yNeighbor = y + neighbors(j, 2);

            % check if neighbor is inside or outside the image
            inside = (xNeighbor >= 1) && (yNeighbor >= 1) && (xNeighbor <= size(originalImage, 1)) && (yNeighbor <= size(originalImage, 2));

            % add neighbor if inside and not already part of the segmented area
            if inside && (floodedImage(xNeighbor, yNeighbor) == 0)
                neighborPositions = neighborPositions + 1;
                neighborList(neighborPositions, :) = [xNeighbor, yNeighbor, originalImage(xNeighbor, yNeighbor)]; 
                floodedImage(xNeighbor, yNeighbor) = 1;
            end
        end

        % add a new block of free memory
        if neighborPositions + 10 > freeNeighbors
            freeNeighbors = freeNeighbors + 10000; 
            neighborList(neighborPositions + 1:freeNeighbors, :) = 0; 
        end

        % find neighbor pixel with highest intensity
        [~, index] = max(neighborList(1:neighborPositions, 3));
        
        % save the x and y coordinates of the pixel (for the neighbor add proccess)
        x = neighborList(index, 1); 
        y = neighborList(index, 2);

        % calculate the new mean of the region
        regionMean = (regionMean*regionSize + neighborList(index, 3))/(regionSize + 1);

        % remove the pixel from the neighbor (check) list
        neighborList(index, :) = neighborList(neighborPositions, :); 
        neighborPositions = neighborPositions - 1;
    end

    % return the segmented area as a logical matrix
    floodedImage = floodedImage == 2;
    
end

function adjustedImage = applyMotionCorrection(GUI, index, excludeFrames)

    GUIHandles = guidata(GUI);

    % frame = sbxRead(GUIHandles.Info, index);
    if GUIHandles.Info.isTif == 1
        frame_all_channels = GUIHandles.tifData(:,:,index+1);
    else
        frame_all_channels = sbxRead(GUIHandles.Info, index);
    end
    num_channels = ndims(frame_all_channels);
    if num_channels > 2
        if strcmp(GUIHandles.imageProcessing.displayChannel, 'green channel')
            disp_chan = 1;
        else
            disp_chan = 2;
        end

        frame = squeeze(frame_all_channels(disp_chan,:,:));
    else
        frame = frame_all_channels;
    end

    if any(GUIHandles.frameCrop > 0)
        frame = frame(GUIHandles.frameCrop(3) + 1:GUIHandles.Info.sz(1) - GUIHandles.frameCrop(4), GUIHandles.frameCrop(1) + 1:GUIHandles.Info.sz(2) - GUIHandles.frameCrop(2));
    end
    
    phaseDifference = GUIHandles.phaseDifferences(index + 1);
    rowShift = GUIHandles.rowShifts(index + 1);
    columnShift = GUIHandles.columnShifts(index + 1);
    
    % check if frame shifts are crazy
    if excludeFrames
        large = abs(rowShift) > 20 || abs(columnShift) > 20;
        
        if index == 0
            jagged = abs(rowShift - GUIHandles.rowShifts(index + 2)) > 10 || abs(columnShift - GUIHandles.columnShifts(index + 2)) > 10;
        else
            jagged = abs(rowShift - GUIHandles.rowShifts(index)) > 10 || abs(columnShift - GUIHandles.columnShifts(index)) > 10;
        end
        
        if large || jagged
            adjustedImage = nan(size(frame));
            return
        end
    end
            
    if phaseDifference ~= 0 || rowShift ~= 0 || columnShift ~= 0
        adjustedImage = fft2(frame);

        [numberOfRows, numberOfColumns] = size(adjustedImage);
        Nr = ifftshift(-fix(numberOfRows/2):ceil(numberOfRows/2) - 1);
        Nc = ifftshift(-fix(numberOfColumns/2):ceil(numberOfColumns/2) - 1);
        [Nc, Nr] = meshgrid(Nc, Nr);

        adjustedImage = adjustedImage.*exp(2i*pi*(-rowShift*Nr/numberOfRows - columnShift*Nc/numberOfColumns));
        adjustedImage = adjustedImage*exp(1i*phaseDifference);

        adjustedImage = abs(ifft2(adjustedImage));
        
        % adjust values just in case
        originalMinimum = double(min(frame(:)));
        originalMaximum = double(max(frame(:)));
        adjustedMinimum = min(adjustedImage(:));
        adjustedMaximum = max(adjustedImage(:));
        
        adjustedImage = uint16((adjustedImage - adjustedMinimum)/(adjustedMaximum - adjustedMinimum)*(originalMaximum - originalMinimum) + originalMinimum);
    else
        adjustedImage = frame;
    end

end

function rollingAverage = computeRollingAverage(GUI, index, align)

    GUIHandles = guidata(GUI);
    
    if ~exist('align', 'var')
        align = true;
    end

    if index - GUIHandles.rollingWindowSize(1) < 0
        start = 0;
        finish = GUIHandles.rollingWindowSize(2);
    elseif index + GUIHandles.rollingWindowSize(2) > GUIHandles.Info.maxIndex
        start = GUIHandles.Info.maxIndex - GUIHandles.rollingWindowSize(1);
        finish = GUIHandles.Info.maxIndex;
    else
        start = index - GUIHandles.rollingWindowSize(1);
        finish = index + GUIHandles.rollingWindowSize(2);
    end
    
    frames = zeros(GUIHandles.imageSize(1), GUIHandles.imageSize(2), finish - start + 1);
    
    if align
        
        % motion correction slows rolling average presentation significantly
        if GUIHandles.motionCorrected
            for i = 0:finish - start
                frames(:, :, i + 1) = applyMotionCorrection(GUI, start + i, false);
            end
        else
            for i = 0:finish - start
                if GUIHandles.Info.isTif == 1
                    if start + i + 1 <= GUIHandles.Info.maxIndex
                        frame_all_channels = GUIHandles.tifData(:,:,start + i + 1);
                    end
                else
                    frame_all_channels = sbxRead(GUIHandles.Info, start + i);
                end
                num_channels = ndims(frame_all_channels);
                if num_channels > 2
                    if strcmp(GUIHandles.imageProcessing.displayChannel, 'green channel')
                        disp_chan = 1;
                    else
                        disp_chan = 2;
                    end
                        
                    frames(:, :, i + 1) = frame_all_channels(disp_chan,:,:);
                else
                    frames(:, :, i + 1) = frame_all_channels;
                end
            end
        end
    else
        for i = 0:finish - start
            if GUIHandles.Info.isTif == 1
                frame = GUIHandles.tifData(:,:,start + i + 1);
            else
                frame = sbxRead(GUIHandles.Info, start + i);
            end
            
            if GUIHandles.motionCorrected
                if any(GUIHandles.frameCrop > 0)
                    frame = frame(GUIHandles.frameCrop(3) + 1:GUIHandles.Info.sz(1) - GUIHandles.frameCrop(4), GUIHandles.frameCrop(1) + 1:GUIHandles.Info.sz(2) - GUIHandles.frameCrop(2));
                end
            end

            frames(:, :, i + 1) = frame;
        end
    end

    rollingAverage = double(mean(frames, 3))/double(intmax('uint16'));
                    
end