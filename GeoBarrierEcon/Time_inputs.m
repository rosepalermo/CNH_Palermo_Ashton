% Time
Tmax = 200;    % Runing time (years)-- was 500 years
Tsteps = 100;    % time steps per year
Tsave = 0.5;     % Save T how often (years), can be float

%%%% Time
dt = 1/Tsteps;   % time steps (years)
t=0:dt:Tmax;    % real time array
ts=length(t);   % time steps
ti = 1:ts;      % time i's

% Plot Control
plottimes = 4;
xaspect = 1.5; yaspect = 1.5;
%xshoreplot = 1.5;
fs = 14;


% Save times
tsavetimes = Tmax/Tsave;
tsavei = 1:(tsavetimes+1); % array of save time
% tsavei = 1:(tsavetimes); % array of save time

plotnum = floor(Tmax/plottimes/dt);
savenum = Tmax/tsavetimes/dt;
