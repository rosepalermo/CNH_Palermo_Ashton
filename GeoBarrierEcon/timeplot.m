hold on
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
plot(Y/1000,xsl_cr,'b', 'linewidth',2)
axis([Y(1)/1000 Y(Yn)/1000 min(xsl_cr) max(xsl_cr)+1])
% linkaxes([axes2,axes4],'x')
xlabel('Alongshore position (km)')
ylabel('shoreline change rate over whole simulation')