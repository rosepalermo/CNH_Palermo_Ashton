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
        
        axis([Y/1000 Y(Yn)/1000 0.5 (max(xbb)+100)/1000])
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