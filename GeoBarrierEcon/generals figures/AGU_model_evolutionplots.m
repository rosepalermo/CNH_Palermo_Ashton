% AGU model evolution plots
addpath('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/natural')
load('NAT_sWmid_OW20_K200_SLa4_diff10.mat')
llxldot_saveall = -llxldot_saveall(:,1+buff:end-buff);


figure()
imagesc(Qow_saveall./llxldot_saveall)
colormap(parula(4))
set(gca,'Clim',[-2 2])

imagesc(Qsf_saveall)

%%
h = figure()
h.Position = [440   488   711   317];

plot(Y(1+buff:end-buff)/1000,(xsl_saveall(1,:)-650)/1000,'b','LineWidth',2)
hold on
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(1,buff+1:end-buff)-650)/1000,'r','LineWidth',2)
set(gca,'xlim',[Y(1)/1000 Y(end)/1000])
set(gca,'xtick',[0:5:10])
set(gca,'ylim',[0 0.5])
set(gca,'ytick',[0 0.5])
xlabel('alongshore position (km)')
ylabel('cross-shore position (km)')
set(gca,'FontSize',14)

h = figure()
h.Position = [440   488   711   317];

plot(Y(1+buff:end-buff)/1000,(xsl_saveall(1,:)-650)/1000,'Color',[0.5 0.5 0.5],'LineWidth',2)
hold on
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(1,buff+1:end-buff)-650)/1000,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xsl_saveall(5000,:)-650)/1000,'b','LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(5000,buff+1:end-buff)-650)/1000,'r','LineWidth',2)
set(gca,'xlim',[Y(1)/1000 Y(end)/1000])
set(gca,'xtick',[0:5:10])
set(gca,'ylim',[0 0.5])
set(gca,'ytick',[0 0.5])
xlabel('alongshore position (km)')
ylabel('cross-shore position (km)')
set(gca,'FontSize',14)

h = figure()
h.Position = [440   488   711   317];

plot(Y(1+buff:end-buff)/1000,(xsl_saveall(1,:)-650)/1000,'Color',[0.75 0.75 0.75],'LineWidth',2)
hold on
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(1,buff+1:end-buff)-650)/1000,'Color',[0.75 0.75 0.75],'LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xsl_saveall(5000,:)-650)/1000,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(5000,buff+1:end-buff)-650)/1000,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xsl_saveall(9150,:)-650)/1000,'b','LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(9150,buff+1:end-buff)-650)/1000,'r','LineWidth',2)
set(gca,'xlim',[Y(1)/1000 Y(end)/1000])
set(gca,'xtick',[0:5:10])
set(gca,'ylim',[0 0.5])
set(gca,'ytick',[0 0.5])
xlabel('alongshore position (km)')
ylabel('cross-shore position (km)')
set(gca,'FontSize',14)

h = figure()
h.Position = [440   488   711   317];

plot(Y(1+buff:end-buff)/1000,(xsl_saveall(1,:)-650)/1000,'Color',[0.9 0.9 0.9],'LineWidth',2)
hold on
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(1,buff+1:end-buff)-650)/1000,'Color',[0.9 0.9 0.9],'LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xsl_saveall(5000,:)-650)/1000,'Color',[0.75 0.75 0.75],'LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(5000,buff+1:end-buff)-650)/1000,'Color',[0.75 0.75 0.75],'LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xsl_saveall(9150,:)-650)/1000,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(9150,buff+1:end-buff)-650)/1000,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xsl_saveall(end,:)-650)/1000,'b','LineWidth',2)
plot(Y(1+buff:end-buff)/1000,(xbb_saveall(end,buff+1:end-buff)-650)/1000,'r','LineWidth',2)
set(gca,'xlim',[Y(1)/1000 Y(end)/1000])
set(gca,'xtick',[0:5:10])
set(gca,'ylim',[0 0.5])
set(gca,'ytick',[0 0.5])
xlabel('alongshore position (km)')
ylabel('cross-shore position (km)')
set(gca,'FontSize',14)
