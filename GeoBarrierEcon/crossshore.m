for j = 1:ys
    
    % Compute local geometries from the saved arrays
    A=Dsf/(xsl(j)-xtoe(j)); % Shoreface Slope
    W=xbb(j)-xsl(j);    % Barrier Width
    Db= min(Dsf + Z - xbb(j)*B(j),2); % Either calculated from the slope or 2m (~mean of Long Island data), whichever is smaller
    %                         Db= (Dsf + Z - xbb(j)*B(j));
    
    
    % Compute Deficit volume Vd, overwash flux Qow, and shoreface flux Qsf
    %Deficit Volume
    Vd_H=(He-H(j))*W;
    if Vd_H<0
        Vd_H=0;
    end
    Vd_B=(We-W)*(H(j)+Db);
    if Vd_B<0
        Vd_B=0;
    end
    Vd=Vd_H+Vd_B;
    
    %overwash flux
    if Vd<Vd_max
        Qow_H=Qow_max*Vd_H/Vd_max;
        Qow_B=Qow_max*Vd_B/Vd_max;
    else
        Qow_H=Qow_max*Vd_H/Vd;
        Qow_B=Qow_max*Vd_B/Vd;
    end
    
    %limit ow for residential and commercial communities
    
    if developed_on
        if devjj(1)<=j && j<=devjj(end)
            
            if commercial
                Qow_B = 0.1*Qow_B;
                Qow_H = 0.1*Qow_H;
            elseif residential
                Qow_B = 0.6*Qow_B;
                Qow_H = 0.6*Qow_H;
            end
        end
    end
    
    
    if community_on
        for c = 1:ncom
            if com(c).jj(1)<=j && j<=com(c).jj(end)
                Qow_B = com(c).Kow*Qow_B;
                Qow_H = com(c).Kow*Qow_H;
            end
        end
    end
    
    Qow=Qow_H+Qow_B;
    
    %shoreface flux
    Qsf=Ksf*(Ae-A);
    
    %         QowH_saveall(i,j) = Qow_H;
    %         QowB_saveall(i,j) = Qow_B;
    %         Qow_saveall(i,j) = Qow;
    %         Qsf_saveall(i,j) = Qsf;
    
    
    % Barrier evolution ----
    % compute changes
    Hdot=Qow_H/W-zdot;
    xbdot=Qow_B/(H(j)+Db);
    xsdot=2*Qow/(Dsf+2*H(j))-4*Qsf*(H(j)+Dsf)/(2*H(j)+Dsf)^2;
    xtdot=2*Qsf*(1/(Dsf+2*H(j))+1/Dsf)+2*zdot/A;
    
    % Do changes- look for failure
    H(j)=H(j)+Hdot*dt;
    if H(j)<0
        tdrown_H=ti(i);
        break;
    end
    
    xbb(j)=xbb(j)+xbdot*dt;
    xsl(j)=xsl(j)+xsdot*dt;
    xtoe(j)=xtoe(j)+xtdot*dt;
    if xbb(j)-xsl(j)<0
        tdrown_W=ti(i);
        break;
    end
    
    %         xbb_saveall(i,j) = xbb(j);
    %save ow and shoreface fluxes
    if (mod(i,savenum)- 1 == 0)
        tsi = (i-1)/savenum +1;
        QowH_save(tsi,j) = Qow_H;
        QowB_save(tsi,j) = Qow_B;
        Qow_save(tsi,j) = Qow;
        Qsf_save(tsi,j) = Qsf;
        xbb_save(tsi,j) = xbb(j);
    end
    
end