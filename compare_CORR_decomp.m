%% Load datapaths
    
pre_decomp = {{...
            '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 1/day 0/T0';...
            '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 1/day 7/T7';...
            '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 1/day 14/T14_rigid'};...
           {'/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/day 0/T';...
            '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/day 1/T';...
            '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/day 3/T';...
            '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/day 5/T';...
            '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/day 7/T_rigid';...
            '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/day 14/T'};...
           {'/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 3/Decompression/day 0/T0'};...
           {'/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 4/Before decompression/T'}};
        
post_decomp = {{...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 1/Decompression/day 1 decompression/T14';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 1/Decompression/day 3 decompression/T3';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 1/Decompression/day 5 decompression/T5';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 1/Decompression/day 7 decompression/T7'};...
        {'/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/Decompression/day 1 decompression/T_rigid';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/Decompression/day 3 decompression/T';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/Decompression/day 5 decompression/T';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/Decompression/day 7 decompression/T'};...
        {'/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 3/Decompression/day 1 post decompression/T1';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 3/Decompression/day 3 post decompression/T3';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 3/Decompression/day 5 post decompression/T5';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 3/Decompression/day 7 post decompression/T7'};...
        {'/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 4/day 1 post decompression/T1';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 4/day 3 post decompression/T3';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 4/day 5 post decompression/T5';...
         '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 4/day 7 post decompression/T7'}};
        
CaMKII_RITE = ...
      {{'/Users/lukasfischer/Work/exps/Shiqian/final dataset/CaMKII/RITE/Mouse 1/day 0/T0'};...
       {'/Users/lukasfischer/Work/exps/Shiqian/final dataset/CaMKII/RITE/Mouse 2/day 0/T0'};...
       {'/Users/lukasfischer/Work/exps/Shiqian/final dataset/CaMKII/RITE/Mouse 3/day 0/T0'};...
       {'/Users/lukasfischer/Work/exps/Shiqian/final dataset/CaMKII/RITE/Mouse 4/day 0/T0'};...
       {'/Users/lukasfischer/Work/exps/Shiqian/final dataset/CaMKII/RITE/Mouse 5/day 0/T0'}};
    
Recompression = ...
    {{'/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 1/Recompression/day 3/T3_rigid';...
      '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 1/Recompression/day 7/T7_rigid'};...
     {'/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/Recompression/day 3 post recompression/T';...
      '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 2/Recompression/day 7 post recompression/T'};...
     {'/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 3/Recompression/day 3/T';...
      '/Users/lukasfischer/Work/exps/Shiqian/Decompression/Mouse 3/Recompression/day 7/T'}};

%% run correlation analysis
              
mean_corr_pre = plot_CORR(pre_decomp, 'pre_decomp', [2000,4300]);
mean_corr_post = plot_CORR(post_decomp, 'post_decomp', [1,3300]);
% mean_corr_day0 = plot_CORR(CaMKII_RITE, 'day0');
mean_corr_recomp = plot_CORR(Recompression, 'Recompression', [1,3300]);

mean_corr_pre_last = [mean_corr_pre(1,3), mean_corr_pre(2,6), mean_corr_pre(3,1), mean_corr_pre(4,1)]; % get the final pre-decomp value from every animal
pre_post_combined = [mean_corr_pre_last', mean_corr_post];
mean_corr_recomp = [mean_corr_recomp; [NaN NaN]];
pre_post_combined = [pre_post_combined, mean_corr_recomp];

figure;
% scatter(pre_post_combined', 'LineWidth',3, 'Color', '#C4C4C4');
scatter_x_vals = ones(size(pre_post_combined)) .* [1:length(pre_post_combined)];
scatter(scatter_x_vals(:), pre_post_combined(:)','Marker','o', 'MarkerEdgeColor','#C4C4C4', 'MarkerFaceColor','w', 'LineWidth',2);
hold on;
errorbar(nanmean(pre_post_combined,1), nanstd(pre_post_combined,1) ./ sqrt([4 4 4 4 4 3 3]),...
         'LineWidth',3,'Marker','o','MarkerFaceColor','w','MarkerSize',10, 'Color', 'r','LineWidth',2);
% scatter(ones(length(mean_corr_day0),1) * 6, mean_corr_day0(:)','Marker','o', 'MarkerEdgeColor','#C4C4C4', 'MarkerFaceColor','w', 'LineWidth',2);
% errorbar([6], mean(mean_corr_day0(:)), std(mean_corr_day0(:))/sqrt(5),'LineWidth',3,'Marker','o','MarkerFaceColor','w','MarkerSize',10, 'Color', 'r','LineWidth',2);
hold off;

ylabel('Pairwise Corr.');
set(gca,'box','off','color','none', 'TickDir','out', 'fontsize',14);
% yticks([0,0.1,0.2,0.3,0.4,0.5]);
% yticklabels({'0','0.1','0.2','0.3','0.4','0.5'});
xticks([1,2,3,4,5,6,7]);
xticklabels({'Pre-decomp.','Post day 1','Post day 3','Post day 5','Post day 7', 'Recomp day 3', 'Recomp day 7'});
xtickangle(45);
ylim([0, 0.5]);
xlim([0.5,7.5])
% pbaspect([0.5 1 1]);

num_shuffles = 10000;

p_d1_PRE_POST = bootstrap_mean_diff(pre_post_combined(:,1), pre_post_combined(:,2), num_shuffles);
p_d3_PRE_POST = bootstrap_mean_diff(pre_post_combined(:,1), pre_post_combined(:,3), num_shuffles);
p_d5_PRE_POST = bootstrap_mean_diff(pre_post_combined(:,1), pre_post_combined(:,4), num_shuffles);
p_d7_PRE_POST = bootstrap_mean_diff(pre_post_combined(:,1), pre_post_combined(:,5), num_shuffles);
p_d5v6_PRE_POST = bootstrap_mean_diff(pre_post_combined(:,5), pre_post_combined(:,6), num_shuffles);
p_d5v7_PRE_POST = bootstrap_mean_diff(pre_post_combined(:,5), pre_post_combined(:,7), num_shuffles);
% p_POST_day0 = bootstrap_mean_diff(pre_post_combined(:,5), mean_corr_day0, num_shuffles);


bonferroni_alpha = 0.05 / 6;

[p,tbl,stats] = anova1(pre_post_combined);
[c,m,h,nms] = multcompare(stats);


x=1;
%%


function mean_corr = plot_CORR(plot_files, prefix, start_stop)
    plot_figs = false;
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
            disp(plot_files{i}{j});
            corr_data{i}{j} = load(strcat(plot_files{i}{j},'_CORR.mat'));  
            auc_data{i}{j} = load(strcat(plot_files{i}{j},'_AUC.mat'));  
            sess_data{i}{j} = load(strcat(plot_files{i}{j},'_analyzed.mat'));
            [~,fname,~] = fileparts(strcat(plot_files{i}{j},'_CORR.mat'));
            if plot_figs
                set(f, 'NumberTitle', 'off', 'Name', strcat(prefix,'_',num2str(i),fname));
                ax = subplot(3,length(plot_files{i}),j);   % plot heatmap and set labels
                
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
                
                imagesc(ax, sess_data{i}{j}.dff_filtered_temp(from_x:to_x,:)', [0, 0.8]); %max(max(sess_data{i}{j}.dff_filtered_temp))
                box off;
                set(ax,'XColor','none','YColor','none');
                pbaspect([2 1 1]);
                heatmap_handles{j} = subplot(3,length(plot_files{i}),length(plot_files{i}) + j);   % plot heatmap and set labels
                imagesc(heatmap_handles{j}, corr_data{i}{j}.pairwise_corr, [0, 1]);
                box off;
                set(ax,'XColor','none','YColor','none');
                ylabel(ax,'Neuron #');
                xlabel(ax,'Neuron #');    
                pbaspect([1 1 1]);  
                heatmap_handles{j} = subplot(3,length(plot_files{i}),2*length(plot_files{i})+j);   % plot heatmap and set labels
%                 plot(mean(sess_data{i}{j}.dff_filtered_temp(from_x:to_x,:)'));
                plot(auc_data{i}{j}.fraction_active_time(from_x:to_x));
                ylim([-0.2,1]);
                title(num2str(size(sess_data{i}{j}.dff_filtered_temp, 2)));
                
%                 boxplot_grouping = [boxplot_grouping; j*ones(length(corr_data{i}{j}.pairwise_corr(:)),1)];
%                 boxplot_data = [boxplot_data; corr_data{i}{j}.pairwise_corr(:)];
            end
            
            mean_data = [mean_data, nanmean(corr_data{i}{j}.pairwise_corr(:))];
            mean_SEM = nanstd(corr_data{i}{j}.pairwise_corr(:)) / sqrt(length(corr_data{i}{j}.pairwise_corr(:)));

             % regression of correlation vs. event rate
             mean_v_rate{i} = robustfit(corr_data{i}{j}.geom_mean(:), corr_data{i}{j}.geom_mean(:));
        end
        if plot_figs
             print(gcf,strcat('/Users/lukasfischer/Work/exps/Shiqian/manuscript/v4/panels/Fig 4/',prefix,'_DREADD_',num2str(i),fname,'.png'),'-dpng','-r600');
         end
        mean_corr(i,1:length(mean_data)) = mean_data;
%         if plot_figs
%             corr_boxplot = subplot(2,length(plot_files{i}),[length(plot_files{i})+1,length(plot_files{i})+2]);
%             mean_plot = subplot(2,length(plot_files{i}),[length(plot_files{i})+3,length(plot_files{i})+4]);
%             geomean_vs_corr = subplot(2,length(plot_files{i}),[length(plot_files{i})+5,length(plot_files{i})+6]);
        
        
%             plot(mean_plot,mean_data);

        %     boxplot_data = [pwcorr1(:); pwcorr2(:)];
%             h = boxplot(corr_boxplot, boxplot_data, boxplot_grouping,'Colors','k', 'symbol','','Widths',0.5);
        %     g = [zeros(length(pwcorr1(:)), 1); ones(length(pwcorr2(:)), 1)];
        %     h = boxplot(corr_boxplot, boxplot_data, g, 'Colors','kr','symbol','','Widths',0.5);
%             hold(corr_boxplot,'on');
% 
%             set(h,{'linew'},{2});

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
