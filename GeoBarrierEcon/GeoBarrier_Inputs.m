%% Barrier geometric model with coupled Alongshore. %%%%%%%%%%%%%%%
% Jorge Lorenzo Trueba adopted by Andrew Ashton starting 2-2015
% adopted by Rose Palermo starting 2-2016
% post AGU2017 bug fixes

%% Run parameters

runs = [320]; %change variable for multiple runs (width)
runn = length(runs); %number of runs

% Time
Tmax = 150;    % Runing time (years)-- was 500 years
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

%%%% Community variables to explicitly define for each
ncom = 2;                      % number of communities
com(1).jj = 21:25;             % 1 represents community 1
com(2).jj = 56:60;             % 2 represents community 2
com(1).w0 = 49;                % 1 initial width *NRM paper (49 meters)
com(2).w0 = 49;                % 2 initial width *NRM paper
propertysize = 50;          % width of properties (cross-shore)
nproperties = 2;              % number of properties per dy
dem = 8000;                  % estimated cost of demolishing a home ~1500-2000 sq ft
com(1).L = (com(1).jj(end)-com(1).jj(1))*dy;    %length of comm 1
com(2).L = (com(2).jj(end)-com(2).jj(1))*dy;    %length of comm 2
com(1).color = 'c';
com(2).color = 'm';

%%%% Community and Cost Benefit Analysis Controls--- (Slott 2008)
f = 1e6;    % fixed cost of nourishment
%the property value of the communities will become a dynamic term
%this is where I will add something having to do with multiple existing
%properties and their value relative to distance from oceanfront and width
%of the beach
com(1).P = 1.5e6; %NRM 2013 (1.5e6)
com(2).P = 1.5e6; %same as P1--- needs to be changed to coastal commercial MA value?
ir = 0.07; % 7% discount rate
nyears = 5; % nyears of project (how long they look into the future)
n = 25; % 25 years (NRM 2013)
com(1).alpha = com(1).P*ir*((1+ir)^n)./(((1+ir)^n)-1);     % annual value of community 1
com(2).alpha = com(2).P*ir*((1+ir)^n)./(((1+ir)^n)-1);     % annual value of community 2
c = 5;              % unit cost of sand /volume
b = 0.2632;          % exponent from Pompe & Rinehard 1995-- first row of houses = 0.2632; OR Landry 2007 (whole community)= 0.085, and NRM 2013 =0.157 (reasonable for coastal homes in NE)
com(1).Wn = 20; %width to add in nourishment
com(2).Wn = 20; %width to add in nourishment


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

%%% zero variables for each community
for c = 1:ncom
    com(c).Xvnn = 0;
    com(c).Vnn = 0;
    com(c).tnourished = zeros(ts,length(runs));
    com(c).tmanret = zeros(ts,length(runs));
    com(c).nnourished = zeros(1,length(runs));
    com(c).nmanret = nan(1,length(runs));
    com(c).inourished = zeros(ts,length(runs));
    com(c).imanret = zeros(ts,length(runs));
    com(c).TBtwN = nan(ts,length(runs));
    com(c).TBtwMR = nan(ts,length(runs));
    com(c).NB = zeros(ts,length(runs));
    com(c).NBmr = zeros(ts,length(runs));
    com(c).action = zeros(ts,length(runs));

end


%%%% Cost Benefit Analysis stuff
Beta1 = zeros(ts,length(runs));
Beta2 = zeros(ts,length(runs));
Cost1 = zeros(ts,length(runs));
Cost2 = zeros(ts,length(runs));
NB1 = zeros(ts,length(runs));
NB2 = zeros(ts,length(runs));

