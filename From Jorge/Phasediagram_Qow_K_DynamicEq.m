% Barrier geometric model. Linear shoreface. Cte sea-level rise.
clc; 
%%Input physical parameters%%%%%%%%%%%%%%%
B=0.001; %Basement slope
Dt=10;% Toe depth (meters). Typically in the range 10-20m
We=300; %Equilibrium width (meters)
He=2;  %Equilibrium heigth (meters)
Ae=0.02; %Equilibrium shoreface slope
Vd_max=100; %Maximum deficit volume (m^2/year)
a=0.002;
b=0;
%%% Initial conditions %%%%%%%%%%%%
A=Ae;
W=We;
H=He; %Barrier initially in equlibrium
% H=2;
% W=300;
xt=0;xs=Dt/A;xb=xs+W;xso=xs;Z=Dt;
Db=Z-B*xb; %Initial back barrier depth (meters) 

%% Computational parameters%%%%%%%%%%%%%%%
Tmax=1000; %Runing time (years)
dt=0.01;    
t=0:dt:Tmax;nt=length(t);
qmin=0;qmax=100;kmin=0;kmax=10000;
Qow_max=qmin:5:qmax; nq=length(Qow_max);
K=kmin:100:kmax;  nk=length(K);
tdrown_H=zeros(nq,nk); tdrown_W=zeros(nq,nk);
SHmax=zeros(nq,nk);SHmean=zeros(nq,nk);
W1=zeros(1,nt);W2=zeros(1,nt);QOW=zeros(1,nt);Ztoe=zeros(1,nt);
A1=zeros(1,nt);H1=zeros(1,nt);
WWamp=zeros(nq,nk);WWpeak=zeros(nq,nk);Npeak=zeros(nq,nk);QOWmean=zeros(nq,nk);
%% Main code%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:nq
for j=1:nk    
for i=1:nt
zdot=a+2*b*t(i); %Base-level rise rate (m/year)
Z=Z+zdot*dt;
Vd_H=(He-H+zdot*dt)*W;if Vd_H<0; Vd_H=0;end
Vd_B=(We-W)*(H+Db);if Vd_B<0; Vd_B=0;end
Vd=Vd_H+Vd_B;
if Vd<Vd_max;  %Equivalent to if Qow>Qow_max; Qow=Qow_max;end
Qow_H=Qow_max(k)*Vd_H/Vd_max;
Qow_B=Qow_max(k)*Vd_B/Vd_max;
else
Qow_H=Qow_max(k)*Vd_H/Vd;
Qow_B=Qow_max(k)*Vd_B/Vd;
end
Qow=Qow_H+Qow_B;
QOW(i)=Qow;
Qsf=K(j)*(Ae-A);
Hdot=Qow_H/W-zdot;
xbdot=Qow_B/(H+Db);
xsdot=2*Qow/(Dt+2*H)-4*Qsf*(H+Dt)/(2*H+Dt)^2;
xtdot=2*Qsf*(1/(Dt+2*H)+1/Dt)+2*zdot/A;
xb=xb+xbdot*dt;
xs=xs+xsdot*dt;
xt=xt+xtdot*dt;
H=H+Hdot*dt;if H<0;tdrown_H(k,j)= t(i);break; end
A=Dt/(xs-xt);
Db=Z-xb*B;
W=xb-xs;if W<0;tdrown_W(k,j)= t(i);break; end
W1(i)=W;
A1(i)=A;
H1(i)=H;
Ztoe(i)=Z-Dt-B*xt;
end
%%%% Dynamic equilibrium%%%%%%%%%%%%
W_de=We-a/B*Vd_max/Qow_max(k);
H_de=He-a*Vd_max/Qow_max(k);
p=4*K(j)*B/Dt*((H_de+Dt)/(2*H_de+Dt));
bb=p*Ae-a;
A_de=(bb+(bb^2+8*B*p*a)^0.5)/(2*p);
Db_de=Dt*(1-B/A_de)-B*W_de;
Qow_de=a/B*(H_de+Db_de)+a*W_de;
Qsf_de=K(j)*(Ae-A_de);

% %% Is it Discontinuous Retreat? %%%%%%%%%%%% findpeaks2
W2=W1(1/dt:nt);
W2mean=mean(W2);
[pks,locs]=findpeaks(W2-W2mean);
u=length(pks);
if u>=1;Amean=mean(pks);Alast=pks(u);
    if Amean>1 && Alast>0.8*Amean;WWpeak(k,j)=200;else WWpeak(k,j)=-200;end
else WWpeak(k,j)=-200;  
end


%% Is it dynamic Equilibrium? %%%%%%%%%%%
W3=W1(nt-100:nt);nw3=length(W3);
A3=A1(nt-100:nt);na3=length(A3);
H3=H1(nt-100:nt);nh3=length(H3);
ZT3=Ztoe(nt-100:nt);zt3=length(ZT3);
for kk=1:nw3; W3(kk)=abs(W3(kk)-W_de);end
for kk=1:na3; A3(kk)=abs(A3(kk)-A_de);end
for kk=1:nh3; H3(kk)=abs(H3(kk)-H_de);end
for kk=1:zt3; ZT3(kk)=abs(ZT3(kk));end
if WWpeak(k,j)==-200 && sum(W3)/nw3<5 && sum(A3)/na3<0.001 && sum(H3)/nh3<0.1 && sum(ZT3)/nh3<0.05;...
        WWpeak(k,j)=400; end

%%%%%%%%%%
% Ztoe2=Ztoe(50/dt:nt);
% Ztoe_mean=mean(Ztoe2);
% [pks,locs]=findpeaks(Ztoe-Ztoe_mean);
% u=length(pks);
% if u>1;Amean=mean(pks);Alast=pks(u);
%     if Alast>0.8*Amean;WWpeak(k,j)=200;WWamp(k,j)=Amean; else WWpeak(k,j)=100;WWamp(k,j)=Amean;end
% elseif u==1;Amean=mean(pks);WWpeak(k,j)=100;WWamp(k,j)=Amean;
% else WWpeak(k,j)=-200;  
% end

%Re-initialitation
W=We; H=He; A=Ae; xt=0;xs=Dt/A;xb=xs+W;Z=Dt;Db=Z-B*xb; 
W1=zeros(1,nt);A1=zeros(1,nt);H1=zeros(1,nt);
end
end
% save test
PHASE_subroutine_dynamicEquilibrium
% contour(K,Qow_max,WWpeak)
% contour(K,Qow_max,WWamp)
% xlabel('K');ylabel('Q_{ow,max}');
% for j=1:1:nk    
%     hold on
%     plot(Qow_max, QOWmean(:,j))
% end
% xlabel('Q_{ow,max}');ylabel('Q_{ow,mean}');
