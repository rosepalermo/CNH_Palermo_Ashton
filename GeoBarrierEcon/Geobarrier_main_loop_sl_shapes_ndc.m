function     GeoBarrier_main_loop_sl_shapes_ndc(mbw,sl,ndc,AA,QW,shape_)

%% Barrier geometric model with coupled Alongshore. %%%%%%%%%%%%%%%
% Jorge Lorenzo Trueba adopted by Andrew Ashton starting 2-2015
% adopted by Rose Palermo starting 2-2017
% close all;clear all;

% inputs
GeoBarrier_Inputs
Time_inputs


xsonly = false;
save_on = true;
plot_on = true;
community_on = false;
if ndc == 1
    developed_on = false;
    community_on = false;
    comres_on = false;
    
elseif ndc == 2
    developed_on = true; % this has to be true for either commercial or residential to matter
    commercial = true;
    residential = false;
    community_on = false;
    comres_on = false;
    
    
elseif ndc == 3
    developed_on = true;
    commercial = false;
    residential = true;
    comres_on = false;
    community_on = false;
elseif ndc == 4
    developed_on = true;
    commercial = false;
    residential = false;
    comres_on = true;
    community_on = false;
    
    % elseif ndc == 4
    %     developed_on = false;
    %     community_on = true;
end

%% TIME LOOP %%%%%%%%%%%%%%%%%%%%

%%%% Sea level
Z=0;             % trying z= 0 which is the sea level

%     %%%% Set the Domain Variables for the barrier
if shape_ == 1
BarrierIC_small_W_in_middle % mbw 1:5 happens
elseif shape_ == 2
BarnegatBay1
elseif shape_ == 3
BarnegatBay2
elseif shape_ == 4
BarnegatBay3
end


% set community variables
if community_on
    Community_inputs
end

% if developed on, make the middle part a community and the sides natural
% for now
if developed_on
    devjj = Yi(floor(length(Yi)/3):floor(2/3*length(Yi)));
end


if community_on
    %%%% Set community locations
    for c = 1:ncom
        com(c).yfirsthouse = xsl(com(c).jj)+com(c).w0; % cross shore location of com
        com(c).housingbb = xbb(com(c).jj);
        com(c).npropxs = floor((com(c).housingbb - xsl(com(c).jj) - com(c).w0)./com(c).propertysize);
        com(c).dist2oc0 = zeros(length(com(c).jj),max((com(c).npropxs)));
        com(c).dist2bb0 = zeros(length(com(c).jj),max((com(c).npropxs)));
        for ll = 1:length(com(c).jj)
            % dist2oc0
            for l = 1:(com(c).npropxs(ll))
                com(c).dist2oc0(ll,l) = 16-l;
            end
            if l > (com(c).npropxs(ll))
                com(c).dist2oc0(end-l:l) = NaN;
            end
            
            %dist2bb0
            for l = 1:(com(c).npropxs(ll))
                com(c).dist2bb0(ll,end+1-l) = 16-l;
            end
            if l > (com(c).npropxs(ll))
                com(c).dist2bb0(1:end-l) = NaN;
            end
        end
        com(c).W = zeros(ts,length(com(c).jj)); % for width of beach in front of com
    end
end

%%%% Zero the Save Variables
Xtoe_save = zeros(tsavetimes, ys);
xsl_save = zeros(tsavetimes, ys);
Xb_save = zeros(tsavetimes, ys);
H_save= zeros(tsavetimes, ys);
xsl_saveall = zeros(ts,length(Yi));
xbb_saveall = zeros(ts,length(Yi));
QowH_saveall = zeros(ts,length(Yi));
QowB_saveall = zeros(ts,length(Yi));
Qow_saveall = zeros(ts,length(Yi));
xsxldot_saveall = zeros(ts,length(Yi));
llxldot_saveall = zeros(ts,length(Yi));
Qsf_saveall = zeros(ts,length(Yi));
Qast_saveall = zeros(ts,length(Yi));
W_saveall = zeros(ts,length(Yi));
jplot = floor(length(Yi)./2); % Which profile youre plotting, the middle of the barrier


if plot_on
    h = figure();
    h.Position = [0,0,1000,1000]
end
for i=1:ts
    
    % SL curve
    zdot = sl_a+sl_b*t(i); %Base-level rise rate (m/year)
    Z = Z+zdot*dt;
    
    % Re/Set run variables
    F = zeros(1,ys); % alongshore flux zero
    
    %% CROSS-SHORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j = 1:ys
        
        % Compute local geometries from the saved arrays
        A=Dsf/(xsl(j)-xtoe(j)); % Shoreface Slope
        W=xbb(j)-xsl(j);    % Barrier Width
        if shape_ ~=1
            Db= min(Dsf + Z - xbb(j)*B(j),Dbb(j)); % Either calculated from the slope or Barnegat Bay Data
        else
            Db= min(Dsf + Z - xbb(j)*B(j),2); % Either calculated from the slope or 2m (~mean of Long Island data), whichever is smaller
            %                         Db= (Dsf + Z - xbb(j)*B(j));
        end
        
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
            if commercial | residential
                if devjj(1)<=j && j<=devjj(end)
                    
                    if commercial
                        Qow_B = 0.1*Qow_B;
                        Qow_H = 0.1*Qow_H;
                    elseif residential
                        Qow_B = 0.6*Qow_B;
                        Qow_H = 0.6*Qow_H;
                    end
                end
            elseif comres_on
                if devjj(1)<=j && j<=((devjj(1) + devjj(end))/2) % first half is residential
                    Qow_B = 0.6*Qow_B;
                    Qow_H = 0.6*Qow_H;
                elseif (((devjj(1) + devjj(end))/2) + 1 )<=j && j<= devjj(end) % second half is commercial
                    Qow_B = 0.1*Qow_B;
                    Qow_H = 0.1*Qow_H;
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
        QowH_saveall(i,j) = Qow_H;
        QowB_saveall(i,j) = Qow_B;
        Qow_saveall(i,j) = Qow;
        
        
        
        %shoreface flux
        Qsf=Ksf*(Ae-A);
        
        Qsf_saveall(i,j) = Qsf;
        
        % Barrier evolution ----
        % compute changes
        Hdot=Qow_H/W-zdot;
        xbdot=Qow_B/(H(j)+Db);
        xsdot=2*Qow/(Dsf+2*H(j))-4*Qsf*(H(j)+Dsf)/(2*H(j)+Dsf)^2;
        xsxldot_saveall(i,j) = xsdot;
        xtdot=2*Qsf*(1/(Dsf+2*H(j))+1/Dsf)+2*zdot/A;
        
        % Do changes- look for failure
        H(j)=H(j)+Hdot*dt;
        if H(j)<0
            tdrown_H=ti(i);
        end
        
        xbb(j)=xbb(j)+xbdot*dt;
        xsl(j)=xsl(j)+xsdot*dt;
        xtoe(j)=xtoe(j)+xtdot*dt;
        if xbb(j)-xsl(j)<0
            tdrown_W=ti(i);
        end
        
        xbb_saveall(i,j) = xbb(j);
        
    end
    
    %% ALONG-SHORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if ~xsonly
        % compute de fluxes - fluxes across rt cell border
        for j=1:(ys-1)
            F(j) = (Ka * dt) * (xsl(j+1) - xsl(j))/dy;
            %             F(j)=Ka/(2*(H(j)+H(j-1))/2+Dsf)*(xsl(j)-xsl(j-1))*dt*3650;
        end
        F(ys) = (Ka * dt) * (xsl(1) - xsl(ys))/dy;
        Qast_saveall(i,:) = F;
        
        % change the shoreline
        for j=2:(ys)
            heff = H(j) + Dsf;
            dsl = (F(j)-F(j-1))/dy/heff; % note positive sl change = erosion
            llxldot_saveall(i,j) = dsl*dy*heff;
            xsl(j) = xsl(j) + dsl;
        end
        
        heff = H(1) + Dsf;
        dsl = (F(1)-F(ys))/dy/heff;
        llxldot_saveall(i,ys) = dsl*dy*heff;
        xsl(1) = xsl(1) + dsl;
        
        if community_on
            for c = 1:ncom
                com(c).W(i,:) = (com(c).yfirsthouse - xsl(com(c).jj)); % beach width
                com(c).Wav(i) = mean(com(c).W(i,:),2); %average width BEFORE NOURISHMENT
            end
            
            %amount of of shoreline retreat from this year to previous year
            if i>100
                for c = 1:ncom
                    com(c).slr = (mean(xsl_saveall(i,com(c).jj))-mean(xsl_saveall(i-100,com(c).jj)))/100;
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
    if xsonly
        Qast_saveall(i,:) = 0;
    end
    
    
    %% economics
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
    
    
    %% nourishing
    if community_on
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
    end
    
    %% save variables now that all changes have been made
    W_saveall(i,:) = xbb-xsl;
    
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
    if plot_on
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
            if buff == 0
%               axis([Y(1) Y(end) 0.5 (max(xbb)+100)])
            else
            axis([Y(buff)/1000 Y(buff+Yn)/1000 0.5 (max(xbb)+100)/1000])
            end
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
end

%% calculate things to plot about nourishment
if community_on
    for c = 1:ncom
        % number of times nourished
        com(c).nnourished(1) = sum(com(c).tnourished(:),1);
        % which times nourished
        com(c).inourished(1:com(c).nnourished(1)) = find(com(c).tnourished(:)>0);
        % time between nourishments
        com(c).TBtwN(1:com(c).nnourished(1)-1) = diff(com(c).inourished(1:com(c).nnourished(1)))/Tsteps;
        %number of managed retreates, when retreated, time btw retreats
        com(c).nmanret(1) = sum(com(c).tmanret(:));
        com(c).imanret(1:com(c).nmanret(1)) = find(com(c).tmanret(:)>0);
        com(c).TBtwMR(1:com(c).nmanret(1)-1) = diff(com(c).imanret(1:com(c).nmanret(1)))/Tsteps;
    end
end

%%
if plot_on
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
    
    % calculate shoreline change over whole simulation
    xsl_cr = (xsl_save(1,:)-xsl_save(end,:))./Tmax;
    axes4 = subplot(4,1,4);
    plot(Y/1000,xsl_cr,'b', 'linewidth',2)
    if buff == 0
%         axis([Y(1) Y(end) min(xsl_cr) max(xsl_cr)+1])
    else
        axis([Y(buff)/1000 Y(buff+Yn)/1000 min(xsl_cr) max(xsl_cr)+1])
    end
    linkaxes([axes2,axes4],'x')
    xlabel('Alongshore position (km)')
    ylabel('shoreline change rate over whole simulation')
    
end





QowB_saveall = QowB_saveall(:,(1+buff:length(Y)-buff));
QowH_saveall = QowH_saveall(:,(1+buff:length(Y)-buff));
Qow_saveall = Qow_saveall(:,(1+buff:length(Y)-buff));
Qsf_saveall = Qsf_saveall(:,(1+buff:length(Y)-buff));
Qast_saveall = Qast_saveall(:,(1+buff:length(Y)-buff));
W_saveall = W_saveall(:,(1+buff:length(Y)-buff));
xsl_saveall = xsl_saveall(:,(1+buff:length(Y)-buff));
if save_on
    if xsonly

        foldername = "D:\Model Output AGU\xsonly\";
        filename = sprintf('XS_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*1000);
    elseif developed_on
        if commercial
            foldername = "D:\Model Output AGU\developedc\";
            filename = sprintf('DC_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
        elseif residential
            foldername = "D:\Model Output AGU\developedr\";
            filename = sprintf('DR_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
        elseif comres_on
            foldername = "D:\Model Output AGU\developedcr\";
            filename = sprintf('DCR_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
            
        end
    elseif community_on

        foldername = "D:\Model Output AGU\populated\";
        filename = sprintf('COM_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
    else
                    foldername = "D:\Model Output AGU\natural\";
%         foldername = "/Volumes/Rose Palermo hard drive/GeoBarrierModelOutput/natural only/";
        filename = sprintf('NAT_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
    end
    savefilename = strcat(foldername,filename);
    
    if plot_on
        if community_on
            fig = '.png'; figname = strcat(foldername,filename,fig);
            saveas(h,figname)
            save(savefilename,'QowB_saveall','QowH_saveall','Qow_saveall','Qsf_saveall','Qast_saveall','W_saveall','t','Y','buff','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_saveall','xsl_saveall','filename','foldername','com','llxldot_saveall')
        else
            fig = '.png'; figname = strcat(foldername,filename,fig);
            saveas(h,figname)
            save(savefilename,'QowB_saveall','QowH_saveall','Qow_saveall','Qsf_saveall','Qast_saveall','W_saveall','t','Y','buff','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_saveall','xsl_saveall','filename','foldername','llxldot_saveall')
        end
    end
    if ~plot_on
        if community_on
            save(savefilename,'QowB_saveall','QowH_saveall','Qow_saveall','Qsf_saveall','Qast_saveall','W_saveall','t','Y','buff','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_saveall','xsl_saveall','filename','foldername','com','llxldot_saveall')
        else
            save(savefilename,'QowB_saveall','QowH_saveall','Qow_saveall','Qsf_saveall','Qast_saveall','W_saveall','t','Y','buff','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_saveall','xsl_saveall','filename','foldername','llxldot_saveall')
        end
    end
end

if plot_on
    if community_on
        h = figure()
        h.Position = [0,0,1000,1000]
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
        if save_on
            fig = '.png'; nbfn = 'nb'; figname = strcat(foldername,filename,nbfn,fig);
            saveas(h,figname)
        end
    end
end

%     plot_GB


end