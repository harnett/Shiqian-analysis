function dff = calculateDFF2(roiFluorescences, baseline_percentile)
    fs = 5;       % sample rate, Hz
%     cutoff = 2; % desired cutoff frequency of the filter, Hz
    win = 60; % size of moving window in seconds
    win_samples = win * fs; % calculate the number of samples in the window (dependent on fs)
    dff = zeros(size(roiFluorescences));
    
    for i=1:1:size(roiFluorescences,2)
        for j=1:1:size(roiFluorescences,1)
            % calculate f0, if-clauses are for boundary conditions at beginning and end of trace
            if j-int32(win_samples/2) < 1
                f0 = prctile(roiFluorescences(1:j+int32(win_samples/2),i),baseline_percentile);
            elseif j+int32(win_samples/2) > size(roiFluorescences,1)
                f0 = prctile(roiFluorescences(j-int32(win_samples/2):size(roiFluorescences,1)-1,i),baseline_percentile);
            else
                f0 = prctile(roiFluorescences(j-int32(win_samples/2):j+int32(win_samples/2),i),baseline_percentile);
            end

            dff(j,i) = roiFluorescences(j,i) - f0; % calculate difference between dF and f0(t)
            dff(j,i) = dff(j,i)/abs(f0);
        end
    end
end