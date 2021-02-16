%% set datapaths
    
Dlx_RITE = {{'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 1/day 0/T8';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 1/day 3/T8';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 1/day 7/T8'},...
            {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 2/day 0/T9';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 2/day 3/T9_rigid';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 2/day 7/T9'},...
            {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 3/day 0/10';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 3/day 3/T10';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 3/day 7/T10'},...
            {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 4/day 0/T11';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 4/day 3/T11';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 4/day 7/T11'},...
            {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 5/day 0/T';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 5/day 3/T';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 5/day 7/T'}};

Dlx_Ion_CC = {{'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 1/day 0/T1';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 1/day 3/T1';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 1/day 7/T1'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 2/day 0/T2';...   
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 2/day 3/T2';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 2/day 7/T2'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 3/day 0/T3';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 3/day 3/T3';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 3/day 7/T3'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 4/day 0/T';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 4/day 3/T';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 4/day 7/T'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 5/day 0/T';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 5/day 3/T';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 5/day 7/T'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 6/day 0/T';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 6/day 3/T';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 6/day 7/T'}};

  Dlx_Sham = {{'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 1/day 0/T4_rigid';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 1/day 3/T4';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 1/day 7/T4'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 2/day 0/T5';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 2/day 3/T5';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 2/day 7/T5'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 3/day 0/T6_rigid';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 3/day 3/T6';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 3/day 7/T6'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 4/day 0/T7_rigid';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 4/day 3/T7';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 4/day 7/T7'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 5/day 0/T_rigid';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 5/day 3/T_rigid';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 5/day 7/T'},...
              {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 6/day 0/T';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 6/day 3/T';...
               '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 6/day 7/T'}};


    

%% run correlation analysis
              
mean_corr_RITE = plot_CORR(Dlx_RITE, 'DlxRITE');
mean_corr_IONCC = plot_CORR(Dlx_Ion_CC, 'DlxIONCC');
mean_corr_SHAM = plot_CORR(Dlx_Sham, 'DlxSHAM');

figure;
errorbar(mean(mean_corr_RITE,1), std(mean_corr_RITE,1)/sqrt(5) ,'LineWidth',3, 'Color', 'r');
hold on;
errorbar(mean(mean_corr_IONCC,1), std(mean_corr_IONCC,1)/sqrt(5) ,'LineWidth',3, 'Color', 'b');
errorbar(mean(mean_corr_SHAM,1), std(mean_corr_SHAM,1)/sqrt(6) ,'LineWidth',3, 'Color', 'k');
hold off;

box off;

pbaspect([1.4 1 1]);

ylabel('Correllation');
set(gca,'box','off','color','none', 'TickDir','out', 'fontsize',14);
yticks([0,0.1,0.2,0.3,0.4,0.5]);
yticklabels({'0','0.1','0.2','0.3','0.4','0.5'});
xticks([1,2,3,4,5,6]);
xticklabels({'Day 0','Day 3','Day 7','Day 14','Day 21','Day 28'});
xtickangle(45);
xlim([0.8,6.2]);

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

% 
% p_d14_RITE_IONCC = bootstrap_mean_diff(mean_corr_RITE(:,4), mean_corr_IONCC(:,4), num_shuffles);
% p_d14_RITE_SHAM = bootstrap_mean_diff(mean_corr_RITE(:,4), mean_corr_SHAM(:,4), num_shuffles);
% p_d14_IONCC_SHAM = bootstrap_mean_diff(mean_corr_IONCC(:,4), mean_corr_SHAM(:,4), num_shuffles);
% 
% p_d21_RITE_IONCC = bootstrap_mean_diff(mean_corr_RITE(:,5), mean_corr_IONCC(:,5), num_shuffles);
% p_d21_RITE_SHAM = bootstrap_mean_diff(mean_corr_RITE(:,5), mean_corr_SHAM(:,5), num_shuffles);
% p_d21_IONCC_SHAM = bootstrap_mean_diff(mean_corr_IONCC(:,5), mean_corr_SHAM(:,5), num_shuffles);
% 
% p_d28_RITE_IONCC = bootstrap_mean_diff(mean_corr_RITE(:,6), mean_corr_IONCC(:,6), num_shuffles);
% p_d28_RITE_SHAM = bootstrap_mean_diff(mean_corr_RITE(:,6), mean_corr_SHAM(:,6), num_shuffles);
% p_d28_IONCC_SHAM = bootstrap_mean_diff(mean_corr_IONCC(:,6), mean_corr_SHAM(:,6), num_shuffles);

bonferroni_alpha = 0.05 / 9;





%%


function mean_corr = plot_CORR(plot_files, prefix)
    plot_figs = true;
    mean_corr = zeros(length(plot_files),length(plot_files{1}));

    corr_data = cell(length(plot_files),length(plot_files{1}));
    sess_data = cell(length(plot_files),length(plot_files{1}));
    
    for i=1:length(plot_files)
        if plot_figs
            f = figure('Position',[10,10,1000,300]);
        end
        boxplot_data = [];
        boxplot_grouping = [];
        mean_data = [];
        mean_SEM = [];
        max_cumAUC = 0;
        auc_ax = [];
        mean_v_rate = cell(length(plot_files),1);
        heatmap_handles = cell(length(plot_files),1);
        for j=1:length(plot_files{i})
            corr_data{i}{j} = load(strcat(plot_files{i}{j},'_CORR.mat'));  
            sess_data{i}{j} = load(strcat(plot_files{i}{j},'_analyzed.mat'));
            [~,fname,~] = fileparts(strcat(plot_files{i}{j},'_CORR.mat'));
            
            
            if plot_figs
                set(f, 'NumberTitle', 'off', 'Name', strcat(prefix,'_',num2str(i),fname));
%                 disp(strcat(prefix,'_',num2str(i),fname,' ', num2str(size(sess_data{i}{j}.dff_temp))));
                ax = subplot(3,6,j);   % plot heatmap and set labels
                imagesc(ax, sess_data{i}{j}.dff_filtered_temp', [0,0.5]); %max(max(sess_data{i}{j}.dff_filtered_temp))]
                box off;
                set(ax,'XColor','none','YColor','none');
                pbaspect([1 1 1]);
                ax = subplot(3,6,6+j);   % plot heatmap and set labels
                imagesc(ax, corr_data{i}{j}.pairwise_corr, [0 1]);
                box off;
                set(ax,'XColor','none','YColor','none');
                ylabel(ax,'Neuron #');
                xlabel(ax,'Neuron #');    
                pbaspect([1 1 1]);
                boxplot_grouping = [boxplot_grouping; j*ones(length(corr_data{i}{j}.pairwise_corr(:)),1)];
                boxplot_data = [boxplot_data; corr_data{i}{j}.pairwise_corr(:)];
                
                auc_ax = [auc_ax, subplot(3,6,12+j)];
%                 plot(mean(cumtrapz(sess_data{i}{j}.dff_filtered_temp)'));
                max_cumAUC = max([max_cumAUC, max(mean(cumtrapz(sess_data{i}{j}.dff_filtered_temp)'))]);
%                 ylim([-0.2,1.2]);
                
            end
            
            
            mean_data = [mean_data, nanmean(corr_data{i}{j}.pairwise_corr(:))];
            mean_SEM = nanstd(corr_data{i}{j}.pairwise_corr(:)) / sqrt(length(corr_data{i}{j}.pairwise_corr(:)));

             % regression of correlation vs. event rate
             mean_v_rate{i} = robustfit(corr_data{i}{j}.geom_mean(:), corr_data{i}{j}.geom_mean(:));
             
        end
        for j=1:length(plot_files{i})
            plot(auc_ax(j), mean(cumtrapz(sess_data{i}{j}.dff_filtered_temp)')/max_cumAUC);
            ylim(auc_ax(j), [0,1] );
            
        end
            
%         if plot_figs
%              print(gcf,strcat('/Users/lukasfischer/Work/exps/Shiqian/manuscript/v4/panels/Fig 3/',prefix,'_',num2str(i),fname,'.png'),'-dpng','-r600');
%          end
        mean_corr(i,:) = mean_data;
%         if plot_figs
%             corr_boxplot = subplot(3,6,[13,14]);
%             mean_plot = subplot(3,6,[16,16]);
%             geomean_vs_corr = subplot(3,6,[17,18]);
%         
%         
%             plot(mean_plot,mean_data);

        %     boxplot_data = [pwcorr1(:); pwcorr2(:)];
%             h = boxplot(corr_boxplot, boxplot_data, boxplot_grouping,'Colors','k', 'symbol','','Widths',0.5);
        %     g = [zeros(length(pwcorr1(:)), 1); ones(length(pwcorr2(:)), 1)];
        %     h = boxplot(corr_boxplot, boxplot_data, g, 'Colors','kr','symbol','','Widths',0.5);
%             hold(corr_boxplot,'on');

%             set(h,{'linew'},{2});

%             xticklabels(corr_boxplot,{'file1';'file2'});
%             xtickangle(corr_boxplot,45);

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
