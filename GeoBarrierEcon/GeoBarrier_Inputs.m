%% Barrier geometric model with coupled Alongshore. %%%%%%%%%%%%%%%
% Jorge Lorenzo Trueba adopted by Andrew Ashton starting 2-2015
% adopted by Rose Palermo starting 2-2016
% post AGU2017 bug fixes

%% Run parameters

% Space
dy = 100; % Spacing alongshore (m)

% SL rise rate = a + bt
% sl_a = 0.003; %m/yr
zzs = 0.001:0.001:0.003;
sl_b = 0; % If b=0 constant sea-level rise



% Barrier Variables - here assume these are constant across barrier, these
% could also be varied for some cases perhaps

% if i == 1
    Dsf = 10; % Shoreface Toe depth (meters). Typically in the range 10-20m
% else
%     Dsf = 16; % USE 16 FOR BARNEGAT BAY
% end

We = 300; % Equilibrium width (meters)
He = 2;   % Equilibrium heigth (meters)
Ae = 0.015;    % Equilibrium shoreface slope3
qows = 0:10:80;
% Qow_max = 50;% Maximum overwash flux (m^2/year) Emily Carruthers estimates: 2.4 - 8.5; ?Masetti 2008: 24-48
Vd_max = 100; % Maximum deficit volume (m^2)
Ksf = 10000;  % Shoreface Flux constant (m^2/year) %model runs for AGU and CS had Ksf 200 % model runs for CS had Ksf 2000
kks = 0:1000:10000; 
Bslope = 0.001; %basement slope
% Wstart = We;   
% Dbb = 2; % depth of the back barrier



% Alongshore input physical parameters
To= 8; % Wave period (seconds)
Ho= 1; % Wave heigth (m) (sic Jorge)

%astfac = 0.1; %0.01:0.5;

% some alongshore coefficients
K2=0.34/2; %m^(3/5)s^(-6/5)
Ka=K2*Ho^(12/5)*To^(1/5)*astfac * 365*86400; %convert to m^3/year



%% IPCC Scenarios -- save for later

% if exist('sl')
%     if sl == 1 % RCP2.6
%         sl_b = 0.0000065;
%         RCP = 26;
%     elseif sl == 2 % RCP4.5
%         sl_b = 0.0000288;
%         RCP = 45;
%     elseif sl == 3 % RCP6.0
%         sl_b = 0.0000509;
%         RCP = 60;
%     elseif sl ==4 % RCP8.5
%         sl_b = 0.0000960;
%         RCP = 85;
%     end
% end
%RCP2.6 = a = 0.0041748~0.004, b = 0.000065; RCP4.5 = a = 0.0040879~0.0004,
%b = 0.0000288; RCP6.0 = a = 0.0039862~0.004, b = 0.0000509; RCP85 = a =
%0.0042945~0.004, b = 0.0000960

