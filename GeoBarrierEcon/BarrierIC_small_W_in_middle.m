% EL = mbw*5;

shape = 'sWmid';

% Space
Yn = 10001; % number of Y cells

%%%% Alongshore array dimensions (initial)
Y=0:dy:Yn*dy;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

%     %%%% Set the Domain Variables for the barrier
W(Yi) = Wstart;
% W(ceil(ys/2)-EL:ceil(ys/2)+EL) = W(ceil(ys/2)-EL:ceil(ys/2)+EL)-150;
% W(ceil(ys/3):2*ceil(ys/3)) = Wstart.*ones(size(ceil(ys/3):2*ceil(ys/3)));
W(ceil((ys-L)./2):ys-ceil((ys-L)./2)) = (Wstart-50).*ones(size(ceil((ys-L)./2):ys-ceil((ys-L)./2)));


xsl(Yi)=Dsf/Ae;        % X shoreline
B=ones(1,ys) * Bslope; % Basement Slope, can be different
xtoe(Yi)=0;            % X toe
xbb(Yi)=xsl(Yi)+W(Yi); % X backbarrier
H(Yi) =He;             % barrier height


   