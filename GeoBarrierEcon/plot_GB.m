if save_on
    jplot = jplot-buff;
    fs = 12;
end

% plot washover and shoreface fluxes
figure()
if ~community_on
    %ppp = Xsl_save(:,jplot)
    plot(t,QowH_saveall(:,jplot),'Color','g', 'linewidth',2)
    hold on
    plot(t,QowB_saveall(:,jplot),'Color','b', 'linewidth',2)
    plot(t,Qow_saveall(:,jplot),'Color','k', 'linewidth',2)
    plot(t,Qsf_saveall(:,jplot),'Color','r', 'linewidth',2)
    plot(t,Qast_saveall(:,jplot),'--','Color','k','LineWidth',2)

end
xlabel('tme (years)')
ylabel('Overwash flux')
legend('Qow_H','Qow_B','Qow','Qsf','Qast')
set(gca,'fontweight','bold')
set(gca,'Fontsize', fs)
str=sprintf('Max Overwash = %d, K = %d, & Sea level rise = %d',Qow_max,Ksf,sl_a);
title(str)
% set(gcf,'PaperPositonMode','auto')

% plot OW_H
figure()
ax1 = subplot(2,3,1)
imagesc(t,Y(buff:length(Y)-buff)/1000,transpose(QowH_saveall))
colormap parula
colorbar
title('OW_H')


% plot OW_B
ax2 = subplot(2,3,2)
imagesc(t,Y(buff:length(Y)-buff)/1000,transpose(QowB_saveall))
colormap parula
colorbar
title('OW_B')

% plot OW_
ax3 = subplot(2,3,3)
imagesc(t,Y(buff:length(Y)-buff)/1000,transpose(Qow_saveall))
colormap parula
colorbar
title('OW')

% plot Qast
ax4 = subplot(2,3,4)
imagesc(t,Y(buff:length(Y)-buff)/1000,transpose(Qsf_saveall))
colormap parula
colorbar
title('SF')

% plot Qast
ax5 = subplot(2,3,5)
imagesc(t,Y(buff:length(Y)-buff)/1000,transpose(Qast_saveall))
colormap parula
colorbar
title('AST')

% plot W
ax6 = subplot(2,3,6)
imagesc(t,Y(buff:length(Y)-buff)/1000,transpose(W_saveall))
colormap parula
colorbar
title('Width')