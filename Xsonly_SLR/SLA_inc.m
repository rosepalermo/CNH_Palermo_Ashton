% Increasing vs constant sea level rise scenarios
% Rose Palermo GCC 2019

% close all; 
clear all;
% constant = 0;
% increasing = ~constant;
start004 = 0;
plotslx_on = 1;
Mqow = 100;%[1:2:50];
slr = [0.5 1.0 1.5 2.0];
output = nan(length(Mqow),length(slr),2);
tdrown_total = nan(length(Mqow),length(slr),2);
xsend = nan(length(Mqow),length(slr),2);
kplot = 1;
for k = [2 4]
    title_txt = ["0.5 m";"1.0 m";"1.5 m";"2.0 m"];
    if plotslx_on
    figure()
    end
for inc = 1:2
    ccc = [1 0];
    plot_color = ["k";"r"];
    constant = ccc(inc);
    increasing = ~constant;
for mm = 1:length(Mqow)
    Qow_max = Mqow(mm);
%% Input physical parameters%%%%%%%%%%%%%%%
B=0.001; %Basement slope
Dsf=10;% Toe depth (meters). Typically in the range 10-20m
We=300; %Equilibrium width (meters)
He=2;  %Equilibrium heigth (meters)
Ae=0.015; %Equilibrium shoreface slope
% Qow_max=100; %Maximum overwash flux (m^2/year)
Vd_max=300; %Maximum deficit volume (m^2/year)
K=10000;  %Shoreface Flux constant (m^2/year)

%% SL rise rate = a + 2bt %%%%%%%%%%%%%%%%

if increasing;  % increasing sea level rise scenarios (SERDP table 3.4)
    a = 1.7e-3;
    
    Bb(1) = 2.71262e-5;     % Scenario 0.5
    Bb(2) = 6.9993141e-5;   % Scenario 1.0
    Bb(3) = 1.12860082e-4;  % Scenario 1.5
    Bb(4) = 1.55727023e-4;  % Scenario 2.0
    b = Bb(k);
elseif constant;        % constant sea level rise scenarios
    b=0.000; % If b=0 constant sea-level rise
    
    Aa(1) = 0.0046; % Scenario 0.5 (1992 - 2100)
    Aa(2) = 0.0093; % Scenario 1.0 (1992 - 2100)
    Aa(3) = 0.0139; % Scenario 1.5 (1992 - 2100)
    Aa(4) = 0.0185; % Scenario 2.0 (1992 - 2100)
    a = Aa(k);
end



%% Computational parameters%%%%%%%%%%%%%%%
Tmax=108; 
Interval=20;
dt=0.01;
t=0:dt:Tmax;n=length(t);
if start004
    T{1} = 9.2:dt:Tmax;
    T{2} = 5.7:dt:Tmax;
    T{3} = 4.5:dt:Tmax;
    T{4} = 3.8:dt:Tmax;
    t = cell2mat(T(k));n=length(t);
end

tt=0:Interval:Tmax;nt=length(tt);
%% Nourishment parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vn=100; % Nourishment Volume
%% Initial conditions %%%%%%%%%%%%
A=Ae;W=We;H=He; %Barrier initially in equlibrium
xt=0;xs=Dsf/A;xb=xs+W;xso=xs;Z=Dsf;
Db=Z-B*xb; %Initial back barrier depth (meters) 
% X=Xo;
%% Variable initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
XS=nan(1,n);
XSchange=nan(1,n);
H_save = nan(1,n);
W_save = nan(1,n);

for i=1:n
%% SL curve
zdot=a+2*b*t(i); %Base-level rise rate (m/year)
Z=Z+zdot*dt;
%% Deficit volume Vd, overwash flux Qow, and shoreface flux Qsf
Vd_H=max(0,(He-H)*W);
Vd_B=max(0,(We-W)*(H+Db));
Vd=Vd_H+Vd_B;
Qow_H=Qow_max*Vd_H/max(Vd,Vd_max);Qow_B=Qow_max*Vd_B/max(Vd,Vd_max);
Qow=Qow_H+Qow_B;
Qsf=K*(Ae-A);
%% Barrier evolution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Hdot=Qow_H/W-zdot;
xbdot=Qow_B/(H+Db);
xsdot=2*Qow/(Dsf+2*H)-4*Qsf*(H+Dsf)/(2*H+Dsf)^2;
xtdot=2*Qsf*(1/(Dsf+2*H)+1/Dsf)+2*zdot/A;
H=H+Hdot*dt; 
if H<0;
    tdrown_H = t(i);
    output(mm,k,inc) = 1;
    tdrown_total(mm,k,inc) = t(i);
    xsend(mm,k,inc) = XS(i-1)-XS(1);
    break;
end
xb=xb+xbdot*dt;
xsold=xs;
xs=xs+xsdot*dt;
xt=xt+xtdot*dt;

%% Additional parameters
A=Dsf/(xs-xt);
W=xb-xs;
if W<0;tdrown_W=t(i);
    output(mm,k,inc) = 2;
    tdrown_total(mm,k,inc) = t(i);
    xsend(mm,k,inc) = XS(i-1)-XS(1);
    break;
end
Db=Z-xb*B;
% Variable storage %%%%%%%%%%%%%%%%%%%%
XS(i)=xs;
XSchange(i)=xs-XS(1);
H_save(i) = H;
W_save(i) = W;
if isnan(xs)
    isnan(xs)
end

end
% save final shoreline change
if isnan(xsend(mm,k,inc))
    xsend(mm,k,inc) = XS(end)-XS(1);
end

if plotslx_on
% %plot
figure(1*k*kplot)
hold on
plot(t,XSchange,'k','linewidth',2,'Color',plot_color(inc))
ylabel('Shoreline location (m)')
xlabel('time (yrs)');
title(title_txt(k));
set(gca,'FontSize',18)
% ylim([0 1000])
xlim([0 Tmax])
xline(108,'--','linewidth',0.5,'HandleVisibility','off');
legend('constant','increasing','location','southeast')

figure(2*k*kplot)
hold on
plot(t(1:end-1),XSchange(2:end)-XSchange(1:end-1),'k','linewidth',2,'Color',plot_color(inc))
% ylabel('Shoreline location (m)')
ylabel('Transgression rate (m/yr)')
xlabel('time (yrs)');
title(title_txt(k));
set(gca,'FontSize',18)
% ylim([0 1000])
xlim([0 Tmax])
xline(108,'--','linewidth',0.5,'HandleVisibility','off');
legend('constant','increasing','location','southeast')

figure(3*k*kplot)
hold on
plot(t,W_save,'k','linewidth',2,'Color',plot_color(inc))
ylabel('Barrier width (meters)')
xlabel('time (yrs)');
title(title_txt(k));
set(gca,'FontSize',18)
% ylim([0 1000])
xlim([0 Tmax])
xline(108,'--','linewidth',0.5,'HandleVisibility','off');
legend('constant','increasing','location','southeast')

% % box on
if exist('tdrown_W')
    scatter(tdrown_W,XSchange(find(t == tdrown_W)-1),'b','*','HandleVisibility','off');
%     legend('constant','increasing','drown','location','northwest')
elseif exist('tdrown_H')
    scatter(tdrown_H,XSchange(find(t == tdrown_H)-1),'g','*','HandleVisibility','off');
%     legend('constant','increasing','drown','location','northwest')
end
end
clearvars tdrown_W tdrown_H

end
end
kplot = kplot+1;
end
%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure();
% subplot(2,1,1); 
% f1 = imagesc(slr,Mqow,output(:,:,1)); 
% set(f1,'AlphaData',~isnan(output(:,:,1)))
% set(gca,'Ydir','normal')
% title('Constant')
% ylabel('Qow max (m^3/m/yr')
% xlabel('SLR Scenario')
% set(gca,'FontSize',12)
% caxis([1 2])
% xticks(slr)
Hdrown_pct = length(find(output(:,:,1)==1))./sum(~isnan(output(:,:,1)),'all')

% subplot(2,1,2);
% f2 = imagesc(slr,Mqow,output(:,:,2)); 
% set(f2,'AlphaData',~isnan(output(:,:,2)))
% set(gca,'Ydir','normal')
% title('Increasing')
% ylabel('Qow max (m^3/m/yr')
% xlabel('SLR Scenario')
% set(gca,'FontSize',12)
% caxis([1 2])
% xticks(slr)
Wdrown_pct = length(find(output(:,:,2)==1))./sum(~isnan(output(:,:,2)),'all')

% 
% figure();
% subplot(2,1,1); 
% f1 = imagesc(slr,Mqow,tdrown_total(:,:,1)); 
% set(f1,'AlphaData',~isnan(tdrown_total(:,:,1)))
% set(gca,'Ydir','normal')
% title('Constant')
% ylabel('Qow max (m^3/m/yr')
% xlabel('SLR Scenario')
% set(gca,'FontSize',12)
% caxis([50 200])
% xticks(slr)
% colorbar
% 
% subplot(2,1,2);
% f2 = imagesc(slr,Mqow,tdrown_total(:,:,2)); 
% set(f2,'AlphaData',~isnan(tdrown_total(:,:,2)))
% set(gca,'Ydir','normal')
% title('Increasing')
% ylabel('Qow max (m^3/m/yr')
% xlabel('SLR Scenario')
% set(gca,'FontSize',12)
% caxis([50 200])
% xticks(slr)
% colorbar

% figure();
% subplot(2,1,1); 
% f1 = imagesc(slr,Mqow,xsend(:,:,1)); 
% set(f1,'AlphaData',~isnan(xsend(:,:,1)))
% % set(gca,'Ydir','normal')
% title('Constant')
% ylabel('Qow max (m^3/m/yr')
% xlabel('SLR Scenario')
% set(gca,'FontSize',12)
% xticks(slr)
% colorbar
% 
% subplot(2,1,2);
% f2 = imagesc(slr,Mqow,xsend(:,:,2)); 
% set(f2,'AlphaData',~isnan(xsend(:,:,2)))
% % set(gca,'Ydir','normal')
% title('Increasing')
% ylabel('Qow max (m^3/m/yr')
% xlabel('SLR Scenario')
% set(gca,'FontSize',12)
% xticks(slr)
% colorbar