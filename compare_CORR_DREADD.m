%% Load datapaths
Gi_pre = ...
        {{'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Gi/Before/Mouse 1/7'};...
         {'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Gi/Before/Mouse 2/9'};...
         {'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Gi/Before/Mouse 3/11'}};
Gi_post = ...    
        {{'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Gi/After/Mouse 1/8'};...
         {'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Gi/After/Mouse 2/10'};...
         {'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Gi/After/Mouse 3/12'}};

CONTROL_pre = ...
            {{'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Control/Before CNO/Mouse 1/1'};...
             {'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Control/Before CNO/Mouse 2/3'};...
             {'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Control/Before CNO/Mouse 3/5'}};   
 
CONTROL_post = ... 
            {{'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Control/After CNO/Mouse 1/2'};...
             {'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Control/After CNO/Mouse 2/4'};...
             {'C:\Users\lfisc\Work\Projects\Shiqian\DREADD/Control/After CNO/Mouse 3/6'}};

%% run correlation analysis


mean_CONTROL_pre = plot_CORR(CONTROL_pre, 'CTRL_pre');
mean_CONTROL_post = plot_CORR(CONTROL_post, 'CTRL_post');

mean_Gi_pre = plot_CORR(Gi_pre, 'Gi_pre');
mean_Gi_post = plot_CORR(Gi_post, 'Gi_post');

pre_post_CONTROL = [mean_CONTROL_pre, mean_CONTROL_post];
pre_post_Gi = [mean_Gi_pre, mean_Gi_post];

figure('Position',[10,10,200,400]);
set(gcf, 'renderer', 'painters')
ax1 = subplot(1,1,1);
% errorbar(mean(pre_post_combined,1), std(pre_post_combined,1)/sqrt(4) ,'LineWidth',3, 'Color', 'r');
plot(pre_post_Gi', 'Marker','o','MarkerFaceColor','w','MarkerSize',10, 'Color', '#E1C7E2','LineWidth',3);
hold on;
errorbar([mean(pre_post_Gi(:,1)), mean(pre_post_Gi(:,2))], [std(pre_post_Gi(:,1))/sqrt(3), std(pre_post_Gi(:,2))/sqrt(3)],...
            'Marker','o','MarkerFaceColor','w','MarkerSize',10, 'Color', '#AA00AA','LineWidth',3);


% set(ax1,'box','off','color','none', 'TickDir','out', 'fontsize',14);
% ylim([0,0.8]);
% ylabel('Pairwise correlation')
% xlim([0.9,2.1]);
% xticks([1,2]);
% xticklabels({'pre', 'post'});
% xtickangle(45);
% title('DREADD Gi');

% ax2 = subplot(1,2,2);
plot(pre_post_CONTROL', 'Marker','o','MarkerFaceColor','w','MarkerSize',10, 'Color', '#C4C4C4','LineWidth',3);

errorbar([mean(pre_post_CONTROL(:,1)), mean(pre_post_CONTROL(:,2))], [std(pre_post_CONTROL(:,1))/sqrt(3), std(pre_post_CONTROL(:,2))/sqrt(3)],...
             'Marker','o','MarkerFaceColor','w','MarkerSize',10, 'Color', 'k','LineWidth',3);
hold off;

set(ax1,'box','off','color','none', 'TickDir','out', 'fontsize',14);
ylim([0,0.8]);
xlim([0.9,2.1]);
xticks([1,2]);
xticklabels({'pre', 'post'});
xtickangle(45);
title('Control');

num_shuffles = 10000;

p_CONTROL = bootstrap_mean_diff(pre_post_CONTROL(:,1), pre_post_CONTROL(:,2), num_shuffles);
p_Gi = bootstrap_mean_diff(pre_post_Gi(:,1), pre_post_Gi(:,2), num_shuffles);

bonferroni_alpha = 0.05 / 2;

[~,p_ctrl] = ttest(pre_post_CONTROL(:,1), pre_post_CONTROL(:,2))
[~,p_dreadd] = ttest(pre_post_Gi(:,1), pre_post_Gi(:,2))




%%

figure();
corr_ax = subplot(1,1,1);
plot(mean_data_comtn_m1,'LineWidth',2,'Color','#CCCCCC');
hold on;
plot(mean_data_comtn_m2,'LineWidth',2,'Color','#CCCCCC');
plot(mean_data_comtn_m3,'LineWidth',2,'Color','#CCCCCC');
plot(mean([mean_data_comtn_m1;mean_data_comtn_m2;mean_data_comtn_m3]) ,'LineWidth',3, 'Color', 'k');
hold off;

ylim([0,0.5]);
xticks([1,2,3,4,5,6]);
xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
xtickangle(45);

corr_ax.LineWidth = 2;
corr_ax.Box = false;
corr_ax.TickDir = 'out';


[mean_data_ioncc_m1,mean_SEM_ioncc_m1] = plot_CORR(plot_files_ioncc_m1);
[mean_data_ioncc_m2,mean_SEM_ioncc_m2] = plot_CORR(plot_files_ioncc_m2);
[mean_data_ioncc_m3,mean_SEM_ioncc_m3] = plot_CORR(plot_files_ioncc_m3);

figure();
corr_ax = subplot(1,1,1);
plot(mean_data_ioncc_m1,'LineWidth',2,'Color','#CCCCCC');
hold on;
plot(mean_data_ioncc_m2,'LineWidth',2,'Color','#CCCCCC');
plot(mean_data_ioncc_m3,'LineWidth',2,'Color','#CCCCCC');
plot(mean([mean_data_ioncc_m1;mean_data_ioncc_m2;mean_data_ioncc_m3]),'LineWidth',3, 'Color', 'k');
hold off;

ylim([0,0.5]);
xticks([1,2,3,4,5,6]);
xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
xtickangle(45);

corr_ax.LineWidth = 2;
corr_ax.Box = false;
corr_ax.TickDir = 'out';




[mean_data_sham_m1,mean_SEM_sham_m1] = plot_CORR(plot_files_sham_m1);
[mean_data_sham_m2,mean_SEM_sham_m2] = plot_CORR(plot_files_sham_m2);
[mean_data_sham_m3,mean_SEM_sham_m3] = plot_CORR(plot_files_sham_m3);
[mean_data_sham_m4,mean_SEM_sham_m4] = plot_CORR(plot_files_sham_m4);
[mean_data_sham_m5,mean_SEM_sham_m5] = plot_CORR(plot_files_sham_m5);
[mean_data_sham_m6,mean_SEM_sham_m6] = plot_CORR(plot_files_sham_m6);

figure();
corr_ax = subplot(1,1,1);
plot(mean_data_sham_m1,'LineWidth',2,'Color','#CCCCCC');
hold on;
plot(mean_data_sham_m2,'LineWidth',2,'Color','#CCCCCC');
plot(mean_data_sham_m3,'LineWidth',2,'Color','#CCCCCC');
plot(mean_data_sham_m4,'LineWidth',2,'Color','#CCCCCC');
plot(mean_data_sham_m5,'LineWidth',2,'Color','#CCCCCC');
plot(mean_data_sham_m6,'LineWidth',2,'Color','#CCCCCC');
plot(mean([mean_data_sham_m1;mean_data_sham_m2;mean_data_sham_m3;mean_data_sham_m4;mean_data_sham_m5;mean_data_sham_m6]),'LineWidth',3, 'Color', 'k');
hold off;

ylim([0,0.5]);
xticks([1,2,3,4,5,6]);
xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
xtickangle(45);

corr_ax.LineWidth = 2;
corr_ax.Box = false;
corr_ax.TickDir = 'out';

figure();
corr_ax = subplot(1,1,1);
errorbar(mean([mean_data_comtn_m1;mean_data_comtn_m2;mean_data_comtn_m3]), std([mean_data_comtn_m1;mean_data_comtn_m2;mean_data_comtn_m3])/sqrt(3) ,'LineWidth',3, 'Color', 'r');
hold on;
errorbar(mean([mean_data_ioncc_m1;mean_data_ioncc_m2;mean_data_ioncc_m3]), std([mean_data_ioncc_m1;mean_data_ioncc_m2;mean_data_ioncc_m3])/sqrt(3) ,'LineWidth',3, 'Color', 'b');
errorbar(mean([mean_data_sham_m1;mean_data_sham_m2;mean_data_sham_m3;mean_data_sham_m4;mean_data_sham_m5;mean_data_sham_m6]),...
          std([mean_data_sham_m1;mean_data_sham_m2;mean_data_sham_m3;mean_data_sham_m4;mean_data_sham_m5;mean_data_sham_m6])/sqrt(6) ,'LineWidth',3, 'Color', 'k');
hold off;

ylim([0,0.5]);
xticks([1,2,3,4,5,6]);
xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
xtickangle(45);

corr_ax.LineWidth = 2;
corr_ax.Box = false;
corr_ax.TickDir = 'out';

[~,p1] = ttest2([mean_data_comtn_m1(1);mean_data_comtn_m2(1);mean_data_comtn_m3(1)], [mean_data_ioncc_m1(1);mean_data_ioncc_m2(1);mean_data_ioncc_m3(1)])
[~,p4] = ttest2([mean_data_comtn_m1(4);mean_data_comtn_m2(4);mean_data_comtn_m3(4)], [mean_data_ioncc_m1(4);mean_data_ioncc_m2(4);mean_data_ioncc_m3(4)])
[~,p5] = ttest2([mean_data_comtn_m1(5);mean_data_comtn_m2(5);mean_data_comtn_m3(5)], [mean_data_ioncc_m1(5);mean_data_ioncc_m2(5);mean_data_ioncc_m3(5)])
[~,p5] = ttest2([mean_data_comtn_m1(6);mean_data_comtn_m2(6);mean_data_comtn_m3(6)], [mean_data_ioncc_m1(6);mean_data_ioncc_m2(6);mean_data_ioncc_m3(6)])

[~,p1] = ttest2([mean_data_comtn_m1(1);mean_data_comtn_m2(1);mean_data_comtn_m3(1)], [mean_data_sham_m1(1);mean_data_sham_m2(1);mean_data_sham_m3(1);mean_data_sham_m4(1);mean_data_sham_m5(1);mean_data_sham_m6(1)])
[~,p4] = ttest2([mean_data_comtn_m1(4);mean_data_comtn_m2(4);mean_data_comtn_m3(4)], [mean_data_sham_m1(4);mean_data_sham_m2(4);mean_data_sham_m3(4);mean_data_sham_m4(4);mean_data_sham_m5(4);mean_data_sham_m6(4)])
[~,p5] = ttest2([mean_data_comtn_m1(5);mean_data_comtn_m2(5);mean_data_comtn_m3(5)], [mean_data_sham_m1(5);mean_data_sham_m2(5);mean_data_sham_m3(5);mean_data_sham_m4(5);mean_data_sham_m5(5);mean_data_sham_m6(5)])
[~,p5] = ttest2([mean_data_comtn_m1(6);mean_data_comtn_m2(6);mean_data_comtn_m3(6)], [mean_data_sham_m1(6);mean_data_sham_m2(6);mean_data_sham_m3(6);mean_data_sham_m4(6);mean_data_sham_m5(6);mean_data_sham_m6(6)])


function mean_corr = plot_CORR(plot_files, prefix)
    plot_figs = true;
    mean_corr = zeros(length(plot_files),length(plot_files{1}));

    corr_data = cell(length(plot_files),length(plot_files{1}));
    sess_data = cell(length(plot_files),length(plot_files{1}));
    for i=1:length(plot_files)
        if plot_figs
            f = figure();
        end
        boxplot_data = [];
        boxplot_grouping = [];
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
                ax = subplot(3,1,1);   % plot heatmap and set labels
                imagesc(ax, sess_data{i}{j}.dff_filtered_temp(1:3300,:)', [0, 0.8]); %max(max(sess_data{i}{j}.dff_filtered_temp))
                box off;
                set(ax,'XColor','none','YColor','none');
                pbaspect([2 1 1]);
                ax2 = subplot(3,1,1+j);   % plot heatmap and set labels
                imagesc(ax2, corr_data{i}{j}.pairwise_corr, [0 1]);
                box off;
                set(ax2,'XColor','none','YColor','none');
%                 ylabel(ax,'Neuron #');
%                 xlabel(ax,'Neuron #');    
                pbaspect([1 1 1]);
                boxplot_grouping = [boxplot_grouping; j*ones(length(corr_data{i}{j}.pairwise_corr(:)),1)];
                boxplot_data = [boxplot_data; corr_data{i}{j}.pairwise_corr(:)];
                heatmap_handles{j} = subplot(3,1,2+j);   % plot heatmap and set labels
%                 plot(mean(sess_data{i}{j}.dff_filtered_temp(1:5300,:)'));
                plot(auc_data{i}{j}.fraction_active_time(1:3300));
                ylim([-0.2,1]);
                title(num2str(size(sess_data{i}{j}.dff_filtered_temp, 2)));
            end
            
            mean_data = [mean_data, nanmean(corr_data{i}{j}.pairwise_corr(:))];
            mean_SEM = nanstd(corr_data{i}{j}.pairwise_corr(:)) / sqrt(length(corr_data{i}{j}.pairwise_corr(:)));

             % regression of correlation vs. event rate
             mean_v_rate{i} = robustfit(corr_data{i}{j}.geom_mean(:), corr_data{i}{j}.geom_mean(:));
        end
        if plot_figs
             print(gcf,strcat('C:\Users\lfisc\Work\Projects\Shiqian/manuscript/v4/panels/Fig 3/',prefix,'_DREADD_',num2str(i),fname,'.png'),'-dpng','-r600');
         end
        mean_corr(i,:) = mean_data;
        if plot_figs
%             corr_boxplot = subplot(2,length(plot_files{i}),[length(plot_files{i})+1,length(plot_files{i})+2]);
%             mean_plot = subplot(2,length(plot_files{i}),[length(plot_files{i})+3,length(plot_files{i})+4]);
%             geomean_vs_corr = subplot(2,length(plot_files{i}),[length(plot_files{i})+5,length(plot_files{i})+6]);
        
        
%             plot(mean_plot,mean_data);

        %     boxplot_data = [pwcorr1(:); pwcorr2(:)];
%             h = boxplot(corr_boxplot, boxplot_data, boxplot_grouping,'Colors','k', 'symbol','','Widths',0.5);
        %     g = [zeros(length(pwcorr1(:)), 1); ones(length(pwcorr2(:)), 1)];
        %     h = boxplot(corr_boxplot, boxplot_data, g, 'Colors','kr','symbol','','Widths',0.5);
%             hold(corr_boxplot,'on');

%             set(h,{'linew'},{2});
% 
%             xticklabels(corr_boxplot,{'file1';'file2'});
%             xtickangle(corr_boxplot,45);
% 
%             ylabel(corr_boxplot,'Correlation (r)');
%             hold(corr_boxplot,'off')
        end
    
    end
   
    
    
    
    
%    close;
    
%     scatter(geomean_vs_corr, geomean1(:), pwcorr1(:), 'MarkerEdgeColor', 'k');
%     hold(geomean_vs_corr,'on');
%     plot(geomean_vs_corr,geomean1(:),brob1(1)+brob1(2)*geomean1(:),'k');
%     scatter(geomean_vs_corr, geomean2(:), pwcorr2(:), 'MarkerEdgeColor', 'r');
%     plot(geomean_vs_corr,geomean2(:),brob2(1)+brob2(2)*geomean2(:),'r');
%     hold(geomean_vs_corr,'off');
end