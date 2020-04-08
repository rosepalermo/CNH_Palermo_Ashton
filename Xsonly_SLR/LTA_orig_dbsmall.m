% Linear increase in the nourishment flux
clc; 
close all;
%% Input physical parameters%%%%%%%%%%%%%%%
B=0.001; %Basement slope
Dt=10;% Toe depth (meters). Typically in the range 10-20m
We=300; %Equilibrium width (meters)
He=2;  %Equilibrium heigth (meters)
Ae=0.02; %Equilibrium shoreface slope
Qow_max=30; %Maximum overwash flux (m^2/year)
Vd_max=300; %Maximum deficit volume (m^2/year)
K=5000;  %Shoreface Flux constant (m^2/year)

%% SL rise rate = a + 2bt %%%%%%%%%%%%%%%%
a=0.005;
b=0.000; % If b=0 constant sea-level rise

%% Computational parameters%%%%%%%%%%%%%%%
Tmax=1000; 
Interval=20;
dt=0.01;
t=0:dt:Tmax;n=length(t);
tt=0:Interval:Tmax;nt=length(tt);
plotnum = 10000;
%% Nourishment parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vn=100; % Nourishment Volume
k=1;
%% Initial conditions %%%%%%%%%%%%
A=Ae;W=We;H=He; %Barrier initially in equlibrium
xt=0;xs=Dt/A;xb=xs+W;xso=xs;Z=10;
Db=min(Z-B*xb,2); %Initial back barrier depth (meters) 
% X=Xo;
%% Variable initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
XS=zeros(1,n);
figure()
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
xsdot=2*Qow/(Dt+2*H)-4*Qsf*(H+Dt)/(2*H+Dt)^2;
xtdot=2*Qsf*(1/(Dt+2*H)+1/Dt)+2*zdot/A;
H=H+Hdot*dt; if H<0;tdrown_H = t(i);break; end
xb=xb+xbdot*dt;
xsold=xs;
xs=xs+xsdot*dt;
xt=xt+xtdot*dt;

%% Additional parameters
A=Dt/(xs-xt);
W=xb-xs;if W<0;tdrown_W=t(i);break; end
% Db = min(Z-B*xb,2);
Db = Z-B*xb;
Db_el_save(i)= Z- Db;
Z_save(i) = Z;
basement(i) = Z-(Z-B*xb);
% Variable storage %%%%%%%%%%%%%%%%%%%%
XS(i)=xs;

if (mod(i,plotnum)- 1 == 0)
hold on
% compute the z's
zt=Z-Dt; zs=Z; ztop=Z+H;
% plot the barrier parts
Xplot=[xt xs xs xb xb];
Zplot=[zt zs ztop ztop Z-Db ];
plot(Xplot,Zplot,'Color','k')
Xplot=[-Dt/B Dt/B];
Zplot=[-Dt Dt];
plot(Xplot,Zplot,'k')
plot([-1000 3000], [Z Z], 'b')
xlabel('onshore location (km)')
ylabel('elevation (m)')
set(gca,'fontweight','bold')
set(gca,'Fontsize', 12)
xlim([0 xb])
ylim([0 Z+5])
end
end
%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
hold on
plot(t,XS,'k','linewidth',1)
ylabel('Shoreline Position')
xlabel('time');
box on

figure()
hold on
plot(t,Db_el_save,'r','linewidth',1)
plot(t,basement,'k','linewidth',1)
plot(t,Z_save,'b','linewidth',1)
ylabel('Z')
xlabel('time')
legend('Db','basement','SLR')

%%
