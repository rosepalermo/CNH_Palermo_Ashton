for c = 1:ncom
            if sum(com(c).npropxs)>0
                if i > nyears*Tsteps
                    %if width and NB > 0 --> nourish
                    if ((min(com(c).W(i,:))>1) && (com(c).NB(i)>0)) && (sum(com(c).tnourished(i-nyears*Tsteps:i))<1)
                        xsl(com(c).jj) = xsl(com(c).jj) - 2*com(c).Vnn/(2*mean(H(com(c).jj))+Dsf);
                        com(c).tnourished(i) = 1;
                        % if width < 0 & MR<N --> nourish
                    elseif ((min(com(c).W(i,:))<=1) && (com(c).NBmr(i)<com(c).NB(i))) && (sum(com(c).tnourished(i-nyears*Tsteps:i))<1)
                        xsl(com(c).jj) = xsl(com(c).jj) - 2*com(c).Vnn/(2*mean(H(com(c).jj))+Dsf);
                        com(c).tnourished(i) = 1;
                        %if width < 0 & MR>N --> retreat
                    elseif (min(com(c).W(i,:))<=1) && ((com(c).NBmr(i)>com(c).NB(i))||sum(com(c).tnourished(i-nyears*Tsteps:i))>1)
                        com(c).yfirsthouse = com(c).yfirsthouse + com(c).propertysize;
                        com(c).tmanret(i) = 1;
                        %recalculate width
                        com(c).W(i,:) = (com(c).yfirsthouse - xsl(com(c).jj)); %beach width
                        % if width > 0 & NB< 0 --> continue
                    elseif (com(c).Wav(i)>1) && (com(c).NB(i)<0)
                        xsl(com(c).jj) = xsl(com(c).jj);
                    end
                end
            end
        end