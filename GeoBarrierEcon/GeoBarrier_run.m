%% Barrier geometric model with coupled Alongshore. %%%%%%%%%%%%%%%
% Jorge Lorenzo Trueba adopted by Andrew Ashton starting 2-2015
% adopted by Rose Palermo starting 2-2016
% post AGU2017 bug fixes
tic
GeoBarrier_inputs
%% TIME LOOP %%%%%%%%%%%%%%%%%%%%
for runn=1:runn
    %input variables
    Wstart = runs(runn);
    %sl_a=runs(runn);
    
    
    %%%% Sea level
    Z=0;             % trying z= 0 which is the sea level
    
    %%%% Set the Domain Variables for the barrier
    B=ones(1,ys) * Bslope; % Basement Slope, can be different
    xtoe(Yi)=0;            % X toe
    xsl(Yi)=Dsf/Ae;        % X shoreline
    W(Yi)=Wstart;          % Barrier width (m)
    xbb(Yi)=xsl(Yi)+W(Yi); % X backbarrier
    H(Yi) =He;             % barrier height
    
    %%%% Set community locations
    com(1).location = mean(xsl(com(1).jj))+com(1).w0;            % cross shore location of comm 1
    com(2).location = mean(xsl(com(2).jj))+com(2).w0;            % cross shore location of comm 2
    locationdiff = com(1).location - com(2).location;
    com(1).W = zeros(ts,length(com(1).jj));   % for width of beach in front of comm1
    com(2).W = zeros(ts,length(com(2).jj));   % for width of beach in front of comm2
    
    %%%% Zero the Save Variables
    Xtoe_save = zeros(tsavetimes, ys);
    Xsl_save = zeros(tsavetimes, ys);
    Xb_save = zeros(tsavetimes, ys);
    H_save= zeros(tsavetimes, ys);
    xsl_saveall = zeros(ts,length(Yi));
    
    
    figure()
    for i=1:ts
        % SL curve
        zdot = sl_a+2*sl_b*t(i); %Base-level rise rate (m/year)
        Z = Z+zdot*dt;
        
        % Re/Set run variables
        F = zeros(1,ys); % alongshore flux zero
        
        %% CROSS-SHORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for j = 1:ys
            
            % Compute local geometries from the saved arrays
            A=Dsf/(xsl(j)-xtoe(j)); % Shoreface Slope
            W=xbb(j)-xsl(j);    % Barrier Width
            Db= Dsf + Z - xbb(j)*B(j); % This is set from the original domain - could use some work
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
            
            if com(1).jj(1)<=j && j<=com(1).jj(end) %for this test, community 1 is residential, so -40%OW (Rogers et al 2015)
                Qow_B = 0.6*Qow_B;
                Qow_H = 0.6*Qow_H;
                %Qow_B = Qow_B;  % (no overwash control)
                %Qow_H = Qow_H;
            end
            
            if com(2).jj(1)<=j && j<=com(2).jj(end) %for this test, community 2 is commerical, so -90%OW (Rogers et al 2015)
                Qow_B = 0.1*Qow_B;
                Qow_H = 0.1*Qow_H;
            end
            
            Qow=Qow_H+Qow_B;
            %shoreface flux
            Qsf=Ksf*(Ae-A);
            
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
        end
        
        %% ALONG-SHORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % compute de fluxes - fluxes across rt cell border
        for j=1:(ys-1)
            F(j) = (Ka * dt) * (xsl(j+1) - xsl(j))/dy;
            %             F(j)=Ka/(2*(H(j)+H(j-1))/2+Dsf)*(xsl(j)-xsl(j-1))*dt*3650;
        end
        F(ys) = (Ka * dt) * (xsl(1) - xsl(ys))/dy;
        
        % change the shoreline
        for j=2:(ys)
            heff = H(j) + Dsf;
            dsl = (F(j)-F(j-1))/dy/heff; % note positive sl change = erosion
            xsl(j) = xsl(j) + dsl;
        end
        
        heff = H(1) + Dsf;
        dsl = (F(1)-F(ys))/dy/heff;
        xsl(1) = xsl(1) + dsl;
        
        for c = 1:ncom
            com(c).W(i,:) = (com(c).location - xsl(com(c).jj)); % beach width
            com(c).Wav(i,runn) = mean(com(c).W(i,:),2);
        end
        
        %         % save all of the shorelines because it will evaluate the retreat rate
        %         % at each year
        xsl_saveall(i,:) = xsl;
        
        %amount of of shoreline retreat from this year to previous year
        
        if i>100
            for c = 1:ncom
                com(c).slr = (mean(xsl_saveall(i,com(c).jj))-mean(xsl_saveall(i-100,com(c).jj)))/100;
            end
        end
        
        if i<100
            for c = 1:ncom
                com(c).slr = 0;
            end
        end
        
        Yvnn= [0,0,Dsf];
        for c = 1:ncom
            com(c).Xvnn = [mean(xsl(com(c).jj)),mean(xsl(com(c).jj))-com(c).Wn,mean(xtoe(com(c).jj))];
            com(c).Vnn = polyarea(com(c).Xvnn,Yvnn)+com(c).Wn*mean(H(com(c).jj));
        end
        
        %% economics
        
        for c = 1:ncom
            [nNB,mNB]=cba(nyears,nproperties,com(c).L,dy,com(c).alpha,b,com(c).slr,com(c).Wn,com(c).Wav(i,runn),min(com(c).W(i,:)),com(c).W(1,1),propertysize,f,c,mean(H(com(c).jj)),Dsf,ir);
            com(c).NB(i,runn) = nNB;
            com(c).NBmr(i,runn) =mNB;
        end
        
        
        %% nourishing
        
        for c = 1:ncom
            if i > 500
                %if width and NB > 0 --> nourish
                if min(com(c).W(i,:))>0 && com(c).NB(i,runn)>0 && sum(com(c).tnourished(i-500:i,runn))<1
                    xsl(com(c).jj) = xsl(com(c).jj) - 2*com(c).Vnn/(2*mean(H(com(c).jj))+Dsf);
                    com(c).tnourished(i,runn) = 1;
                    % if width < 0 & MR<N --> nourish
                elseif min(com(c).W(i,:))<=0 && com(c).NBmr(i,runn)<com(c).NB(i,runn)
                    xsl(com(c).jj) = xsl(com(c).jj) - 2*com(c).Vnn/(2*mean(H(com(c).jj))+Dsf);
                    com(c).tnourished(i,runn) = 1;
                    %if width < 0 & MR>N --> retreat
                elseif min(com(c).W(i,:))<=0 && com(c).NBmr(i,runn)>com(c).NB(i,runn)
                    com(c).location = mean(xsl(com(c).jj))+propertysize;
                    com(c).tmanret(i,runn) = 1;
                    %recalculate width
                    com(c).W(i,:) = (com(c).location - xsl(com(c).jj)); %beach width
                    % if width > 0 & NB< 0 --> continue
                elseif com(c).Wav(i,runn)>0 && com(c).NB(i,runn)<0
                    xsl(com(c).jj) = xsl(com(c).jj);
                end
            end
        end
        
        %% Variable storage ?
        if (mod(i,savenum)- 1 == 0)
            tsi = (i-1)/savenum +1;
            Xtoe_save(tsi,:) = xtoe;
            Xsl_save(tsi,:) = xsl;
            Xb_save(tsi,:) = xbb;
            H_save(tsi,:)= H;
        end
        xsl_saveall(i,:) = xsl;
        
        %% Plots
        if (mod(i,plotnum)- 1 == 0)
            i;
            % PLAN VIEW
            axes2 = subplot(3,1,2);
            box(axes2,'on');
            hold(axes2,'all');
            
            hold on
            plot(Y/1000,xsl/1000,'b', 'linewidth',2)
            plot(Y/1000,xbb/1000,'r', 'linewidth',2)
            
            for c = 1:ncom
                plot(Y(com(c).jj)/1000,xsl(com(c).jj)/1000,'Color',com(c).color,'linewidth',2)
            end
            
            xlabel('alongshore location (km)')
            ylabel('onshore location (km)')
            
            axis([0 max(Y)/1000 0.5 (max(xbb)+100)/1000])
            set(gca,'fontweight','bold')
            set(gca,'Fontsize', fs)
            
            axes3 = subplot(3,1,3);
            hold on
            
            for c = 1:ncom
                jplot = floor((com(c).jj(c)+com(c).jj(end))./2); % Which profile youre plotting
                % compute the z's
                Db= Dsf - xbb(j)*B(j); zt=Z-Dsf; zs=Z; ztop=Z+H(j);
                % plot the barrier parts
                Xplot=[xtoe(jplot) xsl(jplot) xsl(jplot) xbb(jplot) xbb(jplot)]/1000;
                Zplot=[zt     zs     ztop   ztop   -Db ];
                plot(Xplot,Zplot,'Color',com(c).color)
            end
            
            % plot a shoreface
            Xplot=[-Dsf/B(j) Dsf/B(j)]/1000;
            Zplot=[-2*Dsf 0];
            plot(Xplot,Zplot,'k')
            plot([-1000 2000], [Z Z], 'b')
            axis([0 (max(xbb)+100)/1000 -10 5 ])
            xlabel('onshore location (km)')
            ylabel('elevation (m)')
            set(gca,'fontweight','bold')
            set(gca,'Fontsize', fs)
        end
    end
    
    %% calculate things to plot about nourishment
    for c = 1:ncom
        % number of times nourished
        com(c).nnourished(1,runn) = sum(com(c).tnourished(:,runn),1);
        % which times nourished
        com(c).inourished(1:com(c).nnourished(1,runn),runn) = find(com(c).tnourished(:,runn)>0);
        % time between nourishments
        com(c).TBtwN(1:com(c).nnourished(1,runn)-1,runn) = diff(com(c).inourished(1:com(c).nnourished(1,runn),runn))/Tsteps;
        %number of managed retreates, when retreated, time btw retreats
        com(c).nmanret(1,runn) = sum(com(c).tmanret(:,runn));
        com(c).imanret(1:com(c).nmanret(1,runn),runn) = find(com(c).tmanret(:,runn)>0);
        com(c).TBtwMR(1:com(c).nmanret(1,runn)-1,runn) = diff(com(c).imanret(1:com(c).nmanret(1,runn),runn))/Tsteps;
        
    end
    %%
    % time plot
    axes1 = subplot(3,1,1);
    box(axes1,'on');
    hold(axes1,'all');
    
    for c = 1:ncom
        jplot = floor((com(c).jj(1)+com(c).jj(end))./2); %plot middle of com1
        %ppp = Xsl_save(:,jplot)
        plot(tsavei*Tsave,Xsl_save(:,jplot)/1000,'--','Color',com(c).color, 'linewidth',2)
        plot(tsavei*Tsave,Xb_save(:,jplot)/1000,'Color',com(c).color, 'linewidth',2)
    end


    xlabel('time (years)')
    ylabel('onshore location (km)')
    set(gca,'fontweight','bold')
    set(gca,'Fontsize', fs)
    str=sprintf('Run %d: Max Overwash = %d, K = %d, & Sea level rise = %d',runn,Qow_max,Ksf,sl_a);
    title(str)
    set(gcf,'PaperPositionMode','auto')
    
    figure()
    hold on
    c=1;
    for c = 1:ncom
        scatter(com(c).NB(com(c).inourished(1:com(c).nnourished(1,runn),runn),runn),com(c).Wav(com(c).inourished(1:com(c).nnourished(1,runn),runn),runn),com(c).color);
    end
    xlabel('Net Benefit')
    ylabel('mean Width of community before nourishment (m)')
    legend('Community 1','Community 2')
    str=sprintf('Run %d: Max Overwash = %d, K = %d, & Sea level rise = %d',runn,Qow_max,Ksf,sl_a);
    title(str)
    set(gca,'fontweight','bold')
    set(gca,'Fontsize', fs)
    set(gcf,'PaperPositionMode','auto')
    
end

toc