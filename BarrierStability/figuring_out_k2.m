% Froude number is a comparison of velocities. Speed of the fluid vs speed of the wave.
gamma = 0.73:0.01:1.03;
K1 = 0.39;
astfac = 0.1:0.01:1;
T = 8;
H = 1;
E = T.^(1/5)*H.^(12/5);
ang = deg2rad(0:90);
g = 9.8;

K2_LTA = 0.34/2;
K2_AA1 = ((sqrt(g.*gamma)./(2*pi)).^(1/5))*K1;
K2 = 0.34;

for p = 1:length(ang)
    QsAST_LTA(p) = K2_LTA.*E.*((cos(ang(p))).^(6/5)).*(sin(ang(p)))*365*60*60*24;
end

figure()
plot(rad2deg(ang),QsAST_LTA)
% h = colorbar;
% ylabel(h, 'QsAST_LTA')
xlabel('ang')
ylabel('Qast using K2 = 0.17')
set(gca,'FontSize',14)
set(gca,'YDir','normal')

for p = 1:length(ang)
    QsAST_AA1(p) = K2.*E.*((cos(ang(p))).^(6/5)).*(sin(ang(p)))*365*60*60*24;
end

figure()
plot(rad2deg(ang),QsAST_AA1)
% h = colorbar;
% ylabel(h, 'QsAST_LTA')
xlabel('ang')
ylabel('Qast using K2 = 0.34')
set(gca,'FontSize',14)
set(gca,'YDir','normal')

% 0.34 is 2x bigger than it is supposed to be
% K2 is supposed to be 0.34/2