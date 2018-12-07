shape = 'bumpmidsl';
% Space
Yn = 101; % number of Y cells

%%%% Alongshore array dimensions (initial)
Y=0:dy:Yn*dy;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

%     %%%% Set the Domain Variables for the barrier
xsl(Yi)=Dsf/Ae;        % X shoreline
W(Yi)=Wstart;          % Barrier width (m)
xbb(Yi)=xsl(Yi)+W(Yi); % X backbarrier

% add a bump to the shoreline
xsl(ys/3:2*ys/3) = xsl(ys/3:2*ys/3)-100;


%     %%%% Set the Domain Variables for the barrier (add the buff)
ys = ys+2*buff;
Yi = 1:1:ys;   
Y = 0:dy:(Yn+(2*buff))*dy;
xsl = cat(2,xsl(1)*ones(1,buff),xsl,xsl(end)*ones(1,buff));
W = cat(2,W(1)*ones(1,buff),W,W(end)*ones(1,buff));
xbb = cat(2,xbb(1)*ones(1,buff),xbb,xbb(end)*ones(1,buff));


B=ones(1,ys) * Bslope; % Basement Slope, can be different
xtoe(Yi)=0;            % X toe
H(Yi) =He;             % barrier height

    
   