addpath('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/natural')
load('NAT_sWmid_OW20_K200_SLa4_diff10.mat')
llxldot_saveall = -llxldot_saveall(:,1+buff:end-buff);



% figure()
W_ratio = Qow_saveall./(llxldot_saveall);%*100);
% subplot(2,1,1); imagesc(t,Y(1+buff:end-buff),(W_ratio)'); set(gca,'clim',[0 2])
% title('W')
% subplot(2,1,2); imagesc(t,Y(1+buff:end-buff),(W_saveall)'); set(gca,'clim',[150 300])
% title('Width')
h = figure()
h.Position = [440   488   711   317];

plot(Y(1+buff:end-buff),xsl_saveall(1,:)-650,'b','LineWidth',2)
hold on
plot(Y(1+buff:end-buff),xbb_saveall(1,buff+1:end-buff)-650,'r','LineWidth',2)
plot(Y(1+buff:end-buff),xsl_saveall(5000,:)-650,'b','LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(5000,buff+1:end-buff)-650,'r','LineWidth',2)
plot(Y(1+buff:end-buff),xsl_saveall(9150,:)-650,'b','LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(9150,buff+1:end-buff)-650,'r','LineWidth',2)
plot(Y(1+buff:end-buff),xsl_saveall(end,:)-650,'b','LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(end,buff+1:end-buff)-650,'r','LineWidth',2)
set(gca,'xlim',[Y(1) Y(end)])
legend('shoreline','backbarrier')
xlabel('alongshore position (meters)')
ylabel('cross-shore position (meters)')
set(gca,'FontSize',14)

H = figure(); 
H.Position = [671   302   709   503];
subplot(2,2,1)
plot(t,xsl_saveall(:,50)-650,'b','LineWidth',2)
hold on
plot(t,xsl_saveall(:,10)-650,'b--','LineWidth',2)
plot(t,xbb_saveall(:,50)-650,'r','LineWidth',2)
hold on
plot(t,xbb_saveall(:,10)-650,'r--','LineWidth',2)
xlabel('time (years)')
ylabel('cross-shore position (meters)')
set(gca,'FontSize',14)
% set(gca,'ylim',[0 850])
legend('(@ 5000 m)','(@ 1000 m)')


subplot(2,2,2)
plot(t,W_saveall(:,50),'k','LineWidth',2)
hold on
plot(t,W_saveall(:,10),'k--','LineWidth',2)
xlabel('time (years)')
ylabel('Width (meters)')
set(gca,'FontSize',14)
set(gca,'ylim',[150 350])



subplot(2,2,3)
plot(t,llxldot_saveall(:,50),'k','LineWidth',2); 
hold on; 
plot(t,Qow_saveall(:,50),'Color',[0.6 0.6 0.6],'LineWidth',2); 
plot(t,llxldot_saveall(:,10),'k--','LineWidth',2); 
hold on; 
plot(t,Qow_saveall(:,10),'--','Color',[0.6 0.6 0.6],'LineWidth',2); 
xlabel('time (years)')
ylabel('Sediment flux (m^3/yr)')
legend('Qast gradient ','Qow ')%,'Qast gradient (@ 1000 m)','Qow (@ 1000 m)')
set(gca,'FontSize',14)
set(gca,'ylim',[min(min(llxldot_saveall)) Qow_max+10])

ax3 = subplot(2,2,4)
plot(t,W_ratio(:,50),'k','LineWidth',2)
hold on
plot(t,W_ratio(:,10),'k--','LineWidth',2)
set(gca,'ylim',[-2 2],'xlim',[0 t(end)])
set(gca,'FontSize',14)
colormap(ax3,gray(4))
xlabel('time (years)')
ylabel('W = Qow/Qast')

figure()
ax1 = subplot(1,3,1)
imagesc(t,Y(1+buff:end-buff),Qow_saveall')
set(gca,'ydir','normal','FontSize',12)
set(gca,'clim',[-Qow_max Qow_max])
xlabel('time(years)')
ylabel('alongshore distance (meters)')
title('Q_o_w')
colormap(ax1,redblue)
colorbar

ax2 = subplot(1,3,2)
imagesc(t,Y(1+buff:end-buff),llxldot_saveall')
set(gca,'ydir','normal','FontSize',12)
set(gca,'clim',[-Qow_max Qow_max])
xlabel('time (years)')
ylabel('alongshore distance (meters)')
title('Q_a_s_t')
colormap(ax2,redblue)
colorbar

ax3 = subplot(1,3,3)
Wratio = Qow_saveall./llxldot_saveall;
imagesc(t,Y(1+buff:end-buff),(Wratio)')
set(gca,'ydir','normal','FontSize',12)
set(gca,'clim',[-2 2])
xlabel('time(years)')
ylabel('alongshore distance (meters)')
colormap(ax3,parula(4))
title('Washover ratio (Q_o_w/Q_a_s_t)')
colorbar

%% for the presentation
h = figure()
h.Position = [440   488   711   317];

plot(Y(1+buff:end-buff),xsl_saveall(1,:)-650,'b','LineWidth',2)
hold on
plot(Y(1+buff:end-buff),xbb_saveall(1,buff+1:end-buff)-650,'r','LineWidth',2)
set(gca,'xlim',[Y(1) Y(end)])
set(gca,'ylim',[0 500])
xlabel('alongshore position (meters)')
ylabel('cross-shore position (meters)')
set(gca,'FontSize',14)

h = figure()
h.Position = [440   488   711   317];

plot(Y(1+buff:end-buff),xsl_saveall(1,:)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
hold on
plot(Y(1+buff:end-buff),xbb_saveall(1,buff+1:end-buff)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff),xsl_saveall(5000,:)-650,'b','LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(5000,buff+1:end-buff)-650,'r','LineWidth',2)
set(gca,'xlim',[Y(1) Y(end)])
set(gca,'ylim',[0 500])
xlabel('alongshore position (meters)')
ylabel('cross-shore position (meters)')
set(gca,'FontSize',14)

h = figure()
h.Position = [440   488   711   317];

plot(Y(1+buff:end-buff),xsl_saveall(1,:)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
hold on
plot(Y(1+buff:end-buff),xbb_saveall(1,buff+1:end-buff)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff),xsl_saveall(5000,:)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(5000,buff+1:end-buff)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff),xsl_saveall(9150,:)-650,'b','LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(9150,buff+1:end-buff)-650,'r','LineWidth',2)
set(gca,'xlim',[Y(1) Y(end)])
set(gca,'ylim',[0 500])
xlabel('alongshore position (meters)')
ylabel('cross-shore position (meters)')
set(gca,'FontSize',14)

h = figure()
h.Position = [440   488   711   317];

plot(Y(1+buff:end-buff),xsl_saveall(1,:)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
hold on
plot(Y(1+buff:end-buff),xbb_saveall(1,buff+1:end-buff)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff),xsl_saveall(5000,:)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(5000,buff+1:end-buff)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff),xsl_saveall(9150,:)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(9150,buff+1:end-buff)-650,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff),xsl_saveall(end,:)-650,'b','LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(end,buff+1:end-buff)-650,'r','LineWidth',2)
set(gca,'xlim',[Y(1) Y(end)])
set(gca,'ylim',[0 500])
xlabel('alongshore position (meters)')
ylabel('cross-shore position (meters)')
set(gca,'FontSize',14)