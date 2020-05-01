Wstart = 300;

shape = 'gen';

% Space
Yn = 1001; % number of Y cells
% delta t <= delta x^2 / 2*diffusivity; diffusivity in this case is
% astfac*8.125e6. x = 100

%%%% Alongshore array dimensions (initial)
Y=0:dy:Yn*dy;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's


%%%% Set the Domain Variables for the barrier
B=ones(1,ys) * Bslope; % Basement Slope, can be different
xtoe(Yi)=0;            % X toe
xsl(Yi)=Dsf/Ae;        % X shoreline
W(Yi)=We;          % Barrier width (m)
xbb(Yi)=xsl(Yi)+W(Yi); % X backbarrier
H(Yi) =He;             % barrier height

Ysave = 1:5:ys;
yssave = length(Ysave);