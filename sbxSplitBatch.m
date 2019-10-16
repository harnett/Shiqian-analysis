function sbxSplitBatch()
    try
        [sbxNames, sbxPath] = uigetfile('.sbx', 'Please select file containing imaging data.','MultiSelect','on');
    catch
        waitfor(msgbox('Error: Please select valid .sbx file.'));
        error('Please select valid .sbx file.');
    end
    
    if class(sbxNames) == 'cell'
        for i=1:length(sbxNames)
            sbxName = strtok(sbxNames{i}, '.');

            Parameters.GUI = false;
            Info = sbxInfo([sbxPath, sbxName]);
            result = sbxSplit(Info, Parameters);
        end
    end

end
