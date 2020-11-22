% constants
g = 9.8;
gamma_min = 0.73; %(ranges from 0.73 to 1.03)
gamma_max = 1.03;
Dsf = 10;
T_o = 8;
H_o = 1;
psi_min = 0.01;
psi_max = 1;
psi = psi_min:0.01:psi_max;
gamma = gamma_min:0.01:gamma_max;
E = T_o.^(1/5)*H_o.^(12/5);
Dbb = 0.25:0.25:15;
H = 2;
w = 300;
Qow1 = 10;
Dbb1 = 2;
Qow = 1:0.1:40;


%% in my code
K2_LTA = 0.34/2; %%SHOULD BE 0.17!

for p = 1:length(psi)
       mu_LTA(p) = K2_LTA./Dsf.*E*psi(p)*365*60*60*24;
    for q = 1:length(Qow)
       L_astLTA(q,p) = sqrt(mu_LTA(p).*w.*(Dbb1+H)./Qow(q))./1000;
    end
end
figure()
imagesc(Qow,mu_LTA./1000000,L_astLTA')
h = colorbar;
ylabel(h, 'L_a_s_t (km)')
xlabel('Q_o_w (m^3/m/yr)')
ylabel('{\mu} (km^2/yr)')
% ylabel('{\mu} (m^8^/^5/s^6^/^5)')
set(gca,'YDir','normal')
title(sprintf('L_a_s_t when Pe = 1; d_b_b = %d',Dbb1))
% caxis([0 max(max(L_astLTA))])
set(gca,'colorscale','log')
hold on
plot(Qow,ones(length(Qow),1)*0.315360,'--k','LineWidth',0.5)
[C,h] = contour(Qow,mu_LTA./1000000,L_astLTA',[1,5,10,15],'LineColor','k');
clabel(C,h,'FontSize',14)
set(gca,'FontSize',16)



% Vary Dbb
for p = 1:length(psi)
    mu(p) = K2_LTA./Dsf.*E*psi(p)*365*60*60*24;
    for d = 1:length(Dbb)
        L_ast(d,p) = sqrt(mu(p).*w.*(Dbb(d)+H)./Qow1)./1000;
    end
end
%  L_ast = mu.*Dbb./Qow;
figure()
imagesc(Dbb,mu./1000000,L_ast')
h = colorbar;
ylabel(h, 'L_a_s_t (km)')
xlabel('d_b_b (m)')
ylabel('{\mu} (km^2/yr)')
% ylabel('{\mu} (m^8^/^5/s^6^/^5)')
set(gca,'YDir','normal')
title(sprintf('L_a_s_t when Pe = 1; Q_o_w = %d',Qow1))
% caxis([0 max(max(L_astLTA))])
set(gca,'colorscale','log')
hold on
plot(Dbb,ones(length(Dbb),1)*0.315360,'--k','LineWidth',0.5)
[C,h] = contour(Dbb,mu./1000000,L_ast',[1,5,10,15],'LineColor','k');
clabel(C,h,'FontSize',14)
set(gca,'FontSize',16)

%% Gulf coast
mu_gom = 315360;
db_gom = 5;
Qow_gom = 10;

L_gom = sqrt(mu_gom.*w.*(db_gom+H)./Qow_gom)/1000

%% calculate Pe for GoM
mu_gom = 315360;
db_gom = 2;%2:10;
Qow_gom = 10;%5:25;
L_gom_measured = 22000;

Pe_gom = (Qow_gom./(H+db_gom))*(L_gom_measured.^2)./mu_gom./w


