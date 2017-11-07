%% Barrier geometric model with coupled Alongshore. %%%%%%%%%%%%%%%
% Jorge Lorenzo Trueba adopted by Andrew Ashton starting 2-2015
% adopted by Rose Palermo starting 2-2016

%clear;
%close all;
% what I put into wolfram to solve Wn vs W
%8*(1e6*(x1+x2)^0.085-1e6*x1^0.085)=1e6+5/2 * x2 * 400 * 10 + 5* x2 * 2* 400

%% Run parameters
%runs = [330:-10:300];
runs = [320];
runn = length(runs);               % change var (or number to have something the length of the total number of runs)
                    % which n is running
% run1 Height Drowning
%Qow_max =5; Ksf = 10000;
% run 2 Width Drowning
%Qow_max =80; Ksf = 500;
% run 3 Dynamic Equilibrium
%Qow_max =30; Ksf = 10000;
% run 4 Periodic retreat
%Qow_max =60; Ksf = 10000;


% Time
Tmax = 100;    % Runing time (years)-- was 500 years
Tsteps = 100;    % time steps per year
Tsave = 0.5;     % Save T how often (years), can be float

% Space
dy = 100; % Spacing alongshore (m)
Yn = 80; % number of Y cells

% SL rise rate = a + bt
sl_a = 0.003; %m/yr
sl_b = 0; % If b=0 constant sea-level rise

% Barrier Variables - here assume these are constant across barrier, these
% could also be varied for some cases perhaps
Dsf = 10; % Shoreface Toe depth (meters). Typically in the range 10-20m
We = 300; % Equilibrium width (meters)
He = 2;   % Equilibrium heigth (meters)
Ae = 0.015;    % Equilibrium shoreface slope3
Qow_max = 30;% Maximum overwash flux (m^2/year)
Vd_max = 100; % Maximum deficit volume (m^2)
Ksf = 10000;  % Shoreface Flux constant (m^2/year)
Bslope = 0.001; %basement slope
Wstart = We;    %starting width of the barrier

% Alongshore input physical parameters
To= 8; % Wave period (seconds)
Ho= 1; % Wave heigth (m) (sic Jorge)
astfac = .5; % fractional diffusivity (i.e. angular wave distribution reduces diffusivity by what)
% some alongshore coefficients
K2=0.34/2*astfac; %m^(3/5)s^(-6/5)
Ka=K2*Ho^(12/5)*To^(1/5) * 365*86400; %convert to m^3/year

%%%% Community controls
Wn1 = 20; %width to add in nourishment
Wn2 = 20; %width to add in nourishment




%%%% Cost Benefit Analysis Controls--- (Slott 2008)
f = 1e6;    % fixed cost of nourishment
%the property value of the communities will become a dynamic term
%this is where I will add something having to do with multiple existing
%properties and their value relative to distance from oceanfront and width
%of the beach 
alpha1 = 1e6;       % property value of community 1
alpha2 = 1e6;     % property value of community 2
c = 5;              % unit cost of sand /volume
b = 0.085;          % exponent from Landry 2007--whole community
%b = 0.2;          %ocean f6ont properties only

% Plot Control
plottimes = 8;
xaspect = 1.5; yaspect = 1.5;
%xshoreplot = 1.5;
fs = 14;

%% Initialize Variables

%%%% Time
dt = 1/Tsteps;   % time steps (years)
t=0:dt:Tmax;    % real time array
ts=length(t);   % time steps
ti = 1:ts;      % time i's
tsavetimes = Tmax/Tsave;
tsavei = 1:(tsavetimes+1); % array of save time
plotnum = floor(Tmax/plottimes/dt);
savenum = Tmax/tsavetimes/dt;


%%%% Alongshore array dimensions
Y=0:dy:Yn*dy;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

%% after run 1 comment out this section

tnourished1 = zeros(ts,length(runs));
tnourished2 = zeros(ts,length(runs));
tmanret1 = zeros(ts,length(runs));
tmanret2 = zeros(ts,length(runs));
inourished1 = nan(ts,length(runs));
inourished2 = nan(ts,length(runs));
imanret1 = nan(ts,length(runs));
imanret2 = nan(ts,length(runs));
TBtwN1 = nan(ts,length(runs));
TBtwN2 = nan(ts,length(runs));
TBtwMR1 = nan(ts,length(runs));
TBtwMR2 = nan(ts,length(runs));
%%%% Cost Benefit Analysis stuff
Beta1 = zeros(ts,length(runs));
Beta2 = zeros(ts,length(runs));
Cost1 = zeros(ts,length(runs));
Cost2 = zeros(ts,length(runs));
NB1 = zeros(ts,length(runs));
NB2 = zeros(ts,length(runs));

%%



% open figure and squeeze
% Fig1 = figure(1);
% figpos = get(Fig1, 'Position');
% figpos(3) = figpos(3)* xaspect;
% figpos(4) = figpos(4) * yaspect;
% set(Fig1,'Position',figpos)

%% TIME LOOP %%%%%%%%%%%%%%%%%%%%
for runn=1:runn
    %input variables
    Wstart=runs(runn);
    %Wstart=400;
    %%%% Set community locations
    jjcom = zeros(size(Yi));
    jjcom1 = 31:35;             % 1 represents community 1
    jjcom2 = 36:40;             % 2 represents community 2
    location1 = 700;            % cross shore location of comm 1
    location2 = 700;            % cross shore location of comm 2
    locationdiff = location1 - location2;
    W1 = zeros(ts,length(jjcom1));   % for width of beach in front of comm1
    W2 = zeros(ts,length(jjcom2));   % for width of beach in front of comm2
    propertysize = 50;          % width of properties (cross-shore)
    nproperties = 2;              % number of properties per dy
    dem = 8000;                  % estimated cost of demolishing a home ~1500-2000 sq ft
    L1 = (jjcom1(end)-jjcom1(1))*dy;    %length of comm 1
    L2 = (jjcom2(end)-jjcom2(1))*dy;    %length of comm 2
    %xsl(jjcom)=xbb(jjcom)-Wcom;   % sl in front of communities if different
    notcomm = setdiff(Yi,jjcom); %part of the shoreline not on community
    
    %%%% Sea level
    Z=0;             % trying z= 0 which is the sea level

    %%%% Set the Domain Variables for the barrier
    B=ones(1,ys) * Bslope; % Basement Slope, can be different
    xtoe(Yi)=0;            % X toe
    xsl(Yi)=Dsf/Ae;        % X shoreline
    W(Yi)=Wstart;          % Barrier width (m)
    xbb(Yi)=xsl(Yi)+W(Yi); % X backbarrier
    H(Yi) =He;             % barrier height
    
    %%%% Zero the Save Variables
    Xtoe_save = zeros(tsavetimes, ys);
    Xsl_save = zeros(tsavetimes, ys);
    Xb_save = zeros(tsavetimes, ys);
    H_save= zeros(tsavetimes, ys);
    
    
    figure()
for i=1:ts
    % SL curve
    zdot = sl_a+2*sl_b*t(i); %Base-level rise rate (m/year)
    Z = Z+zdot*dt;
    
    % Re/Set run variables
    F = zeros(1,ys); % alongshore flux zero
    
    %% CROSS-SHORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j = 1:ys
        
        % Compute local geometries from the saved arrays
        A=Dsf/(xsl(j)-xtoe(j)); % Shoreface Slope
        W=xbb(j)-xsl(j);    % Barrier Width
        Db= Dsf + Z - xbb(j)*B(j); % This is set from the original domain - could use some work
        % Compute Deficit volume Vd, overwash flux Qow, and shoreface flux Qsf
        %Deficit Volume
        Vd_H=(He-H(j))*W;
        if Vd_H<0
            Vd_H=0;
        end
        Vd_B=(We-W)*(H(j)+Db);
        if Vd_B<0
            Vd_B=0;
        end
        Vd=Vd_H+Vd_B;
        
        %overwash flux
        if Vd<Vd_max 
            Qow_H=Qow_max*Vd_H/Vd_max;
            Qow_B=Qow_max*Vd_B/Vd_max;
        else
            Qow_H=Qow_max*Vd_H/Vd;
            Qow_B=Qow_max*Vd_B/Vd;
        end

        if ismember(j,jjcom1(:)) %for this test, community 1 is residential, so -40%OW (Rogers et al 2015)
            Qow_B = 0.6*Qow_B;
            Qow_H = 0.6*Qow_H;
        end
        
        if ismember(j,jjcom2(:)) %for this test, community 2 is commerical, so -90%OW (Rogers et al 2015)
            Qow_B = 0.1*Qow_B;
            Qow_H = 0.1*Qow_H;
        end
        
        Qow=Qow_H+Qow_B;
        %shoreface flux
        Qsf=Ksf*(Ae-A);
        
        % Barrier evolution ----
        % compute changes
        Hdot=Qow_H/W-zdot;
        xbdot=Qow_B/(H(j)+Db);
        xsdot=2*Qow/(Dsf+2*H(j))-4*Qsf*(H(j)+Dsf)/(2*H(j)+Dsf)^2;
        xtdot=2*Qsf*(1/(Dsf+2*H(j))+1/Dsf)+2*zdot/A;
        
        % Do changes- look for failure
        H(j)=H(j)+Hdot*dt;
        if H(j)<0
            tdrown_H=ti(i);
            break;
        end
        xbb(j)=xbb(j)+xbdot*dt;
        xsl(j)=xsl(j)+xsdot*dt;
        xtoe(j)=xtoe(j)+xtdot*dt;
        if xbb(j)-xsl(j)<0
            tdrown_W=ti(i);
            break;
        end
    end
    
    %% ALONG-SHORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % compute de fluxes - fluxes across rt cell border
    for j=1:(ys-1)
        F(j) = (Ka * dt) * (xsl(j+1) - xsl(j))/dy;
        %             F(j)=Ka/(2*(H(j)+H(j-1))/2+Dsf)*(xsl(j)-xsl(j-1))*dt*3650;
    end
    F(ys) = (Ka * dt) * (xsl(1) - xsl(ys))/dy;
    
    % change the shoreline
    for j=2:(ys)
        heff = H(j) + Dsf;
        dsl = (F(j)-F(j-1))/dy/heff; % note positive sl change = erosion
        xsl(j) = xsl(j) + dsl;
    end
    
    heff = H(1) + Dsf;
    dsl = (F(1)-F(ys))/dy/heff;
    xsl(1) = xsl(1) + dsl;
    
    %nourishment width and volume
%     Wn1 = xsl(jjcom1) - location1;
%     Wn2 = xsl(jjcom2) - location2;
% this is something that can be optimized. Right now this is crap.

    W1(i,:) = (location1 - xsl(jjcom1)); %beach width
    W2(i,:) = (location2 - xsl(jjcom2)); %beach width

    %Vnn1= 0.5 * mean(Wn1) * L1 * Dsf + mean(Wn1) * mean(H) * L1;
    %Vnn2= 0.5 * mean(Wn2) * L2 * Dsf + mean(Wn2) * mean(H) * L2;
    Xvnn1 = [mean(xsl(jjcom1)),mean(xsl(jjcom1))-Wn1,mean(xtoe(jjcom1))];
    Xvnn2 = [mean(xsl(jjcom2)),mean(xsl(jjcom2))-Wn2,mean(xtoe(jjcom2))];
    Yvnn= [0,0,Dsf];
   Vnn1 = polyarea(Xvnn1,Yvnn)+Wn1*mean(H(jjcom1));
   Vnn2 = polyarea(Xvnn2,Yvnn)+Wn2*mean(H(jjcom2));

    %% here is where an economic model should go
    
    %Beta1 = alpha1 * mean(W1+Wn1)^b;
    Beta1(i,runn) = nproperties*L1/dy * (alpha1 * ((Wn1+mean(W1(i,:)))^b) - alpha1 * mean(W1(i,:))^b);
    Cost1(i,runn) = f + c/2 * Wn1 * L1 * Dsf + c * Wn1 * mean(H(jjcom1)) * L1;
    NB1(i,runn) = Beta1(i,runn)-Cost1(i,runn);
    if min(W1(i,:))<=1
        Beta1mr(i,runn) = nproperties*L1/dy * (alpha1 * ((propertysize+mean(W1(i,:)))^b-mean(W1(i,:))^b)); 
        %Cost1mr(i,runn) = dem*dy/nproperties*propertysize + alpha1*nproperties*L1/dy;
        Cost1mr(i,runn) = alpha1*nproperties*L1/dy;
        NB1mr(i,runn) = Beta1mr(i,runn)-Cost1mr(i,runn);
    end
    
  
    
    %Beta2 = alpha2 * mean(W2+Wn2)^b;
    Beta2(i,runn) = nproperties*L2/dy * (alpha2 * ((Wn2+mean(W2(i,:)))^b) - alpha2 * mean(W2(i,:))^b);
    Cost2(i,runn) = f + c/2 * Wn2 * L2 * Dsf + c * Wn2 * mean(H(jjcom2)) * L2;
    NB2(i,runn) = Beta2(i,runn)-Cost2(i,runn);
    if min(W2(i,:))<=1
        Beta2mr(i,runn) = nproperties*L2/dy * (alpha2 * ((propertysize+mean(W2(i,:)))^b-mean(W2(i,:))^b));
        %Cost2mr(i,runn) = dem*dy/nproperties*propertysize + alpha2*nproperties*L2/dy;
        Cost2mr(i,runn) = alpha2*nproperties*L2/dy;
        NB2mr(i,runn) = Beta2mr(i,runn)-Cost2mr(i,runn);
    end
   
    

    
%     %% nourishing
% % 
% %        if mean(xsl(jjcom1)) >= location1
% %            disp('need to make decision')
% %        end
% %        if mean(xsl(jjcom2)) >= location2
% %            disp('need to make decision 2')
% %        end
% %        
% %        
% %if (rem(t,1)==0) % option to nourish once a year
%        %community 1
%         %if (mean(xsl(jjcom1)) >= location1) && (Beta1 > Cost1)
%         if mean(W1(i,:))>0 && NB1(i,runn)>0
%             xsl(jjcom1) = xsl(jjcom1) - 2*Vnn1/(2*mean(H(jjcom1))+Dsf);
%             tnourished1(i,runn) = 1;
%             %disp('nourished 1')
%             %nourished_time1=i
%         elseif min(W1(i,:))<=0 && NB1mr(i,runn)<NB1(i,runn)
%             xsl(jjcom1) = xsl(jjcom1) - 2*Vnn1/(2*mean(H(jjcom1))+Dsf);
%             tnourished1(i,runn) = 1;
% %             disp('test')
%         elseif min(W1(i,:))<=0 && NB1mr(i,runn)>NB1(i,runn)
%             location1 = mean(xsl(jjcom1))+propertysize;
%             tmanret1(i,runn) = 1;
%             %recalculate width
%             W1(i,:) = (location1 - xsl(jjcom1)); %beach width
%         elseif mean(W1(i,:))>0 && NB1(i,runn)<0
%             xsl(jjcom1) = xsl(jjcom1);
%         end
%         
%         
%        %community 2
%         if mean(W2(i,:))>0 && NB2(i,runn)>0
%             xsl(jjcom2) = xsl(jjcom2) - 2*Vnn2/(2*mean(H(jjcom2))+Dsf);
%             tnourished2(i,runn) = 1;
%             %disp('nourished 1')
%             %nourished_time1=i
%         elseif min(W2(i,:))<=0 && NB2mr(i,runn)<NB2(i,runn)
%             xsl(jjcom2) = xsl(jjcom2) - 2*Vnn2/(2*mean(H(jjcom2))+Dsf);
%             tnourished2(i,runn) = 1;           
%         elseif min(W2(i,:))<=0 && NB2mr(i,runn)>NB2(i,runn)
%             location2 = mean(xsl(jjcom2))+propertysize;
%             tmanret2(i,runn) = 1;
%             %recalculate width
%             W2(i,:) = (location2 - xsl(jjcom2)); %beach width
%         elseif mean(W2(i,:))>0 && NB2(i,runn)<0
%             xsl(jjcom2) = xsl(jjcom2);
%         end
% %end
%   
%         

    %% Variable storage ?
    if (mod(i,savenum)- 1 == 0)
        tsi = (i-1)/savenum +1;
        Xtoe_save(tsi,:) = xtoe;
        Xsl_save(tsi,:) = xsl;
        Xb_save(tsi,:) = xbb;
        H_save(tsi,:)= H;
    end
    
    %% Plots
    if (mod(i,plotnum)- 1 == 0)
        i;

        
        % PLAN VIEW
        axes2 = subplot(3,1,2);
        box(axes2,'on');
        hold(axes2,'all');
        
        hold on
        plot(Y/1000,xsl/1000,'b', 'linewidth',2)
        plot(Y/1000,xbb/1000,'r', 'linewidth',2)
        
        plot(Y(jjcom1)/1000,xsl(jjcom1)/1000,'c','linewidth',2)
        plot(Y(jjcom2)/1000,xsl(jjcom2)/1000,'m','linewidth',2)
        
%         dxsl=diff(xsl);
%         dY=0:dy:(Yn*dy-1);
%         plot(dY,dxsl,'k', 'linewidth',2)
        
  %      patch([Y/1000 flip(Y/1000)],[xsl/1000 flip(xbb/1000)],'k')
        
        xlabel('alongshore location (km)')
        ylabel('onshore location (km)')
        
        axis([0 max(Y)/1000 0.5 (max(xbb)+100)/1000])
        %axis([0 7 0.4 1.25])
        set(gca,'fontweight','bold')
        set(gca,'Fontsize', fs)
        
        
        axes3 = subplot(3,1,3);
%         box(axes3,'on');
%         hold(axes3,'all');
        hold on
        %comm1
        jplot = floor((jjcom1(1)+jjcom1(end))./2); % Which profile youre plotting
        % compute the z's
        Db= Dsf - xbb(j)*B(j); zt=Z-Dsf; zs=Z; ztop=Z+H(j);
        % plot the barrier parts
        Xplot=[xtoe(jplot) xsl(jplot) xsl(jplot) xbb(jplot) xbb(jplot)]/1000;
        Zplot=[zt     zs     ztop   ztop   -Db ];
        plot(Xplot,Zplot,'c')
        
        %comm2
        jplot = floor((jjcom2(1)+jjcom2(end))./2); % Which profile youre plotting
        % compute the z's
        Db= Dsf - xbb(j)*B(j); zt=Z-Dsf; zs=Z; ztop=Z+H(j);
        % plot the barrier parts
        Xplot=[xtoe(jplot) xsl(jplot) xsl(jplot) xbb(jplot) xbb(jplot)]/1000;
        Zplot=[zt     zs     ztop   ztop   -Db ];
        plot(Xplot,Zplot,'m')
        
        % plot a shoreface
        Xplot=[-Dsf/B(j) Dsf/B(j)]/1000;
        Zplot=[-2*Dsf 0];
        plot(Xplot,Zplot,'k')
        plot([-1000 2000], [Z Z], 'b')
        axis([0 (max(xbb)+100)/1000 -10 5 ])
        xlabel('onshore location (km)')
        ylabel('elevation (m)')
        set(gca,'fontweight','bold')
        set(gca,'Fontsize', fs)
    end
end

%% calculate things to plot about nourishment
% number of times nourished
nnourished1(1,runn) = sum(tnourished1(:,runn),1)
nnourished2(1,runn) = sum(tnourished2(:,runn),1)
% which times nourished
inourished1(1:nnourished1(1,runn),runn) = find(tnourished1(:,runn)>0);
inourished2(1:nnourished2(1,runn),runn) = find(tnourished2(:,runn)>0);
% time between nourishments
TBtwN1(1:nnourished1(1,runn)-1,runn) = diff(inourished1(1:nnourished1(1,runn),runn))/Tsteps;
TBtwN2(1:nnourished2(1,runn)-1,runn) = diff(inourished2(1:nnourished2(1,runn),runn))/Tsteps;


nmanret1(1,runn) = sum(tmanret1(:,runn))
nmanret2(1,runn) = sum(tmanret2(:,runn))
imanret1(1:nmanret1(1,runn),runn) = find(tmanret1(:,runn)>0);
imanret2(1:nmanret2(1,runn),runn) = find(tmanret2(:,runn)>0);
TBtwMR1(1:nmanret1(1,runn)-1,runn) = diff(imanret1(1:nmanret1(1,runn),runn))/Tsteps;
TBtwMR2(1:nmanret2(1,runn)-1,runn) = diff(imanret2(1:nmanret2(1,runn),runn))/Tsteps;

meanW1(:,runn) = mean(W1,2);
meanW2(:,runn) = mean(W2,2);
diffW = mean(meanW1(find(meanW1>0)))-mean(meanW2(find(meanW2>0)));

% nourished vs action 
action1 = nnourished1+nmanret1;
action2 = nnourished2+nmanret2;
fnour1 = nnourished1/action1;
fnour2 = nnourished2/action2;
fro1 = nmanret1/action1;
fro2 = nmanret2/action2;

%%
% time plot
axes1 = subplot(3,1,1);
box(axes1,'on');
hold(axes1,'all');

jplot = floor((jjcom1(1)+jjcom1(end))./2); %plot middle of com1
%ppp = Xsl_save(:,jplot)
plot(tsavei*Tsave,Xsl_save(:,jplot)/1000,'b', 'linewidth',2)
plot(tsavei*Tsave,Xb_save(:,jplot)/1000,'r', 'linewidth',2)


%jplot = floor(Yn/2)    %plot middle of comm2
jplot = floor((jjcom2(1)+jjcom2(end))./2);  %plot community 2
plot(tsavei*Tsave,Xsl_save(:,jplot)/1000,'--b', 'linewidth',2)
plot(tsavei*Tsave,Xb_save(:,jplot)/1000,'--r', 'linewidth',2)


%axis([0 Tmax 0.5 (max(xbb)+100)/1000])
% axis([0 Tmax 0.6 0.9])
xlabel('time (years)')
ylabel('onshore location (km)')
%legend('Shoreline A','Backbarrier A','Shoreline B','Backbarrier B','location','se')
legend('Shoreline 1','Shoreline 2','location','se')
set(gca,'fontweight','bold')
set(gca,'Fontsize', fs)
str=sprintf('Run %d: Max Overwash = %d and K = %d',runn,Qow_max,Ksf);
title(str)
set(gcf,'PaperPositionMode','auto')

figure()
hold on
scatter(NB1(inourished1(1:nnourished1(1,runn),runn),runn),meanW1(inourished1(1:nnourished1(1,runn),runn),runn),'c')
scatter(NB2(inourished2(1:nnourished2(1,runn),runn),runn),meanW2(inourished2(1:nnourished2(1,runn),runn),runn),'m')
xlabel('Net Benefit')
ylabel('mean Width of community before nourishment (m)')
legend('Community 1','Community 2')
str=sprintf('Run %d: Max Overwash = %d and K = %d',runn,Qow_max,Ksf);
title(str)
set(gca,'fontweight','bold')
set(gca,'Fontsize', fs)
set(gcf,'PaperPositionMode','auto')
% 
% figure()
% hold on
% scatter(Cost1(:,runn),Beta1(:,runn),'c','.')
% scatter(Cost2(:,runn),Beta2(:,runn),'m','.')
% xlabel('Cost')
% ylabel('Benefit')
% legend('Community 1','Community 2')
% str=sprintf('Run %d: Max Overwash = %d and K = %d',runn,Qow_max,Ksf);
% title(str)
% set(gca,'fontweight','bold')
% set(gca,'Fontsize', fs)
% set(gcf,'PaperPositionMode','auto')
end
% %%
% figure()
% for runn=1:length(runs)
%     hold on
%     scatter(NB1(inourished1(1:nnourished1(1,runn),runn),runn),meanW1(inourished1(1:nnourished1(1,runn),runn),runn))
%     %scatter(NB2(inourished2(1:nnourished2(1,runn),runn),runn),meanW2(inourished2(1:nnourished2(1,runn),runn)),'m')
% end
% xlabel('Net Benefit')
% ylabel('mean Width of community before nourishment (m)')
% legend('Community 1','Community 2')
% str=sprintf('Run %d: Max Overwash = %d and K = %d',runn,Qow_max,Ksf);
% title(str)
% set(gca,'fontweight','bold')
% set(gca,'Fontsize', fs)
% set(gcf,'PaperPositionMode','auto')
% 
% figure()
% for runn=1:length(runs)
%     hold on
%     scatter(Cost1(:,runn),Beta1(:,runn),'c','.')
%     scatter(Cost2(:,runn),Beta2(:,runn),'m','.')
% end
% nou=find(Beta1>Cost1);
% nou2=find(Beta2>Cost2);
% scatter(Cost1(nou),Beta1(nou),'r','.')
% scatter(Cost2(nou2),Beta2(nou2),'k','.')
% xlabel('Cost')
% ylabel('Benefit')
% legend('Community 1','Community 2')
% str=sprintf('Run %d: Max Overwash = %d and K = %d',runn,Qow_max,Ksf);
% title(str)
% set(gca,'fontweight','bold')
% set(gca,'Fontsize', fs)
% set(gcf,'PaperPositionMode','auto')
% 
% 
% figure()
% hold on
% scatter3(nnourished1,nanmedian(TBtwN1),1:runn,[],1:runn,'.')
% scatter3(nnourished2,nanmedian(TBtwN2),1:runn,[],1:runn,'o')
% scatter3(nmanret1,nanmedian(TBtwMR1),1:runn,[],1:runn,'*')
% scatter3(nmanret2,nanmedian(TBtwMR2),1:runn,[],1:runn,'x')
% colormap(jet)
% colorbar
% view(2)
% xlabel('Number of times action taken/100 years')
% ylabel('time between actions')
% legend('nnourished1','nnourished2','nmanret1','nmanret2')
% set(gca,'fontweight','bold')
% set(gca,'Fontsize', fs)
% set(gcf,'PaperPositionMode','auto')
