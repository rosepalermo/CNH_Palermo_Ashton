%% Barrier geometric model with coupled Alongshore. %%%%%%%%%%%%%%%
% Jorge Lorenzo Trueba adopted by Andrew Ashton starting 2-2015
% adopted by Rose Palermo starting 2-2016
% post AGU2017 bug fixes

%% Run parameters

% Space
dy = 100; % Spacing alongshore (m)
buff = 1;

% SL rise rate = a + bt
sl_a = 0.004; %m/yr
zzs = 0.001:0.001:0.003;
sl_b = 0; % If b=0 constant sea-level rise

if exist('sl')
    if sl == 1
        sl_a = 0.003;
    elseif sl == 2
        sl_a = 0.004;
    elseif sl == 3
        sl_a = 0.005;
    elseif sl == 4
        sl_a = 0.1;
    end

end

% Barrier Variables - here assume these are constant across barrier, these
% could also be varied for some cases perhaps
Dsf = 10; % Shoreface Toe depth (meters). Typically in the range 10-20m
We = 300; % Equilibrium width (meters)
He = 2;   % Equilibrium heigth (meters)
Ae = 0.015;    % Equilibrium shoreface slope3
Qow_max = 50;% Maximum overwash flux (m^2/year) Emily Carruthers estimates: 2.4 - 8.5; ?Masetti 2008: 24-48
qows = 0:10:80;
Vd_max = 100; % Maximum deficit volume (m^2)
Ksf = 200;  % Shoreface Flux constant (m^2/year)
kks = 0:1000:10000; 
Bslope = 0.001; %basement slope
Wstart = We;    

% Alongshore input physical parameters
To= 8; % Wave period (seconds)
Ho= 1; % Wave heigth (m) (sic Jorge)
astfac = .5; % fractional diffusivity (i.e. angular wave distribution reduces diffusivity by what)
% some alongshore coefficients
K2=0.34/2*astfac; %m^(3/5)s^(-6/5)
Ka=K2*Ho^(12/5)*To^(1/5) * 365*86400; %convert to m^3/year



%% ICCP Scenarios -- save for later

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

