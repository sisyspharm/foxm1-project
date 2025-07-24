close all; clear; clc;
warning('off','all');

FPath = '/Users/heng/Dropbox/Macbook Pro/Projects/FOXM1 project/Experiments/EXP2020-02-16 LiveFitParams CLS Live v9';
FName = 'mydata.mat';

load(fullfile(FPath,FName));

is_save = 0;
if is_save==1; mkdir(fullfile(FPath,'Figure')); end

color = [ 40 81 255
    254 57 32 ]./255;

color2 = [ 186 195 233
    40 81 255
    239 201 196
    254 57 32 ]./255;

color5 = [ 0 0 0
    200 236 12
    112 243 0
    52 183 0
    36 127 0 ]./255;

x = linspace(-2.5,12,30)';
% x = (1:30)';

%# ####### Get data ####### #%
y = s.no_treatment_tmp.cell_mean(:,[1,3,4,5,6]); %(:,[1,4]);
z = s.no_treatment_tmp.cell_std(:,[1,3,4,5,6]); %(:,[1,4]);

n = size(y,2);

%# Correction time 7,8
y_offset = y(6:9,1) - linspace(y(6,1),y(9,1),9-6+1)';
y_offset = y_offset(2:3);
y([7,8],:) = y([7,8],:) - y_offset;
clear y_offset;

% %# Correction time 15,16
y_offset = y(14:17,1) - linspace(y(14,1),y(17,1),17-14+1)';
y_offset = y_offset(2:3);
y([15,16],:) = y([15,16],:) - y_offset;
clear y_offset;

for i = 1:n
y(6:9,i) = linspace(y(6,i),y(9,i),9-6+1);
y(17:20,i) = linspace(y(17,i),y(20,i),20-17+1);
end
clear i;

f = fit(x,y(:,1),'poly4');
y = y ./ f(x);
z = z ./ f(x);

f = fit(x(1:9),y(1:9,1),'poly2');
y(1:9,:) = y(1:9,:) ./ f(x(1:9));

for i = 1:n
    f = fit(x(1:6),y(1:6,i),'poly2');
    y(1:6,i) = y(1:6,i) ./ f(x(1:6));
end
clear i;
for i = 1:n
    y(1:6,i) = smooth(y(1:6,i),20);
    y(6:end,i) = smooth(y(6:end,i),20);
    
    z(:,i) = smooth(z(:,i),20);
end
clear i;

z = z ./ 10;

%%
clc;

st = 6;
fitpars = [];

fig = figure('units','normalized','position',[0.2 0.2 0.4 0.45]); hold on;
for i = 2:5

xd = x(st:end).*60; % mins
yd = y(st:end,i) - y(st,i);

%# Michaelis–Menten kinetics with nth order
x0 = [1 100 1]; 
fitfun = fittype( @(a,b,c,x) a.* (x.^c) ./ (b + (x.^c)) );
[fitted_curve,gof] = fit(xd,yd,fitfun,...
    'StartPoint',x0,...
    'Lower',[ 0 0 1 ],...
    'Upper',[ 10 1e3 1 ]);

fitpars = [ fitpars ; [ fitted_curve.a fitted_curve.b fitted_curve.c ]];

xf = linspace(xd(1),xd(end),1000)';
yf = fitted_curve(xf);

fprintf('Fitting parameters #%d >>> \n',i);
disp(fitted_curve);
fprintf('\n');

pl = plot(xd,yd,'.');
pl.MarkerSize = 40;
pl.Color = color5(i,:);

pl = plot(xf,yf,'-');
pl.LineWidth = 6;
pl.Color = color5(i,:);

end
clear i;

xlim([ 0 720 ]);
xticks(0:120:720);
xticklabels(0:2:12);
ylim([ 0 0.5 ]);
yticks(0:0.1:0.5);
xlabel('Time (hr)');
ylabel('dFOXM1 cell intensity');
set(gca,'fontsize',28,'linewidth',3);
box on;

if is_save==1; saveas(fig,fullfile(FPath,'Figure','TMP Experiment - No Treatment - Mean Intensity - Fitted'),'png'); close all; end
clear fig fl pl li;


%{
Output Parameters on each condition:

Fitting parameters #2 >>> 
     General model:
     fitted_curve(x) = a.*(x.^c)./(b+(x.^c))
     Coefficients (with 95% confidence bounds):
       a =      0.1601  (0.1487, 0.1715)
       b =       314.7  (-170.4, 799.7)
       c =       1.333  (0.9653, 1.701)

Fitting parameters #3 >>> 
     General model:
     fitted_curve(x) = a.*(x.^c)./(b+(x.^c))
     Coefficients (with 95% confidence bounds):
       a =      0.2542  (0.2304, 0.278)
       b =       645.1  (-235.8, 1526)
       c =        1.33  (1.018, 1.641)

Fitting parameters #4 >>> 
     General model:
     fitted_curve(x) = a.*(x.^c)./(b+(x.^c))
     Coefficients (with 95% confidence bounds):
       a =      0.3438  (0.3098, 0.3778)
       b =       718.1  (40.75, 1395)
       c =       1.257  (1.041, 1.474)

Fitting parameters #5 >>> 
     General model:
     fitted_curve(x) = a.*(x.^c)./(b+(x.^c))
     Coefficients (with 95% confidence bounds):
       a =      0.6577  (0.5708, 0.7446)
       b =       143.7  (100.8, 186.6)
       c =      0.8427  (0.7489, 0.9365)
%}

%%
clc;

%# PLOT V_MAX
fig = figure('units','normalized','position',[0.1 0.2 0.25 0.55]); hold on;
for i = 1:4
    br = bar(i,fitpars(i,1));
    br.LineWidth = 3;
    br.FaceColor = color5(i+1,:);
    br.BarWidth = 0.7;
end
clear i;
title('V_{max}','fontsize',32);
xlabel('TMP (uM)');
ylabel('V_{max} (RFU)');
xlim([ 0.3 4.8 ]);
ylim([ 0 0.6 ]);
xticks(1:4);
xticklabels({'0.4','4','40','400'});
set(gca,'fontsize',28,'linewidth',3);
box on;
if is_save==1; saveas(fig,fullfile(FPath,'Figure','TMP Experiment - No Treatment - Mean Intensity - Fitted - Vmax'),'png'); close all; end
clear fig fl pl li;
 
%# PLOT K_M
fig = figure('units','normalized','position',[0.4 0.2 0.25 0.55]); hold on;
for i = 1:4
    br = bar(i,fitpars(i,2));
    br.LineWidth = 3;
    br.FaceColor = color5(i+1,:);
    br.BarWidth = 0.7;
end
clear i;
title('K_M','fontsize',32);
xlabel('TMP (uM)');
ylabel('K_M (min)');
xlim([ 0.3 4.8 ]);
ylim([ 0 300 ]);
xticks(1:4);
xticklabels({'0.4','4','40','400'});
set(gca,'fontsize',28,'linewidth',3);
box on;
if is_save==1; saveas(fig,fullfile(FPath,'Figure','TMP Experiment - No Treatment - Mean Intensity - Fitted - Km'),'png'); close all; end
clear fig fl pl li;

%%
is_save = 0;

%# PLOT CORRELATION BETWEEN V_MAX AND CONC_TMP
fig = figure('units','normalized','position',[0.7 0.2 0.22 0.5]); hold on;

xc = log10([0.4,4,40,400])'; %# Conc
yc = fitpars(:,1); %# Vmax

[fcx,gof] = fit(xc,yc,'poly1');
xcf = linspace(xc(1),xc(end),1000)';
ycf = fcx(xcf);


% mdl = fitlm(xc,yc);
% rsquare = mdl.Rsquared.Ordinary;
% fprintf('R-square of simple linear regression: %0.4f\n',rsquare);

% Calculate Pearson correlation coefficient
[R, P] = corrcoef(xc, yc);

% Extract the correlation coefficient (r) and p-value
r = R(1,2); % Correlation coefficient
p_value = P(1,2); % P-value

% Calculate r squared (coefficient of determination)
r_squared = r^2;

% Display the results
fprintf('Pearson correlation coefficient (r): %f\n', r);
fprintf('Coefficient of determination (r^2): %f\n', r_squared);
fprintf('P-value: %f\n', p_value);


for i = 1:numel(xc)
    pl = plot(xc(i),yc(i),'o');
    pl.MarkerSize = 40;
    pl.MarkerEdgeColor = color5(i+1,:); %[155 45 255]./255;
    pl.MarkerFaceColor = color5(i+1,:); %[155 45 255]./255;
end

pl = plot(xcf,ycf,'-');
pl.Color = 'k';
pl.LineWidth = 8;
pl.MarkerSize = 10;

xlabel('log_{10}(TMP) (uM)');
ylabel('V_{max} (RFU)');

xlim([ -1 3 ]);
ylim([ 0.1 0.6 ]);
yticks(0.1:0.1:0.6);

% %# ADD R-SQUARE TEXT
% tx = text(-0.8,0.56,sprintf('r2 = %-0.4f',gof.rsquare));
% tx.FontSize = 16;
% tx.HorizontalAlignment = 'left';
% tx.VerticalAlignment = 'bottom';

set(gca,'fontsize',28,'linewidth',3);
box on;
if is_save==1; saveas(fig,fullfile(FPath,'Figure','TMP Experiment - No Treatment - Mean Intensity - Fitted - Correlation - Vmax - Conc'),'png'); close all; end
clear fig fl pl li;
