%% Load datapaths
    
Pilocarpine = ...
      {{'/Users/lukasfischer/Work/exps/Shiqian/Pilocarpine/T2-4/T2-004-1-450'}};

         
    

%% run correlation analysis
              
mean_corr = plot_CORR(Pilocarpine, 'carb');

% figure('Position',[10,10,200,400]);
% % scatter(pre_post_combined', 'LineWidth',3, 'Color', '#C4C4C4');
% scatter_x_vals = ones(size(mean_corr)) .* [1:size(mean_corr,2)];
% scatter(scatter_x_vals(:), mean_corr(:)','Marker','o', 'MarkerEdgeColor','#C4C4C4', 'MarkerFaceColor','w', 'LineWidth',2);
% hold on;
% errorbar(mean(mean_corr,1), std(mean_corr,1)/sqrt(4),...
%          'LineWidth',3,'Marker','o','MarkerFaceColor','w','MarkerSize',10, 'Color', '#319191','LineWidth',2);
% % scatter(ones(length(mean_corr_day0),1) * 6, mean_corr_day0(:)','Marker','o', 'MarkerEdgeColor','#C4C4C4', 'MarkerFaceColor','w', 'LineWidth',2);
% % errorbar([6], mean(mean_corr_day0(:)), std(mean_corr_day0(:))/sqrt(5),'LineWidth',3,'Marker','o','MarkerFaceColor','w','MarkerSize',10, 'Color', 'r','LineWidth',2);
% hold off;
% 
% ylabel('Pairwise Corr.');
% set(gca,'box','off','color','none', 'TickDir','out', 'fontsize',14);
% % yticks([0,0.1,0.2,0.3,0.4,0.5]);
% % yticklabels({'0','0.1','0.2','0.3','0.4','0.5'});
% xticks([1,2,3]);
% xticklabels({'Baseline','Keterolac'});
% xtickangle(45);
% xlim([0.8,2.2]);
% ylim([0, 0.5]);
% 
% % xlim([0.8,6.2])
% 
% num_shuffles = 10000;
% 
% % p_c30_PRE_POST = bootstrap_mean_diff(mean_corr(:,1), mean_corr(:,2), num_shuffles);
% p_Keterolac_PRE_POST = bootstrap_mean_diff(mean_corr(:,1), mean_corr(:,2), num_shuffles);
% 
% bonferroni_alpha = 0.05 / 1;



%%

function mean_corr = plot_CORR(plot_files, prefix)
    plot_figs = true;
    mean_corr = zeros(length(plot_files),length(plot_files{1}));

    corr_data = cell(length(plot_files),length(plot_files{1}));
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
            sess_data{i}{j} = load(strcat(plot_files{i}{j},'_analyzed.mat'));
            [~,fname,~] = fileparts(strcat(plot_files{i}{j},'_CORR.mat'));
            if plot_figs
                set(f, 'NumberTitle', 'off', 'Name', strcat(prefix,'_',num2str(i),fname));
                ax = subplot(3,length(plot_files{i}),j);   % plot heatmap and set labels
                imagesc(ax, sess_data{i}{j}.dff_filtered_temp', [-0.1, 0.8]); %max(max(sess_data{i}{j}.dff_filtered_temp))
                box off;
                set(ax,'XColor','none','YColor','none');
                pbaspect([2 1 1]);
                ax = subplot(3,length(plot_files{i}),length(plot_files{i}) + j); 
                imagesc(ax, corr_data{i}{j}.pairwise_corr, [0 1]);
                box off;
                set(ax,'XColor','none','YColor','none');
                ylabel(ax,'Neuron #');
                xlabel(ax,'Neuron #');    
                pbaspect([1 1 1]);    
                boxplot_grouping = [boxplot_grouping; j*ones(length(corr_data{i}{j}.pairwise_corr(:)),1)];
                boxplot_data = [boxplot_data; corr_data{i}{j}.pairwise_corr(:)];
                ax = subplot(3,length(plot_files{i}),2*length(plot_files{i}) + j); 
                plot(mean(sess_data{i}{j}.dff_filtered_temp'));
                ylim([-0.2,1]);
                title(num2str(size(sess_data{i}{j}.dff_filtered_temp, 2)));
            end
            
            mean_data = [mean_data, nanmean(corr_data{i}{j}.pairwise_corr(:))];
            mean_SEM = nanstd(corr_data{i}{j}.pairwise_corr(:)) / sqrt(length(corr_data{i}{j}.pairwise_corr(:)));

             % regression of correlation vs. event rate
             mean_v_rate{i} = robustfit(corr_data{i}{j}.geom_mean(:), corr_data{i}{j}.geom_mean(:));
        end
        if plot_figs
            print(gcf,strcat('/Users/lukasfischer/Work/exps/Shiqian/manuscript/v4/panels/Fig 4/',prefix,'_CARB_',num2str(i),fname,'.png'),'-dpng','-r600');
        end
        mean_corr(i,:) = mean_data;
%         if plot_figs
%             corr_boxplot = subplot(2,length(plot_files{i}),length(plot_files{i})+1);
%             mean_plot = subplot(2,length(plot_files{i}),length(plot_files{i})+2);
%             geomean_vs_corr = subplot(2,length(plot_files{i}),length(plot_files{i})+3);
%         
%         
%             plot(mean_plot,mean_data);

        %     boxplot_data = [pwcorr1(:); pwcorr2(:)];
%             h = boxplot(corr_boxplot, boxplot_data, boxplot_grouping,'Colors','k', 'symbol','','Widths',0.5);
        %     g = [zeros(length(pwcorr1(:)), 1); ones(length(pwcorr2(:)), 1)];
        %     h = boxplot(corr_boxplot, boxplot_data, g, 'Colors','kr','symbol','','Widths',0.5);
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
   
    
    
    
    
%    close;
    
%     scatter(geomean_vs_corr, geomean1(:), pwcorr1(:), 'MarkerEdgeColor', 'k');
%     hold(geomean_vs_corr,'on');
%     plot(geomean_vs_corr,geomean1(:),brob1(1)+brob1(2)*geomean1(:),'k');
%     scatter(geomean_vs_corr, geomean2(:), pwcorr2(:), 'MarkerEdgeColor', 'r');
%     plot(geomean_vs_corr,geomean2(:),brob2(1)+brob2(2)*geomean2(:),'r');
%     hold(geomean_vs_corr,'off');
end

% 
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
% 
