% make pdf of approximate gulf lengths
load('gulf_length_approx.mat')
lengths = sort(lengths);

figure()
[f,x] = ecdf(lengths); plot(x,f,'k','LineWidth',2); %Empirical CDF
hold on
plot(ones(length(f),1)*8.14,f)
xlabel('Length (km)')
ylabel('Probability')
title('Approximate length of Gulf coastal barriers')
set(gca,'FontSize',16)

% Approximate an alongshore length
psi = 0.4;%0:0.1:1;
Qow = 5:25;
db = 2;
H = 2;
w = 350;
mu = 0.025*365*60*60*24*psi;
L_gom = sqrt(mu.*w.*(db+H)./Qow)/1000;

Pe = (10./(H+db))*(lengths.^2)./mu./w;
Pe = sort(Pe);

figure()
[f,x] = ecdf(Pe); plot(x,f,'k','LineWidth',2); %Empirical CDF
hold on
% plot(ones(length(f),1)*8.14,f)
xlabel('Pe')
ylabel('Probability')
title('Approximate length of Gulf coastal barriers')
set(gca,'FontSize',16)


% average volume of overwash deposit from Aylward 2015 ~500 m^3
% average alongshore length of overwash deposits 20-100 m
% average Qow = 5-25, going with 10 in the middle
