function roi_zscore = calculateZSCORE(roiFluorescences)
    roi_zscore = zeros(size(roiFluorescences));
    for i=1:1:size(roiFluorescences,2)
        roi_std = nanstd(roiFluorescences(roiFluorescences(:,i) < prctile(roiFluorescences(:,i),50),i));
        roi_mean = nanmean(roiFluorescences(roiFluorescences(:,i) < prctile(roiFluorescences(:,i),50),i));
        for j=1:1:size(roiFluorescences,1)
            roi_zscore(j,i) = (roiFluorescences(j,i) - roi_mean)/roi_std; % calculate difference between dF and f0(t)
        end
    end
end
