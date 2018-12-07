tnourished1 = com(1).tnourished;
tnourished1(tnourished1 == 0) = NaN;
figure()
plot(t,com(1).W)
hold on
scatter(t,tnourished1,'o')
figure()
plot(t,com(1).NB)
hold on
plot(t,com(1).NBmr)
scatter(t,tnourished1,'o')
legend('NB nourishment','NB managed retreat','times nourished')