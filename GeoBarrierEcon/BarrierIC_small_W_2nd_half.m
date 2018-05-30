shape = 'sW2';
% Space
Yn = 101; % number of Y cells

%%%% Alongshore array dimensions (initial)
Y=0:dy:Yn*dy;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

%     %%%% Set the Domain Variables for the barrier
    W(Yi)=Wstart+100;          % Barrier width (m)
    W(ys/2:end) = Wstart-100;

%     %%%% Set the Domain Variables for the barrier (add the buff)
ys = ys+2*buff;
Yi = 1:1:ys;   
Y = 0:dy:(Yn+(2*buff))*dy;

W = cat(2,W(1)*ones(1,buff),W,W(end)*ones(1,buff));

B=ones(1,ys) * Bslope; % Basement Slope, can be different
xtoe(Yi)=0;            % X toe
xsl(Yi)=Dsf/Ae;        % X shoreline
xbb(Yi)=xsl(Yi)+W(Yi); % X backbarrier
H(Yi) =He;             % barrier height
    
   