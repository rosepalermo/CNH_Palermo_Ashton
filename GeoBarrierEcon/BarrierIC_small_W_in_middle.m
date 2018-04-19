% Space
Yn = 101; % number of Y cells

%%%% Alongshore array dimensions (initial)
Y=0:dy:Yn*dy;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

%     %%%% Set the Domain Variables for the barrier
xsl(Yi)=Dsf/Ae;        % X shoreline
xsl(ys/3:2*ys/3) = xsl(ys/3:2*ys/3)+100;

%     %%%% Set the Domain Variables for the barrier (add the buffer)
ys = ys+2*buffer;
Yi = 1:1:ys;   
Y = 0:dy:(Yn+(2*buffer))*dy;

W = cat(2,W(1)*ones(1,buffer),W,W(end)*ones(1,buffer));

B=ones(1,ys) * Bslope; % Basement Slope, can be different
xtoe(Yi)=0;            % X toe
xbb(Yi)=xsl(Yi)+W(Yi); % X backbarrier
H(Yi) =He;             % barrier height
W(Yi)=Wstart+100;          % Barrier width (m)

    
   