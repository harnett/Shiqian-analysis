%% Load datapaths 

CaMKII_RITE = ...
      {{'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII\RITE/Mouse 1/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII\RITE/Mouse 1/day 3/T3';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 1/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 1/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 1/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 1/day 28/T28'},...
       {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 2/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 2/day 3/T3';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 2/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 2/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 2/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 2/day 28/T28'},...
       {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 3/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 3/day 3/T3';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 3/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 3/day 14/day14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 3/day 21/day21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 3/day 28/T28'},...
       {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 4/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 4/day 3/T3';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 4/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 4/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 4/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 4/day 28/T28'},...
       {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 5/day 0/T0';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 5/day 3/T3';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 5/day 7/T7';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 5/day 14/T14';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 5/day 21/T21';...
        'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/RITE/Mouse 5/day 28/T28'}};
    
CaMKII_Ion_CC = ...
       {{'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 1/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 1/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 1/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 1/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 1/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 1/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 2/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 2/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 2/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 2/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 2/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 2/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 3/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 3/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 3/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 3/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 3/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 3/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 4/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 4/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 4/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 4/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 4/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 4/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 5/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 5/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 5/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 5/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 5/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 5/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 6/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 6/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 6/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 6/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 6/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/IoN-CCI/Mouse 6/day 28/T28'}};

CaMKII_all_SHAM = ...
       {{'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 1/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 1/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 1/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 1/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 1/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 1/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 2/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 2/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 2/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 2/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 2/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 2/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 3/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 3/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 3/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 3/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 3/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(Com-TN)/Mouse 3/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 4/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 4/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 4/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 4/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 4/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 4/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 5/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 5/day 3/T3_rigid';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 5/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 5/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 5/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 5/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 6/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 6/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 6/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 6/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 6/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Sham(IoN-CCI)/Mouse 6/day 28/T28'};...
        {'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Mouse 7/day 0/T0';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Mouse 7/day 3/T3';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Mouse 7/day 7/T7';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Mouse 7/day 14/T14';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Mouse 7/day 21/T21';...
         'C:\Users\lfisc\Work\Projects\Shiqian\final dataset\CaMKII/SHAM/Mouse 7/day 28/T28'}};


stat_stop = [1,-1];  

plot_3d_trajectories = true;

%% just make plots    
plot_CORR(CaMKII_RITE, 'RITE', [4], {[1,3300], [1,3300], [2000,5300], [1300,4600], [1,3300], [2000,5300]}, plot_3d_trajectories);
% plot_CORR(CaMKII_Ion_CC, 'IONCC', [4], {[1500,4800], [1,3300], [1,3300], [1,3300], [1,3300], [1500,4800]});
% plot_CORR(CaMKII_all_SHAM, 'SHAM', [1], [1,3300]);

%% make PCA distance analysis plot
[mean_corr_RITE, mean_dist_ne_RITE, mean_dist_e_RITE] = plot_CORR(CaMKII_RITE, 'RITE', [1,2,3,4,5], stat_stop, plot_3d_trajectories);

figure;
ax = subplot(1,1,1);
plot(nanmean(mean_dist_ne_RITE,1), 'Color', 'k');
% errorbar(nanmean(mean_dist_ne_RITE,1), std(mean_dist_ne_RITE,1)/sqrt(5) ,'LineWidth',4, 'Color', 'k');
% plot(ax, [2,3,4,5,6], nanmean(mean_dist_e_RITE(:,2:end),1),'LineWidth',4, 'Color', '#FF0000', 'MarkerSize', 10, 'Marker', 'o', 'MarkerFaceColor', '#FF0000', 'MarkerEdgeColor', 'none'); %, 'Marker', 's', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
hold on;
plot(ax, nanmean(mean_dist_ne_RITE,1),'LineWidth',4, 'Color', '#000000', 'MarkerSize', 10, 'Marker', 'o', 'MarkerFaceColor', '#000000', 'MarkerEdgeColor', 'none'); %, 'Marker', 's', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
plot_shade(ax, [2,3,4,5,6], mean_dist_e_RITE(:,2:end)', '#FF0000');
plot_shade(ax, [1,2,3,4,5,6], mean_dist_ne_RITE', '#000000');
plot(nanmean(mean_dist_e_RITE,1), 'Color', 'r');
errorbar(nanmean(mean_dist_e_RITE,1), std(mean_dist_e_RITE,1)/sqrt(5) ,'LineWidth',4, 'Color', 'r');
hold off;
box off;

xticks([1,2,3,4,5,6]);
xticklabels({'0','3','7','14','21','28'});
xlabel('Days post surgery');
xlim([0.8,6.2]);

xlabel('Distance to mean');

%% run correlation analysis
              
mean_corr_RITE = plot_CORR(CaMKII_RITE, 'RITE', [1,2,3,4,5], stat_stop, plot_3d_trajectories);
mean_corr_IONCC = plot_CORR(CaMKII_Ion_CC, 'IONCC', [1,2,3,4,5,6], stat_stop, plot_3d_trajectories);
mean_corr_SHAM = plot_CORR(CaMKII_all_SHAM, 'SHAM', [1,2,3,4,5,6,7] ,stat_stop, plot_3d_trajectories);


figure;
% errorbar(mean(mean_corr_RITE,1), std(mean_corr_RITE,1)/sqrt(5) ,'LineWidth',4, 'Color', 'r', 'CapSize',0); %, 'Marker', 's', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
% hold on;
% errorbar(mean(mean_corr_IONCC,1), std(mean_corr_IONCC,1)/sqrt(6) ,'LineWidth',4, 'Color', 'b', 'CapSize',0); % ,'Marker', '^', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
% errorbar(mean(mean_corr_SHAM,1), std(mean_corr_SHAM,1)/sqrt(7) ,'LineWidth',4, 'Color', '#008000', 'CapSize',0); % ,'Marker', 'o', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
% hold off;

ax = subplot(1,1,1);
plot(mean(mean_corr_RITE,1),'LineWidth',4, 'Color', '#FF0000', 'MarkerSize', 10, 'Marker', 'o', 'MarkerFaceColor', '#FF0000', 'MarkerEdgeColor', 'none'); %, 'Marker', 's', 'MarkerSize', 12, 'MarkerFaceColor', 'w'
hold on;
plot(mean(mean_corr_IONCC,1),'LineWidth',4, 'Color', '#0000FF', 'MarkerSize', 10, 'Marker', 'o', 'MarkerFaceColor', '#0000FF', 'MarkerEdgeColor', 'none');
plot(mean(mean_corr_SHAM,1),'LineWidth',4, 'Color', '#008000', 'MarkerSize', 10, 'Marker', 'o', 'MarkerFaceColor', '#008000', 'MarkerEdgeColor', 'none');
plot_shade(ax, [1,2,3,4,5,6], mean_corr_RITE', '#FF0000');
plot_shade(ax, [1,2,3,4,5,6], mean_corr_IONCC', '#0000FF');
plot_shade(ax, [1,2,3,4,5,6], mean_corr_SHAM', '#008000');
hold off;

box off;

pbaspect([2.2 1 1]);

ylabel('Correllation');
set(gca,'box','off','color','none', 'TickDir','out', 'fontsize',21,'linewidth',3);
yticks([0,0.1,0.2,0.3,0.4,0.5]);
yticklabels({'0','0.1','0.2','0.3','0.4','0.5'});
xticks([1,2,3,4,5,6]);
xticklabels({'0','3','7','14','21','28'});
xlabel('Days post surgery');
xlim([1,6]);

%%

y_vals = [reshape(mean_corr_RITE.',1,[]), reshape(mean_corr_IONCC.',1,[]), reshape(mean_corr_SHAM.',1,[])];
groups{1} = repmat({'d0','d3','d7','d14','d21','d28'}, 1, size(mean_corr_RITE,1) + size(mean_corr_IONCC,1) + size(mean_corr_SHAM,1));
groups{2} = [repmat({'RITE'}, 1, size(mean_corr_RITE(:),1)), repmat({'IONCC'}, 1, size(mean_corr_IONCC(:),1)), repmat({'SHAM'}, 1, size(mean_corr_SHAM(:),1)) ] ;

[p,tbl,stats] = anovan(y_vals, groups, 'model','interaction','varnames',{'Days','Groups'});
figure;
results = multcompare(stats,'Dimension',[1 2], 'CType' ,'bonferroni');

num_shuffles = 10000;

p_d1_RITE_IONCC = bootstrap_mean_diff(mean_corr_RITE(:,1), mean_corr_IONCC(:,1), num_shuffles);
p_d1_RITE_SHAM = bootstrap_mean_diff(mean_corr_RITE(:,1), mean_corr_SHAM(:,1), num_shuffles);
p_d1_IONCC_SHAM = bootstrap_mean_diff(mean_corr_IONCC(:,1), mean_corr_SHAM(:,1), num_shuffles);

p_d3_RITE_IONCC = bootstrap_mean_diff(mean_corr_RITE(:,2), mean_corr_IONCC(:,2), num_shuffles);
p_d3_RITE_SHAM = bootstrap_mean_diff(mean_corr_RITE(:,2), mean_corr_SHAM(:,2), num_shuffles);
p_d3_IONCC_SHAM = bootstrap_mean_diff(mean_corr_IONCC(:,2), mean_corr_SHAM(:,2), num_shuffles);
p_d3_RITE_ALLCONTROL = bootstrap_mean_diff(mean_corr_RITE(:,2), [mean_corr_IONCC(:,2);mean_corr_SHAM(:,2)], num_shuffles);

p_d7_RITE_IONCC = bootstrap_mean_diff(mean_corr_RITE(:,3), mean_corr_IONCC(:,3), num_shuffles);
p_d7_RITE_SHAM = bootstrap_mean_diff(mean_corr_RITE(:,3), mean_corr_SHAM(:,3), num_shuffles);
p_d7_IONCC_SHAM = bootstrap_mean_diff(mean_corr_IONCC(:,3), mean_corr_SHAM(:,3), num_shuffles);

p_d14_RITE_IONCC = bootstrap_mean_diff(mean_corr_RITE(:,4), mean_corr_IONCC(:,4), num_shuffles);
p_d14_RITE_SHAM = bootstrap_mean_diff(mean_corr_RITE(:,4), mean_corr_SHAM(:,4), num_shuffles);
p_d14_IONCC_SHAM = bootstrap_mean_diff(mean_corr_IONCC(:,4), mean_corr_SHAM(:,4), num_shuffles);

p_d21_RITE_IONCC = bootstrap_mean_diff(mean_corr_RITE(:,5), mean_corr_IONCC(:,5), num_shuffles);
p_d21_RITE_SHAM = bootstrap_mean_diff(mean_corr_RITE(:,5), mean_corr_SHAM(:,5), num_shuffles);
p_d21_IONCC_SHAM = bootstrap_mean_diff(mean_corr_IONCC(:,5), mean_corr_SHAM(:,5), num_shuffles);

p_d28_RITE_IONCC = bootstrap_mean_diff(mean_corr_RITE(:,6), mean_corr_IONCC(:,6), num_shuffles);
p_d28_RITE_SHAM = bootstrap_mean_diff(mean_corr_RITE(:,6), mean_corr_SHAM(:,6), num_shuffles);
p_d28_IONCC_SHAM = bootstrap_mean_diff(mean_corr_IONCC(:,6), mean_corr_SHAM(:,6), num_shuffles);

bonferroni_alpha = 0.05 / 18;


%%

function plot_shade(ax, x_data, y_data, col)
%     str = '#FF0000';
    col2 = sscanf(col(2:end),'%2x%2x%2x',[1 3])/255;   % stupid fucking workaround for Matlab not being able to use hexcodes everywhere
    fill(ax, [x_data, fliplr(x_data)], [mean(y_data,2)' + (std(y_data,0,2)' ./ sqrt(length(y_data))'), fliplr(mean(y_data,2)' - (std(y_data,0,2)' ./ sqrt(length(y_data))'))], col2, 'FaceAlpha',.3, 'EdgeColor','none');
end

function [mean_corr, mean_dist_nonevent_all, mean_dist_event_all] = plot_CORR(plot_files, prefix, process_files, start_stop, plot_3d_trajectories)
    plot_figs = true;
    mean_corr = zeros(length(plot_files),length(plot_files{1}));
    mean_dist_event_all = zeros(length(plot_files),length(plot_files{1}));
    mean_dist_nonevent_all = zeros(length(plot_files),length(plot_files{1}));
    
    corr_data = cell(length(plot_files),length(plot_files{1}));
    sess_data = cell(length(plot_files),length(plot_files{1}));
    auc_data = cell(length(plot_files),length(plot_files{1}));    
    
    for k=1:length(process_files)
        i = process_files(k);
        if plot_figs
            f = figure('Position',[10,10,1000,500]);
        end
        boxplot_data = [];
        boxplot_grouping = [];
        mean_dist_event = [];
        mean_dist_nonevent = [];
        mean_data = [];
        mean_SEM = [];
        mean_v_rate = cell(length(plot_files),1);
        heatmap_handles = cell(length(plot_files),1);
        for j=1:length(plot_files{i})
            corr_data{i}{j} = load(strcat(plot_files{i}{j},'_CORR.mat'));  
            auc_data{i}{j} = load(strcat(plot_files{i}{j},'_AUC.mat'));  
            sess_data{i}{j} = load(strcat(plot_files{i}{j},'_analyzed.mat'));
            [~,fname,~] = fileparts(strcat(plot_files{i}{j},'_CORR.mat'));
            
            if plot_figs
                set(f, 'NumberTitle', 'off', 'Name', strcat(prefix,'_',num2str(i),fname));
                ax = subplot(5,7,j);   % plot heatmap and set labels
%                 cm = gray;
%                 cm = flipud(cm);
%                 colormap(cm);
%                 colormap hot;
    
                if iscell(start_stop)
                    ss = start_stop{j};
                else
                    ss = start_stop;
                end

                if ss(1) == -1
                    from_x = 1;
                else
                    from_x = ss(1);
                end
                if ss(2) == -1
                    to_x = length(sess_data{i}{j}.dff_filtered_temp(:,1));
                else
                    to_x = ss(2);
                end

                imagesc(ax, sess_data{i}{j}.dff_filtered_temp(from_x:to_x,:)', [0.0, 0.8]); %max(max(sess_data{i}{j}.dff_filtered_temp))
                box off;
                set(ax,'XColor','none','YColor','none');
                pbaspect([2 1 1]);
                ax = subplot(5,7,7+j);   % plot heatmap and set labels
                
%                 colormap default;
                imagesc(ax, corr_data{i}{j}.pairwise_corr, [0 1]);
                box off;
                set(ax,'XColor','none','YColor','none');
                ylabel(ax,'Neuron #');
                xlabel(ax,'Neuron #');    
                pbaspect([1 1 1]);
                boxplot_grouping = [boxplot_grouping; j*ones(length(corr_data{i}{j}.pairwise_corr(:)),1)];
                boxplot_data = [boxplot_data; corr_data{i}{j}.pairwise_corr(:)];
                
                ax = subplot(5,7,14+j);
%                 plot(mean(sess_data{i}{j}.dff_filtered_temp'));
                plot(auc_data{i}{j}.fraction_active_time(from_x:to_x));
                set(ax,'box','off','color','none', 'TickDir','out');
                ylim([-0.2,1.2]);
                
                title(num2str(size(sess_data{i}{j}.dff_filtered_temp(from_x:to_x))));

                dff_pca = sess_data{i}{j}.dff_filtered_temp(from_x:to_x,:);
                for di=1:size(dff_pca,2)
                    dff_pca(:,di) = smooth(dff_pca(:,di), 10);
                    dff_pca(:,di) = (dff_pca(:,di) - min(dff_pca(:,di)))  / (max(dff_pca(:,di)) - min(dff_pca(:,di)));
                end
                if plot_3d_trajectories
                    ax = subplot(5,7,21+j);

                    dff_pca = downsample(dff_pca, 5);
                    dff_pca = dff_pca';
                    coeff = pca(dff_pca);
                    plot3(coeff(:,1),coeff(:,2),coeff(:,3),'k');
                    hold on;
                    frac_active_t = auc_data{i}{j}.fraction_active_time(from_x:to_x);
                    frac_active_t = downsample(frac_active_t, 5);
    %                 frac_act = frac_active_t > 0.6;
                    global_event_idx = find(frac_active_t > 0.5);


                    event_datapoints = [];
                    non_event_datapoints = [];
                    if length(global_event_idx) > 0
                        trace_start_stop = find(diff(global_event_idx) > 1);
                        t_start = [global_event_idx(1); global_event_idx(trace_start_stop+1)];
                        t_end = [global_event_idx(trace_start_stop); global_event_idx(end)];
    %                     scatter3(coeff(global_event_idx,1),coeff(global_event_idx,2),coeff(global_event_idx,3),'MarkerEdgeColor','r');
                        for t=1:length(t_start)
                            plot3(coeff(t_start(t):t_end(t),1),coeff(t_start(t):t_end(t),2),coeff(t_start(t):t_end(t),3), 'r', 'Linewidth',2);
                            event_datapoints = [event_datapoints; coeff(t_start(t):t_end(t),1),coeff(t_start(t):t_end(t),2),coeff(t_start(t):t_end(t),3)];
                        end
                        for t=1:length(t_start)
    %                         plot3(coeff(t_start(t):t_end(t),1),coeff(t_start(t):t_end(t),2),coeff(t_start(t):t_end(t),3), 'r', 'Linewidth',2);
                            if t==1
                                non_event_datapoints = [non_event_datapoints; coeff(1:t_start(t),1),coeff(1:t_start(t),2),coeff(1:t_start(t),3)];
                            elseif t < length(t_start)
                                non_event_datapoints = [non_event_datapoints; coeff(t_end(t-1):t_start(t),1),coeff(t_end(t-1):t_start(t),2),coeff(t_end(t-1):t_start(t),3)];
                            end
                        end
                        non_event_datapoints = [non_event_datapoints; coeff(t_end(end):end,1),coeff(t_end(end):end,2),coeff(t_end(end):end,3)];
                    else
                        non_event_datapoints = [coeff(:,1),coeff(:,2),coeff(:,3)];
                    end

                    xlabel('PCA 1');
                    ylabel('PCA 2');
                    zlabel('PCA 3');
    %                 xlim([-0.2,0.2,]);
    %                 ylim([-0.2,0.2,]);
    %                 zlim([-0.2,0.2,]);    
    %                 view(60,45);
                    hold off;
    %                 
                    coeff_mean = [nanmean(coeff(:,1)), nanmean(coeff(:,2)), nanmean(coeff(:,3))];
                    data_distance = non_event_datapoints - coeff_mean; % calculate the euclidian distance for each datapoint from the mean
                    nonevent_data_distance = sqrt(sum(data_distance.^2, 2));
                    mean_nonevent_data_distance = mean(nonevent_data_distance);

                    ax = subplot(5,7,28+j);
                    if length(global_event_idx) > 0
                        data_distance = event_datapoints - coeff_mean; % calculate the euclidian distance for each datapoint from the mean
                        event_data_distance = sqrt(sum(data_distance.^2, 2));
                        mean_event_data_distance = mean(event_data_distance);

                        boxplot_data = [nonevent_data_distance; event_data_distance];
                        g = [zeros(length(nonevent_data_distance),1); ones(length(event_data_distance),1)];
                        boxplot(boxplot_data, g, 'Colors','kr', 'Symbol','');

                        ylim([0,0.3]);
                        yticks([0,0.1,0.2,0.3]);
                        pbaspect([1 1 1]);
                        box off;

                        ranksum(nonevent_data_distance, event_data_distance)
                        dist_diff = [nanmedian(nonevent_data_distance), nanmedian(event_data_distance)];

                    else
                        dist_diff = [nanmedian(nonevent_data_distance), NaN];
                        event_data_distance = NaN;
                        mean_event_data_distance = NaN;
                    end
                end
            end
            
            if plot_figs
                mean_dist_event = [mean_dist_event, dist_diff(2)];
                mean_dist_nonevent = [mean_dist_nonevent, dist_diff(1)];
            end
            mean_data = [mean_data, nanmean(corr_data{i}{j}.pairwise_corr(:))];
            mean_SEM = nanstd(corr_data{i}{j}.pairwise_corr(:)) / sqrt(length(corr_data{i}{j}.pairwise_corr(:)));

             % regression of correlation vs. event rate
             mean_v_rate{i} = robustfit(corr_data{i}{j}.geom_mean(:), corr_data{i}{j}.geom_mean(:));
             
        end
        if plot_figs
             print(gcf,strcat("C:\Users\lfisc\Work\Projects\Shiqian\plotted_figures\",prefix,'_',num2str(i),fname,'.png'),'-dpng','-r600');
        end
        if plot_figs
            mean_dist_event_all(i,:) = mean_dist_event;
            mean_dist_nonevent_all(i,:) = mean_dist_nonevent;
        end
        mean_corr(i,:) = mean_data;
%         if plot_figs
%             corr_boxplot = subplot(3,6,[13,14]);
%             mean_plot = subplot(3,6,[16,16]);
%             geomean_vs_corr = subplot(3,6,[17,18]);
%         
%         
%             plot(mean_plot,mean_data);
% 
%             boxplot_data = [pwcorr1(:); pwcorr2(:)];
%             h = boxplot(corr_boxplot, boxplot_data, boxplot_grouping,'Colors','k', 'symbol','','Widths',0.5);
%             g = [zeros(length(pwcorr1(:)), 1); ones(length(pwcorr2(:)), 1)];
%             h = boxplot(corr_boxplot, boxplot_data, g, 'Colors','kr','symbol','','Widths',0.5);
%             hold(corr_boxplot,'on');
% 
%             set(h,{'linew'},{2});
% 
%             xticklabels(corr_boxplot,{'file1';'file2'});
%             xtickangle(corr_boxplot,45);
% 
%             ylabel(corr_boxplot,'Correlation (r)');
%             hold(corr_boxplot,'off')
%         end
    
    end
   
    
    
    
    
   %close;
    
%     scatter(geomean_vs_corr, geomean1(:), pwcorr1(:), 'MarkerEdgeColor', 'k');
%     hold(geomean_vs_corr,'on');
%     plot(geomean_vs_corr,geomean1(:),brob1(1)+brob1(2)*geomean1(:),'k');
%     scatter(geomean_vs_corr, geomean2(:), pwcorr2(:), 'MarkerEdgeColor', 'r');
%     plot(geomean_vs_corr,geomean2(:),brob2(1)+brob2(2)*geomean2(:),'r');
%     hold(geomean_vs_corr,'off');
end

% plot_files_sham_m1 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 0/T0_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 3/T3_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 7/T7_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 14/T14_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 21/T21_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 28/T28_CORR.mat';...
%                   };
% 
%     plot_files_sham_m2 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 0/T0_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 3/T3_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 7/T7_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 14/T14_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 21/T21_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 28/T28_CORR.mat';...
%                   };
%                           
%     plot_files_sham_m3 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 0/T0_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 3/T3_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 7/T7_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 14/T14_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 21/T21_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 28/T28_CORR.mat';...
%                   };
%               
%      plot_files_sham_m4 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 0/T0_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 3/T3_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 7/T7_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 14/T14_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 21/T21_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 28/T28_CORR.mat';...
%                   };
% 
%     plot_files_sham_m5 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 0/T0_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 3/T3_rigid_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 7/T7_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 14/T14_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 21/T21_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 28/T28_CORR.mat';...
%                   };
%                           
%     plot_files_sham_m6 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 0/T0_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 3/T3_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 7/T7_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 14/T14_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 21/T21_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 28/T28_CORR.mat';...
%                   };
% 
% 
%               
%               
%               
%     plot_files_ioncc_m1 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 0/T0_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 3/T3_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 7/T7_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 14/T14_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 21/T21_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 28/T28_CORR.mat';...
%                   };
% 
%     plot_files_ioncc_m2 = { '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 0/T0_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 3/T3_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 7/T7_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 14/T14_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 21/T21_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 28/T28_CORR.mat';...
%                   };
%                           
%     plot_files_ioncc_m3 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 0/T0_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 3/T3_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 7/T7_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 14/T14_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 21/T21_CORR.mat';...
%                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 28/T28_CORR.mat';...
%                   };
% 
% 
%     plot_files_comtn_m1 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 0/T0_rigid_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 3/T3_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 7/T7_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 14/T14_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 21/T21_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 28/T28_CORR.mat';...
%                   };
% 
%     plot_files_comtn_m2 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 0/T0_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 3/T3_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 7/T7_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 14/T14_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 21/T21_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 28/T28_CORR.mat';...
%                   };
%                           
%     plot_files_comtn_m3 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 0/T0_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 3/T3_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 7/T7_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 14/day14_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 21/day21_CORR.mat';...
%                   '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 28/T28_CORR.mat';...
%                   };


% figure();
% corr_ax = subplot(1,1,1);
% plot(mean_data_comtn_m1,'LineWidth',2,'Color','#CCCCCC');
% hold on;
% plot(mean_data_comtn_m2,'LineWidth',2,'Color','#CCCCCC');
% plot(mean_data_comtn_m3,'LineWidth',2,'Color','#CCCCCC');
% plot(mean([mean_data_comtn_m1;mean_data_comtn_m2;mean_data_comtn_m3]) ,'LineWidth',3, 'Color', 'k');
% hold off;
% 
% ylim([0,0.5]);
% xticks([1,2,3,4,5,6]);
% xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
% xtickangle(45);
% 
% corr_ax.LineWidth = 2;
% corr_ax.Box = false;
% corr_ax.TickDir = 'out';
% 
% 
% [mean_data_ioncc_m1,mean_SEM_ioncc_m1] = plot_CORR(plot_files_ioncc_m1);
% [mean_data_ioncc_m2,mean_SEM_ioncc_m2] = plot_CORR(plot_files_ioncc_m2);
% [mean_data_ioncc_m3,mean_SEM_ioncc_m3] = plot_CORR(plot_files_ioncc_m3);
% 
% figure();
% corr_ax = subplot(1,1,1);
% plot(mean_data_ioncc_m1,'LineWidth',2,'Color','#CCCCCC');
% hold on;
% plot(mean_data_ioncc_m2,'LineWidth',2,'Color','#CCCCCC');
% plot(mean_data_ioncc_m3,'LineWidth',2,'Color','#CCCCCC');
% plot(mean([mean_data_ioncc_m1;mean_data_ioncc_m2;mean_data_ioncc_m3]),'LineWidth',3, 'Color', 'k');
% hold off;
% 
% ylim([0,0.5]);
% xticks([1,2,3,4,5,6]);
% xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
% xtickangle(45);
% 
% corr_ax.LineWidth = 2;
% corr_ax.Box = false;
% corr_ax.TickDir = 'out';
% 
% 
% 
% 
% [mean_data_sham_m1,mean_SEM_sham_m1] = plot_CORR(plot_files_sham_m1);
% [mean_data_sham_m2,mean_SEM_sham_m2] = plot_CORR(plot_files_sham_m2);
% [mean_data_sham_m3,mean_SEM_sham_m3] = plot_CORR(plot_files_sham_m3);
% [mean_data_sham_m4,mean_SEM_sham_m4] = plot_CORR(plot_files_sham_m4);
% [mean_data_sham_m5,mean_SEM_sham_m5] = plot_CORR(plot_files_sham_m5);
% [mean_data_sham_m6,mean_SEM_sham_m6] = plot_CORR(plot_files_sham_m6);
% 
% figure();
% corr_ax = subplot(1,1,1);
% plot(mean_data_sham_m1,'LineWidth',2,'Color','#CCCCCC');
% hold on;
% plot(mean_data_sham_m2,'LineWidth',2,'Color','#CCCCCC');
% plot(mean_data_sham_m3,'LineWidth',2,'Color','#CCCCCC');
% plot(mean_data_sham_m4,'LineWidth',2,'Color','#CCCCCC');
% plot(mean_data_sham_m5,'LineWidth',2,'Color','#CCCCCC');
% plot(mean_data_sham_m6,'LineWidth',2,'Color','#CCCCCC');
% plot(mean([mean_data_sham_m1;mean_data_sham_m2;mean_data_sham_m3;mean_data_sham_m4;mean_data_sham_m5;mean_data_sham_m6]),'LineWidth',3, 'Color', 'k');
% hold off;
% 
% ylim([0,0.5]);
% xticks([1,2,3,4,5,6]);
% xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
% xtickangle(45);
% 
% corr_ax.LineWidth = 2;
% corr_ax.Box = false;
% corr_ax.TickDir = 'out';
% 
% figure();
% corr_ax = subplot(1,1,1);
% errorbar(mean([mean_data_comtn_m1;mean_data_comtn_m2;mean_data_comtn_m3]), std([mean_data_comtn_m1;mean_data_comtn_m2;mean_data_comtn_m3])/sqrt(3) ,'LineWidth',3, 'Color', 'r');
% hold on;
% errorbar(mean([mean_data_ioncc_m1;mean_data_ioncc_m2;mean_data_ioncc_m3]), std([mean_data_ioncc_m1;mean_data_ioncc_m2;mean_data_ioncc_m3])/sqrt(3) ,'LineWidth',3, 'Color', 'b');
% errorbar(mean([mean_data_sham_m1;mean_data_sham_m2;mean_data_sham_m3;mean_data_sham_m4;mean_data_sham_m5;mean_data_sham_m6]),...
%           std([mean_data_sham_m1;mean_data_sham_m2;mean_data_sham_m3;mean_data_sham_m4;mean_data_sham_m5;mean_data_sham_m6])/sqrt(6) ,'LineWidth',3, 'Color', 'k');
% hold off;
% 
% ylim([0,0.5]);
% xticks([1,2,3,4,5,6]);
% xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
% xtickangle(45);
% 
% corr_ax.LineWidth = 2;
% corr_ax.Box = false;
% corr_ax.TickDir = 'out';
% 
% [~,p1] = ttest2([mean_data_comtn_m1(1);mean_data_comtn_m2(1);mean_data_comtn_m3(1)], [mean_data_ioncc_m1(1);mean_data_ioncc_m2(1);mean_data_ioncc_m3(1)])
% [~,p4] = ttest2([mean_data_comtn_m1(4);mean_data_comtn_m2(4);mean_data_comtn_m3(4)], [mean_data_ioncc_m1(4);mean_data_ioncc_m2(4);mean_data_ioncc_m3(4)])
% [~,p5] = ttest2([mean_data_comtn_m1(5);mean_data_comtn_m2(5);mean_data_comtn_m3(5)], [mean_data_ioncc_m1(5);mean_data_ioncc_m2(5);mean_data_ioncc_m3(5)])
% [~,p5] = ttest2([mean_data_comtn_m1(6);mean_data_comtn_m2(6);mean_data_comtn_m3(6)], [mean_data_ioncc_m1(6);mean_data_ioncc_m2(6);mean_data_ioncc_m3(6)])
% 
% [~,p1] = ttest2([mean_data_comtn_m1(1);mean_data_comtn_m2(1);mean_data_comtn_m3(1)], [mean_data_sham_m1(1);mean_data_sham_m2(1);mean_data_sham_m3(1);mean_data_sham_m4(1);mean_data_sham_m5(1);mean_data_sham_m6(1)])
% [~,p4] = ttest2([mean_data_comtn_m1(4);mean_data_comtn_m2(4);mean_data_comtn_m3(4)], [mean_data_sham_m1(4);mean_data_sham_m2(4);mean_data_sham_m3(4);mean_data_sham_m4(4);mean_data_sham_m5(4);mean_data_sham_m6(4)])
% [~,p5] = ttest2([mean_data_comtn_m1(5);mean_data_comtn_m2(5);mean_data_comtn_m3(5)], [mean_data_sham_m1(5);mean_data_sham_m2(5);mean_data_sham_m3(5);mean_data_sham_m4(5);mean_data_sham_m5(5);mean_data_sham_m6(5)])
% [~,p5] = ttest2([mean_data_comtn_m1(6);mean_data_comtn_m2(6);mean_data_comtn_m3(6)], [mean_data_sham_m1(6);mean_data_sham_m2(6);mean_data_sham_m3(6);mean_data_sham_m4(6);mean_data_sham_m5(6);mean_data_sham_m6(6)])
