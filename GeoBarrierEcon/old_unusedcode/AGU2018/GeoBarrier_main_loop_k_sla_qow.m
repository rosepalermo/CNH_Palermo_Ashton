%% Barrier geometric model with coupled Alongshore. %%%%%%%%%%%%%%%
% Jorge Lorenzo Trueba adopted by Andrew Ashton starting 2-2015
% adopted by Rose Palermo starting 2-2017
close all;clear all;

% inputs
GeoBarrier_inputs
Time_inputs
% Community_inputs

if exist('ncom')
    community_on = true;
else
    community_on = false;
end

%% TIME LOOP %%%%%%%%%%%%%%%%%%%%
for kk=1:length(kks)
    Ksf = kks(kk);
    
    for qow = 1:length(qows)
        Qow_max = qows(qow);
        
        for zz = 1:length(zzs)
            sl_a = zzs(zz);
            
    %input variables

    
    %%%% Sea level
    Z=0;             % trying z= 0 which is the sea level
    
    %     %%%% Set the Domain Variables for the barrier
    %     B=ones(1,ys) * Bslope; % Basement Slope, can be different
    %     xtoe(Yi)=0;            % X toe
    %     xsl(Yi)=Dsf/Ae;        % X shoreline
    %     W(Yi)=Wstart;          % Barrier width (m)
    %     xbb(Yi)=xsl(Yi)+W(Yi); % X backbarrier
    %     H(Yi) =He;             % barrier height
    
    Gen_BarrierIC %set barrier inital conditions (include those above)
    %BarrierIC_LBI %cartoon of Long Beach Island. This is trash. Need the
    %              %real data
%     BarrierIC_small_W_in_middle
    %BarrierIC_small_W_1st_half
%     BarrierIC_bump_middle_sl_bb
%     BarrierIC_bump_middle_sl
    
    if community_on
        %%%% Set community locations
        for c = 1:ncom
            com(c).location = mean(xsl(com(c).jj))+com(c).w0;            % cross shore location of com
            com(c).W = zeros(ts,length(com(c).jj));   % for width of beach in front of com
        end
    end
    
    %%%% Zero the Save Variables
    Xtoe_save = zeros(tsavetimes, ys);
    xsl_save = zeros(tsavetimes, ys);
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
        
        if community_on
            for c = 1:ncom
                com(c).W(i,:) = (com(c).location - xsl(com(c).jj)); % beach width
                com(c).Wav(i,kk,qow,zz) = mean(com(c).W(i,:),2); %average width BEFORE NOURISHMENT
            end
        end
        
        %         % save all of the shorelines because it will evaluate the retreat rate
        %         % at each year
        xsl_saveall(i,:) = xsl;
        
        %amount of of shoreline retreat from this year to previous year
        if community_on
            if i>100
                for c = 1:ncom
                    com(c).slr = (mean(xsl_saveall(i,com(c).jj))-mean(xsl_saveall(i-100,com(c).jj)))/100;
                end
            end
        end
        
        if community_on
            if i<100 % in the first year we'll just say no change
                for c = 1:ncom
                    com(c).slr = 0;
                end
            end
        end
        
        Yvnn= [0,0,Dsf];
        if community_on
            for c = 1:ncom
                com(c).Xvnn = [mean(xsl(com(c).jj)),mean(xsl(com(c).jj))-com(c).Wn,mean(xtoe(com(c).jj))];
                com(c).Vnn = polyarea(com(c).Xvnn,Yvnn)+com(c).Wn*mean(H(com(c).jj));
            end
        end
        
        %% economics
        if community_on
            for c = 1:ncom
                [nNB,mNB]=cba(nyears,com(c).nproperties,com(c).L,dy,com(c).alpha,b,com(c).slr,com(c).Wn,com(c).Wav(i,kk,qow,zz),min(com(c).W(i,:)),com(c).W(1,1),com(c).propertysize,f,c,mean(H(com(c).jj)),Dsf,dr);
                com(c).NB(i,kk,qow,zz) = nNB;
                com(c).NBmr(i,kk,qow,zz) =mNB;
            end
        end
        
        
        %% nourishing
        if community_on
            for c = 1:ncom
                if i > 500
                    %if width and NB > 0 --> nourish
                    if min(com(c).W(i,:))>0 && com(c).NB(i,kk,qow,zz)>0 && sum(com(c).tnourished(i-nyears*100:i,kk,qow,zz))<1
                        xsl(com(c).jj) = xsl(com(c).jj) - 2*com(c).Vnn/(2*mean(H(com(c).jj))+Dsf);
                        com(c).tnourished(i,kk,qow,zz) = 1;
                        % if width < 0 & MR<N --> nourish
                    elseif min(com(c).W(i,:))<=0 && com(c).NBmr(i,kk,qow,zz)<com(c).NB(i,kk,qow,zz)
                        xsl(com(c).jj) = xsl(com(c).jj) - 2*com(c).Vnn/(2*mean(H(com(c).jj))+Dsf);
                        com(c).tnourished(i,kk,qow,zz) = 1;
                        %if width < 0 & MR>N --> retreat
                    elseif min(com(c).W(i,:))<=0 && com(c).NBmr(i,kk,qow,zz)>com(c).NB(i,kk,qow,zz)
                        com(c).location = mean(xsl(com(c).jj))+com(c).propertysize;
                        com(c).tmanret(i,kk,qow,zz) = 1;
                        %recalculate width
                        com(c).W(i,:) = (com(c).location - xsl(com(c).jj)); %beach width
                        % if width > 0 & NB< 0 --> continue
                    elseif com(c).Wav(i,kk,qow,zz)>0 && com(c).NB(i,kk,qow,zz)<0
                        xsl(com(c).jj) = xsl(com(c).jj);
                    end
                end
            end
        end
        
        %% Variable storage ?
        if (mod(i,savenum)- 1 == 0)
            tsi = (i-1)/savenum +1;
            Xtoe_save(tsi,:) = xtoe;
            xsl_save(tsi,:) = xsl;
            Xb_save(tsi,:) = xbb;
            H_save(tsi,:)= H;
        end
        xsl_saveall(i,:) = xsl;
        
        %% Plots
        if (mod(i,plotnum)- 1 == 0)
            i;
            % PLAN VIEW
            axes2 = subplot(4,1,2);
            box(axes2,'on');
            hold(axes2,'all');
            
            hold on
            plot(Y/1000,xsl/1000,'b', 'linewidth',2)
            plot(Y/1000,xbb/1000,'r', 'linewidth',2)
            
            if community_on
                for c = 1:ncom
                    plot(Y(com(c).jj)/1000,xsl(com(c).jj)/1000,'Color',com(c).color,'linewidth',2)
                end
            end
            
            xlabel('alongshore location (km)')
            ylabel('onshore location (km)')
            
            axis([Y(buffer)/1000 Y(buffer+Yn)/1000 0.5 (max(xbb)+100)/1000])
            set(gca,'fontweight','bold')
            set(gca,'Fontsize', fs)
            
            axes3 = subplot(4,1,3);
            hold on
            
            if community_on
                for c = 1:ncom
                    jplot = floor((com(c).jj(c)+com(c).jj(end))./2); % Which profile youre plotting
                    % compute the z's
                    Db= Dsf - xbb(j)*B(j); zt=Z-Dsf; zs=Z; ztop=Z+H(j);
                    % plot the barrier parts
                    Xplot=[xtoe(jplot) xsl(jplot) xsl(jplot) xbb(jplot) xbb(jplot)]/1000;
                    Zplot=[zt     zs     ztop   ztop   -Db ];
                    plot(Xplot,Zplot,'Color',com(c).color)
                end
            end
            
            if ~community_on
                    jplot = floor(length(Yi)./2); % Which profile youre plotting, the middle of the barrier
                    % compute the z's
                    Db= Dsf - xbb(j)*B(j); zt=Z-Dsf; zs=Z; ztop=Z+H(j);
                    % plot the barrier parts
                    Xplot=[xtoe(jplot) xsl(jplot) xsl(jplot) xbb(jplot) xbb(jplot)]/1000;
                    Zplot=[zt     zs     ztop   ztop   -Db ];
                    plot(Xplot,Zplot,'Color','k')
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
    if community_on
        for c = 1:ncom
            % number of times nourished
            com(c).nnourished(1,kk,qow,zz) = sum(com(c).tnourished(:,kk,qow,zz),1);
            % which times nourished
            com(c).inourished(1:com(c).nnourished(1,kk,qow,zz),kk,qow,zz) = find(com(c).tnourished(:,kk,qow,zz)>0);
            % time between nourishments
            com(c).TBtwN(1:com(c).nnourished(1,kk,qow,zz)-1,kk,qow,zz) = diff(com(c).inourished(1:com(c).nnourished(1,kk,qow,zz),kk,qow,zz))/Tsteps;
            %number of managed retreates, when retreated, time btw retreats
            com(c).nmanret(1,kk,qow,zz) = sum(com(c).tmanret(:,kk,qow,zz));
            com(c).imanret(1:com(c).nmanret(1,kk,qow,zz),kk,qow,zz) = find(com(c).tmanret(:,kk,qow,zz)>0);
            com(c).TBtwMR(1:com(c).nmanret(1,kk,qow,zz)-1,kk,qow,zz) = diff(com(c).imanret(1:com(c).nmanret(1,kk,qow,zz),kk,qow,zz))/Tsteps;
        end
    end
    %%
    % time plot
    axes1 = subplot(4,1,1);
    box(axes1,'on');
    hold(axes1,'all');
    
    if community_on
        for c = 1:ncom
            jplot = floor((com(c).jj(1)+com(c).jj(end))./2); %plot middle of com1
            %ppp = Xsl_save(:,jplot)
            plot(tsavei*Tsave,xsl_save(:,jplot)/1000,'--','Color',com(c).color, 'linewidth',2)
            plot(tsavei*Tsave,Xb_save(:,jplot)/1000,'Color',com(c).color, 'linewidth',2)
        end
    end
    if ~community_on
            jplot = floor(length(Yi)./2); % Which profile youre plotting, the middle of the barrier
            %ppp = Xsl_save(:,jplot)
            plot(tsavei*Tsave,xsl_save(:,jplot)/1000,'--','Color','k', 'linewidth',2)
            plot(tsavei*Tsave,Xb_save(:,jplot)/1000,'Color','k', 'linewidth',2)
    end
    
    xlabel('time (years)')
    ylabel('onshore location (km)')
    set(gca,'fontweight','bold')
    set(gca,'Fontsize', fs)
    str=sprintf('Max Overwash = %d, K = %d, & Sea level rise = %d',Qow_max,Ksf,sl_a);
    title(str)
    set(gcf,'PaperPositionMode','auto')
    
    
    if community_on
        figure()
        hold on
        for c = 1:ncom
            scatter(com(c).NB(com(c).inourished(1:com(c).nnourished(1))),com(c).Wav(com(c).inourished(1:com(c).nnourished(1))),com(c).color);
        end
        xlabel('Net Benefit')
        ylabel('mean Width of community before nourishment (m)')
        legend('Community 1','Community 2')
        str=sprintf('Max Overwash = %d, K = %d, & Sea level rise = %d',Qow_max,Ksf,sl_a);
        title(str)
        set(gca,'fontweight','bold')
        set(gca,'Fontsize', fs)
        set(gcf,'PaperPositionMode','auto')
    end

    % calculate shoreline change over whole simulation
    xsl_cr = (xsl_save(1,:)-xsl_save(end,:))./Tmax;
    axes4 = subplot(4,1,4);
    plot(Y/1000,xsl_cr,'b', 'linewidth',2)
    axis([Y(buffer)/1000 Y(buffer+Yn)/1000 min(xsl_cr) max(xsl_cr)+1])
    linkaxes([axes2,axes4],'x')
    xlabel('Alongshore position (km)')
    ylabel('shoreline change rate over whole simulation')

    
        end
    end
end

