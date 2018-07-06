addpath('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/natural')
load('NAT_sWmid_OW20_K200_SLa4_diff10.mat')
llxldot_saveall = llxldot_saveall(:,1+buff:end-buff);
figure()
W = Qow_saveall./(abs(llxldot_saveall));%*100);
subplot(2,1,1); imagesc(t,Y(1+buff:end-buff),abs(W)'); set(gca,'clim',[0 2])
title('W')
subplot(2,1,2); imagesc(t,Y(1+buff:end-buff),abs(W_saveall)'); set(gca,'clim',[150 300])
title('Width')


H = figure(); 
H.Position = [671   302   709   503];
subplot(2,2,1)
plot(t,xsl_saveall(:,50),'k','LineWidth',2)
hold on
plot(t,xsl_saveall(:,10),'k--','LineWidth',2)
xlabel('time (years)')
ylabel('crossshore position (meters)')
set(gca,'FontSize',14)
set(gca,'ylim',[650 850])
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
plot(t,Qow_saveall(:,50),'Color',[0.7 0.7 0.7],'LineWidth',2); 
plot(t,llxldot_saveall(:,10),'k--','LineWidth',2); 
hold on; 
plot(t,Qow_saveall(:,10),'--','Color',[0.7 0.7 0.7],'LineWidth',2); 
xlabel('time (years)')
ylabel('Sediment flux (m^3/yr)')
legend('Qast (@ 5000 m) ','Qow (@ 5000 m)','Qast (@ 1000 m)','Qow (@ 1000 m)')
set(gca,'FontSize',14)
set(gca,'ylim',[-Qow_max Qow_max])

subplot(2,2,4)
plot(t,W(:,50),'k','LineWidth',2)
hold on
plot(t,W(:,10),'k--','LineWidth',2)
set(gca,'ylim',[0 2],'xlim',[0 t(end)])
set(gca,'FontSize',14)
xlabel('time (years)')
ylabel('W = Qow/Qast')

figure()
subplot(1,3,1)
imagesc(t,Y(1+buff:end-buff),Qow_saveall')
set(gca,'ydir','normal','FontSize',12)
set(gca,'clim',[0 50])
xlabel('time(years)')
ylabel('alongshore distance (meters)')
title('0.4')
colorbar

subplot(1,3,2)
imagesc(t,Y(1+buff:end-buff),llxldot_saveall')
set(gca,'ydir','normal','FontSize',12)
set(gca,'clim',[-200 200])
xlabel('time (years)')
ylabel('alongshore distance (meters)')
title('Qast')
colorbar

subplot(1,3,3)
Wratio = Qow_saveall./llxldot_saveall;
imagesc(t,Y(1+buff:end-buff),abs(Wratio)')
set(gca,'ydir','normal','FontSize',12)
set(gca,'clim',[0 2])
xlabel('time(years)')
ylabel('alongshore distance (meters)')
title('Washover ratio (Qow/Qast)')
colorbar
