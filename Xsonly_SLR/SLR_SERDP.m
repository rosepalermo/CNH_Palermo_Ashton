% plot sea level rise for longer timeline than 2100 using SERDP curves
t = 1:226; % 500 years
colors = {'r','c','k','b'};

% increasing;  % increasing sea level rise scenarios (SERDP table 3.4)
a = 1.7e-3;

Bb(1) = 2.71262e-5;     % Scenario 0.5
Bb(2) = 6.9993141e-5;   % Scenario 1.0
Bb(3) = 1.12860082e-4;  % Scenario 1.5
Bb(4) = 1.55727023e-4;  % Scenario 2.0

for k = 1:length(Bb)
SLR_i(k,:) = a*t+Bb(k).*t.^2;   % sea level rise
RSLR_i(k,:) = a+2*Bb(k).*t;     % rate of smeea level rise
end

subplot(2,2,2)
hold on
for k = 1:4
plot(t,SLR_i(k,:),colors{k})
end
xlabel('time (yrs)')
ylabel('SLR (m)')
legend('0.5','1.0','1.5','2.0','location','northwest')
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

Aa(1) = 0.0046; % Scenario 0.5 (1992 - 2100)
Aa(2) = 0.0093; % Scenario 1.0 (1992 - 2100)
Aa(3) = 0.0139; % Scenario 1.5 (1992 - 2100)
Aa(4) = 0.0185; % Scenario 2.0 (1992 - 2100)

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


