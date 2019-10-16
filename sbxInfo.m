function Info = sbxInfo(sbxName)

    %SBXINFO Import info structure from .sbx file.
    %   Info = SBXINFO(sbxName) creates the structure Info corresponding to the indicated .sbx file.
    %
    %   sbxName: string 
    %       Path of .sbx file (e.g., 'C:/User/xx0_000_001.sbx').
    %
    %   Info: structure
    %       Structure containing important details about imaging data.
    
    if ~exist('sbxName', 'var')
        try
            [sbxName, sbxPath] = uigetfile('.sbx', 'Please select file containing imaging data.');
            sbxName = [sbxPath, sbxName];
        catch
            waitfor(msgbox('Error: Please select valid .sbx file.'));
            error('Please select valid .sbx file.');
        end
    end
    
    % pull off the file extension if it's there
    sbxName = strtok(sbxName, '.');
    
    if exist([sbxName, '.mat'], 'file')
        Info = importdata([sbxName, '.mat']);
    else
        waitfor(msgbox('Error: .mat file required to generate Info structure.'));
        error('.mat file required to generate Info structure.');
    end
    
    % check if both PMT 0 & 1 (case 1), PMT 0 (case 2), or PMT 1 (case 3)
    switch Info.channels
        case 1
            Info.nChannels = 2;
        case 2
            Info.nChannels = 1;
        case 3
            Info.nChannels = 1;
    end
    
    % likewise with scanmode; assume unidirectional scanning
    if ~isfield(Info, 'scanmode')
        Info.scanmode = 1;
    end
    
    % if scanmode was bidirectional, adjust the number of lines scanned per buffer
    if Info.scanmode == 0
        Info.recordsPerBuffer = Info.recordsPerBuffer*2;
    end
    
    % if frame size wasn't set, manually put it in at default values
    if ~isfield(Info, 'sz')
        Info.sz = [Info.recordsPerBuffer, 796];
    end
    
    if ~exist([sbxName, '.sbx'], 'file')
        waitfor(msgbox('Error: .sbx file not found.'));
        error('.sbx file not found.');
    end
    
    Info.Directory = dir([sbxName, '.sbx']);
    
    if ~isfield(Info.Directory, 'folder')
        [Info.Directory.folder, ~, ~] = fileparts([sbxName, '.sbx']);
    end
    
    Info.Directory.folder = [Info.Directory.folder, '\'];
    Info.Directory.name = strtok(Info.Directory.name, '.');
    
    % data is stored with uint16 precision - each sample is stored as 2 bytes
    Info.samplesPerFrame = Info.sz(1)*Info.sz(2)*Info.nChannels;
    Info.bytesPerFrame = 2*Info.samplesPerFrame;
    
    % frame index starts at 0
    Info.maxIndex = Info.Directory.bytes/Info.bytesPerFrame - 1;

end