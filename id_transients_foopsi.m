function roi_transients = id_transients_foopsi(dff,foopsi_events,foopsi_filtered)
    roi_transients = {};
    foopsi_transient_threshold = 0.1;
    
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
            while cr_foopsi_filtered(k) > foopsi_transient_threshold && k > 1
                k = k - 1;
            end
            
            % only add this transient if its not equal to the previous one
            if size(transient_start) > 0 
                if k ~= transient_start(end)
                    transient_start = [transient_start; k];
                    % determine end of transient
                    k = event_idx(j);
                    while cr_foopsi_filtered(k) > foopsi_transient_threshold && k < size(cr_foopsi_filtered,1)
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
                while cr_foopsi_filtered(k) > foopsi_transient_threshold && k < size(cr_foopsi_filtered,1)
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