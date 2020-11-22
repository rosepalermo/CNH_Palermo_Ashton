% varying width to calculate net benefits

Wav = 0:1000;
% Wav = 50;
% alpha = 100000:1000:1000000;
for i = 1:length(Wav)
[nNB(i),mNB(i),bNB(i)]=cba_xs(nyears,alpha,b,slr,Wn,Wav(i),Wo,p,f,cost,Hav,Dsf,L,dr,dy,npropxs,npropll,subsidies);

end
% % 
% plot(alpha,bNB)
% hold on
% plot(alpha,nNB)
% plot(alpha,mNB)
% legend('bNB','nNB','mNB')
% xlabel('annual rental value ($)'); ylabel('$')

colors = parula(5);
% plot(Wav,bNB,'Color',colors(4,:),'LineWidth',2)
hold on
plot(Wav,nNB,'--','Color',colors(3,:),'LineWidth',2)
plot(Wav,mNB,'--','Color',colors(1,:),'LineWidth',2)
xlim([0 100])
% legend('beach NB','nourishment NB','managed retreat NB','location','southeast')
xlabel('Beach width'); ylabel('Net Benefits assumin no erosion ($)');%ylabel('NB assuming no erosion - NB assuming 1m/yr erosion ($)')
set(gca,'FontSize',14)
