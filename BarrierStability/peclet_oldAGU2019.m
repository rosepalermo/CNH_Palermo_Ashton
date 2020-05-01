% constants
g = 9.8;
gamma_min = 0.73; %(ranges from 0.73 to 1.03)
gamma_max = 1.03;
Dsf = 10;
T = 8;
H = 1;
psi_min = 0;
psi_max = 1;
psi = 0.01:0.01:1;
gamma = 0.73:0.01:1.03;
E = T.^(1/5)*H.^(12/5);
Dbb = 0.25:0.25:10;
Qow1 = 30;
Dbb1 = 2;
Qow = 1:80;


% first estimates

K1 = 0.39;
K2 = ((sqrt(g.*gamma)./(2*pi)).^(1/5))*K1;
K2_min = ((sqrt(g*gamma_min)./(2*pi))^(1/5))*K1;
K2_max = ((sqrt(g*gamma_max)./(2*pi))^(1/5))*K1;

for k = 1:length(K2)
    for p = 1:length(psi)
        mu_first(k,p) = K2(k)./Dsf.*E*psi(p)*365*60*60*24;
    end
end
% figure()
% imagesc(K2,psi,mu')
% h = colorbar;
% ylabel(h, 'mu')
% xlabel('K2')
% ylabel('psi')
% set(gca,'FontSize',14)
% set(gca,'YDir','normal')
% little variation in K2, so taking the average
K2av = mean(K2)./2; % THIS K2 IS WRONG!!!! MISSING A FACTOR OF 2 SO DIVIDE BY 2! SHOULD BE 0.17!

% % Vary Dbb
% for p = 1:length(psi)
%     mu(p) = K2av./Dsf.*E*psi(p)*365*60*60*24;
%     for d = 1:length(Dbb)
%         L_ast(d,p) = mu(p).*Dbb(d)./Qow1./1000;
%     end
% end
% %  L_ast = mu.*Dbb./Qow;
% figure()
% imagesc(Dbb,psi,L_ast')
% h = colorbar;
% ylabel(h, 'L_a_s_t (km)')
% xlabel('D_b_b')
% ylabel('psi')
% set(gca,'FontSize',14)
% set(gca,'YDir','normal')
% title(sprintf('L_a_s_t when Pe = 1; Qow = %d',Qow1))
% 
% % Vary Qow
% for p = 1:length(psi)
%     mu(p) = K2av./Dsf.*E*psi(p)*365*60*60*24;
%     for q = 1:length(Qow)
%         L_ast2(q,p) = mu(p).*Dbb1./Qow(q)./1000;
%     end
% end
% %  L_ast = mu.*Dbb./Qow;
% figure()
% imagesc(Qow,psi,L_ast2')
% h = colorbar;
% ylabel(h, 'L_a_s_t (km)')
% xlabel('Q_o_w')
% ylabel('psi')
% set(gca,'FontSize',14)
% set(gca,'YDir','normal')
% title(sprintf('L_a_s_t when Pe = 1; Dbb = %d',Dbb1))
% 
% figure()
% imagesc(Qow,psi,log(L_ast2'))
% h = colorbar;
% ylabel(h, 'log (L_a_s_t) log(km)')
% xlabel('Q_o_w')
% ylabel('psi')
% set(gca,'FontSize',14)
% set(gca,'YDir','normal')
% title(sprintf('L_a_s_t when Pe = 1; Dbb = %d',Dbb1))

%% in my code
astfac = 0.1:0.01:1;
K2_LTA = 0.34/2;

for p = 1:length(psi)
       mu_LTA(p) = K2_LTA./Dsf.*E*psi(p)*365*60*60*24;
    for q = 1:length(Qow)
       L_astLTA(q,p) = mu_LTA(p).*Dbb1./Qow(q)./1000;
    end
end
figure()
imagesc(Qow,mu_LTA,L_astLTA')
h = colorbar;
ylabel(h, 'L_a_s_t (km)')
xlabel('Q_o_w (m^3/m/yr)')
ylabel('{\mu}')
% ylabel('{\mu} (m^8^/^5/s^6^/^5)')
set(gca,'YDir','normal')
title(sprintf('L_a_s_t when Pe = 1; d_b_b = %d',Dbb1))
% caxis([0 max(max(L_astLTA))])
set(gca,'colorscale','log')
hold on
[C,h] = contour(Qow,mu_LTA,L_astLTA',[10,25,50,100,150],'LineColor','k');
clabel(C,h,'FontSize',14)
set(gca,'FontSize',16)



% Vary Dbb
for p = 1:length(psi)
    mu(p) = K2_LTA./Dsf.*E*psi(p)*365*60*60*24;
    for d = 1:length(Dbb)
        L_ast(d,p) = mu(p).*Dbb(d)./Qow1./1000;
    end
end
%  L_ast = mu.*Dbb./Qow;
figure()
imagesc(Dbb,mu,L_ast')
h = colorbar;
ylabel(h, 'L_a_s_t (km)')
xlabel('d_b_b (m)')
ylabel('{\mu}')
% ylabel('{\mu} (m^8^/^5/s^6^/^5)')
set(gca,'YDir','normal')
title(sprintf('L_a_s_t when Pe = 1; Q_o_w = %d',Qow1))
% caxis([0 max(max(L_astLTA))])
set(gca,'colorscale','log')
hold on
[C,h] = contour(Dbb,mu,L_ast',[10,25,50,100,150],'LineColor','k');
clabel(C,h,'FontSize',14)
set(gca,'FontSize',16)



%% now when L_ow is not the same as L_AST
% L_ow = 2000:500:4000; % 2-4 (estimated from barrier islands in AL)
% L_ow = 4000;
% 
% for p = 1:length(psi)
%        mu_LTA(p) = K2_LTA./Dsf.*E*psi(p)*365*60*60*24;
%     for q = 1:length(Qow)
%        L_astLTA(q,p) = sqrt(mu_LTA(p).*Dbb1.*L_ow./Qow(q))./1000;
%     end
% end
% figure()
% imagesc(Qow,psi,L_astLTA')
% h = colorbar;
% ylabel(h, 'L_a_s_t LTA (km)')
% xlabel('Qow')
% ylabel('psi')
% set(gca,'FontSize',14)
% set(gca,'YDir','normal')
% title(sprintf('L_a_s_t calc. in LTA when Pe = 1; Dbb = %d',Dbb1))
% set(gca,'colorscale','log')
