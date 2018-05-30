shape = 'LBI';
%% This is for long beach island
% ncom = 2;                      % number of communities
% com(1).jj = 20:95;             % 1 represents community 1
% com(2).jj = 96:140;             % 2 represents community 2
% com(1).w0 = 49;                % 1 initial beach width *NRM paper (49 meters)
% com(2).w0 = 49;                % 2 initial beach width *NRM paper
% com(1).W0 = 450;               % 1 initial barrier width
% com(2).W0 = 1100;               % 2 initial barrier width
% com(1).Kow = 0.6;              % residential, 40% overwash lost (Rogers et al 2015)
% com(2).Kow = 0.6;              % residential too

% Space
% dy = 100; % Spacing alongshore (m)    This is set in the inputs file
Yn = 331; % number of Y cells

%%%% Alongshore array dimensions
Y=0:dy:Yn*dy;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

%     %%%% Set the Domain Variables for the barrier (add the buff)
ys = ys+2*buff;
Yi = 1:ys;   


B=ones(1,ys) * Bslope; % Basement Slope, can be different

%Rose change the shoreline position first
% xsl(Yi)=Dsf/Ae;        % X shoreline
xsl = cat(2,linspace(1800,1000,76),linspace(1000,1000,100),linspace(1000,500,100),linspace(500,700,56));
RotAng = -atan((xsl(end)-xsl(1))/Y(end)-Y(1));
figure()
plot(Y,xsl)
hold on
v = [Y;xsl];
x_center = Y(1);
y_center = xsl(1);
center = repmat([x_center; y_center], 1, length(Y));
R = [cos(RotAng) -sin(RotAng); sin(RotAng) cos(RotAng)];
nrot=1;
% while (xsl(1) - xsl(end)) > 100
% xsl = xsl * cos(RotAng) + Y * sin(RotAng);
% Y = -xsl * sin(RotAng) + Y * cos(RotAng);
% % end
% choose a point which will be the center of rotation
nrot = nrot+1;
% create a matrix which will be used later in calculations
vo = R*(v - center) + center;
Y = vo(1,:);
xsl = vo(2,:);
% end
plot(Y,xsl)
legend('raw','rot')

Y = 0:dy:(Yn+2*buff)*dy;
xsl = cat(2,xsl(1)*ones(1,buff),xsl,xsl(end)*ones(1,buff));
plot(Y,xsl)
%Then decide the location of the toe based on the slope and xsl
xtoe=xsl-Dsf/Ae;            % X toe

%this is where W start gets hard coded. make a variable for each community
%to have an initial W that gets put here in this code and then one for the
%natural part
% W(com) = some var from structure
% W(nat) = make a new structure
% W(Yi)=Wstart;          % Barrier width (m)
% W(Yi) = randi([300 400],1,length(Yi));
W(1:20) = 900;
W(20:115) = 800;
W(115:150) = 1000;
W(150:(Yn+1)-50) = 900;
W((Yn+1)-50:Yn+1) = 350;
W = cat(2,500*ones(1,buff),W,500*ones(1,buff));
if exist('ncom')
    for c = 1:ncom
        W(com(c).jj) = com(c).W0;
    end
end

%bb stays the same
xbb=xsl+W; % X backbarrier

%whatever I do for width, do the same for height
% H(Yi) =He;             % barrier height
H = randi([1 3],1,(Yn+1));
H = cat(2,He*ones(1,buff),H,He*ones(1,buff));

% Yi = 1:1:2*buff+length(Yi);

if exist('ncom')
    for c = 1:ncom
        com(c).jj = com(c).jj + buff;
    end
end

