%%%% Community variables to explicitly define for each
ncom = 2;                      % number of communities
com(1).jj = 20:95;             % 1 represents community 1
com(2).jj = 96:140;             % 2 represents community 2
com(1).w0 = 49;                % 1 initial beach width *NRM paper (49 meters)
com(2).w0 = 49;                % 2 initial beach width *NRM paper
com(1).W0 = 450;               % 1 initial barrier width
com(2).W0 = 1100;               % 2 initial barrier width
com(1).Kow = 0.6;              % residential, 40% overwash lost (Rogers et al 2015)
com(2).Kow = 0.6;              % residential too
                               % commercial, 90% overwash lost (Rogers et al 2015)
com(1).propertysize = 50;          % width of properties (cross-shore)
com(2).propertysize = 50;          % width of properties (cross-shore)
com(1).nproperties = 2;              % number of properties per dy
com(2).nproperties = 2;              % number of properties per dy
% dem = 8000;                  % estimated cost of demolishing a home ~1500-2000 sq ft
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
dr = 0.07; % 7% discount rate
nyears = 5; % nyears of project (how long they look into the future)
n = 25; % 25 years (NRM 2013)
com(1).alpha = com(1).P*dr;     % annual value of community 1
com(2).alpha = com(2).P*dr;     % annual value of community 2
% other way would be P*((1+dr)^n)./(((1+ir)^n)-1); 

c = 5;              % unit cost of sand /volume
b = 0.2632;          % exponent from Pompe & Rinehard 1995-- first row of houses = 0.2632; OR Landry 2007 (whole community)= 0.085, and NRM 2013 =0.157 (reasonable for coastal homes in NE)
com(1).Wn = 20; %width to add in nourishment
com(2).Wn = 20; %width to add in nourishment

%LOCATIONS ARE SET IN THE RUN LOOP




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