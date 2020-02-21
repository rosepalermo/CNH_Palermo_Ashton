
% Compute local geometries from the saved arrays
A=Dsf./(xsl-xtoe); % Shoreface Slope
W=xbb-xsl;    % Barrier Width
Db= min(Dsf + Z - xbb.*B,Dbb); % Either calculated from the slope or Dbb - initial Db (2m) (~mean of Long Island data), whichever is smaller
%                         Db= (Dsf + Z - xbb(j)*B(j));

% Compute mud fraction - from BRIE
% Df = (Dsf+Z-xbb.*Bslope) - Db; % thickness of mud in shelf-slope bay
% Mf = Df./(Df + Db + H); % mud fraction
%     MF = 0;

% Compute Deficit volume Vd, overwash flux Qow, and shoreface flux Qsf
%Deficit Volume
Vd_H=(He-H).*W;
if ~isempty(find(Vd_H<0))
    Vd_H(find(Vd_H<0))=0;
end
Vd_B=(We-W).*(H+Db);
if ~isempty(find(Vd_B<0))
    Vd_B(find(Vd_B<0))=0;
end
Vd=Vd_H+Vd_B;

%overwash flux
if Vd<Vd_max
    Qow_H=Qow_max.*Vd_H./Vd_max;
    Qow_B=Qow_max.*Vd_B./Vd_max;
else
    Qow_H=Qow_max.*Vd_H./Vd;
    Qow_B=Qow_max.*Vd_B./Vd;
end
% THIS WILL NEED TO BE CHANGED FOR NOT LOOP
%     %limit ow for residential and commercial communities
%
%     if developed_on
%         if devjj(1)<=j && j<=devjj(end)
%
%             if commercial
%                 Qow_B = 0.1*Qow_B;
%                 Qow_H = 0.1*Qow_H;
%             elseif residential
%                 Qow_B = 0.6*Qow_B;
%                 Qow_H = 0.6*Qow_H;
%             end
%         end
%     end
%
%
%     if community_on
%         for c = 1:ncom
%             if com(c).jj(1)<=j && j<=com(c).jj(end)
%                 Qow_B = com(c).Kow*Qow_B;
%                 Qow_H = com(c).Kow*Qow_H;
%             end
%         end
%     end

Qow=Qow_H+Qow_B;
Qow(isnan(Qow)) = 0;
Qow_H(isnan(Qow_H)) = 0;
Qow_B(isnan(Qow_B)) = 0;

%shoreface flux
Qsf=Ksf*(Ae-A);

%         QowH_saveall(i,j) = Qow_H;
%         QowB_saveall(i,j) = Qow_B;
%         Qow_saveall(i,j) = Qow;
%         Qsf_saveall(i,j) = Qsf;


% Barrier evolution ----
% compute changes
Hdot=Qow_H./W-zdot;
xbdot=Qow_B./(H+Db);
%     xsdot=2*Qow/(Dsf+2*H(j))-4*Qsf*(H(j)+Dsf)/(2*H(j)+Dsf)^2;
xsdot = 2*Qow./((2.*H + Dsf)) - 4.*Qsf.*(H + Dsf)./((2*H+Dsf).^2); %
% xsdot = 2*Qow./((2.*H + Dsf).*(1-Mf)) - 4.*Qsf.*(H + Dsf)./((2*H+Dsf).^2); % mud fraction modified xsdot
xtdot=2*Qsf.*(1./(Dsf+2*H)+1./Dsf)+2*zdot./A;

% Do changes- look for failure
H=H+Hdot*dt;
if ~isempty(find(H<0))
    tdrown_H=ti(i);
    return;
end

xbb=xbb+xbdot*dt;
xsl=xsl+xsdot*dt;
xtoe=xtoe+xtdot*dt;
W = xbb-xsl;
if ~isempty(find(W<0))
    tdrown_W=ti(i);
    return;
end

%         xbb_saveall(i,j) = xbb(j);
%save ow and shoreface fluxes
if (mod(i,savenum)- 1 == 0)
    tsi = (i-1)/savenum +1;
    QowH_save(tsi,Ysave) = Qow_H(:,Ysave);
    QowB_save(tsi,Ysave) = Qow_B(:,Ysave);
    Qow_save(tsi,Ysave) = Qow(:,Ysave);
    Qsf_save(tsi,Ysave) = Qsf(:,Ysave);
    xbb_save(tsi,:) = xbb(:,Ysave);
end

