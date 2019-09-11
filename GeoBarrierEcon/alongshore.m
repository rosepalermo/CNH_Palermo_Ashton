if ~xsonly
    % compute de fluxes - fluxes across rt cell border
    for j=1:(ys-1)
        F(j) = (Ka * dt) * (xsl(j+1) - xsl(j))/dy;
        %             F(j)=Ka/(2*(H(j)+H(j-1))/2+Dsf)*(xsl(j)-xsl(j-1))*dt*3650;
    end
    F(ys) = (Ka * dt) * (xsl(1) - xsl(ys))/dy;
    %         Qast_saveall(i,:) = F;
    
    % change the shoreline
    for j=2:(ys)
        heff = H(j) + Dsf;
        dsl = (F(j)-F(j-1))/dy/heff; % note positive sl change = erosion
        xsl(j) = xsl(j) + dsl;
    end
    
    heff = H(1) + Dsf;
    dsl = (F(1)-F(ys))/dy/heff;
    xsl(1) = xsl(1) + dsl;
    
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