% make pdf of approximate gulf lengths
load('gulf_length_approx.mat')
[p,x] = hist(lengths,15); %plot(x,p/sum(p)); %PDF

figure()
[f,x] = ecdf(lengths); plot(x,f,'k','LineWidth',2); %CDF
xlabel('Length (km)')
ylabel('Probability')
title('Approximate length of Gulf coastal barriers')
set(gca,'FontSize',16)

% Approximate an alongshore length
psi = 0.4;%0:0.1:1;
Qow = 10;
dbb = 2;
mu = 0.025*365*60*60*24*psi;
Last = mu/dbb/Qow/1000; % Length in KM

% average volume of overwash deposit from Aylward 2015 ~500 m^3
% average alongshore length of overwash deposits 20-100 m
% average Qow = 5-25, going with 10 in the middle
