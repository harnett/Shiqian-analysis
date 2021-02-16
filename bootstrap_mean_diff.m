function p = bootstrap_mean_diff(group1, group2, num_shuffles)
% carry out bootstrap mean difference test between two groups.
% calculates confidence interval and p-value
% if multiple comparisons are carried out, posthoc correct has to be carried out separately

shuffled_meandiff = zeros(num_shuffles,1);

rng('shuffle');
for n=1:num_shuffles
    g1_randidx = randi(length(group1),length(group1),1);
    g2_randidx = randi(length(group2),length(group2),1);
    shuffled_meandiff(n)=nanmean(group1(g1_randidx))-nanmean(group2(g2_randidx));
end

% Calculate confidence interval
alphaLevel=0.05; % set the p value ? 
cis=prctile(shuffled_meandiff,[100*alphaLevel/2,100*(1-alphaLevel/2)]);

% Calculate p-value 
CI_range = cis(2) - cis(1);
SE = CI_range / (2*1.96);
zS = abs(mean(shuffled_meandiff)) / SE;
p = exp((-0.717*zS)-(0.416*(zS^2)));


end