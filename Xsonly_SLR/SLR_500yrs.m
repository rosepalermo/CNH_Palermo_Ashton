% plot sea level rise for longer timeline than 2100 using basic exponential
% after same amount of slr after 500 years
t = 1:500; % 500 years
colors = {'r','c','k','b'};

% increasing;  % increasing sea level rise scenarios (SERDP table 3.4)
a = 1.7e-3;

Bb(1) = 1.66e-5;     % Scenario 5
Bb(2) = 3.66e-5;   % Scenario 10
Bb(3) = 1.966e-4;  % Scenario 50
Bb(4) = 3.966e-4;  % Scenario 100

for k = 1:length(Bb)
SLR_i(k,:) = a*t+Bb(k).*t.^2;   % sea level rise
RSLR_i(k,:) = a+2*Bb(k).*t;     % rate of sea level rise
end

subplot(2,2,2)
hold on
for k = 1:4
plot(t,SLR_i(k,:),colors{k})
end
xlabel('time (yrs)')
ylabel('SLR (m)')
legend('5','10','50','100','location','northwest')
title('Increasing Rate of SLR')

subplot(2,2,4)
hold on
for k = 1:4
plot(t,RSLR_i(k,:),colors{k})
end
xlabel('time (yrs)')
ylabel('Rate of SLR (m/yr)')
%%

% constant;        % constant sea level rise scenarios
b=0.000; % If b=0 constant sea-level rise

Aa(1) = 0.01; % Scenario 5
Aa(2) = 0.02; % Scenario 10
Aa(3) = 0.1; % Scenario 50
Aa(4) = 0.2; % Scenario 100

for k = 1:length(Aa)
SLR_c(k,:) = Aa(k)*t+b.*t.^2;   % sea level rise
RSLR_c(k,:) = Aa(k)+2*b.*t;     % rate of sea level rise
end


subplot(2,2,1)
hold on
for k = 1:4
plot(t,SLR_c(k,:),colors{k})
end
xlabel('time (yrs)')
ylabel('SLR (m)')
% legend('0.5','1.0','1.5','2.0','location','northwest')
title('Constant Rate of SLR')

subplot(2,2,3)
hold on
for k = 1:4
plot(t,RSLR_c(k,:),colors{k})
end
xlabel('time (yrs)')
ylabel('Rate of SLR (m/yr)')

for k = 1:4
meanRSLR_i(k) = mean(RSLR_i(k,:));
meanRSLR_c(k) = mean(RSLR_c(k,:));
end

% figure()
% for k = 1:4
% scatter(t,RSLR_c(k,:),colors{k})
% end
% xlabel('time (yrs)')
% ylabel('Rate of SLR (m/yr)')


