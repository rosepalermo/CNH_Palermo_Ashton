% Linear increase in the nourishment flux
clc; 
% close all;
%% Input physical parameters%%%%%%%%%%%%%%%
B=0.001; %Basement slope
Dt=10;% Toe depth (meters). Typically in the range 10-20m
We=300; %Equilibrium width (meters)
He=2;  %Equilibrium heigth (meters)
Ae=0.015; %Equilibrium shoreface slope
Qow_max=100; %Maximum overwash flux (m^2/year)
Vd_max=300; %Maximum deficit volume (m^2/year)
K=10000;  %Shoreface Flux constant (m^2/year)

%% SL rise rate = a + 2bt %%%%%%%%%%%%%%%%
a=0.004;
b=0.000; % If b=0 constant sea-level rise

%% Computational parameters%%%%%%%%%%%%%%%
Tmax=100; 
Interval=20;
dt=0.01;
t=0:dt:Tmax;n=length(t);
tt=0:Interval:Tmax;nt=length(tt);
%% Nourishment parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vn=100; % Nourishment Volume
k=1;
%% Initial conditions %%%%%%%%%%%%
A=Ae;W=We/3;H=He*3; %Barrier initially in equlibrium
xt=0;xs=Dt/A;xb=xs+W;xso=xs;Z=Dt;
Db=Z-B*xb; %Initial back barrier depth (meters) 
% X=Xo;
%% Variable initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
XS=zeros(1,n);
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
Db=Z-xb*B;
% Variable storage %%%%%%%%%%%%%%%%%%%%
XS(i)=xs;
end
%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(t,XS,'b','linewidth',1)
ylabel('Shoreline Position')
xlabel('time');
yline(XS(1)+100,'b')
box on

