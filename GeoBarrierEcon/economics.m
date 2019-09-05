  if community_on
        
        for c = 1:ncom
            if sum(com(c).npropxs)>0
                %calculate distances to ocean and bay
                com(c).npropxs = floor((com(c).housingbb - com(c).yfirsthouse)/com(c).propertysize);
                com(c).dist2oc = zeros(length(com(c).jj),max((com(c).npropxs)));
                com(c).dist2bb = zeros(length(com(c).jj),max((com(c).npropxs)));
                for ll = 1:length(com(c).jj)
                    % dist2oc0
                    for l = 1:(max(com(c).npropxs))
                        com(c).dist2oc(ll,l) = 16-l;
                    end
                    if l > (com(c).npropxs(ll)) % put nans in because use maximum for community
                        com(c).dist2oc(end-l:l) = NaN;
                    end
                    
                    %dist2bb0
                    for l = 1:(max(com(c).npropxs))
                        com(c).dist2bb(ll,end+1-l) = 16-l;
                    end
                    if l > (com(c).npropxs(ll)) % put nans in because use maximum for community
                        com(c).dist2bb(1:end-l) = NaN;
                    end
                end
                if size(com(c).dist2oc,2)<size(com(c).dist2oc0,2)
                    com(c).dist2oc = cat(2,zeros(length(com(c).jj),(size(com(c).dist2oc0,2) - size(com(c).dist2oc,2))),com(c).dist2oc);
                    com(c).dist2bb = cat(2,zeros(length(com(c).jj),(size(com(c).dist2bb0,2) - size(com(c).dist2bb,2))),com(c).dist2bb);
                end
                
                
                % run economic model to find net benefit
                [nNB,mNB]=cba(nyears,com(c).npropertiesll,com(c).L,dy,com(c).alpha,b,com(c).slr,com(c).Wn,com(c).Wav(i),min(com(c).W(i,:)),com(c).W(1,1),com(c).propertysize,f,cost,mean(H(com(c).jj)),Dsf,dr,com(c).dist2oc0,com(c).dist2oc,com(c).dist2bb0,com(c).dist2bb,kappa,kkappa,com(c).npropxs,subsidies);
                
                com(c).NB(i) = nNB;
                com(c).NBmr(i) =mNB;
            else
                com(c).tcommunityfail(i) = i;
            end
        end
    end