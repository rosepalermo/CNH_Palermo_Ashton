% Froude number is a comparison of velocities. Speed of the fluid vs speed of the wave.
gamma = 0.73:0.01:1.03;
K1 = 0.39;
astfac = 0.1:0.01:1;
T = 8;
H = 1;
E = T.^(1/5)*H.^(12/5);
ang = deg2rad(0:90);
g = 9.8;
Dbb = 0.25:0.25:20;
Dbb1 = 5;
Qow = 1:80;
Qow1 = 30;
Dsf = 10;

K2_LTA = 0.34/2;

for p = 1:length(ang)
    QsAST_LTA(p) = K2_LTA.*E.*((cos(ang(p))).^(6/5)).*(sin(ang(p)))*365*60*60*24;
end

% figure()
% plot(rad2deg(ang),QsAST_LTA)
% % h = colorbar;
% % ylabel(h, 'QsAST_LTA')
% xlabel('ang')
% ylabel('Qast using K2 = 0.17')
% set(gca,'FontSize',14)
% set(gca,'YDir','normal')

maxQast = max(QsAST_LTA); %m^3/m/yr max

for bb = 1:length(Dbb)
    for q = 1:length(Qow)
        Last(bb,q) = Dbb(bb)*maxQast./Qow(q)./Dsf;
    end
end

figure()
imagesc(Dbb,Qow,Last'./1000)
h = colorbar;
ylabel(h, 'L_a_s_t (km)')
xlabel('D_b_b')
ylabel('Q_o_w')
set(gca,'FontSize',14)
set(gca,'YDir','normal')
title(sprintf('L_a_s_t when Fr = 1; Q_a_s_t_,_m_a_x = %d',maxQast))
set(gca,'colorscale','log')
hold on
[C,h] = contour(Dbb,Qow,Last'./1000,[10,25,50,100,150],'LineColor','k');
clabel(C,h,'FontSize',14)
set(gca,'FontSize',16)


figure()
imagesc(Dbb,Qow,log(Last'./1000))
h = colorbar;
ylabel(h, 'log(L_a_s_t) log(km)')
xlabel('D_b_b')
ylabel('Q_o_w')
set(gca,'FontSize',14)
set(gca,'YDir','normal')
title(sprintf('L_a_s_t when Fr = 1; Q_a_s_t_,_m_a_x = %d',maxQast))

