% plot regime diagram of Vd given H & W of barrier

h = 0.5:0.05:5;
w = 50:5:500;

[W,H] = meshgrid(w,h);

He = 2;
We = 300;
Db = 6;

Vd_H=max(0,(He-H).*W);
Vd_B=max(0,(We-W).*(H+Db));
Vd=Vd_H+Vd_B;

imagesc(w,h,Vd)
ylabel('height')
xlabel('width')
hold on
c = colorbar;
c.Label.String = 'volume deficit';
contour(w,h,Vd,[0 300],'k')
set(gca,'ydir','normal')
set(gca,'FontSize',16)
xline(We,'--');
yline(He,'--');
% caxis([0 300])