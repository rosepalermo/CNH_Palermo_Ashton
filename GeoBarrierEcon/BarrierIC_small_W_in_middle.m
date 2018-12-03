function BarrierIC_small_W_in_middle(mbw)

EL = mbw*10;

shape = 'sWmid';

% Space
Yn = 101; % number of Y cells

%%%% Alongshore array dimensions (initial)
Y=0:dy:Yn*dy;    % real y array
ys=length(Y);    % alongshore spots
Yi = 1:ys;       % Y i's

%     %%%% Set the Domain Variables for the barrier
W(Yi) = Wstart;
W(ys/3-EL:2*ys/3+EL) = W(ys/3-EL:2*ys/3+EL)-150;

W = cat(2,W(1)*ones(1,buff),W,W(end)*ones(1,buff));


%     %%%% Set the Domain Variables for the barrier (add the buff)
ys = ys+2*buff;
Yi = 1:1:ys;   
Y = 0:dy:(Yn+(2*buff))*dy;

xsl(Yi)=Dsf/Ae;        % X shoreline
B=ones(1,ys) * Bslope; % Basement Slope, can be different
xtoe(Yi)=0;            % X toe
xbb(Yi)=xsl(Yi)+W(Yi); % X backbarrier
H(Yi) =He;             % barrier height


end
    
   