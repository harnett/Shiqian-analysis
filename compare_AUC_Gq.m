%% set datapaths
Gq_C21_FLIT = ...
      {{'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021\Gq+C21+FLIT\mouse 1\day 0\T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 1/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 1/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 1/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 1/day 28/T28'},...
       {'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 2/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 2/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 2/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 2/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 2/day 28/T28'},...
       {'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 4/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 4/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 4/day 14/T14_rigid';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 4/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 4/day 28/T28'}};
    
%        {'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 3/day 0/T0';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 3/day 7/T7';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 3/day 14/T14';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 3/day 21/T21';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+FLIT/mouse 3/day 28/T28'},...
    
Gq_C21_SHAM = ...
      {{'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 1/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 1/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 1/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 1/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 1/day 28/T28'},...    
       {'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 2/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 2/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 2/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 2/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 2/day 28/T28'},... 
       {'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 4/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 4/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 4/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 4/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 4/day 28/T28'}};
    
%        {'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 3/day 0/T0';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 3/day 7/T7';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 3/day 14/T14_rigid';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 3/day 21/T21';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/Gq+C21+sham/mouse 3/day 28/T28'},...
    
Vector_C21_FLIT = ...
      {{'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 1/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 1/day 7/T7_rigid';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 1/day 14/T14_rigid';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 1/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 1/day 28/T28_rigid'},...
       {'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 2/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 2/day 7/T7_rigid';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 2/day 14/T14_rigid';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 2/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 2/day 28/T28'}...
       {'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 4/day 0/T0_rigid';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 4/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 4/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 4/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 4/day 28/T28'}};   
% {'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 3/day 0/T0';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 3/day 7/T7';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 3/day 14/T14';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 3/day 21/T21';...
%         'C:\Users\lfisc\Work\Projects\Shiqian\Gq imaging data_01282021/vector+C21+FLIT/mouse 3/day 28/T28'},...
    
%% run individual or small group
norm_res = false;  
[frac_global_RITE,num_transients_RITE,global_AUC_RITE,ind_AUC_RITE,sum_events_RITE,tot_AUC_RITE,trace_AUC_RITE] = group_graphs(CaMKII_RITE, norm_res);
% [frac_global_RITE,num_transients_RITE,global_AUC_RITE,ind_AUC_RITE,sum_events_RITE,tot_AUC_RITE,trace_AUC_RITE] = group_graphs(CaMKII_Ion_CC, norm_res);
% [frac_global_RITE,num_transients_RITE,global_AUC_RITE,ind_AUC_RITE,sum_events_RITE,tot_AUC_RITE,trace_AUC_RITE] = group_graphs(CaMKII_all_SHAM, norm_res);
%      

%% 2-Way ANOVA and bootstrap difference on groups
norm_res = false;   

[frac_global_RITE,num_transients_RITE,global_AUC_RITE,ind_AUC_RITE,sum_events_RITE,tot_AUC_RITE,trace_AUC_RITE] = group_graphs(Gq_C21_FLIT, norm_res);
[frac_global_IONCC,num_transients_IONCC,global_AUC_IONCC,ind_AUC_IONCC,sum_events_IONCC,tot_AUC_IONCC,trace_AUC_IONCC] = group_graphs(Vector_C21_FLIT, norm_res);
[frac_global_SHAM,num_transients_SHAM,global_AUC_SHAM,ind_AUC_SHAM,sum_events_SHAM,tot_AUC_SHAM,trace_AUC_SHAM] = group_graphs(Gq_C21_SHAM, norm_res);

% y_vals = [reshape(trace_AUC_RITE.',1,[]), reshape(trace_AUC_IONCC.',1,[]), reshape(trace_AUC_SHAM.',1,[])];
% groups{1} = repmat({'d1','d2','d3'}, 1, size(trace_AUC_RITE,1) + size(trace_AUC_IONCC,1) + size(trace_AUC_SHAM,1));
% groups{2} = [repmat({'RITE'}, 1, size(trace_AUC_RITE(:),1)), repmat({'IONCC'}, 1, size(trace_AUC_IONCC(:),1)), repmat({'SHAM'}, 1, size(trace_AUC_SHAM(:),1)) ] ;

% [p,tbl,stats] = anovan(y_vals, groups, 'model','interaction','varnames',{'Days','Groups'});
% figure;
% results = multcompare(stats,'Dimension',[1 2]);



num_shuffles = 10000;

p_d0_RITE_IONCC = bootstrap_mean_diff(trace_AUC_RITE(:,1), trace_AUC_IONCC(:,1), num_shuffles);
p_d0_RITE_SHAM = bootstrap_mean_diff(trace_AUC_RITE(:,1), trace_AUC_SHAM(:,1), num_shuffles);
p_d0_IONCC_SHAM = bootstrap_mean_diff(trace_AUC_IONCC(:,1), trace_AUC_SHAM(:,1), num_shuffles);

p_d3_RITE_IONCC = bootstrap_mean_diff(trace_AUC_RITE(:,2), trace_AUC_IONCC(:,2), num_shuffles);
p_d3_RITE_SHAM = bootstrap_mean_diff(trace_AUC_RITE(:,2), trace_AUC_SHAM(:,2), num_shuffles);
p_d3_IONCC_SHAM = bootstrap_mean_diff(trace_AUC_IONCC(:,2), trace_AUC_SHAM(:,2), num_shuffles);

p_d7_RITE_IONCC = bootstrap_mean_diff(trace_AUC_RITE(:,3), trace_AUC_IONCC(:,3), num_shuffles);
p_d7_RITE_SHAM = bootstrap_mean_diff(trace_AUC_RITE(:,3), trace_AUC_SHAM(:,3), num_shuffles);
p_d7_IONCC_SHAM = bootstrap_mean_diff(trace_AUC_IONCC(:,3), trace_AUC_SHAM(:,3), num_shuffles);

p_d14_RITE_IONCC = bootstrap_mean_diff(trace_AUC_RITE(:,4), trace_AUC_IONCC(:,4), num_shuffles);
p_d14_RITE_SHAM = bootstrap_mean_diff(trace_AUC_RITE(:,4), trace_AUC_SHAM(:,4), num_shuffles);
p_d14_IONCC_SHAM = bootstrap_mean_diff(trace_AUC_IONCC(:,4), trace_AUC_SHAM(:,4), num_shuffles);

p_d21_RITE_IONCC = bootstrap_mean_diff(trace_AUC_RITE(:,5), trace_AUC_IONCC(:,5), num_shuffles);
p_d21_RITE_SHAM = bootstrap_mean_diff(trace_AUC_RITE(:,5), trace_AUC_SHAM(:,5), num_shuffles);
p_d21_IONCC_SHAM = bootstrap_mean_diff(trace_AUC_IONCC(:,5), trace_AUC_SHAM(:,5), num_shuffles);

% p_d28_RITE_IONCC = bootstrap_mean_diff(trace_AUC_RITE(:,6), trace_AUC_IONCC(:,6), num_shuffles);
% p_d28_RITE_SHAM = bootstrap_mean_diff(trace_AUC_RITE(:,6), trace_AUC_SHAM(:,6), num_shuffles);
% p_d28_IONCC_SHAM = bootstrap_mean_diff(trace_AUC_IONCC(:,6), trace_AUC_SHAM(:,6), num_shuffles);

p_d1_RITE_ALLCONT = bootstrap_mean_diff(trace_AUC_RITE(:,1), [trace_AUC_IONCC(:,1); trace_AUC_SHAM(:,1)], num_shuffles);
p_d2_RITE_ALLCONT = bootstrap_mean_diff(trace_AUC_RITE(:,2), [trace_AUC_IONCC(:,2); trace_AUC_SHAM(:,2)], num_shuffles);
p_d3_RITE_ALLCONT = bootstrap_mean_diff(trace_AUC_RITE(:,3), [trace_AUC_IONCC(:,3); trace_AUC_SHAM(:,3)], num_shuffles);

bonferroni_alpha = 0.05 / 15;

% figure;
% errorbar(mean(trace_AUC_RITE,1), std(trace_AUC_RITE,1)/sqrt(5) ,'LineWidth',3, 'Color', 'r');
% hold on;
% errorbar(mean(trace_AUC_IONCC,1), std(trace_AUC_IONCC,1)/sqrt(6) ,'LineWidth',3, 'Color', 'b');
% errorbar(mean(trace_AUC_SHAM,1), std(trace_AUC_SHAM,1)/sqrt(4) ,'LineWidth',3, 'Color', 'k');
% hold off;

figure;

errorbar(mean(trace_AUC_RITE,1), std(trace_AUC_RITE,1)/sqrt(5) ,'LineWidth',3, 'Color', 'r'); % , 'Marker', 's', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
hold on;
errorbar(mean(trace_AUC_IONCC,1), std(trace_AUC_IONCC,1)/sqrt(6) ,'LineWidth',3, 'Color', '#752075'); % ,'Marker', '^', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
errorbar(mean(trace_AUC_SHAM,1), std(trace_AUC_SHAM,1)/sqrt(7) ,'LineWidth',3,'Color', '#008000'); % ,'Marker', 'o', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
% errorbar(mean([trace_AUC_IONCC;trace_AUC_SHAM],1), std([trace_AUC_IONCC;trace_AUC_SHAM],1)/sqrt(10) ,'LineWidth',3, 'Color', 'k');
hold off;
pbaspect([1.5 1 1]);
set(gca,'box','off','color','none', 'TickDir','out', 'fontsize',14);
ylabel('AUC')
xticks([1,2,3,4,5]);
xticklabels({'Day 0','Day 3','Day 7','Day 14','Day 21'});
xtickangle(45);
legend('RITE','ION-CC','SHAM');

figure;
ax = subplot(1,1,1);
plot(mean(frac_global_RITE,1),'LineWidth',1, 'Color', '#752075', 'MarkerSize', 4, 'Marker', 'o', 'MarkerFaceColor', '#752075', 'MarkerEdgeColor', 'none'); %, 'Marker', 's', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
hold on;
plot(mean(frac_global_IONCC,1),'LineWidth',1, 'Color', '#FF0000', 'MarkerSize', 4, 'Marker', 'o', 'MarkerFaceColor', '#FF0000', 'MarkerEdgeColor', 'none');
plot(mean(frac_global_SHAM,1),'LineWidth',1, 'Color', '#008000', 'MarkerSize', 4, 'Marker', 'o', 'MarkerFaceColor', '#008000', 'MarkerEdgeColor', 'none');
plot_shade(ax, [1,2,3,4,5], frac_global_RITE', '#752075');
plot_shade(ax, [1,2,3,4,5], frac_global_IONCC', '#FF0000');
plot_shade(ax, [1,2,3,4,5], frac_global_SHAM', '#008000');
ylim([0,0.7]);
hold off;
pbaspect([1.5 1 1]);


% errorbar(mean(frac_global_RITE,1), std(frac_global_RITE,1)/sqrt(5) ,'LineWidth',3, 'Color', 'r', 'CapSize',0); %, 'Marker', 's', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
% hold on;
% errorbar(mean(frac_global_IONCC,1), std(frac_global_IONCC,1)/sqrt(6) ,'LineWidth',3, 'Color', 'b', 'CapSize',0); % ,'Marker', '^', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
% errorbar(mean(frac_global_SHAM,1), std(frac_global_SHAM,1)/sqrt(7) ,'LineWidth',3,'Color', '#008000', 'CapSize',0); % ,'Marker', 'o', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
% % errorbar(mean([frac_global_IONCC;frac_global_SHAM],1), std([frac_global_IONCC;frac_global_SHAM],1)/sqrt(10) ,'LineWidth',3, 'Color', 'k');
% hold off;





set(gca,'box','off','color','none', 'TickDir','out', 'fontsize',14);
ylabel('FRAC GLOBAL')
xticks([1,2,3,4,5,6]);
xticklabels({'Day 0','Day 3','Day 7','Day 14','Day 21','Day 28'});
xtickangle(45);
legend('RITE','ION-CC','SHAM');

y_vals = [reshape(frac_global_RITE.',1,[]), reshape(frac_global_IONCC.',1,[]), reshape(frac_global_SHAM.',1,[])];
groups{1} = repmat({'d0','d3','d7','d14','d21'}, 1, size(frac_global_RITE,1) + size(frac_global_IONCC,1) + size(frac_global_SHAM,1));
groups{2} = [repmat({'FLIT'}, 1, size(frac_global_RITE(:),1)), repmat({'VECTOR'}, 1, size(frac_global_IONCC(:),1)), repmat({'SHAM'}, 1, size(frac_global_SHAM(:),1)) ] ;

[p,tbl,stats] = anovan(y_vals, groups, 'model','interaction','varnames',{'Days','Groups'});
figure;
results = multcompare(stats,'Dimension',[1 2], 'CType' ,'bonferroni');

x = 1;
% figure;
% errorbar(mean(global_AUC_RITE./tot_AUC_RITE,1), std(global_AUC_RITE./tot_AUC_RITE,1)/sqrt(5) ,'LineWidth',3, 'Color', 'r', 'Marker', 's', 'MarkerSize', 12, 'MarkerFaceColor', 'w');
% hold on;
% errorbar(mean(global_AUC_IONCC./tot_AUC_IONCC,1), std(global_AUC_IONCC./tot_AUC_IONCC,1)/sqrt(5) ,'LineWidth',3, 'Color', 'b','Marker', '^', 'MarkerSize', 12, 'MarkerFaceColor', 'w');
% errorbar(mean(global_AUC_SHAM./tot_AUC_SHAM,1), std(global_AUC_SHAM./tot_AUC_SHAM,1)/sqrt(5) ,'LineWidth',3, 'Color', '#008000','Marker', 'o', 'MarkerSize', 12, 'MarkerFaceColor', 'w');
% % errorbar(mean([frac_global_IONCC;frac_global_SHAM],1), std([frac_global_IONCC;frac_global_SHAM],1)/sqrt(10) ,'LineWidth',3, 'Color', 'k');
% hold off;
% set(gca,'box','off','color','none', 'TickDir','out', 'fontsize',14);
% ylabel('GLOBAL AUC FRACTION')
% xticks([1,2,3,4,5,6]);
% xticklabels({'Day 0','Day 3','Day 7','Day 14','Day 21','Day 28'});
% xtickangle(45);
% legend('RITE','ION-CC','SHAM');


%% ANOVA on limited days

% y_vals = [reshape(frac_global_RITE.',1,[]), reshape(frac_global_IONCC.',1,[]), reshape(frac_global_SHAM.',1,[])];
% groups{1} = repmat({'d0','d3'}, 1, size(frac_global_RITE,1) + size(frac_global_IONCC,1) + size(frac_global_SHAM,1));
% groups{2} = [repmat({'FLIT'}, 1, size(frac_global_RITE(:),1)), repmat({'VECTOR'}, 1, size(frac_global_IONCC(:),1)), repmat({'SHAM'}, 1, size(frac_global_SHAM(:),1)) ] ;
% 
% [p,tbl,stats] = anovan(y_vals, groups, 'model','interaction','varnames',{'Days','Groups'});
% figure;
% results = multcompare(stats,'Dimension',[1 2], 'CType' ,'bonferroni');

y_vals = [reshape(frac_global_RITE(:,1:2).',1,[]), reshape(frac_global_IONCC(:,1:2).',1,[]), reshape(frac_global_SHAM(:,1:2).',1,[])];
groups{1} = repmat({'d0','d3'}, 1, size(frac_global_RITE(:,1:2),1) + size(frac_global_IONCC(:,1:2),1) + size(frac_global_SHAM(:,1:2),1));
groups{2} = [repmat({'FLIT'}, 1, 2*4), repmat({'SHAM'}, 1, 2*4), repmat({'VECTOR'}, 1, 2*4)] ;

[p,tbl,stats] = anovan(y_vals, groups, 'model','interaction','varnames',{'Days','Groups'});
figure;
results = multcompare(stats,'Dimension',[1 2], 'CType' ,'tukey-kramer')

%% AUC analysis for each neuron
roi_AUC_RITE = get_trace_AUC(Dlx_RITE);
roi_AUC_IONCC = get_trace_AUC(Dlx_Ion_CC);
roi_AUC_SHAM = get_trace_AUC(Dlx_Sham);

% group all the data by experimental group
auc_rois = cell(size(roi_AUC_RITE,2));
for i=1:size(roi_AUC_RITE,2)
    for j=1:size(roi_AUC_RITE,1)
        auc_rois{1,i} = [auc_rois{1,i}, roi_AUC_RITE{j,i}];
    end
    for j=1:size(roi_AUC_IONCC,1)
        auc_rois{2,i} = [auc_rois{2,i}, roi_AUC_IONCC{j,i}];
    end
    for j=1:size(roi_AUC_SHAM,1)
        auc_rois{3,i} = [auc_rois{3,i}, roi_AUC_SHAM{j,i}];
    end
end

% set up 2-Way ANOVA
% y_vals = [reshape(trace_AUC_RITE.',1,[]), reshape(trace_AUC_IONCC.',1,[]), reshape(trace_AUC_SHAM.',1,[])];
y_vals = [auc_rois{1,1},auc_rois{1,2},auc_rois{1,3},auc_rois{2,1},auc_rois{2,2},auc_rois{2,3},auc_rois{3,1},auc_rois{3,2},auc_rois{3,3}];
groups{1} = [repmat({'d1'}, 1, length(auc_rois{1,1})), repmat({'d2'}, 1, length(auc_rois{1,2})), repmat({'d3'}, 1, length(auc_rois{1,3})),...
             repmat({'d1'}, 1, length(auc_rois{2,1})), repmat({'d2'}, 1, length(auc_rois{2,2})), repmat({'d3'}, 1, length(auc_rois{2,3})),...
             repmat({'d1'}, 1, length(auc_rois{3,1})), repmat({'d2'}, 1, length(auc_rois{3,2})), repmat({'d3'}, 1, length(auc_rois{3,3}))];
% groups{2} = [repmat({'RITE'}, 1, length(auc_rois{1,1}) + length(auc_rois{1,2}) + length(auc_rois{1,3})),...
%              repmat({'IONCC'}, 1, length(auc_rois{2,1}) + length(auc_rois{2,2}) + length(auc_rois{2,3})),...
%              repmat({'SHAM'}, 1, length(auc_rois{3,1}) + length(auc_rois{3,2}) + length(auc_rois{3,3}))];
         
groups{2} = [repmat({'RITE'}, 1, length(auc_rois{1,1}) + length(auc_rois{1,2}) + length(auc_rois{1,3})),...
             repmat({'SHAM'}, 1, length(auc_rois{2,1}) + length(auc_rois{2,2}) + length(auc_rois{2,3})),...
             repmat({'SHAM'}, 1, length(auc_rois{3,1}) + length(auc_rois{3,2}) + length(auc_rois{3,3}))];

[p,tbl,stats] = anovan(y_vals, groups, 'model','interaction','varnames',{'Days','Groups'});
figure;
results = multcompare(stats,'Dimension',[1 2]);

%% run bootstrap mean difference test
roi_AUC_RITE = get_trace_AUC(CaMKII_RITE);
roi_AUC_IONCC = get_trace_AUC(CaMKII_Ion_CC);
roi_AUC_SHAM = get_trace_AUC(CaMKII_all_SHAM);

% group all the data by experimental group
auc_rois = cell(size(roi_AUC_RITE,2));
for i=1:size(roi_AUC_RITE,2)
    for j=1:size(roi_AUC_RITE,1)
        auc_rois{1,i} = [auc_rois{1,i}, roi_AUC_RITE{j,i}];
    end
    for j=1:size(roi_AUC_IONCC,1)
        auc_rois{2,i} = [auc_rois{2,i}, roi_AUC_IONCC{j,i}];
    end
    for j=1:size(roi_AUC_SHAM,1)
        auc_rois{3,i} = [auc_rois{3,i}, roi_AUC_SHAM{j,i}];
    end
end


num_shuffles = 10000;

p_d1_RITE_IONCC = bootstrap_mean_diff(auc_rois{1,1}, auc_rois{2,1}, num_shuffles);
p_d1_RITE_SHAM = bootstrap_mean_diff(auc_rois{1,1}, auc_rois{3,1}, num_shuffles);
p_d1_IONCC_SHAM = bootstrap_mean_diff(auc_rois{2,1}, auc_rois{3,1}, num_shuffles);

p_d2_RITE_IONCC = bootstrap_mean_diff(auc_rois{1,2}, auc_rois{2,2}, num_shuffles);
p_d2_RITE_SHAM = bootstrap_mean_diff(auc_rois{1,2}, auc_rois{3,2}, num_shuffles);
p_d2_IONCC_SHAM = bootstrap_mean_diff(auc_rois{2,2}, auc_rois{3,2}, num_shuffles);

p_d3_RITE_IONCC = bootstrap_mean_diff(auc_rois{1,3}, auc_rois{2,3}, num_shuffles);
p_d3_RITE_SHAM = bootstrap_mean_diff(auc_rois{1,3}, auc_rois{3,3}, num_shuffles);
p_d3_IONCC_SHAM = bootstrap_mean_diff(auc_rois{2,3}, auc_rois{3,3}, num_shuffles);

bonferroni_alpha = 0.05 / 9;

%%



function [frac_global,num_transients,global_AUC,ind_AUC,sum_events,tot_AUC,trace_AUC] = group_graphs(file_list, norm_res)

    frac_global = zeros(length(file_list),5);
    num_transients = zeros(length(file_list),5);
    global_AUC = zeros(length(file_list),5);
    ind_AUC = zeros(length(file_list),5);
    sum_events = zeros(length(file_list),5);
    tot_AUC = zeros(length(file_list),5);
    trace_AUC = zeros(length(file_list),5);
    global_AUC_n = cell(length(file_list),5);
    ind_AUC_n = cell(length(file_list),5);
    num_transients_n = cell(length(file_list),5);
    frac_global_n = cell(length(file_list),5);
    num_frames = zeros(length(file_list),5);
    
    for i=1:length(file_list)
        disp(file_list(i));
        [frac_global(i,:),num_transients(i,:),global_AUC(i,:),ind_AUC(i,:),sum_events(i,:),tot_AUC(i,:),trace_AUC(i,:), global_AUC_all, ind_AUC_all, num_transients_neurons, frac_global_neurons, num_frames(i,:)] = plot_CORR(file_list{i}, sprintf('Dlx Com-TN %d',i));
        for j=1:5
            global_AUC_n{i,j} = global_AUC_all{j};
            ind_AUC_n{i,j} = ind_AUC_all{j};
            num_transients_n{i,j} = num_transients_neurons{j};
            frac_global_n{i,j} = frac_global_neurons{j};
        end
    end
   
    
    figure();
    ax1 = subplot(4,2,1);
%     plot(frac_global','LineWidth',2,'Color','#CCCCCC');
    plot(ax1,[1,2,3,4,5], mean(frac_global),'LineWidth',3, 'Color', '#FF0000');
    hold on;
    plot_shade(ax1, [1,2,3,4,5], frac_global', '#FF0000');
%     plot(mean(frac_global) ,'LineWidth',3, 'Color', 'k');
    title('Fraction global');
    hold off;
    

    ylim([0,1]);
    xticks([1,2,3,4,5]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21'});
    xtickangle(45);

    ax1.LineWidth = 2;
    ax1.Box = false;
    ax1.TickDir = 'out';

    ax2 = subplot(4,2,2);
    plot(num_transients','LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(nanmean(num_transients) ,'LineWidth',3, 'Color', 'k');
    title('Number of transients');
    hold off;

    ylim([0,100]);
    xticks([1,2,3]);
    xticklabels({'Day 0';'Day 3';'Day 7'});
    xtickangle(45);

    ax2.LineWidth = 2;
    ax2.Box = false;
    ax2.TickDir = 'out';

    
    ax3 = subplot(4,2,3);
    plot(global_AUC','LineWidth',2,'Color','#CCCCCC');
    hold on;
%     plot(nanmean(global_AUC) ,'LineWidth',3, 'Color', 'g');
    errorbar(mean(global_AUC,1), std(global_AUC,1)/sqrt(5) ,'LineWidth',3, 'Color', '#10D600');
    title('AUC global');
    hold off;

    ylim([0,100]);
    xticks([1,2,3,4,5]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21'});
    xtickangle(45);

    ax3.LineWidth = 2;
    ax3.Box = false;
    ax3.TickDir = 'out';

    

    ax4 = subplot(4,2,4);
    plot(ind_AUC','LineWidth',2,'Color','#CCCCCC');
    hold on;
%     plot(nanmean(ind_AUC) ,'LineWidth',3, 'Color', 'r');
    errorbar(mean(ind_AUC,1), std(ind_AUC,1)/sqrt(5) ,'LineWidth',3, 'Color', 'r');
    title('AUC independent');
    hold off;

    ylim([0,100]);
    xticks([1,2,3,4,5]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21'});
    xtickangle(45);

    ax4.LineWidth = 2;
    ax4.Box = false;
    ax4.TickDir = 'out';

    

    if norm_res == true
        for i=1:size(trace_AUC,1)
            trace_AUC(i,:) = trace_AUC(i,:)/max(trace_AUC(i,:));
        end
    end
    ax5 = subplot(4,2,5);
    plot(trace_AUC','LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(nanmean(trace_AUC) ,'LineWidth',3, 'Color', 'k');
    title('Trace AUC');
    hold off;

%     ylim([0,1]);
    xticks([1,2,3]);
    xticklabels({'Day 0';'Day 3';'Day 7'});
    xtickangle(45);

    ax5.LineWidth = 2;
    ax5.Box = false;
    ax5.TickDir = 'out';

    
    if norm_res == true
        for i=1:size(tot_AUC,1)
            tot_AUC(i,:) = tot_AUC(i,:)/max(tot_AUC(i,:));
        end
    end
    ax6 = subplot(4,2,6);
    plot(tot_AUC','LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(nanmean(tot_AUC) ,'LineWidth',3, 'Color', 'k');
    title('total AUC');
    hold off;

    %     ylim([0,2000]);
    xticks([1,2,3]);
    xticklabels({'Day 0';'Day 3';'Day 7'});
    xtickangle(45);

    ax6.LineWidth = 2;
    ax6.Box = false;
    ax6.TickDir = 'out';
    
    ax7 = subplot(4,2,7);
    if norm_res == true
        norm_AUC_ind = ind_AUC ./ (ind_AUC + global_AUC);
        norm_AUC_glob = global_AUC ./ (ind_AUC + global_AUC);
%         errorbar(mean(norm_AUC_ind,1), std(norm_AUC_ind,1)/sqrt(5) ,'LineWidth',3, 'Color', 'r');
        plot(ax7,[1,2,3,4,5,6], mean(norm_AUC_ind),'LineWidth',3, 'Color', '#10D600');
        hold on;
        plot(ax7,[1,2,3,4,5,6], mean(norm_AUC_glob),'LineWidth',3, 'Color', 'r');
        plot_shade(ax7, [1,2,3,4,5,6], norm_AUC_ind', '#10D600');
        plot_shade(ax7, [1,2,3,4,5,6], norm_AUC_glob', '#FF0000');
%         errorbar(mean(norm_AUC_glob,1), std(norm_AUC_glob,1)/sqrt(5) ,'LineWidth',3, 'Color', '#10D600');
        title('AUC global');
        hold off;
        ax7.Box = false;
        ax7.TickDir = 'out';
    else
        errorbar(mean(ind_AUC,1), std(ind_AUC,1)/sqrt(5) ,'LineWidth',3, 'Color', 'r');
        hold on;
        errorbar(mean(global_AUC,1), std(global_AUC,1)/sqrt(5) ,'LineWidth',3, 'Color', '#10D600');
        title('AUC global');
        hold off;
        ax7.Box = false;
        ax7.TickDir = 'out';
    end
    
%     ax8 = subplot(4,2,8);
%     glob_event_rate = (frac_global .* num_transients * 5.5 * 60) ./ num_frames; 
%     plot(glob_event_rate','LineWidth',2, 'Color', '#CCCCCC')
%     hold on;
%     errorbar(mean(glob_event_rate,1), std(glob_event_rate,1)/sqrt(size(glob_event_rate,1)) ,'LineWidth',3, 'Color', 'r');
%     hold off;
%     disp('test');
%     ylim([0,1]);
%     ax8.LineWidth = 2;
%     ax8.Box = false;
%     ax8.TickDir = 'out';
    
%     ax8 = subplot(4,2,8);
%     scatter_colors = ["#FF2908", "#AFFF20", "#20EEFF", "#3B22FF", "#FE26FF"];
%     
%     hold on;
%     
%     days = [4,6,4,4,3];
%     x_fitvals = num_transients_n{1,days(1)}(~isnan(frac_global_n{1,days(1)}));
%     x_fitvals = (x_fitvals - min(x_fitvals)) / (max(x_fitvals) - min(x_fitvals));
%     y_fitvals = frac_global_n{1,days(1)}(~isnan(frac_global_n{1,days(1)}));
%     y_fitvals = y_fitvals / max(y_fitvals);
%     
%     scatter(x_fitvals, y_fitvals, 'MarkerEdgeColor', '#919396');
%     p = polyfit(x_fitvals, y_fitvals, 2);
%     x_fit = linspace(min(x_fitvals),max(x_fitvals));
%     y_fit = polyval(p,x_fit);
%     plot(x_fit,y_fit, 'Linewidth',2, 'Color', scatter_colors(1))
%     
%     for i=2:size(num_transients_n,1)
%         
%         x_fitvals = num_transients_n{i,days(i)}(~isnan(frac_global_n{i,days(i)}));
%         x_fitvals = x_fitvals / max(x_fitvals);
%         y_fitvals = frac_global_n{i,days(i)}(~isnan(frac_global_n{i,days(i)}));
%         y_fitvals = y_fitvals / max(y_fitvals);
%         p = polyfit(x_fitvals, y_fitvals, 2);
%         x_fit = linspace(min(x_fitvals),max(x_fitvals));
%         y_fit = polyval(p,x_fit);
%         scatter(x_fitvals, y_fitvals, 'MarkerEdgeColor', '#919396')
%         plot(x_fit,y_fit, 'Linewidth',2, 'Color', scatter_colors(i))
%     end
%     hold off;
%     set(ax8,'box','off','color','none', 'TickDir','out', 'fontsize',14);

    
end

function trace_AUC = get_trace_AUC(plot_files)
    auc_data = cell(length(plot_files),1);
    trace_AUC = cell(length(plot_files),length(plot_files{1}));
    
    for i=1:length(plot_files)
        for j=1:length(plot_files{i})
            auc_data{i} = load(strcat(plot_files{i}{j},'_AUC.mat'));
            trace_AUC{i,j} = auc_data{i}.AUC_fulltrace;
        end
    end
end

function [frac_global,num_transients,global_AUC,ind_AUC,sum_events, tot_AUC, trace_AUC, global_AUC_neurons, ind_AUC_neurons, num_transients_neurons, frac_global_neurons, num_frames] = plot_CORR(plot_files, plot_title)

    auc_data = cell(length(plot_files),1);
    roi_data = cell(length(plot_files),1);
    
    mean_frac_global = cell(length(plot_files),1);
    mean_num_transients = cell(length(plot_files),1);
    mean_num_ind_transients = cell(length(plot_files),1);
    mean_num_global_transients = cell(length(plot_files),1);
    global_AUC_neurons = cell(length(plot_files),1);
    ind_AUC_neurons = cell(length(plot_files),1);
    num_transients_neurons = cell(length(plot_files),1);
    frac_global_neurons = cell(length(plot_files),1);
    
    num_frames = [];   
    frac_global = [];
    num_transients = [];
    num_ind_transients = [];
    num_global_transients = [];
    global_AUC = [];
    ind_AUC = [];
    sum_events = [];
    tot_AUC = [];
    trace_AUC = [];
    
    for i=1:length(plot_files)
         if ~strcmp(plot_files{i}, '')
            disp(plot_files{i});
            auc_data{i} = load(strcat(plot_files{i},'_AUC.mat'));
            roi_data{i} = load(strcat(plot_files{i},'_analyzed.mat'));
            

            event_count = zeros(size(roi_data{i}.foopsi_events));
            event_count(roi_data{i}.foopsi_events > 0.3) = 1; 
            sum_events = [sum_events, sum(sum( event_count ))];
            frac_global = [frac_global, nanmean(auc_data{i}.fraction_global_transients)];
            num_transients = [num_transients, nanmean(auc_data{i}.tot_num_transients)];
            num_ind_transients = [num_ind_transients, nanmean(auc_data{i}.tot_num_transients) - nanmean(auc_data{i}.num_global_transients)];
            num_global_transients = [num_global_transients, nanmean(auc_data{i}.num_global_transients)];

            global_AUC = [global_AUC, nanmean(auc_data{i}.tot_AUC_global)];
            ind_AUC = [ind_AUC, nanmean(auc_data{i}.tot_AUC_ind)];
            tot_AUC = [tot_AUC, nanmean(auc_data{i}.tot_AUC_ind) + nanmean(auc_data{i}.tot_AUC_global)];
            trace_AUC = [trace_AUC, nanmean(auc_data{i}.AUC_fulltrace)];
            
            global_AUC_neurons{i} = auc_data{i}.tot_AUC_global;
            ind_AUC_neurons{i} = auc_data{i}.tot_AUC_ind;
            num_transients_neurons{i} = auc_data{i}.tot_num_transients;
            frac_global_neurons{i} = auc_data{i}.fraction_global_transients;
            num_frames = [num_frames, length(auc_data{i}.fraction_active_time)];
            
         else
             global_AUC = [global_AUC, NaN];
             ind_AUC = [ind_AUC, NaN];
             frac_global = [frac_global, NaN];
             num_transients = [num_transients, NaN];
             sum_events = [sum_events, NaN];
             
         end

    end
    
    figure();
    ax1 = subplot(3,2,1);
    plot(ax1,frac_global);
    ylabel('fraction global');
    title(plot_title);
    
    ax2 = subplot(3,2,2);
    plot(ax2,num_transients);
    ylabel('total # of transients');
    
    ax3 = subplot(3,2,3);
    plot(ax3,global_AUC);
    ylabel('AUC of global transients');
    
    ax4 = subplot(3,2,4);
    plot(ax4,ind_AUC);
    ylabel('AUC of ind transients');
    
    ax5 = subplot(3,2,5);
    plot(ax5,sum_events);
    ylabel('sum of events');
    
    ax6 = subplot(3,2,6);
    plot(ax6,tot_AUC);
    ylabel('total AUC');
    
    close()
   

end

function plot_shade(ax, x_data, y_data, col)
%     str = '#FF0000';
    col2 = sscanf(col(2:end),'%2x%2x%2x',[1 3])/255;   % stupid fucking workaround for Matlab not being able to use hexcodes everywhere
    fill(ax, [x_data, fliplr(x_data)], [mean(y_data,2)' + (std(y_data,0,2)' ./ sqrt(length(y_data))'), fliplr(mean(y_data,2)' - (std(y_data,0,2)' ./ sqrt(length(y_data))'))], col2, 'FaceAlpha',.3, 'EdgeColor','none');
end