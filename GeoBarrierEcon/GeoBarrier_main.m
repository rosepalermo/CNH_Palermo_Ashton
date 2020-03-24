%% Barrier geometric model with coupled Alongshore. %%%%%%%%%%%%%%%
% close all;clear all;
% tic
% sl_a = 0.003;%[0.003 0.004 0.005 0.01 0.05 0.1]; % sl_a right now is 0.003
% Qow_max = 20;%[5 10 20 30 40 50];
% astfac = 0.3;%[0.1 0.2 0.3 0.4 0.5];
% Dbb = 100;%2:10;
% Wstart = 325;%150:50:400;
% L = 334;%[10 30 50 70 90];% 102= ys

function GeoBarrier_main(Qow_max,astfac,Dbb,Wstart,L,sl_a,shape)
% Jorge Lorenzo Trueba adopted by Andrew Ashton starting 2-2015
% adopted by Rose Palermo starting 2-2017
    % inputs
    GeoBarrier_Inputs
    Time_inputs
    
    xsonly = false;
    save_on = true;
    developed_on = false; % this has to be true for either commercial or residential to matter
    commercial = false;
    residential = false;
    community_on = false;
    xs_only = false;
    plot_on = false;
    if plot_on
        h = figure();
    end
    
    
    %% TIME LOOP %%%%%%%%%%%%%%%%%%%%
    
    %%%% Sea level
    Z=0;             % trying z= 0 which is the sea level
    
    %     %%%% Set the Domain Variables for the barrier
    if shape == "sWmid"
        BarrierIC_small_W_in_middle %set barrier inital conditions (include those above)
    elseif shape == "gen"
        Gen_BarrierIC
    end
    % BarnegatBay3
       

    
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
                    com(c).dis2oc0(end-l:l) = NaN;
                end
                
                %dist2bb0
                for l = 1:(com(c).npropxs(ll))
                    com(c).dist2bb0(ll,end+1-l) = 16-l;
                end
                if l > (com(c).npropxs(ll))
                    com(c).dis2bb0(1:end-l) = NaN;
                end
            end
            com(c).W = zeros(ts,length(com(c).jj)); % for width of beach in front of com
        end
    end
    
    %%%% Zero the Save Variables
    Xtoe_save = zeros(tsavetimes+1, yssave);
    xsl_save = zeros(tsavetimes+1, yssave);
    xbb_save = zeros(tsavetimes+1, yssave);
    H_save= zeros(tsavetimes+1, yssave);
    QowH_save = zeros(tsavetimes+1, yssave);
    QowB_save = zeros(tsavetimes+1, yssave);
    Qow_save = zeros(tsavetimes+1, yssave);
    Qsf_save = zeros(tsavetimes+1, yssave);
    Qast_save = zeros(tsavetimes+1, yssave);
    W_save = zeros(tsavetimes+1, yssave);
    
    % xsl_saveall = zeros(ts,length(Yi));
    % xbb_saveall = zeros(ts,length(Yi));
    % QowH_saveall = zeros(ts,length(Yi));
    % QowB_saveall = zeros(ts,length(Yi));
    % Qow_saveall = zeros(ts,length(Yi));
    % Qsf_saveall = zeros(ts,length(Yi));
    % Qast_saveall = zeros(ts,length(Yi));
    % W_saveall = zeros(ts,length(Yi));
    jplot = floor(length(Ysave)./2); % Which profile youre plotting, the middle of the barrier
    
    
    
    for i=1:ts
        
        % SL curve
        zdot = sl_a+sl_b*t(i); %Base-level rise rate (m/year)
        Z = Z+zdot*dt;
        
        % Re/Set run variables
        F = zeros(1,ys); % alongshore flux zero
        
        %% CROSS-SHORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        crossshore
        % if width or height drown, break
%         if (H(j)<0) | (xbb(j)-xsl(j)<0)
        if exist('tdrown_H') | exist('tdrown_W')
            break;
        end
        
        %% ALONG-SHORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        alongshore
        
        
        %% save variables now that all changes have been made
        %     W_saveall(i,:) = xbb-xsl;
        
        %% Variable storage ?
        if (mod(i,savenum)- 1 == 0)
            tsi = (i-1)/savenum +1;
            Xtoe_save(tsi,:) = xtoe(Ysave);
            xsl_save(tsi,:) = xsl(Ysave);
            H_save(tsi,:)= H(Ysave);
            if xs_only
                Qast_save(tsi,:) = 0;
            else
                Qast_save(tsi,:) = F(Ysave);
            end
            W_save(tsi,:) = xbb(Ysave)-xsl(Ysave);
        end
        %     xsl_saveall(i,:) = xsl;
        
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
                
                axis([Y(1)/1000 Y(Yn)/1000 0.5 (nanmax(xbb)+100)/1000])
                set(gca,'fontweight','bold')
                set(gca,'Fontsize', fs)
                
                axes3 = subplot(4,1,3);
                hold on
                
                if community_on
                    for c = 1:ncom
                        jplot = floor((com(c).jj(c)+com(c).jj(end))./2); % Which profile youre plotting
                        % compute the z's
                        zt=Z-Dsf; zs=Z; ztop=Z+H(j);
                        % plot the barrier parts
                        Xplot=[xtoe(jplot) xsl(jplot) xsl(jplot) xbb(jplot) xbb(jplot)]/1000;
                        Zplot=[zt     zs     ztop   ztop   -Db ];
                        plot(Xplot,Zplot,'Color',com(c).color)
                    end
                end
                
                if ~community_on
                    jplot = floor(length(Ysave)./2); % Which profile youre plotting, the middle of the barrier
                    % compute the z's
                    zt=Z-Dsf; zs=Z; ztop=Z+H(jplot);
                    % plot the barrier parts
                    Xplot=[xtoe(jplot) xsl(jplot) xsl(jplot) xbb(jplot) xbb(jplot)]/1000;
                    Zplot=[zt     zs     ztop   ztop   -Db(jplot) ];
                    plot(Xplot,Zplot,'Color','k')
                end
                
                
                % plot a shoreface
                Xplot=[-Dsf/B(jplot) Dsf/B(jplot)]/1000;
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
    
    % calculate shoreline change over whole simulation
    xsl_cr = (xsl_save(1,:)-xsl_save(end,:))./Tmax;
    xsl_c_all = xsl_save(1:end-1,:)-xsl_save(2:end,:);
    % mdxsl(Dbb) = max(max(xsl_c_all)); % This was too small to show any
    % interesting changes. All the same.
    mxsl_cr = max(max(xsl_cr));
    mdxsl = max(max((xsl_save(1,:)-xsl_save(end,:))));
    
    % time plot
    if plot_on
        axes1 = subplot(4,1,1);
        box(axes1,'on');
        hold(axes1,'all');
        
        if community_on
            for c = 1:ncom
                jplot = floor((com(c).jj(1)+com(c).jj(end))./2); %plot middle of com1
                %ppp = Xsl_save(:,jplot)
                plot(tsavei*Tsave,xsl_save(:,jplot)/1000,'--','Color',com(c).color, 'linewidth',2)
                plot(tsavei*Tsave,xbb_save(:,jplot)/1000,'Color',com(c).color, 'linewidth',2)
            end
        end
        if ~community_on
            %ppp = Xsl_save(:,jplot)
            plot(tsavei*Tsave,xsl_save(:,jplot)/1000,'--','Color','k', 'linewidth',2)
            plot(tsavei*Tsave,xbb_save(:,jplot)/1000,'Color','k', 'linewidth',2)
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
        
        axes4 = subplot(4,1,4);
        plot(Ysave/1000,xsl_cr,'b', 'linewidth',2)
        %     axis([Y(1)/1000 Y(Yn)/1000 nanmin(xsl_cr) nanmax(xsl_cr)+1])
%         linkaxes([axes2,axes4],'x')
        xlabel('Alongshore position (km)')
        ylabel('shoreline change rate over whole simulation')
        
    end
    
    
    if save_on
        save_files
    end
end
% toc