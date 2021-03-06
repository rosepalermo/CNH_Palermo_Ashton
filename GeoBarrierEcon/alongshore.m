if ~xsonly
    xsl_forflux = [xsl xsl(1)];
    % compute de fluxes - fluxes across rt cell border
        F = (Ka * dt) * (xsl_forflux(2:end) - xsl_forflux(1:end-1))/dy;
        %             F(j)=Ka/(2*(H(j)+H(j-1))/2+Dsf)*(xsl(j)-xsl(j-1))*dt*3650;
    F_fordel = [F(end) F];
    % change the shoreline
        heff = H + Dsf;
        dsl = (F_fordel(2:end)-F_fordel(1:end-1))./dy./heff.*(1-Mf); % note positive sl change = erosion
        xsl = xsl + dsl;
    
        
    if community_on
        for c = 1:ncom
            com(c).W(i,:) = (com(c).yfirsthouse - xsl(com(c).jj)); % beach width
            com(c).Wav(i) = mean(com(c).W(i,:),2); %average width BEFORE NOURISHMENT
        end
        
        %amount of of shoreline retreat from this year to previous year
        if i>100
            for c = 1:ncom
                %                     com(c).slr = (mean(xsl_saveall(i,com(c).jj))-mean(xsl_saveall(i-100,com(c).jj)))/100;
                com(c).slr = (mean(xsl(i,com(c).jj))-mean(xsl(i-100,com(c).jj)))/100;
            end
            
        elseif i<100 % in the first year we'll just say no change
            for c = 1:ncom
                com(c).slr = 0;
            end
        end
        
        Yvnn= [0,0,Dsf];
        for c = 1:ncom
            com(c).Xvnn = [mean(xsl(com(c).jj)),mean(xsl(com(c).jj))-com(c).Wn,mean(xtoe(com(c).jj))];
            com(c).Vnn = polyarea(com(c).Xvnn,Yvnn)+com(c).Wn*mean(H(com(c).jj));
        end
    end
    
end