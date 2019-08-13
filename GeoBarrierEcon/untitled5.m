heff = H(2:ys) + Dsf;
            dsl = (F(2:ys)-F(1:end-1))./dy./heff; % note positive sl change = erosion
            xsl(2:ys) = xsl(2:ys) + dsl;
            heff1 = H(1) + Dsf;
            dsl1 = (F(1)-F(ys))/dy/heff1;
            xsl(1) = xsl(1) + dsl1;
            if (mod(i,savenum)- 1 == 0)
                tsi = (i-1)/savenum +1;
                Qast_save(tsi,:) = F;
                llxldot_save(tsi,1:end-1) = dsl*dy*heff;
                llxldot_save(tsi,ys) = dsl1*dy*heff1;
            end
            
            
                    heff = H(1) + Dsf;
        dsl = (F(1)-F(ys))/dy/heff;
        llxldot_saveall(i,ys) = dsl*dy*heff;
        xsl(1) = xsl(1) + dsl;