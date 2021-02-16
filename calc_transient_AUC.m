function transient_AUC = calc_transient_AUC(dff, transient_idx, start_idx, stop_idx, fs)
    transient_AUC = zeros(size(transient_idx,1),1);  % AUC for each transient of each neuron

    onset_idx = transient_idx(:,1);
    offset_idx = transient_idx(:,2);        
    if size(onset_idx) > 0
        for j=1:size(onset_idx,1)
            if onset_idx(j) > start_idx && offset_idx(j) < stop_idx
                x_vals = linspace(1,(offset_idx(j)-onset_idx(j))/fs, offset_idx(j)-onset_idx(j)+1);
                y_vals = dff(onset_idx(j):offset_idx(j))';
                if size(x_vals,2) > 1
                    t_auc = trapz(x_vals, y_vals);
                    if ~isnan(t_auc)
                        transient_AUC(j) = t_auc;
                    end
                end
                
            end
        end
    end

end