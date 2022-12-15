%% set some basic parameters
flitc = '#FF0000';
ionc = '#0000FF';
shamc = '#008000';
carbac = '#319191';
decompc = '#000000';
ketc = '#319191';
gqc = '#752075';
gi = '#C0996B';


marker_size = 3.2;
line_width = 1;


%% WOOD WEIGHT CHANGE
datafile = "C:\Users\lfisc\Work\Projects\Shiqian\behavior graphs\Wood weight change.xlsx";

data = readmatrix(datafile);

data_SHAM_ION = data(:,2:19);
data_SHAM_FLIT = data(:,38:55);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_ION = data(:,20:37);
data_FLIT = data(:,56:73);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,1,1.4]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);

% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 0.05, 0.1, 0.15, 0.2, 0.25])
yticklabels({'0', '0.05', '0.1', '0.15', '0.2', '0.25'})

xlim([1,5]);
ylim([0,0.25])

hold off;

saveas(f,'Wood weight change','svg');


%% FOOD PREFERENCE
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Food preference.xlsx";

data = readmatrix(datafile);

data_SHAM_ION = data(:,2:19);
data_SHAM_FLIT = data(:,56:73);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_ION = data(:,38:55);
data_FLIT = data(:,20:37);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,1.3,1.7]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 20, 40, 60, 80, 100])
yticklabels({'0', '20', '40', '60', '80', '100'})

xlim([1,5]);
ylim([0,100])

hold off;

saveas(f,'Food preference','svg');

%% Gi_DREADD MECHANICAL WITHDRAWAL THRESHOLD

datafile = "C:\Users\lfisc\Work\Projects\Shiqian\Gi_DREADD\Mechanical.xlsx";

data = readmatrix(datafile);

data_VECTOR_Gi = data(:,1:8);
data_C21_Gi = data(:,9:16);
data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,1.5,2.0]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_C21_Gi,2), 'Color', gi, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gi, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_VECTOR_Gi,2), 'Color', 'k', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_C21_Gi, gi);
plot_shade(ax, data_x, data_VECTOR_Gi, '#000000');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6])
yticklabels({'0', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6'})

xlim([1,5]);
ylim([0,0.6])

hold off;

saveas(f,'Gi_DREADD Mechanical withdrawal threshold','svg');

%% Gi_DREADD SOLID CHOW

datafile = "C:\Users\lfisc\Work\Projects\Shiqian\Gi_DREADD\Solid chow.xlsx";

data = readmatrix(datafile);

data_VECTOR_Gi = data(:,1:8);
data_C21_Gi = data(:,9:16);
data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,1.5,2.0]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_C21_Gi,2), 'Color', gi, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gi, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_VECTOR_Gi,2), 'Color', 'k', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_C21_Gi, gi);
plot_shade(ax, data_x, data_VECTOR_Gi, '#000000');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 20, 40, 60, 80, 100])
yticklabels({'0', '20', '40', '60', '80', '100'})

xlim([1,5]);
ylim([0,100])

hold off;

saveas(f,'Gi_DREADD solid chow','svg');

%% Gi_DREADD BODY WEIGHT

datafile = "C:\Users\lfisc\Work\Projects\Shiqian\Gi_DREADD\Body weight.xlsx";

data = readmatrix(datafile);

data_VECTOR_Gi = data(:,1:8);
data_C21_Gi = data(:,9:16);
data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,3.0,2.0]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_C21_Gi,2), 'Color', gi, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gi, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_VECTOR_Gi,2), 'Color', 'k', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_C21_Gi, gi);
plot_shade(ax, data_x, data_VECTOR_Gi, '#000000');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([25, 27, 29, 31, 33, 35])
yticklabels({'25', '27', '29', '31', '33', '35'})

xlim([1,5]);
ylim([25,35])

hold off;

saveas(f,'Gi_DREADD body weight','svg');

%% Gi_DREADD BALSA WOOD

datafile = "C:\Users\lfisc\Work\Projects\Shiqian\Gi_DREADD\Balsa.xlsx";

data = readmatrix(datafile);

data_VECTOR_Gi = data(:,1:8);
data_C21_Gi = data(:,9:16);
data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,1.5,2.0]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_C21_Gi,2), 'Color', gi, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gi, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_VECTOR_Gi,2), 'Color', 'k', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_C21_Gi, gi);
plot_shade(ax, data_x, data_VECTOR_Gi, '#000000');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0.0, 0.1, 0.2, 0.3])
yticklabels({'0.0', '0.1', '0.2', '0.3'})

xlim([1,5]);
ylim([0,0.3])

hold off;

saveas(f,'Gi_DREADD balsa wood','svg');

%% Gi_DREADD INCISOR LENGTH

datafile = "C:\Users\lfisc\Work\Projects\Shiqian\Gi_DREADD\Incisors length.xlsx";

data = readmatrix(datafile);

data_VECTOR_Gi = data(:,1:8);
data_C21_Gi = data(:,9:16);
data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,3.0,2.0]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_C21_Gi,2), 'Color', gi, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gi, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_VECTOR_Gi,2), 'Color', 'k', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_C21_Gi, gi);
plot_shade(ax, data_x, data_VECTOR_Gi, '#000000');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([10, 11, 12, 13])
yticklabels({'10', '11', '12', '13'})

xlim([1,5]);
ylim([10,13])

hold off;

saveas(f,'Gi_DREADD incisor length','svg');


%% Gi_DREADD EYE GRIMACE
marker_size = 3.8;

datafile = "C:\Users\lfisc\Work\Projects\Shiqian\Gi_DREADD\Grimace.xlsx";

data = readmatrix(datafile);

data_VECTOR_Gi = data(:,1);
data_C21_Gi = data(:,2);
data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,1.5,2.0]);
ax = subplot(1,1,1);
plot(ax, data_x, data_C21_Gi', 'Color', gi,'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gi, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, data_VECTOR_Gi', 'Color', 'k', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 's', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'none');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 20, 40, 60, 80, 100])
yticklabels({'0', '20', '40', '60', '80', '100'})

xlim([1,5]);
ylim([0,100])

hold off;

saveas(f,'Gi_DREADD Eye grimace','svg');


%% MECHANICAL WITHDRAWAL THRESHOLD
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Mechanical withdrawal threshold.xlsx";

data = readmatrix(datafile);

data_SHAM_FLIT = data(:,2:19);
data_SHAM_ION = data(:,56:73);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_ION = data(:,38:55);
data_FLIT = data(:,20:37);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,1.7,1.6]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 0.1, 0.2, 0.3, 0.4])
yticklabels({'0', '0.1', '0.2', '0.3', '0.4'})

xlim([1,5]);
ylim([0,0.4])

hold off;

saveas(f,'Mechanical withdrawal threshold','svg');

%% EYE GRIMACE
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/eye contraction.xlsx";

data = readmatrix(datafile);

data_SHAM_FLIT = data(:,2);
data_SHAM_ION = data(:,4);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_ION = data(:,3);
data_FLIT = data(:,5);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,1,1.6]);
ax = subplot(1,1,1);
plot(ax, data_x, data_FLIT', 'Color', flitc,'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, data_ION', 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, data_SHAM_FLIT', 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 20, 40, 60, 80, 100])
yticklabels({'0', '20', '40', '60', '80', '100'})

xlim([1,5]);
ylim([0,100])

hold off;

saveas(f,'Eye grimace','svg');

%% URINE TESTOSTERONE
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Urine testosterone.xlsx";

data = readmatrix(datafile);

data_SHAM_FLIT = data(:,3:8);
data_SHAM_ION = data(:,21:26);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_ION = data(:,9:14);
data_FLIT = data(:,15:20);

data_x = [1,2,3,4];

f = figure('units','inches','position',[2,2,1,1.7]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 10, 20, 30, 40, 50])
yticklabels({'0', '10', '20', '30', '40', '50'})

xlim([1,4]);
ylim([0,50])

hold off;

saveas(f,'Urine testosterone','svg');

%% MOUNTING BEHAVIOR
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/mating behavior.xlsx";

data = readmatrix(datafile);

data_SHAM_FLIT = data(:,2:19);
data_SHAM_ION = data(:,38:55);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_ION = data(:,56:73);
data_FLIT = data(:,20:37);

data_x = [1,2,3,4];

f = figure('units','inches','position',[2,2,1,1.7]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5])
xticklabels({'0', '7', '14', '21'})

yticks([0, 50, 100, 150, 200])
yticklabels({'0', '50', '100', '150', '200'})

xlim([1,4]);
ylim([0,200])

hold off;

saveas(f,'mounting behavior','svg');

%% COMPOSITE SCORE FIG 1
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/composite score fig1.xlsx";

data = readmatrix(datafile);

data_SHAM_FLIT = data(:,2:19);
data_SHAM_ION = data(:,38:55);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_ION = data(:,56:73);
data_FLIT = data(:,20:37);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,1.3,1.7]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 5, 10, 15])
yticklabels({'0', '5', '10', '15'})

xlim([1,5]);
ylim([-1,15])

hold off;

saveas(f,'composite score','svg');

%% CARBAMAZEPINE MECHANICAL WITHDRAWAL
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Carba mechanical withdrawal.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2:11);
data_CARBA60 = data(:,12:21);

data_x = [1,2,3,4,5,6,7];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_CARBA60,2), std(data_CARBA60,0,2) ./ sqrt(length(data_CARBA60)), 'Color', carbac, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_SALINE,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_CARBA60,2), 'Color', carbac, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', carbac, 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_SALINE,flitc);
plot_shade(ax, data_x, data_CARBA60,carbac);

% errorbar(ax, data_x, mean(data_SALINE,2), std(data_SALINE,0,2) ./ sqrt(length(data_SALINE)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6, 7])
xticklabels({'0', '30', '60', '90', '120', '150', '180'})

yticks([0, 0.1, 0.2, 0.3, 0.4])
yticklabels({'0.0', '0.1', '0.2', '0.3', '0.4'})

xlim([1,7]);
ylim([0,0.4])

hold off;

saveas(f,'Carba withdrawal','svg');

%% CARBA 60 FACE GRIMACING
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Carba60 grimacing.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2);
data_CARBA60 = data(:,4);

data_x = [1,2,3,4,5,6,7];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
plot(ax, data_x, data_SALINE', 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, data_CARBA60', 'Color', carbac, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', carbac, 'MarkerEdgeColor', 'none');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6, 7])
xticklabels({'0', '30', '60', '90', '120', '150', '180'})

yticks([0, 20, 40, 60, 80, 100])
yticklabels({'0', '20', '40', '60', '80', '100'})

xlim([1,7]);
ylim([0,100])

hold off;

saveas(f,'Carba60 eye grimace','svg');

%% CARBAMAZEPINE FACE GROOMING
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Carba face grooming.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2:11);
data_CARBA60 = data(:,12:21);

data_x = [1,2,3,4,5,6,7];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_CARBA60,2), std(data_CARBA60,0,2) ./ sqrt(length(data_CARBA60)), 'Color', carbac, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_SALINE,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_CARBA60,2), 'Color', carbac, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', carbac, 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_SALINE,flitc);
plot_shade(ax, data_x, data_CARBA60,carbac);

% errorbar(ax, data_x, mean(data_SALINE,2), std(data_SALINE,0,2) ./ sqrt(length(data_SALINE)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6, 7])
xticklabels({'0', '30', '60', '90', '120', '150', '180'})

yticks([0, 2, 4, 6, 8, 10])
yticklabels({'0', '2', '4', '6', '8', '10'})

xlim([1,7]);
ylim([0,10])

hold off;

saveas(f,'Carba face grooming','svg');

%% DECOMPRESSION FACE GRIMACING
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Decompression grimace 2.xlsx";

data = readmatrix(datafile);

data_SHAM = data(:,2);
data_FLIT = data(:,3);
data_DECOMP = data(:,4);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
plot(ax, data_x, data_SHAM', 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, data_FLIT', 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, data_DECOMP', 'Color', decompc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 20, 40, 60, 80, 100])
yticklabels({'0', '20', '40', '60', '80', '100'})

xlim([1,5]);
ylim([-0.0,100])

hold off;

saveas(f,'Decompression eye grimace','svg');

%% DECOMPRESSION WOOD WEIGHT CHANGE
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Decompression balsa.xlsx";

data = readmatrix(datafile);

data_SHAM = data(:,2:11);
data_FLIT = data(:,12:21);
data_DECOMP = data(:,22:31);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% hold on;
% errorbar(ax, data_x, mean(data_DECOMP,2), std(data_DECOMP,0,2) ./ sqrt(length(data_DECOMP)), 'Color', decompc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');

plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_DECOMP,2), 'Color', decompc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_DECOMP,decompc);
plot_shade(ax, data_x, data_SHAM,shamc);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3])
yticklabels({'0', '0.05', '0.1', '0.15', '0.2', '0.25', '0.3'})

xlim([1,5]);
% ylim([0,0.25])

hold off;

saveas(f,'Decompression wood weight change','svg');

%% DECOMPRESSION COMPOSITE SCORE FIG 1
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Decompression z score 2.xlsx";

data = readmatrix(datafile);

data_SHAM = data(:,2:11);
data_DECOMP = data(:,22:31);
data_FLIT = data(:,12:21);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% hold on;
% errorbar(ax, data_x, mean(data_DECOMP,2), std(data_DECOMP,0,2) ./ sqrt(length(data_DECOMP)), 'Color', decompc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');

plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_DECOMP,2), 'Color', decompc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_DECOMP,decompc);
plot_shade(ax, data_x, data_SHAM,shamc);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 6, 12, 18])
yticklabels({'0', '6', '12', '18'})

xlim([1,5]);
ylim([-1,18])

hold off;

saveas(f,'Decompression composite score','svg');

%% Gq MECHANICAL WITHDRAWAL THRESHOLD
datafile = "C:\Users\lfisc\Work\Projects\Shiqian\behavior graphs\Gq_mechanical.xlsx";

data = readmatrix(datafile);

data_Gq_SHAM = data(:,2:8);
data_Gq_FLIT = data(:,9:16);
data_VECTOR_FLIT = data(:,17:24);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,1.7,1.6]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_VECTOR_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_Gq_FLIT,2), 'Color', gqc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gqc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_Gq_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_VECTOR_FLIT,flitc);
plot_shade(ax, data_x, data_Gq_FLIT,gqc);
plot_shade(ax, data_x, data_Gq_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

pbaspect([1.3 1 1]);

xticks([1, 2, 3, 4, 5])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6])
yticklabels({'0', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6'})

xlim([1,5]);
% ylim([0,0.4])

hold off;

saveas(f,'Gq Mechanical withdrawal threshold','svg');

%% Gq COMPOSITE SCORE FIG 1
datafile = "C:\Users\lfisc\Work\Projects\Shiqian\behavior graphs\Gq_composite_score.xlsx";

data = readmatrix(datafile);

data_Gq_SHAM = data(:,2:8);
data_Gq_FLIT = data(:,9:16);
data_VECTOR_FLIT = data(:,17:24);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% hold on;
% errorbar(ax, data_x, mean(data_DECOMP,2), std(data_DECOMP,0,2) ./ sqrt(length(data_DECOMP)), 'Color', decompc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');

plot(ax, data_x, mean(data_VECTOR_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_Gq_FLIT,2), 'Color', gqc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gqc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_Gq_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_VECTOR_FLIT,flitc);
plot_shade(ax, data_x, data_Gq_FLIT,gqc);
plot_shade(ax, data_x, data_Gq_SHAM,shamc);

plot_appearance(ax);

pbaspect([1.3 1 1]);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 6, 12, 18])
yticklabels({'0', '6', '12', '18'})

xlim([1,5]);
ylim([-1,18])

hold off;

saveas(f,'Gq composite score','svg');

figure;
boxplot_data = [data_Gq_SHAM(:,1), data_Gq_FLIT(:,1), data_VECTOR_FLIT(:,1),...
                data_Gq_SHAM(:,2), data_Gq_FLIT(:,2), data_VECTOR_FLIT(:,2)];
g = [ones(length(data_Gq_FLIT(:,1)),1); ones(length(data_Gq_SHAM(:,1)),1)*2; ones(length(data_VECTOR_FLIT(:,1)),1)*3;...
     ones(length(data_Gq_FLIT(:,2)),1)*4; ones(length(data_Gq_SHAM(:,2)),1)*5;ones(length(data_VECTOR_FLIT(:,1)),1)*6];

boxplot_colors = hex2rgb(['#008000';'#752075';'#FF0000']);

boxplot_data = boxplot_data(:);
boxplot(boxplot_data, g, 'Colors',boxplot_colors, 'Symbol','');

% hold on;
% scatter(g, boxplot_data(:));

% ylim([0,0.4]);
% yticks([0,0.1,0.2,0.3,0.4]);
% pbaspect([1 1 1]);
box off;
hold off;

%% Gq FACE GRIMACING
datafile = "C:\Users\lfisc\Work\Projects\Shiqian\behavior graphs\Gq_facial_grimace.xlsx";

data = readmatrix(datafile);

data_Gq_SHAM = data(:,2);
data_Gq_FLIT = data(:,3);
data_VECTOR_FLIT = data(:,4);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
plot(ax, data_x, data_Gq_SHAM', 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, data_VECTOR_FLIT', 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, data_Gq_FLIT', 'Color', gqc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gqc, 'MarkerEdgeColor', 'none');

plot_appearance(ax);

pbaspect([1.3 1 1]);

xticks([1, 2, 3, 4, 5])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 20, 40, 60, 80, 100])
yticklabels({'0', '20', '40', '60', '80', '100'})

xlim([1,5]);
ylim([-0.0,100])

hold off;

saveas(f,'Gq eye grimace','svg');

%% Gq Grooming
datafile = "C:\Users\lfisc\Work\Projects\Shiqian\behavior graphs\Gq_grooming.xlsx";

data = readmatrix(datafile);

data_Gq_SHAM = data(:,2:8);
data_Gq_FLIT = data(:,9:16);
data_VECTOR_FLIT = data(:,17:24);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% hold on;
% errorbar(ax, data_x, mean(data_DECOMP,2), std(data_DECOMP,0,2) ./ sqrt(length(data_DECOMP)), 'Color', decompc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');

plot(ax, data_x, mean(data_VECTOR_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_Gq_FLIT,2), 'Color', gqc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gqc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_Gq_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_VECTOR_FLIT,flitc);
plot_shade(ax, data_x, data_Gq_FLIT,gqc);
plot_shade(ax, data_x, data_Gq_SHAM,shamc);

plot_appearance(ax);

pbaspect([1.3 1 1]);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

% yticks([0, 6, 12, 18])
% yticklabels({'0', '6', '12', '18'})

xlim([1,5]);
% ylim([-1,18])

hold off;

saveas(f,'Gq grooming','svg');

%% Gq Balsa Wood
datafile = "C:\Users\lfisc\Work\Projects\Shiqian\behavior graphs\Gq_balsa_wood.xlsx";

data = readmatrix(datafile);

data_Gq_SHAM = data(:,2:8);
data_Gq_FLIT = data(:,9:16);
data_VECTOR_FLIT = data(:,17:24);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% hold on;
% errorbar(ax, data_x, mean(data_DECOMP,2), std(data_DECOMP,0,2) ./ sqrt(length(data_DECOMP)), 'Color', decompc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');

plot(ax, data_x, mean(data_VECTOR_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_Gq_FLIT,2), 'Color', gqc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gqc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_Gq_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_VECTOR_FLIT,flitc);
plot_shade(ax, data_x, data_Gq_FLIT,gqc);
plot_shade(ax, data_x, data_Gq_SHAM,shamc);

plot_appearance(ax);

pbaspect([1.3 1 1]);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

% yticks([0, 6, 12, 18])
% yticklabels({'0', '6', '12', '18'})

xlim([1,5]);
% ylim([-1,18])

hold off;

saveas(f,'Gq Balsa Wood','svg');

%% Gq Solid Food
datafile = "C:\Users\lfisc\Work\Projects\Shiqian\behavior graphs\Gq_Solid_food.xlsx";

data = readmatrix(datafile);

data_Gq_SHAM = data(:,2:8);
data_Gq_FLIT = data(:,9:16);
data_VECTOR_FLIT = data(:,17:24);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.3]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% hold on;
% errorbar(ax, data_x, mean(data_DECOMP,2), std(data_DECOMP,0,2) ./ sqrt(length(data_DECOMP)), 'Color', decompc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0, 'MarkerSize', 3, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');

plot(ax, data_x, mean(data_VECTOR_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_Gq_FLIT,2), 'Color', gqc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', gqc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_Gq_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_VECTOR_FLIT,flitc);
plot_shade(ax, data_x, data_Gq_FLIT,gqc);
plot_shade(ax, data_x, data_Gq_SHAM,shamc);

plot_appearance(ax);

pbaspect([1.3 1 1]);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

% yticks([0, 6, 12, 18])
% yticklabels({'0', '6', '12', '18'})

xlim([1,5]);
% ylim([-1,18])

hold off;

saveas(f,'Gq Solid Food','svg');

%% SUPP 1 FACE GROOMING
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Face grooming.xlsx";

data = readmatrix(datafile);

data_SHAM_FLIT = data(:,2:19);
data_SHAM_ION = data(:,56:73);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_FLIT = data(:,20:37);
data_ION = data(:,38:55);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);

% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 2, 4, 6, 8, 10])
yticklabels({'0', '2', '4', '6', '8', '10'})

xlim([1,5]);
ylim([0,10])

hold off;

saveas(f,'Supp 1 grooming','svg');

%% SUPP 1 BODY WEIGHT
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 1 body weight.xlsx";

data = readmatrix(datafile);

data_SHAM_FLIT = data(:,2:19);
data_SHAM_ION = data(:,56:73);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_FLIT = data(:,20:37);
data_ION = data(:,38:55);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);

% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([20, 25, 30, 35])
yticklabels({'20', '25', '30', '35'})

xlim([1,5]);
ylim([20,35])

hold off;

saveas(f,'Supp 1 body weight','svg');

%% SUPP 1 INCISOR LENGTH
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 1 Incisor length.xlsx";

data = readmatrix(datafile);

data_SHAM_ION = data(:,2:19);
data_SHAM_FLIT = data(:,38:55);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_ION = data(:,20:37);
data_FLIT = data(:,56:73);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);

% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([10, 11, 12, 13])
yticklabels({'10', '11', '12', '13'})

xlim([1,5]);
ylim([10,13])

hold off;

saveas(f,'Supp 1 Incisor length','svg');

%% SUPP 1 SOFT FOOD PREFERENCE
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 1 food preference.xlsx";

data = readmatrix(datafile);

data_SHAM_FLIT = data(:,2:19);
data_SHAM_ION = data(:,56:73);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_FLIT = data(:,20:37);
data_ION = data(:,38:55);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);

% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 20, 40, 60, 80, 100])
yticklabels({'0', '20', '40', '60', '80', '100'})

xlim([1,5]);
ylim([0,100])

hold off;

saveas(f,'Supp 1 Food Preference','svg');

%% SUPP 1 SHAM COMPOSITE SCORE
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 1 shame z-score.xlsx";

data = readmatrix(datafile);

data_SHAM_FLIT = data(:,2:19);
data_SHAM_ION = data(:,20:37);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_SHAM_FLIT,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_SHAM_ION,2), 'Color', shamc, 'LineStyle', '--', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
% plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_SHAM_FLIT,shamc);
plot_shade(ax, data_x, data_SHAM_ION,'#007000');
% plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

% yticks([0, 5, 10, 15])
% yticklabels({'0', '5', '10', '15'})

xlim([1,5]);
ylim([-5,5])

hold off;

saveas(f,'Supp 1 composite score','svg');

%% SUPP 2 MECHANICAL
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 2 mechanical.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2:13);
data_BTX = data(:,14:25);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_SALINE,2), 'Color', '#000000', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', '#000000', 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_BTX,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_SALINE,'#000000');
plot_shade(ax, data_x, data_BTX,flitc);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0.0, 0.1, 0.2, 0.3, 0.4])
yticklabels({'0.0', '0.1', '0.2', '0.3', '0.4'})

xlim([1,5]);
ylim([0,0.4])

hold off;

saveas(f,'Supp 2 mechanical','svg');

%% SUPP 2 GROOMING
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 2 grooming.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2:13);
data_BTX = data(:,14:25);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_SALINE,2), 'Color', '#000000', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', '#000000', 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_BTX,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_SALINE,'#000000');
plot_shade(ax, data_x, data_BTX,flitc);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 1, 2, 3, 4, 5])
yticklabels({'0', '1', '2', '3', '4', '5'})

xlim([1,5]);
ylim([0,5])

hold off;

saveas(f,'Supp 2 grooming','svg');

%% SUPP 2 body weight
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 2 body weight.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2:13);
data_BTX = data(:,14:25);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_SALINE,2), 'Color', '#000000', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', '#000000', 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_BTX,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_SALINE,'#000000');
plot_shade(ax, data_x, data_BTX,flitc);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([20, 22, 24, 26, 28, 30])
yticklabels({'20', '22', '24', '26', '28', '30'})

xlim([1,5]);
ylim([20,30])

hold off;

saveas(f,'Supp 2 body weight','svg');

%% SUPP 2 Incisor Length
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 1 Incisor length.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2:13);
data_BTX = data(:,14:25);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_SALINE,2), 'Color', '#000000', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', '#000000', 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_BTX,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_SALINE,'#000000');
plot_shade(ax, data_x, data_BTX,flitc);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([8, 9, 10, 11, 12])
yticklabels({'8', '9', '10', '11', '12'})

xlim([1,5]);
ylim([8,12])

hold off;

saveas(f,'Supp 2 incisor length','svg');

%% SUPP 2 WOOD WEIGHT
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 2 wood weight.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2:13);
data_BTX = data(:,14:25);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_SALINE,2), 'Color', '#000000', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', '#000000', 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_BTX,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_SALINE,'#000000');
plot_shade(ax, data_x, data_BTX,flitc);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0.0, 0.1, 0.2, 0.3])
yticklabels({'0.0', '0.1', '0.2', '0.3'})

xlim([1,5]);
ylim([0,0.3])

hold off;

saveas(f,'Supp 2 wood weight','svg');

%% SUPP 3 MOUNTING BEHAVIOR
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 3 mounting.xlsx";

data = readmatrix(datafile);

data_SHAM_ION = data(:,2:19);
data_SHAM_FLIT = data(:,38:55);
data_SHAM = horzcat(data_SHAM_ION,data_SHAM_FLIT);
data_ION = data(:,20:37);
data_FLIT = data(:,56:73);



data_x = [1,2,3,4];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_ION,2), 'Color', ionc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ionc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_ION,ionc);
plot_shade(ax, data_x, data_SHAM,shamc);

% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5])
xticklabels({'0', '7', '14', '21'})

yticks([0, 10, 20, 30, 40, 50])
yticklabels({'0', '10', '20', '30', '40', '50'})

xlim([1,4]);
ylim([0,50])

hold off;

saveas(f,'Supp 3 mounting','svg');

%% SUPP 10 MECHANICAL
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 10 mechanical.xlsx";

data = readmatrix(datafile);

data_SHAM = data(:,2:11);
data_DECOMP = data(:,22:31);
data_FLIT = data(:,12:21);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_DECOMP,2), 'Color', decompc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_DECOMP,decompc);
plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 0.1, 0.2, 0.3, 0.4])
yticklabels({'0', '0.1', '0.2', '0.3', '0.4'})

xlim([1,5]);
ylim([0,0.4])

hold off;

saveas(f,'Supp 10 mechanical','svg');

%% SUPP 10 GROOMING
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 10 grooming.xlsx";

data = readmatrix(datafile);

data_SHAM = data(:,2:11);
data_DECOMP = data(:,22:31);
data_FLIT = data(:,12:21);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_DECOMP,2), 'Color', decompc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_DECOMP,decompc);
plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 4, 8, 12])
yticklabels({'0', '4', '8', '12'})

xlim([1,5]);
ylim([0,12])

hold off;

saveas(f,'Supp 10 grooming','svg');

%% SUPP 9 MECHANICAL
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 9 ket mechanical.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2:11);
data_BTX = data(:,12:21);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_SALINE,2), 'Color', '#000000', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', '#000000', 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_BTX,2), 'Color', ketc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ketc, 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_SALINE,'#000000');
plot_shade(ax, data_x, data_BTX,ketc);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0.0, 0.05, 0.1])
yticklabels({'0.0', '0.05', '0.1'})

xlim([1,5]);
ylim([0,0.1])

hold off;

saveas(f,'Supp 9 mechanical','svg');

%% SUPP 9 GROOMING
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 9 ket grooming.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2:11);
data_BTX = data(:,12:21);

data_x = [1,2,3,4,5];

% length(data_FLIT,1)
% std(data_FLIT,0,2) ./ length(data_FLIT);

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, mean(data_SALINE,2), 'Color', '#000000', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', '#000000', 'MarkerEdgeColor', 'none');
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
hold on;
plot(ax, data_x, mean(data_BTX,2), 'Color', ketc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ketc, 'MarkerEdgeColor', 'none');

plot_shade(ax, data_x, data_SALINE,'#000000');
plot_shade(ax, data_x, data_BTX,ketc);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 4, 8, 12])
yticklabels({'0', '4', '8', '12'})

xlim([1,5]);
ylim([0,12])

hold off;

saveas(f,'Supp 9 grooming','svg');

%% DECOMPRESSION FACE GRIMACING
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 9 ket grimace.xlsx";

data = readmatrix(datafile);

data_SALINE = data(:,2);
data_KET = data(:,3);


data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
plot(ax, data_x, data_SALINE', 'Color', '#000000', 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', '#000000', 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, data_KET', 'Color', ketc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', ketc, 'MarkerEdgeColor', 'none');

plot_appearance(ax);

xticks([1, 2, 3, 4, 5])
xticklabels({'0', '7', '14', '21', '28'})

yticks([0, 20, 40, 60, 80, 100])
yticklabels({'0', '20', '40', '60', '80', '100'})

xlim([1,5]);
ylim([-0.0,100])

hold off;

saveas(f,'Supp 9 ket grimace','svg');

%% SUPP 10 INCISOR LENGTH
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 10 incisor.xlsx";

data = readmatrix(datafile);

data_SHAM = data(:,2:11);
data_DECOMP = data(:,22:31);
data_FLIT = data(:,12:21);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_DECOMP,2), 'Color', decompc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_DECOMP,decompc);
plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([10, 11, 12, 13])
yticklabels({'10', '11', '12', '13'})

xlim([1,5]);
ylim([10,13])

hold off;

saveas(f,'Supp 10 incisor','svg');

%% SUPP 10 BODYWEIGHT
datafile = "/Users/lukasfischer/Work/exps/Shiqian/behavior graphs/Supp 10 bodyweight.xlsx";

data = readmatrix(datafile);

data_SHAM = data(:,2:11);
data_DECOMP = data(:,22:31);
data_FLIT = data(:,12:21);

data_x = [1,2,3,4,5];

f = figure('units','inches','position',[2,2,2,1.7]);
ax = subplot(1,1,1);
% errorbar(ax, data_x, mean(data_FLIT,2), std(data_FLIT,0,2) ./ sqrt(length(data_FLIT)), 'Color', flitc, 'LineWidth',1, 'CapSize',0);
plot(ax, data_x, mean(data_FLIT,2), 'Color', flitc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', flitc, 'MarkerEdgeColor', 'none');
hold on;
plot(ax, data_x, mean(data_DECOMP,2), 'Color', decompc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', decompc, 'MarkerEdgeColor', 'none');
plot(ax, data_x, mean(data_SHAM,2), 'Color', shamc, 'LineWidth',line_width, 'MarkerSize', marker_size, 'Marker', 'o', 'MarkerFaceColor', shamc, 'MarkerEdgeColor', 'none');
plot_shade(ax, data_x, data_FLIT,flitc);
plot_shade(ax, data_x, data_DECOMP,decompc);
plot_shade(ax, data_x, data_SHAM,shamc);
% errorbar(ax, data_x, mean(data_ION,2), std(data_ION,0,2) ./ sqrt(length(data_ION)), 'Color', ionc, 'LineWidth',1, 'CapSize',0);
% errorbar(ax, data_x, mean(data_SHAM,2), std(data_SHAM,0,2) ./ sqrt(length(data_SHAM)), 'Color', shamc, 'LineWidth',1, 'CapSize',0);

plot_appearance(ax);

xticks([1, 2, 3, 4, 5, 6])
xticklabels({'0', '7', '14', '21', '28'})

yticks([20, 25, 30, 35])
yticklabels({'20', '25', '30', '35'})

xlim([1,5]);
ylim([20,35])

hold off;

saveas(f,'Supp 10 bodyweight','svg');


%%

function plot_shade(ax, x_data, y_data, col)
%     str = '#FF0000';
    col2 = sscanf(col(2:end),'%2x%2x%2x',[1 3])/255;   % stupid fucking workaround for Matlab not being able to use hexcodes everywhere
    fill(ax, [x_data, fliplr(x_data)], [mean(y_data,2)' + (std(y_data,0,2)' ./ sqrt(length(y_data))'), fliplr(mean(y_data,2)' - (std(y_data,0,2)' ./ sqrt(length(y_data))'))], col2, 'FaceAlpha',.3, 'EdgeColor','none');
end

function plot_appearance(ax)
%     box(ax,'off');
    ax.Box = 'off';
    ax.LineWidth = 0.5;
    ax.TickDir = 'out';
    ax.FontName = 'Arial';
    ax.FontSize = 8;
end