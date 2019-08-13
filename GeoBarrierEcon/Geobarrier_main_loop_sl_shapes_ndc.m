% function     GeoBarrier_main_loop_sl_shapes_ndc(mbw,sl,ndc,AA,QW,shape_)

for Dbb = 2:10
mbw = 1;
sl = 2;
ndc = 1;
AA = 3;
QW = 3;
shape_ = 1;
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
if shape ==1 & developed_on
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
QowH_save = zeros(tsavetimes, ys);
QowB_save = zeros(tsavetimes, ys);
QowB_save = zeros(tsavetimes, ys);
Qow_save = zeros(tsavetimes, ys);
xsxldot_save = zeros(tsavetimes, ys);
llxldot_save = zeros(tsavetimes, ys);
Qsf_save = zeros(tsavetimes, ys);
Qast_save = zeros(tsavetimes, ys);
W_save = zeros(tsavetimes, ys);
H_save = zeros(tsavetimes, ys);
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
H_saveall = zeros(ts,length(Yi));
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
    LTA
    
    %% ALONG-SHORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    alongshore
    
    
    %% economics + nourish
    if community_on
        economics
        nourish
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
H_saveall = H_saveall(:,(1+buff:length(Y)-buff));
xsl_saveall = xsl_saveall(:,(1+buff:length(Y)-buff));
if save_on
    if xsonly

        foldername = "/Users/rosepalermo/Dropbox (MIT)/AGU2018/NJ/xsonly/";
        filename = sprintf('XS_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*1000);
    elseif developed_on
        if commercial
            foldername = "/Users/rosepalermo/Dropbox (MIT)/AGU2018/NJ/developedc/";
            filename = sprintf('DC_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
        elseif residential
            foldername = "/Users/rosepalermo/Dropbox (MIT)/AGU2018/NJ/developedr/";
            filename = sprintf('DR_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
        elseif comres_on
            foldername = "/Users/rosepalermo/Dropbox (MIT)/AGU2018/NJ/developedcr/";
            filename = sprintf('DCR_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
            
        end
    elseif community_on

        foldername = "/Users/rosepalermo/Dropbox (MIT)/AGU2018/NJ/populated/";
        filename = sprintf('COM_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
    else
        foldername = "/Users/rosepalermo/Dropbox (MIT)/march2019/";
%         foldername = "/Volumes/Rose Palermo hard drive/GeoBarrierModelOutput/natural only/";
%         filename = sprintf('NAT_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*100);
        filename = sprintf('NAT_%d_Dbb',Dbb);
    end
    savefilename = strcat(foldername,filename);
    
    if plot_on
        if community_on
            fig = '.png'; figname = strcat(foldername,filename,fig);
            saveas(h,figname)
            save(savefilename,'QowB_save','QowH_save','Qow_save','Qsf_save','Qast_save','H_save','W_save','t','Y','buff','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_save','xsl_saveall','filename','foldername','com','llxldot_saveall')
        else
            fig = '.png'; figname = strcat(foldername,filename,fig);
            saveas(h,figname)
            save(savefilename,'QowB_save','QowH_save','Qow_save','Qsf_save','Qast_save','H_save','W_save','t','Y','buff','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_save','xsl_save','filename','foldername','llxldot_save')
        end
    end
    if ~plot_on
        if community_on
            save(savefilename,'QowB_save','QowH_save','Qow_save','Qsf_save','Qast_save','H_save','W_save','t','Y','buff','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_save','xsl_save','filename','foldername','com','llxldot_save')
        else
            save(savefilename,'QowB_save','QowH_save','Qow_save','Qsf_save','Qast_save','H_save','W_save','t','Y','buff','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_save','xsl_save','filename','foldername','llxldot_save')
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