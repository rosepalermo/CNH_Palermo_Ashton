% Barnegat Bay 1
addpath('/Users/rosepalermo/Documents/Research/Alongshore coupled/Barnegat Bay')
load('BarnegatBay3.mat')


shape = 'bbay3';
dy = mean(diff(sl_x))*85394;

% detrend sl_x and sl_y

% Space
Yn = length(sl_x); % number of Y cells

%%%% Alongshore array dimensions (initial)
Y=sl_y*111035;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

%     %%%% Set the Domain Variables for the barrier
% W is already defined by adding Barnegat bay1
W = W';
H = H';
Dbb = Dbb';
% H is alredy defined by adding Barnegat bay1

xsl(Yi)=Dsf/Ae;        % X shoreline
B=ones(1,ys) * Bslope; % Basement Slope, can be different
xtoe(Yi)=min(sl_x)-600;            % X toe
xbb=xsl+W; % X backbarrier
test = 1;