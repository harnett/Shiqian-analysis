function compare_AUC()
    
    plot_files_sham_m1 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 0/T0_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 3/T3_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 7/T7_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 14/T14_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 21/T21_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 1/day 28/T28_AUC.mat';...
                  };

    plot_files_sham_m2 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 0/T0_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 3/T3_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 7/T7_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 14/T14_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 21/T21_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 2/day 28/T28_AUC.mat';...
                  };
                          
    plot_files_sham_m3 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 0/T0_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 3/T3_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 7/T7_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 14/T14_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 21/T21_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(Com-TN)/Mouse 3/day 28/T28_AUC.mat';...
                  };
              
     plot_files_sham_m4 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 0/T0_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 3/T3_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 7/T7_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 14/T14_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 21/T21_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 4/day 28/T28_AUC.mat';...
                  };

    plot_files_sham_m5 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 0/T0_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 3/T3_rigid_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 7/T7_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 14/T14_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 21/T21_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 5/day 28/T28_AUC.mat';...
                  };
                          
    plot_files_sham_m6 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 0/T0_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 3/T3_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 7/T7_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 14/T14_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 21/T21_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Sham/Sham(IoN-CCI)/Mouse 6/day 28/T28_AUC.mat';...
                  };


              
              
              
    plot_files_ioncc_m1 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 0/T0_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 3/T3_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 7/T7_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 14/T14_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 21/T21_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 1/day 28/T28_AUC.mat';...
                  };

    plot_files_ioncc_m2 = { '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 0/T0_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 3/T3_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 7/T7_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 14/T14_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 21/T21_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 2/day 28/T28_AUC.mat';...
                  };
                          
    plot_files_ioncc_m3 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 0/T0_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 3/T3_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 7/T7_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 14/T14_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 21/T21_AUC.mat';...
                 '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/IoN-CCI/Mouse 3/day 28/T28_AUC.mat';...
                  };


    plot_files_comtn_m1 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 0/T0_rigid_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 3/T3_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 7/T7_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 14/T14_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 21/T21_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 1/day 28/T28_AUC.mat';...
                  };

    plot_files_comtn_m2 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 0/T0_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 3/T3_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 7/T7_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 14/T14_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 21/T21_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 2/day 28/T28_AUC.mat';...
                  };
                          
    plot_files_comtn_m3 = {'/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 0/T0_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 3/T3_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 7/T7_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 14/day14_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 21/day21_AUC.mat';...
                  '/Users/lukasfischer/Work/exps/Shiqian/CaMKII/Com-TN/Mouse 3/day 28/T28_AUC.mat';...
                  };
    
    [frac_global_m1,num_transients_m1,global_AUC_m1,ind_AUC_m1,trace_AUC_m1] = plot_CORR(plot_files_comtn_m1, 'Com-TN M1');
    [frac_global_m2,num_transients_m2,global_AUC_m2,ind_AUC_m2,trace_AUC_m2] = plot_CORR(plot_files_comtn_m2, 'Com-TN M2');
    [frac_global_m3,num_transients_m3,global_AUC_m3,ind_AUC_m3,trace_AUC_m3] = plot_CORR(plot_files_comtn_m3, 'Com-TN M3');
   
    
    figure();
    ax1 = subplot(2,2,1);
    plot(frac_global_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(frac_global_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(frac_global_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([frac_global_m1;frac_global_m2;frac_global_m3]) ,'LineWidth',3, 'Color', 'k');
    title('Fraction global');
    hold off;
    
    ylim([0,1]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax1.LineWidth = 2;
    ax1.Box = false;
    ax1.TickDir = 'out';
    
    ax2 = subplot(2,2,2);
    plot(num_transients_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(num_transients_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(num_transients_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([num_transients_m1;num_transients_m2;num_transients_m3]) ,'LineWidth',3, 'Color', 'k');
    title('Number of transients');
    hold off;
    
    ylim([0,100]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax2.LineWidth = 2;
    ax2.Box = false;
    ax2.TickDir = 'out';
    
    ax3 = subplot(2,2,3);
    plot(global_AUC_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(global_AUC_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(global_AUC_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([global_AUC_m1;global_AUC_m2;global_AUC_m3]) ,'LineWidth',3, 'Color', 'k');
    title('AUC global');
    hold off;
    
    ylim([0,100]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax3.LineWidth = 2;
    ax3.Box = false;
    ax3.TickDir = 'out';
    
    ax4 = subplot(2,2,4);
    plot(ind_AUC_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(ind_AUC_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(ind_AUC_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([ind_AUC_m1;ind_AUC_m2;ind_AUC_m3]) ,'LineWidth',3, 'Color', 'k');
    title('AUC independent');
    hold off;
    
    ylim([0,100]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax4.LineWidth = 2;
    ax4.Box = false;
    ax4.TickDir = 'out';
%     

    
    
    [frac_global_ioncc_m1,num_transients_ioncc_m1,global_AUC_ioncc_m1,ind_AUC_ioncc_m1,trace_AUC_ioncc_m1] = plot_CORR(plot_files_ioncc_m1, 'Ion-CC M1');
    [frac_global_ioncc_m2,num_transients_ioncc_m2,global_AUC_ioncc_m2,ind_AUC_ioncc_m2,trace_AUC_ioncc_m2] = plot_CORR(plot_files_ioncc_m2, 'Ion-CC M2');
    [frac_global_ioncc_m3,num_transients_ioncc_m3,global_AUC_ioncc_m3,ind_AUC_ioncc_m3,trace_AUC_ioncc_m3] = plot_CORR(plot_files_ioncc_m3, 'Ion-CC M3');
    
    figure();
    ax1 = subplot(2,2,1);
    plot(frac_global_ioncc_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(frac_global_ioncc_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(frac_global_ioncc_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([frac_global_ioncc_m1;frac_global_ioncc_m2;frac_global_ioncc_m3]) ,'LineWidth',3, 'Color', 'k');
    title('Fraction global');
    hold off;
    
    ylim([0,1]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax1.LineWidth = 2;
    ax1.Box = false;
    ax1.TickDir = 'out';
    
    ax2 = subplot(2,2,2);
    plot(num_transients_ioncc_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(num_transients_ioncc_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(num_transients_ioncc_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([num_transients_ioncc_m1;num_transients_ioncc_m2;num_transients_ioncc_m3]) ,'LineWidth',3, 'Color', 'k');
    title('Number of transients');
    hold off;
    
    ylim([0,100]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax2.LineWidth = 2;
    ax2.Box = false;
    ax2.TickDir = 'out';
    
    ax3 = subplot(2,2,3);
    plot(global_AUC_ioncc_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(global_AUC_ioncc_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(global_AUC_ioncc_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([global_AUC_ioncc_m1;global_AUC_ioncc_m2;global_AUC_ioncc_m3]) ,'LineWidth',3, 'Color', 'k');
    title('AUC global');
    hold off;
    
    ylim([0,100]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax3.LineWidth = 2;
    ax3.Box = false;
    ax3.TickDir = 'out';
    
    ax4 = subplot(2,2,4);
    plot(ind_AUC_ioncc_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(ind_AUC_ioncc_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(ind_AUC_ioncc_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([ind_AUC_ioncc_m1;ind_AUC_ioncc_m2;ind_AUC_ioncc_m3]) ,'LineWidth',3, 'Color', 'k');
    title('AUC independent');
    hold off;
    
    ylim([0,100]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax4.LineWidth = 2;
    ax4.Box = false;
    ax4.TickDir = 'out';
    
    
    
    
    [frac_global_sham_m1,num_transients_sham_m1,global_AUC_sham_m1,ind_AUC_sham_m1,trace_AUC_sham_m1] = plot_CORR(plot_files_sham_m1, 'SHAM M1');
    [frac_global_sham_m2,num_transients_sham_m2,global_AUC_sham_m2,ind_AUC_sham_m2,trace_AUC_sham_m2] = plot_CORR(plot_files_sham_m2, 'SHAM M2');
    [frac_global_sham_m3,num_transients_sham_m3,global_AUC_sham_m3,ind_AUC_sham_m3,trace_AUC_sham_m3] = plot_CORR(plot_files_sham_m3, 'SHAM M3');
    [frac_global_sham_m4,num_transients_sham_m4,global_AUC_sham_m4,ind_AUC_sham_m4,trace_AUC_sham_m4] = plot_CORR(plot_files_sham_m4, 'SHAM M4');
    [frac_global_sham_m5,num_transients_sham_m5,global_AUC_sham_m5,ind_AUC_sham_m5,trace_AUC_sham_m5] = plot_CORR(plot_files_sham_m5, 'SHAM M5');
    [frac_global_sham_m6,num_transients_sham_m6,global_AUC_sham_m6,ind_AUC_sham_m6,trace_AUC_sham_m6] = plot_CORR(plot_files_sham_m6, 'SHAM M6');
    
    figure();
    ax1 = subplot(2,2,1);
    plot(frac_global_sham_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(frac_global_sham_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(frac_global_sham_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(frac_global_sham_m4,'LineWidth',2,'Color','#CCCCCC');
    plot(frac_global_sham_m5,'LineWidth',2,'Color','#CCCCCC');
    plot(frac_global_sham_m6,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([frac_global_sham_m1;frac_global_sham_m2;frac_global_sham_m3;frac_global_sham_m4;frac_global_sham_m5;frac_global_sham_m6]) ,'LineWidth',3, 'Color', 'k');
    title('Fraction global');
    hold off;
    
    ylim([0,1]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax1.LineWidth = 2;
    ax1.Box = false;
    ax1.TickDir = 'out';
    
    ax2 = subplot(2,2,2);
    plot(num_transients_sham_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(num_transients_sham_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(num_transients_sham_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(num_transients_sham_m4,'LineWidth',2,'Color','#CCCCCC');
    plot(num_transients_sham_m5,'LineWidth',2,'Color','#CCCCCC');
    plot(num_transients_sham_m6,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([num_transients_sham_m1;num_transients_sham_m2;num_transients_sham_m3;num_transients_sham_m4;num_transients_sham_m5;num_transients_sham_m6]) ,'LineWidth',3, 'Color', 'k');
    title('Number of transients');
    hold off;
    
    ylim([0,100]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax2.LineWidth = 2;
    ax2.Box = false;
    ax2.TickDir = 'out';
    
    ax3 = subplot(2,2,3);
    plot(global_AUC_sham_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(global_AUC_sham_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(global_AUC_sham_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(global_AUC_sham_m4,'LineWidth',2,'Color','#CCCCCC');
    plot(global_AUC_sham_m5,'LineWidth',2,'Color','#CCCCCC');
    plot(global_AUC_sham_m6,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([global_AUC_sham_m1;global_AUC_sham_m2;global_AUC_sham_m3;global_AUC_sham_m4;global_AUC_sham_m5;global_AUC_sham_m6]) ,'LineWidth',3, 'Color', 'k');
    title('AUC global');
    hold off;
    
    ylim([0,100]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax3.LineWidth = 2;
    ax3.Box = false;
    ax3.TickDir = 'out';
    
    ax4 = subplot(2,2,4);
    plot(ind_AUC_sham_m1,'LineWidth',2,'Color','#CCCCCC');
    hold on;
    plot(ind_AUC_sham_m2,'LineWidth',2,'Color','#CCCCCC');
    plot(ind_AUC_sham_m3,'LineWidth',2,'Color','#CCCCCC');
    plot(ind_AUC_sham_m4,'LineWidth',2,'Color','#CCCCCC');
    plot(ind_AUC_sham_m5,'LineWidth',2,'Color','#CCCCCC');
    plot(ind_AUC_sham_m5,'LineWidth',2,'Color','#CCCCCC');
    plot(mean([ind_AUC_sham_m1;ind_AUC_sham_m2;ind_AUC_sham_m3;ind_AUC_sham_m4;ind_AUC_sham_m5;ind_AUC_sham_m6]) ,'LineWidth',3, 'Color', 'k');
    title('AUC independent');
    hold off;
    
    ylim([0,100]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax4.LineWidth = 2;
    ax4.Box = false;
    ax4.TickDir = 'out';
%     
    figure();
    ax5 = subplot(1,1,1);
    errorbar(mean([frac_global_m1;frac_global_m2;frac_global_m3]), std([frac_global_m1;frac_global_m2;frac_global_m3])/sqrt(3) ,'LineWidth',3, 'Color', 'r');
    hold on;
    errorbar(mean([frac_global_ioncc_m1;frac_global_ioncc_m2;frac_global_ioncc_m3]), std([frac_global_ioncc_m1;frac_global_ioncc_m2;frac_global_ioncc_m3])/sqrt(3) ,'LineWidth',3, 'Color', 'b');
    errorbar(mean([frac_global_sham_m1;frac_global_sham_m2;frac_global_sham_m3;frac_global_sham_m4;frac_global_sham_m5;frac_global_sham_m6]),...
              std([frac_global_sham_m1;frac_global_sham_m2;frac_global_sham_m3;frac_global_sham_m4;frac_global_sham_m5;frac_global_sham_m6])/sqrt(6) ,'LineWidth',3, 'Color', 'k');
    hold off;
    
    ylim([0,0.8]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax5.LineWidth = 2;
    ax5.Box = false;
    ax5.TickDir = 'out';
    
    figure();
    ax5 = subplot(1,1,1);
    errorbar(mean([trace_AUC_m1;trace_AUC_m2;trace_AUC_m3]), std([trace_AUC_m1;trace_AUC_m2;trace_AUC_m3])/sqrt(3) ,'LineWidth',3, 'Color', 'r');
    hold on;
    errorbar(mean([trace_AUC_ioncc_m1;trace_AUC_ioncc_m2;trace_AUC_ioncc_m3]), std([trace_AUC_ioncc_m1;trace_AUC_ioncc_m2;trace_AUC_ioncc_m3])/sqrt(3) ,'LineWidth',3, 'Color', 'b');
    errorbar(mean([trace_AUC_sham_m1;trace_AUC_sham_m2;trace_AUC_sham_m3;trace_AUC_sham_m4;trace_AUC_sham_m5;trace_AUC_sham_m6]),...
              std([trace_AUC_sham_m1;trace_AUC_sham_m2;trace_AUC_sham_m3;trace_AUC_sham_m4;trace_AUC_sham_m5;trace_AUC_sham_m6])/sqrt(6) ,'LineWidth',3, 'Color', 'k');
    hold off;
    
%     ylim([0,0.8]);
    xticks([1,2,3,4,5,6]);
    xticklabels({'Day 0';'Day 3';'Day 7';'Day 14';'Day 21';'Day 28'});
    xtickangle(45);
    
    ax5.LineWidth = 2;
    ax5.Box = false;
    ax5.TickDir = 'out';
    
    disp('Ion-CC');
    [~,p1] = ttest2([frac_global_m1(1);frac_global_m2(1);frac_global_m3(1)], [frac_global_ioncc_m1(1);frac_global_ioncc_m2(1);frac_global_ioncc_m3(1)])
    [~,p4] = ttest2([frac_global_m1(4);frac_global_m2(4);frac_global_m3(4)], [frac_global_ioncc_m1(4);frac_global_ioncc_m2(4);frac_global_ioncc_m3(4)])
    [~,p5] = ttest2([frac_global_m1(5);frac_global_m2(5);frac_global_m3(5)], [frac_global_ioncc_m1(5);frac_global_ioncc_m2(5);frac_global_ioncc_m3(5)])
    [~,p6] = ttest2([frac_global_m1(6);frac_global_m2(6);frac_global_m3(6)], [frac_global_ioncc_m1(6);frac_global_ioncc_m2(6);frac_global_ioncc_m3(6)])
    disp('Sham');
    [~,p1] = ttest2([frac_global_m1(1);frac_global_m2(1);frac_global_m3(1)], [frac_global_sham_m1(1);frac_global_sham_m2(1);frac_global_sham_m3(1)])
    [~,p4] = ttest2([frac_global_m1(4);frac_global_m2(4);frac_global_m3(4)], [frac_global_sham_m1(4);frac_global_sham_m2(4);frac_global_sham_m3(4)])
    [~,p5] = ttest2([frac_global_m1(5);frac_global_m2(5);frac_global_m3(5)], [frac_global_sham_m1(5);frac_global_sham_m2(5);frac_global_sham_m3(5)])
    [~,p6] = ttest2([frac_global_m1(6);frac_global_m2(6);frac_global_m3(6)], [frac_global_sham_m1(6);frac_global_sham_m2(6);frac_global_sham_m3(6)])
    
end

function [frac_global,num_transients,global_AUC,ind_AUC,trace_AUC] = plot_CORR(plot_files, plot_title)

    auc_data = cell(length(plot_files),1);
    for i=1:length(plot_files)
        auc_data{i} = load(plot_files{i});
    end
    
    mean_frac_global = cell(length(plot_files),1);
    mean_num_transients = cell(length(plot_files),1);
    mean_num_ind_transients = cell(length(plot_files),1);
    mean_num_global_transients = cell(length(plot_files),1);
    
    frac_global = [];
    num_transients = [];
    num_ind_transients = [];
    num_global_transients = [];
    global_AUC = [];
    ind_AUC = [];
    trace_AUC = [];
    
    for i=1:length(plot_files)
        frac_global = [frac_global, nanmean(auc_data{i}.fraction_global_transients)];
        num_transients = [num_transients, nanmean(auc_data{i}.tot_num_transients)];
        num_ind_transients = [num_ind_transients, nanmean(auc_data{i}.tot_num_transients) - nanmean(auc_data{i}.num_global_transients)];
        num_global_transients = [num_global_transients, nanmean(auc_data{i}.num_global_transients)];
        
        global_AUC = [global_AUC, nanmean(auc_data{i}.tot_AUC_global)];
        ind_AUC = [ind_AUC, nanmean(auc_data{i}.tot_AUC_ind)];
        trace_AUC = [trace_AUC, nanmean(auc_data{i}.AUC_fulltrace)];
        
%         boxplot_grouping = [boxplot_grouping; i*ones(length(corr_data{i}.pairwise_corr(:)),1)];
%         boxplot_data = [boxplot_data; corr_data{i}.pairwise_corr(:)];
%         
%         mean_data = [mean_data, nanmean(corr_data{i}.pairwise_corr(:))];
%         mean_SEM = nanstd(corr_data{i}.pairwise_corr(:)) / sqrt(length(corr_data{i}.pairwise_corr(:)));
%         
%          % regression of correlation vs. event rate
%          mean_v_rate{i} = robustfit(corr_data{i}.geom_mean(:), corr_data{i}.geom_mean(:));
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
    plot(ax5,trace_AUC);
    ylabel('AUC fulltrace');
    
    close()
   
    
%     scatter(geomean_vs_corr, geomean1(:), pwcorr1(:), 'MarkerEdgeColor', 'k');
%     hold(geomean_vs_corr,'on');
%     plot(geomean_vs_corr,geomean1(:),brob1(1)+brob1(2)*geomean1(:),'k');
%     scatter(geomean_vs_corr, geomean2(:), pwcorr2(:), 'MarkerEdgeColor', 'r');
%     plot(geomean_vs_corr,geomean2(:),brob2(1)+brob2(2)*geomean2(:),'r');
%     hold(geomean_vs_corr,'off');
end