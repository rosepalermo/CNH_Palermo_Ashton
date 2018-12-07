% Barnegat Bay 1
addpath('/Users/rosepalermo/Documents/Research/Alongshore coupled/Barnegat Bay')
load('BarnegatBay2.mat')

sl_x = flipud(sl_x);
sl_y = flipud(sl_y);
uniqueTO = flipud(uniqueTO);
W = flipud(W);
H = flipud(H);
Dbb = flipud(Dbb);
ModelMatrix = flipud(ModelMatrix);
alongshoredist = flipud(alongshoredist);


shape = 'bbay2';
dy = mean(diff(sl_x))*85394;

% Space
Yn = length(sl_x); % number of Y cells

%%%% Alongshore array dimensions (initial)
Y=-sl_x;%*85394;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

%     %%%% Set the Domain Variables for the barrier
% W is already defined by adding Barnegat bay1
W = W';
H = H';
Dbb = Dbb';
% H is alredy defined by adding Barnegat bay1

% xsl(Yi)=Dsf/Ae;        % X shoreline
xsl = sl_y';%*111035;
B=ones(1,ys) * Bslope; % Basement Slope, can be different
xtoe(Yi)=min(sl_x)-600;            % X toe
xbb=xsl+W; % X backbarrier
test = 1;