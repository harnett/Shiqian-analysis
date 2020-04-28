function compare_FOV()
    try
        [sbxNames, sbxPath] = uigetfile('.sbx', 'Please select file containing imaging data.','MultiSelect','off');
    catch
        waitfor(msgbox('Error: Please select valid .sbx file.'));
        error('Please select valid .sbx file.');
    end
    
    sbxName = strtok(sbxNames, '.');
    Info = sbxInfo([sbxPath, sbxName]);
    
    N = Info.maxIndex;
    num_frames = 500;
    Parameters.frameCrop(1) = 0;
    Parameters.frameCrop(2) = 0;
    Parameters.frameCrop(3) = 0;
    Parameters.frameCrop(4) = 0;
    mean_frame_start = squeeze(sbxreadframes(sbxName,0,num_frames,Parameters));
    mean_frame_end = squeeze(sbxreadframes(sbxName,N-num_frames,num_frames,Parameters));
    
    figure();
    ax1 = subplot(121);
    imagesc(mean(mean_frame_start, 3));
    ax2 = subplot(122);
    imagesc(mean(mean_frame_end, 3));
    linkaxes([ax1,ax2]);
end