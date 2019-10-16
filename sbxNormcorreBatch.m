function sbxNormcorreBatch()
    crop_BD_artifact = false;
    try
        [sbxNames, sbxPath] = uigetfile('.sbx', 'Please select file containing imaging data.','MultiSelect','on');
    catch
        waitfor(msgbox('Error: Please select valid .sbx file.'));
        error('Please select valid .sbx file.');
    end
    
    if class(sbxNames) == 'cell'
        for i=1:length(sbxNames)
            sbxName = strtok(sbxNames{i}, '.');
            Info = sbxInfo([sbxPath, sbxName]);
            
            if crop_BD_artifact == true
                Parameters.frameCrop(1) = 91;
                Parameters.frameCrop(2) = 0;
                Parameters.frameCrop(3) = 0;
                Parameters.frameCrop(4) = 0;
            else
                Parameters.frameCrop(1) = 0;
                Parameters.frameCrop(2) = 0;
                Parameters.frameCrop(3) = 0;
                Parameters.frameCrop(4) = 0;
            end
            
            N = Info.maxIndex;
            Y_n = sbxreadframes(sbxName,0,N,Parameters);
            Y = squeeze(Y_n);
            Y = single(Y);                 % convert to single precision 
            Y = Y - min(Y(:));             % remove baseline from absolute values

            % now try non-rigid motion correction (also in parallel)
            options_nonrigid = NoRMCorreSetParms('d1',size(Y,1),'d2',size(Y,2),'grid_size',[32,32],'mot_uf',4,'bin_width',200,'max_shift',15,'max_dev',3,'us_fac',50,'init_batch',200);
            tic; [M2,shifts2,template2,options_nonrigid] = normcorre_batch(Y,options_nonrigid); toc
            
            disp('saving frames file...');
            newFileID = fopen([sbxName, '_rigid.sbx'], 'w');
            min_val = min(Y(:));
            Info.samplesPerFrame = size(M2,1) * size(M2,2);
            Info.sz(1) = size(M2,1);
            Info.sz(2) = size(M2,2);
            for n=1:N  
                frame = reshape(permute(M2(:,:,n),[2,1]),[Info.samplesPerFrame,1]);
                frame = frame + min_val;
                frame = intmax('uint16') - uint16(frame);
                fwrite(newFileID,frame,'uint16');
            end
            fclose(newFileID);
            save([sbxName, '_rigid.mat'], 'Info');
            
            
            
            disp('making dummy alignment file');
            phaseDifferences = zeros(1,Info.maxIndex+1);
            rowShifts = zeros(1,Info.maxIndex+1);
            columnShifts = zeros(1,Info.maxIndex+1);
            frameCrop = Parameters.frameCrop;
            save([Info.Directory.folder, Info.Directory.name, '_rigid.rigid'], 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop');
%             Info.Directory.name = char([Info.Directory.name, '_rigid']);
            %disp('sbx Process');
            %sbxPreAnalysisNew(GUIHandles.Info)
            disp('done motion correction');

            Info.Directory.name = [sbxName, '_rigid'];
            Parameters.GUI = false;
            Parameters.resonantOffset = 0;
            % set pixel intensity threshold for sampling frames for reference
            Parameters.threshold = 1500;
            % set sigma of Gaussian filter applied to image to smooth out pixel artefacts - 0 is no filtering
            Parameters.gaussianFilter = 0.0;
            Parameters.method = 1;
            Parameters.sampleSize = 300;
            Parameters.sampleBounds(1) = 0;
            Parameters.sampleBounds(2) = Info.maxIndex;

            Parameters.maxQuantile = 0.95;
            Info.isTif = 0;
    
            % pre-computing parameters...
            [meanImage, maxIntensityImage, crossCorrelationImage, localCrossCorrelationImage, pcaImage, result] = sbxPreAnalysis(Info, Parameters);
        end
    end
end