% for straight barrier island (no AST) with sea level rise rate of 4mm/yr,
% plot shoreline position and width through time for OW = 50, 20 (%40 -
% residential), and 5 (10%, commercial)

addpath('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/natural only')
load('NAT_gen_OW50_K200_SLa4_diff5.mat')
figure(1)
plot(Y(1+buff:end-buff),xsl_saveall(1,:),'b','LineWidth',2)
hold on
plot(Y(1+buff:end-buff),xsl_saveall(end,:),'k','LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(1,2:end-1),'r--','LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(end,2:end-1),'k--','LineWidth',2)

figure(2)
subplot(2,1,1)
plot(t,xsl_saveall(:,50),'k','LineWidth',2)
hold on
xlabel('time (years)')
ylabel('cross-shore position (meters)')
set(gca,'FontSize',14)
set(gca,'ylim',[650 900])


subplot(2,1,2)
plot(t,W_saveall(:,50),'k','LineWidth',2)
hold on
xlabel('time (years)')
ylabel('Width (meters)')
set(gca,'FontSize',14)
set(gca,'ylim',[150 350])


load('NAT_gen_OW30_K200_SLa4_diff5.mat')
figure(1)
hold on
plot(Y(1+buff:end-buff),xsl_saveall(end,:),'Color',[0.4 0.4 0.4],'LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(end,2:end-1),'--','Color',[0.4 0.4 0.4],'LineWidth',2)

figure(2)
subplot(2,1,1)
plot(t,xsl_saveall(:,50),'Color',[0.4 0.4 0.4],'LineWidth',2)
hold on
xlabel('time (years)')
ylabel('crossshore position (meters)')
set(gca,'FontSize',14)
set(gca,'ylim',[650 900])


subplot(2,1,2)
plot(t,W_saveall(:,50),'Color',[0.4 0.4 0.4],'LineWidth',2)
hold on
xlabel('time (years)')
ylabel('Width (meters)')
set(gca,'FontSize',14)
set(gca,'ylim',[150 350])



load('NAT_gen_OW5_K200_SLa4_diff5.mat')
figure(1)
hold on
plot(Y(1+buff:end-buff),xsl_saveall(end,:),'Color',[0.8 0.8 0.8],'LineWidth',2)
plot(Y(1+buff:end-buff),xbb_saveall(end,2:end-1),'--','Color',[0.8 0.8 0.8],'LineWidth',2)

figure(2)
subplot(2,1,1)
plot(t,xsl_saveall(:,50),'Color',[0.8 0.8 0.8],'LineWidth',2)
hold on
xlabel('time (years)')
ylabel('crossshore position (meters)')
set(gca,'FontSize',14)
set(gca,'ylim',[650 900])
legend('max Qow = 50','max Qow = 30 (40% less)','max Qow = 5 (90% less)','location','southeast')

subplot(2,1,2)
plot(t,W_saveall(:,50),'Color',[0.8 0.8 0.8],'LineWidth',2)
hold on
xlabel('time (years)')
ylabel('Width (meters)')
set(gca,'FontSize',14)
set(gca,'ylim',[150 350])