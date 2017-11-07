%% Barrier geometric model with coupled Alongshore. %%%%%%%%%%%%%%%
% Jorge Lorenzo Trueba adopted by Andrew Ashton starting 2-2015
% adopted by Rose Palermo starting 2-2016

clear; close all;

%% Run parameters

% Time
Tmax = 100;    % Runing time (years)-- was 500 years
Tsteps = 100;    % time steps per year
Tsave = .5;     % Save T how often (years), can be float

% Space
dy = 200; % Spacing alongshore (m)
Yn = 200; % number of Y cells

% SL rise rate = a + bt
sl_a = 0.002; %m/yr
sl_b = 0; % If b=0 constant sea-level rise

% Barrier Variables - here assume these are constant across barrier, these
% could also be varied for some cases perhaps
Dsf = 10; % Shoreface Toe depth (meters). Typically in the range 10-20m
We = 300; % Equilibrium width (meters)
He = 2;   % Equilibrium heigth (meters)
Ae = 0.015;    % Equilibrium shoreface slope3
Qow_max = 50;% Maximum overwash flux (m^2/year)
Vd_max = 100; % Maximum deficit volume (m^2)
Ksf = 10000;  % Shoreface Flux constant (m^2/year)
Bslope = 0.001; %basement slope

% Alongshore input physical parameters
To= 8; % Wave period (seconds)
Ho= 1; % Wave heigth (m) (sic Jorge)
astfac = .5; % fractional diffusivity (i.e. angular wave distribution reduces diffusivity by what)


%%%% Community controls
%pertpart = 1/3; %part of the shoreline that is a community
Wcom = We; %width of beach where community is, let's say it doesn't drop below 150 somehow later
Wstart = We; %width of not community


%%%% Cost Benefit Analysis Controls--- (Slott 2008)
f = 1e6;    % fixed cost of nourishment
alpha1 = 1.5e6;   % property value of community 1
alpha2 = 1.3e6;   % property value of community 2
c = 5;          % unit cost of sand /volume
b = 0.085;      % exponent from Landry 2007
D = 10;         % depth limit of wave action

% Plot Control
plottimes = 3;
xaspect = .6; yaspect = .8;
xshoreplot = 1.5;
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
tnourished = zeros(size(t));
tnourished2 = zeros(size(t));

%%%% Alongshore array dimensions
Y=0:dy:Yn*dy;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

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



%%%% Set community locations
jjcom = zeros(size(Yi));
jjcom1 = 31:50;             % 1 represents community 1
jjcom2 = 141:161;           % 2 represents community 2
location1 = 800;            % cross shore location of comm 1
location2 = 800;            % cross shore location of comm 2
%xsl(jjcom)=xbb(jjcom)-Wcom;   % sl of shoreline in front of communities
notcomm = setdiff(Yi,jjcom); %part of the shoreline not on community


%%%% Cost Benefit Analysis stuff
L1 = (jjcom1(end)-jjcom1(1))*dy;
L2 = (jjcom2(end)-jjcom2(1))*dy;
Wn1 = zeros(size(Yi));
Beta1 = zeros(size(Yi));
Cost1 = zeros(size(Yi));
Wn2 = zeros(size(Yi));
Beta2 = zeros(size(Yi));
Cost2 = zeros(size(Yi));


% some alongshore coefficients
K2=0.34/2*astfac; %m^(3/5)s^(-6/5)
Ka=K2*Ho^(12/5)*To^(1/5) * 365*86400; %convert to m^3/year

% open figure and squeeze
Fig1 = figure(8);
figpos = get(Fig1, 'Position');
figpos(3) = figpos(3)* xaspect;
figpos(4) = figpos(4) * yaspect;
set(Fig1,'Position',figpos)

%% TIME LOOP %%%%%%%%%%%%%%%%%%%%
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
    Wn1 = xsl(jjcom1) - location1;
    Wn2 = xsl(jjcom2) - location2;
    Vnn1= mean(Wn1) * L1 * D + mean(Wn1) * mean(H) * L1;
    Vnn2= mean(Wn2) * L2 * D + mean(Wn2) * mean(H) * L2;

    %% here is where an economic model should go
    
    Beta1 = alpha1 * mean(xsl(jjcom1)-location1)^b;
    Cost1 = f + c/2 * mean(Wn1) * L1 * D + c * mean(Wn1) * mean(H) * L1;
    
    
    Beta2 = alpha2 * mean(xsl(jjcom2)-location2)^b;
    Cost2 = f + c/2 * mean(Wn2) * L2 * D + c * mean(Wn1) * mean(H) * L2;
    
    

    
    %% nourishing
   
       %community exists @ xsl = 800, so nourish + 20 when beach is at 820
       %here is also where i need to start putting in a property value
       %component
       
       %rich 
        if xsl(jjcom1) > location1 & Beta1 > Cost1
            xsl(jjcom1) = xsl(jjcom1) -;
            tnourished(i) = 1;
            disp('nourished 1')
            Beta1-Cost1
        else
            xsl(jjcom1) = xsl(jjcom1);
        end
        
        
        %poor 
        if xsl(jjcom2) > location2 & Beta2 > Cost2
            xsl(jjcom2) = xsl(jjcom2) -20;
            tnourished2(i) = 1;
            disp('nourished 2')
            Beta2-Cost2
        else
            xsl(jjcom2) = xsl(jjcom2);
        end
        
        % recompute geometries
        for j = 1:ys
            % Compute local geometries from the saved arrays
            A=Dsf/(xsl(j)-xtoe(j)); % Shoreface Slope
            W=xbb(j)-xsl(j);    % Barrier Width
            Db= Dsf + Z - xbb(j)*B(j); % This is set from the original domain - could use some work
            % Compute Deficit volume Vd, overwash flux Qow, and shoreface flux Qsf
        end


        

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
        i
        % PLAN VIEW
        axes2 = subplot(2,1,2);
        box(axes2,'on');
        hold(axes2,'all');
        
        hold on
        plot(Y/1000,xsl/1000,'b', 'linewidth',2)
        plot(Y/1000,xbb/1000,'r', 'linewidth',2)
        
  %      patch([Y/1000 flip(Y/1000)],[xsl/1000 flip(xbb/1000)],'k')
        
        xlabel('alongshore location (km)')
        ylabel('onshore location (km)')
        
        axis([0 max(Y)/1000 0 xshoreplot])
        set(gca,'fontweight','bold')
        set(gca,'Fontsize', fs)
        
    end
end
nnourished = sum(tnourished)
nnourished2 = sum(tnourished2)

% time plot
axes1 = subplot(2,1,1);
box(axes1,'on');
hold(axes1,'all');

jplot = 1;
%ppp = Xsl_save(:,jplot)
plot(tsavei*Tsave,Xsl_save(:,jplot)/1000,'b', 'linewidth',2)
plot(tsavei*Tsave,Xb_save(:,jplot)/1000,'r', 'linewidth',2)

jplot = floor(Yn/2)
plot(tsavei*Tsave,Xsl_save(:,jplot)/1000,'--b', 'linewidth',2)
plot(tsavei*Tsave,Xb_save(:,jplot)/1000,'--r', 'linewidth',2)


axis([0 Tmax 0.5 xshoreplot])
xlabel('time (years)')
ylabel('onshore location (km)')
legend('Shoreline A','Backbarrier A','Shoreline B','Backbarrier B','location','se')
set(gca,'fontweight','bold')
set(gca,'Fontsize', fs)


set(gcf,'PaperPositionMode','auto')

% %     THIS IS THE OLD PROFILE PLOT
%         figure
%           axes1 = subplot(2,1,1);
%         box(axes1,'on');
%         hold(axes1,'all');
% 
%         jp = 10; % Which profile you plotting
% 
%         % compute the z's
%         Db= Dsf - xbb(j)*B(j); zt=Z-Dsf; zs=Z; ztop=Z+H(j);
%         % plot the barrier parts
%         Xplot=[xtoe(jp) xsl(jp) xsl(jp) xbb(jp) xbb(jp)];
%         Zplot=[zt     zs     ztop   ztop   -Db ];
%         plot(Xplot,Zplot,'k')
%         % plot a shoreface
%         Xplot=[-Dsf/B(j) Dsf/B(j)];
%         Zplot=[-2*Dsf 0];
%         plot(Xplot,Zplot,'k')
%         plot([-1000 2000], [Z Z], 'b')
%         axis([-200 1800 -15 10 ])
