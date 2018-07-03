
addpath('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/natural only')
load('NAT_sWmid_OW20_K200_SLa3_diff1.mat')
Y = Y(1+buff:end-buff);
xbb_saveall = xbb_saveall(:,1+buff:end-buff);
W = Qow_saveall./abs(Qast_saveall);


h = figure()
h.Position = [440   488   711   317];

plot(Y,xsl_saveall(1,:),'b','LineWidth',2)
hold on
plot(Y,xbb_saveall(1,:),'r','LineWidth',2)
plot(Y,xsl_saveall(5000,:),'b','LineWidth',2)
plot(Y,xbb_saveall(5000,:),'r','LineWidth',2)
plot(Y,xsl_saveall(end,:),'b','LineWidth',2)
plot(Y,xbb_saveall(end,:),'r','LineWidth',2)
set(gca,'xlim',[Y(1) Y(end)])


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
plot(t,Qast_saveall(:,50),'k','LineWidth',2); 
hold on; 
plot(t,Qow_saveall(:,50),'Color',[0.7 0.7 0.7],'LineWidth',2); 
plot(t,Qast_saveall(:,10),'k--','LineWidth',2); 
hold on; 
plot(t,Qow_saveall(:,10),'--','Color',[0.7 0.7 0.7],'LineWidth',2); 
xlabel('time (years)')
ylabel('Sediment flux (m^3/yr)')
legend('Qast (@ 5000 m) ','Qow (@ 5000 m)','Qast (@ 1000 m)','Qow (@ 1000 m)')
set(gca,'FontSize',14)
set(gca,'ylim',[-10 75])

subplot(2,2,4)
plot(t,W(:,50),'k','LineWidth',2)
hold on
plot(t,W(:,10),'k--','LineWidth',2)
set(gca,'ylim',[0 2])
set(gca,'FontSize',14)
xlabel('time (years)')
ylabel('W = Qow/Qast')
%%
load('NAT_sWmid_OW20_K200_SLa3_diff10.mat')
Y = Y(1+buff:end-buff);
xbb_saveall = xbb_saveall(:,1+buff:end-buff);
W = Qow_saveall./abs(Qast_saveall);


h = figure()
h.Position = [440   488   711   317];
hold on
plot(Y,xsl_saveall(1,:),'b','LineWidth',2)
plot(Y,xbb_saveall(1,:),'r','LineWidth',2)
plot(Y,xsl_saveall(5000,:),'b','LineWidth',2)
plot(Y,xbb_saveall(5000,:),'r','LineWidth',2)
plot(Y,xsl_saveall(9150,:),'b','LineWidth',2)
plot(Y,xbb_saveall(9150,:),'r','LineWidth',2)
plot(Y,xsl_saveall(end,:),'b','LineWidth',2)
plot(Y,xbb_saveall(end,:),'r','LineWidth',2)
xlabel('alongshore position (meters)')
ylabel('cross shore position (meters)')
set(gca,'FontSize',14)
set(gca,'xlim',[Y(1) Y(end)])


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
plot(t,Qast_saveall(:,50),'k','LineWidth',2); 
hold on; 
plot(t,Qow_saveall(:,50),'Color',[0.7 0.7 0.7],'LineWidth',2); 
plot(t,Qast_saveall(:,10),'k--','LineWidth',2); 
hold on; 
plot(t,Qow_saveall(:,10),'--','Color',[0.7 0.7 0.7],'LineWidth',2); 
xlabel('time (years)')
ylabel('Sediment flux (m^3/yr)')
legend('Qast (@ 5000 m) ','Qow (@ 5000 m)','Qast (@ 1000 m)','Qow (@ 1000 m)')
set(gca,'FontSize',14)
set(gca,'ylim',[-10 75])

subplot(2,2,4)
plot(t,W(:,50),'k','LineWidth',2)
hold on
plot(t,W(:,10),'k--','LineWidth',2)
set(gca,'ylim',[0 2])
set(gca,'FontSize',14)
xlabel('time (years)')
ylabel('W = Qow/Qast')

