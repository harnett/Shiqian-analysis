function compare_CORR_Dlx()
    
        Dlx_RITE_m1 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 1/day 0/T8_CORR.mat';...
                       '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 1/day 3/T8_CORR.mat';...
                       '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 1/day 7/T8_CORR.mat'};
                   
        Dlx_RITE_m2 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 2/day 0/T9_CORR.mat';...
                     '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 2/day 3/T9_rigid_CORR.mat';...
                     '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 2/day 7/T9_CORR.mat'};
                   
         Dlx_RITE_m3 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 3/day 0/10_CORR.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 3/day 3/T10_CORR.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 3/day 7/T10_CORR.mat'};    

         Dlx_RITE_m4 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 4/day 0/T11_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 4/day 3/T11_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 4/day 7/T11_CORR.mat'};
         
          Dlx_RITE_m5 = { '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 5/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 5/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 5/day 7/T_CORR.mat'}
          
          Dlx_RITE_m6 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 6/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 6/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 6/day 7/T_CORR.mat'};
            
          Dlx_RITE_m7 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 7/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 7/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 7/day 7/T_CORR.mat'};
        
          Dlx_RITE_m8 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 8/day 0/T_rigid_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 8/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 8/day 7/T_CORR.mat'};
          
          Dlx_RITE_m9 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 9/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 9/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 9/day 7/T_CORR.mat'};
          
          Dlx_RITE_m10 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 10/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 10/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/RITE/Mouse 10/day 7/T_CORR.mat'};       

    Dlx_Sham_m1 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 1/day 0/T4_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 1/day 3/T4_rigid_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 1/day 7/T4_CORR.mat'};
             
    Dlx_Sham_m2 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 2/day 0/T5_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 2/day 3/T5_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 2/day 7/T5_CORR.mat'};
             
     Dlx_Sham_m3 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 3/day 0/T6_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 3/day 3/T6_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 3/day 7/T6_CORR.mat'};      
             
     Dlx_Sham_m4 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 4/day 0/T7_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 4/day 3/T7_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 4/day 7/T7_CORR.mat'};        
       
      Dlx_Sham_m5 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 5/day 0/T_CORR.mat';...
             '';... %'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 5/day 3/T_CORR.mat';...  <-- RUN LATER
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 5/day 7/T_rigid_CORR.mat'};
        
      Dlx_Sham_m6 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 6/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 6/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 6/day 7/T_CORR.mat'};
       
      Dlx_Sham_m7 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 7/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 7/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/Sham/Mouse 7/day 7/T_CORR.mat'};

       Dlx_Ion_CC_m1 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 1/day 0/T1_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 1/day 3/T1_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 1/day 7/T1_CORR.mat'};
       
       Dlx_Ion_CC_m2 = {'';... %'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 2/day 0/T2_CORR.mat';...    <-- RUN LATER
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 2/day 3/T2_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 2/day 7/T2_CORR.mat'};
             
       Dlx_Ion_CC_m3 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 3/day 0/T3_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 3/day 3/T3_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 3/day 7/T3_CORR.mat'};
             
       Dlx_Ion_CC_m4 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 4/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 4/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 4/day 7/T_CORR.mat'};
       
       Dlx_Ion_CC_m5 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 5/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 5/day 3/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 5/day 7/T_CORR.mat'};
       
       Dlx_Ion_CC_m6 = {'/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 6/day 0/T_CORR.mat';...
             '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 6/day 3/T_CORR.mat';...
             ''};
%              '/Users/lukasfischer/Work/exps/Shiqian/Dlx data/IoN-CCI/Mouse 6/day 7/T_CORR.mat'};

         
    [mean_Dlx_RITE_m1,mean_SEM_Dlx_RITE_m1] = plot_CORR(Dlx_RITE_m1);
    [mean_Dlx_RITE_m2,mean_SEM_Dlx_RITE_m2] = plot_CORR(Dlx_RITE_m2);
    [mean_Dlx_RITE_m3,mean_SEM_Dlx_RITE_m3] = plot_CORR(Dlx_RITE_m3);
    [mean_Dlx_RITE_m4,mean_SEM_Dlx_RITE_m4] = plot_CORR(Dlx_RITE_m4);
    [mean_Dlx_RITE_m5,mean_SEM_Dlx_RITE_m5] = plot_CORR(Dlx_RITE_m5);
%     [mean_Dlx_RITE_m6,mean_SEM_Dlx_RITE_m6] = plot_CORR(Dlx_RITE_m6);
%     [mean_Dlx_RITE_m7,mean_SEM_Dlx_RITE_m7] = plot_CORR(Dlx_RITE_m7);
%     [mean_Dlx_RITE_m8,mean_SEM_Dlx_RITE_m8] = plot_CORR(Dlx_RITE_m8);
%     [mean_Dlx_RITE_m9,mean_SEM_Dlx_RITE_m9] = plot_CORR(Dlx_RITE_m9);
%     [mean_Dlx_RITE_m10,mean_SEM_Dlx_RITE_m10] = plot_CORR(Dlx_RITE_m10);

    figure();
    corr_ax = subplot(1,1,1);
    plot(mean_Dlx_RITE_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(mean_Dlx_RITE_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_RITE_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_RITE_m4,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_RITE_m5,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_RITE_m6,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_RITE_m7,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_RITE_m8,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_RITE_m9,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_RITE_m10,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([mean_Dlx_RITE_m1;mean_Dlx_RITE_m2;mean_Dlx_RITE_m3;mean_Dlx_RITE_m4;mean_Dlx_RITE_m5;mean_Dlx_RITE_m6;mean_Dlx_RITE_m7;mean_Dlx_RITE_m8;mean_Dlx_RITE_m9;mean_Dlx_RITE_m10]) ,'LineWidth',3, 'Color', 'k');
    hold off;
    
    ylim([0,0.3]);
    xticks([1,2,3]);
    xticklabels({'Day 0';'Day 3';'Day 7'});
    xtickangle(45);
    
    corr_ax.LineWidth = 2;
    corr_ax.Box = false;
    corr_ax.TickDir = 'out';
    
    
    [mean_plot_Dlx_Ion_CC_m1,mean_SEM_Dlx_Ion_CC_m1] = plot_CORR(Dlx_Ion_CC_m1);
    [mean_plot_Dlx_Ion_CC_m2,mean_SEM_Dlx_Ion_CC_m2] = plot_CORR(Dlx_Ion_CC_m2);
    [mean_plot_Dlx_Ion_CC_m3,mean_SEM_Dlx_Ion_CC_m3] = plot_CORR(Dlx_Ion_CC_m3);
    [mean_plot_Dlx_Ion_CC_m4,mean_SEM_Dlx_Ion_CC_m4] = plot_CORR(Dlx_Ion_CC_m4);
    [mean_plot_Dlx_Ion_CC_m5,mean_SEM_Dlx_Ion_CC_m5] = plot_CORR(Dlx_Ion_CC_m5);
    [mean_plot_Dlx_Ion_CC_m6,mean_SEM_Dlx_Ion_CC_m6] = plot_CORR(Dlx_Ion_CC_m6);
    
    figure();
    corr_ax = subplot(1,1,1);
    plot(mean_plot_Dlx_Ion_CC_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(mean_plot_Dlx_Ion_CC_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_plot_Dlx_Ion_CC_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_plot_Dlx_Ion_CC_m4,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_plot_Dlx_Ion_CC_m5,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_plot_Dlx_Ion_CC_m6,'LineWidth',2,'Color','#CCCCCC');
    
    plot(nanmean([mean_plot_Dlx_Ion_CC_m1;mean_plot_Dlx_Ion_CC_m2;mean_plot_Dlx_Ion_CC_m3;mean_plot_Dlx_Ion_CC_m4;mean_plot_Dlx_Ion_CC_m5;mean_plot_Dlx_Ion_CC_m6]),'LineWidth',3, 'Color', 'k');
    hold off;
    
    ylim([0,0.5]);
    xticks([1,2,3]);
    xticklabels({'Day 0';'Day 3';'Day 7'});
    xtickangle(45);
    
    corr_ax.LineWidth = 2;
    corr_ax.Box = false;
    corr_ax.TickDir = 'out';
    
    
    
    [mean_Dlx_Sham_m1,mean_SEM_Dlx_Sham_m1] = plot_CORR(Dlx_Sham_m1);
    [mean_Dlx_Sham_m2,mean_SEM_Dlx_Sham_m2] = plot_CORR(Dlx_Sham_m2);
    [mean_Dlx_Sham_m3,mean_SEM_Dlx_Sham_m3] = plot_CORR(Dlx_Sham_m3);
    [mean_Dlx_Sham_m4,mean_SEM_Dlx_Sham_m4] = plot_CORR(Dlx_Sham_m4);
    [mean_Dlx_Sham_m5,mean_SEM_Dlx_Sham_m5] = plot_CORR(Dlx_Sham_m5);
    [mean_Dlx_Sham_m6,mean_SEM_Dlx_Sham_m6] = plot_CORR(Dlx_Sham_m6);
    [mean_Dlx_Sham_m7,mean_SEM_Dlx_Sham_m7] = plot_CORR(Dlx_Sham_m7);
    
    figure();
    corr_ax = subplot(1,1,1);
    plot(mean_Dlx_Sham_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(mean_Dlx_Sham_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_Sham_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_Sham_m4,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_Sham_m5,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_Sham_m6,'LineWidth',2,'Color','#CCCCCC');
    plot(mean_Dlx_Sham_m7,'LineWidth',2,'Color','#CCCCCC');
    plot(nanmean([mean_Dlx_Sham_m1;mean_Dlx_Sham_m2;mean_Dlx_Sham_m3;mean_Dlx_Sham_m4;mean_Dlx_Sham_m5;mean_Dlx_Sham_m6;mean_Dlx_Sham_m7]),'LineWidth',3, 'Color', 'k');
    hold off;
    
    ylim([0,0.5]);
%     xticks([1,2,3,4,5,6]);
%     xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
%     xtickangle(45);
    
    corr_ax.LineWidth = 2;
    corr_ax.Box = false;
    corr_ax.TickDir = 'out';
    
    figure();
    corr_ax = subplot(1,1,1);
    errorbar(nanmean([mean_Dlx_RITE_m1;mean_Dlx_RITE_m2;mean_Dlx_RITE_m3;mean_Dlx_RITE_m4;mean_Dlx_RITE_m5;mean_Dlx_RITE_m6;mean_Dlx_RITE_m7;mean_Dlx_RITE_m8;mean_Dlx_RITE_m9;mean_Dlx_RITE_m10]),...
              nanstd([mean_Dlx_RITE_m1;mean_Dlx_RITE_m2;mean_Dlx_RITE_m3;mean_Dlx_RITE_m4;mean_Dlx_RITE_m5;mean_Dlx_RITE_m6;mean_Dlx_RITE_m7;mean_Dlx_RITE_m8;mean_Dlx_RITE_m9;mean_Dlx_RITE_m10])/sqrt(10) ,'LineWidth',3, 'Color', 'r');
    hold on;
    errorbar(nanmean([mean_plot_Dlx_Ion_CC_m1;mean_plot_Dlx_Ion_CC_m2;mean_plot_Dlx_Ion_CC_m3;mean_plot_Dlx_Ion_CC_m4;mean_plot_Dlx_Ion_CC_m5;mean_plot_Dlx_Ion_CC_m6]),...
             nanstd([mean_plot_Dlx_Ion_CC_m1;mean_plot_Dlx_Ion_CC_m2;mean_plot_Dlx_Ion_CC_m3;mean_plot_Dlx_Ion_CC_m4;mean_plot_Dlx_Ion_CC_m5;mean_plot_Dlx_Ion_CC_m6])/sqrt(6) ,'LineWidth',3, 'Color', 'b');
         
    errorbar(nanmean([mean_Dlx_Sham_m1;mean_Dlx_Sham_m2;mean_Dlx_Sham_m3;mean_Dlx_Sham_m4;mean_Dlx_Sham_m5;mean_Dlx_Sham_m6;mean_Dlx_Sham_m7]),...
             nanstd([mean_Dlx_Sham_m1;mean_Dlx_Sham_m2;mean_Dlx_Sham_m3;mean_Dlx_Sham_m4;mean_Dlx_Sham_m5;mean_Dlx_Sham_m6;mean_Dlx_Sham_m7])/sqrt(7) ,'LineWidth',3, 'Color', 'k');
    hold off;
    
    ylim([0,0.3]);
    ylabel('correlation');
    xticks([1,2,3]);
    xticklabels({'Day 0';'Day 3';'Day 7'});
    xtickangle(45);
    
    corr_ax.LineWidth = 2;
    corr_ax.Box = false;
    corr_ax.TickDir = 'out';
    
%     [~,p1] = ttest2([mean_data_comtn_m1(1);mean_data_comtn_m2(1);mean_data_comtn_m3(1)], [mean_data_ioncc_m1(1);mean_data_ioncc_m2(1);mean_data_ioncc_m3(1)])
%     [~,p4] = ttest2([mean_data_comtn_m1(4);mean_data_comtn_m2(4);mean_data_comtn_m3(4)], [mean_data_ioncc_m1(4);mean_data_ioncc_m2(4);mean_data_ioncc_m3(4)])
%     [~,p5] = ttest2([mean_data_comtn_m1(5);mean_data_comtn_m2(5);mean_data_comtn_m3(5)], [mean_data_ioncc_m1(5);mean_data_ioncc_m2(5);mean_data_ioncc_m3(5)])
%     [~,p5] = ttest2([mean_data_comtn_m1(6);mean_data_comtn_m2(6);mean_data_comtn_m3(6)], [mean_data_ioncc_m1(6);mean_data_ioncc_m2(6);mean_data_ioncc_m3(6)])
%     
%     [~,p1] = ttest2([mean_data_comtn_m1(1);mean_data_comtn_m2(1);mean_data_comtn_m3(1)], [mean_data_sham_m1(1);mean_data_sham_m2(1);mean_data_sham_m3(1);mean_data_sham_m4(1);mean_data_sham_m5(1);mean_data_sham_m6(1)])
%     [~,p4] = ttest2([mean_data_comtn_m1(4);mean_data_comtn_m2(4);mean_data_comtn_m3(4)], [mean_data_sham_m1(4);mean_data_sham_m2(4);mean_data_sham_m3(4);mean_data_sham_m4(4);mean_data_sham_m5(4);mean_data_sham_m6(4)])
%     [~,p5] = ttest2([mean_data_comtn_m1(5);mean_data_comtn_m2(5);mean_data_comtn_m3(5)], [mean_data_sham_m1(5);mean_data_sham_m2(5);mean_data_sham_m3(5);mean_data_sham_m4(5);mean_data_sham_m5(5);mean_data_sham_m6(5)])
%     [~,p5] = ttest2([mean_data_comtn_m1(6);mean_data_comtn_m2(6);mean_data_comtn_m3(6)], [mean_data_sham_m1(6);mean_data_sham_m2(6);mean_data_sham_m3(6);mean_data_sham_m4(6);mean_data_sham_m5(6);mean_data_sham_m6(6)])
    
end

function [mean_data,mean_SEM] = plot_CORR(plot_files)
      
    corr_data = cell(length(plot_files),1);
%     for i=1:length(plot_files)
%         if ~strcmp(plot_files{i}, '')
%             corr_data{i} = load(plot_files{i});
%         else
%             corr_data{i} = NaN;
%         end
%     end

    figure();
    boxplot_data = [];
    boxplot_grouping = [];
    mean_data = [];
    mean_SEM = [];
    mean_v_rate = cell(length(plot_files),1);
    heatmap_handles = cell(length(plot_files),1);
    for i=1:length(plot_files)
        if ~strcmp(plot_files{i}, '')
            corr_data{i} = load(plot_files{i});
        
            heatmap_handles{i} = subplot(2,length(plot_files),i);   % plot heatmap and set labels
            imagesc(heatmap_handles{i}, corr_data{i}.pairwise_corr, [-0.2 0.6]);
            ylabel(heatmap_handles{i},'Neuron #');
            xlabel(heatmap_handles{i},'Neuron #');    

            boxplot_grouping = [boxplot_grouping; i*ones(length(corr_data{i}.pairwise_corr(:)),1)];
            boxplot_data = [boxplot_data; corr_data{i}.pairwise_corr(:)];

            mean_data = [mean_data, nanmean(corr_data{i}.pairwise_corr(:))];
            mean_SEM = nanstd(corr_data{i}.pairwise_corr(:)) / sqrt(length(corr_data{i}.pairwise_corr(:)));

             % regression of correlation vs. event rate
             mean_v_rate{i} = robustfit(corr_data{i}.geom_mean(:), corr_data{i}.geom_mean(:));
        else
            mean_data = [mean_data, NaN];
            mean_SEM = NaN;
        end
    end
   
    if length(plot_files) > 2
        corr_boxplot = subplot(2,length(plot_files),[length(plot_files)+1,length(plot_files)+2]);
        mean_plot = subplot(2,length(plot_files),[length(plot_files)+3]);
    else
        corr_boxplot = subplot(2,length(plot_files),[length(plot_files)+1]);
        mean_plot = subplot(2,length(plot_files),[length(plot_files)+2]);
    end
    
%     geomean_vs_corr = subplot(2,length(plot_files),[length(plot_files)+5,length(plot_files)+6]);
    
    
    plot(mean_plot,mean_data);
    
%     boxplot_data = [pwcorr1(:); pwcorr2(:)];
    h = boxplot(corr_boxplot, boxplot_data, boxplot_grouping,'Colors','k', 'symbol','','Widths',0.5);
%     g = [zeros(length(pwcorr1(:)), 1); ones(length(pwcorr2(:)), 1)];
%     h = boxplot(corr_boxplot, boxplot_data, g, 'Colors','kr','symbol','','Widths',0.5);
    hold(corr_boxplot,'on');
    
    set(h,{'linew'},{2});
    
    xticklabels(corr_boxplot,{'file1';'file2'});
    xtickangle(corr_boxplot,45);
    
    ylabel(corr_boxplot,'Correlation (r)');
    hold(corr_boxplot,'off')
    
%    close;
    
%     scatter(geomean_vs_corr, geomean1(:), pwcorr1(:), 'MarkerEdgeColor', 'k');
%     hold(geomean_vs_corr,'on');
%     plot(geomean_vs_corr,geomean1(:),brob1(1)+brob1(2)*geomean1(:),'k');
%     scatter(geomean_vs_corr, geomean2(:), pwcorr2(:), 'MarkerEdgeColor', 'r');
%     plot(geomean_vs_corr,geomean2(:),brob2(1)+brob2(2)*geomean2(:),'r');
%     hold(geomean_vs_corr,'off');
end