if save_on
    if jplot>buff
        jplot = jplot-buff;
    end
    fs = 12;
end

% plot washover and shoreface fluxes
if ~community_on
    h = figure()
    %ppp = Xsl_save(:,jplot)
    plot(t,QowH_saveall(:,jplot),'Color','g', 'linewidth',2)
    hold on
    plot(t,QowB_saveall(:,jplot),'Color','b', 'linewidth',2)
    plot(t,Qow_saveall(:,jplot),'Color','k', 'linewidth',2)
    plot(t,Qsf_saveall(:,jplot),'Color','r', 'linewidth',2)
    plot(t,Qast_saveall(:,jplot),'--','Color','k','LineWidth',2)
end
if community_on
    for c = 1:ncom
        h = figure()
        h.Position = [0,0,1000,1000]
        jplot = mean(com(c).jj);
        %ppp = Xsl_save(:,jplot)
        plot(t,QowH_saveall(:,jplot),'Color','g', 'linewidth',2)
        hold on
        plot(t,QowB_saveall(:,jplot),'Color','b', 'linewidth',2)
        plot(t,Qow_saveall(:,jplot),'Color','k', 'linewidth',2)
        plot(t,Qsf_saveall(:,jplot),'Color','r', 'linewidth',2)
        plot(t,Qast_saveall(:,jplot),'--','Color','k','LineWidth',2)
        xlabel('time (years)')
        ylabel('Overwash flux')
        legend('Qow_H','Qow_B','Qow','Qsf','Qast')
        set(gca,'fontweight','bold')
        set(gca,'Fontsize', fs)
        str=sprintf('com %d, Max Overwash = %d, K = %d, & Sea level rise = %d',c,Qow_max,Ksf,sl_a);
        title(str)
        % set(gcf,'PaperPositonMode','auto')
        if save_on
            fig = '.png'; qsmid ='qsmid'; cc=num2str(c); figname = strcat(foldername,filename,qsmid,cc,fig);
            saveas(h,figname)
        end
    end
end




% plot OW_H
h = figure()
h.Position = [0,0,1000,1000]
ax1 = subplot(2,4,1);
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(QowH_saveall))
colormap parula
colorbar
shading flat
set(gca,'clim',[0,mean(median(QowH_saveall))+2*mean(std(QowH_saveall))])
title('OW_H')


% plot OW_B
ax2 = subplot(2,4,2);
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(QowB_saveall))
colormap parula
colorbar
shading flat
set(gca,'clim',[0,mean(median(QowB_saveall))+2*mean(std(QowB_saveall))])
title('OW_B')

% plot OW_
ax3 = subplot(2,4,3);
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(Qow_saveall))
colormap parula
colorbar
shading flat
title('OW')
set(gca,'clim',[0,mean(median(Qow_saveall))+2*mean(std(Qow_saveall))])


% plot Qsf
ax4 = subplot(2,4,4);
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(Qsf_saveall))
colormap parula
colorbar
shading flat
title('SF')

% plot Qxs
Qxs = Qsf_saveall + Qow_saveall;
ax5 = subplot(2,4,5);
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(Qxs))
colormap parula
colorbar
shading flat
title('XS')


% plot Qast
ax6 = subplot(2,4,6);
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(Qast_saveall))
colormap parula
colorbar
shading flat
title('AST')
if mean(median(Qast_saveall))>0
    set(gca,'clim',[mean(median(Qast_saveall))-2*mean(std(Qast_saveall)),mean(median(Qast_saveall))+2*mean(std(Qast_saveall))])
end

% plot Pe
% PE = advection/diffusion
ax7 = subplot(2,4,7);
% OR SHOULD THIS BE QXS??
O = abs(Qow_saveall)./abs(Qast_saveall); %Pe(Pe==Inf) = 9999;
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(O))
colormap parula
colorbar
shading flat
title('Overwash/AST Ratio (O)')
set(gca, 'clim', [0 1]);



% THIS WAS NOT A HELPFUL GRAPH
% % Q diff
% ax8 = subplot(2,4,8);
% Qdiff = abs(Qast_saveall) - abs(Qow_saveall);
% pcolor(t,Y(buff:length(Y)-buff)/1000,transpose(Qdiff))
% colormap parula
% colorbar
% shading flat
% title('Qast - Qow')
% set(gca,'clim',[mean(median(Qdiff))-2*mean(std(Qdiff)),mean(median(Qdiff))+2*mean(std(Qdiff))])


% plot W
% figure()
% subplot(1,2,1)
ax8 = subplot(2,4,8);
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(W_saveall))
colormap parula
colorbar
shading flat
title('Width')
if save_on
    fig = '.png'; qsmid ='figs'; figname = strcat(foldername,filename,qsmid,fig);
    saveas(h,figname)
end

% % plot shoreline change rate
h = figure()
h.Position = [0,0,1000,1000]
subplot(1,2,1)
scr = cat(1,zeros(1,length(Y)-2*buff),xsl_saveall(101:end,:)-xsl_saveall(1:end-100,:));
pcolor(t(100:end),Y(1+buff:length(Y)-buff)/1000,transpose(scr))
colormap parula
colorbar
shading flat
title('SCR (M/YR)')


%plot total amount of shoreline change across barrier
subplot(1,2,2)
sc_total = xsl_saveall(end,:) - xsl_saveall(1,:);
plot(sc_total,Y(1+buff:length(Y)-buff)/1000)
title('Total Shoreline Change')

if save_on
    fig = '.png'; scr ='scr'; figname = strcat(foldername,filename,scr,fig);
    saveas(h,figname)
end


% make figure described in my outline
% plot width, Qsf, AST, O, shoreline retreat
h = figure()
h.Position = [0,0,1500,500]
subplot(1,5,1)
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(W_saveall))
colormap parula
colorbar
shading flat
title('Width')

subplot(1,5,2)
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(Qsf_saveall))
colormap parula
colorbar
shading flat
title('Qsf')

subplot(1,5,3)
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(Qast_saveall))
colormap parula
colorbar
shading flat
title('AST')
if mean(median(Qast_saveall))>0
    set(gca,'clim',[mean(median(Qast_saveall))-2*mean(std(Qast_saveall)),mean(median(Qast_saveall))+2*mean(std(Qast_saveall))])
end

subplot(1,5,4)
pcolor(t,Y(1+buff:length(Y)-buff)/1000,transpose(O))
colormap parula
colorbar
shading flat
title('Overwash/AST Ratio (O)')
set(gca, 'clim', [0 1]);

subplot(1,5,5)
plot(sc_total,Y(1+buff:length(Y)-buff)/1000)
title('Total Shoreline Change')

if save_on
    fig = '.png'; out ='outline'; figname = strcat(foldername,filename,out,fig);
    saveas(h,figname)
end

% % plot animation
%
% figure()
% ax1_1 = subplot(
% xslplot = xsl_saveall(1:500:end,:);
% xbbplot = xsl_saveall(1:500:end,:);


