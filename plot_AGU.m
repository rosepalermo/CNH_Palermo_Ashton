
load('sla1_W_300_330')
load('sla2_W_300_330')
load('sla3_W_300_330')
load('sla4_W_300_330')
% load('sla5_W_300_330')

w = transpose(330:-1:300);
slr = [0.001*ones(1,length(w)); 0.003*ones(1,length(w)); 0.005*ones(1,length(w));0.01*ones(1,length(w))];
n1 = [n1_w_sl1;n1_w_sl2;n1_w_sl3;n1_w_sl4];

subplot(2,2,1)
for i = 1:4
hold on
scatter3(slr(i,:),w,n1(i,:),[],n1(i,:))
end
shading interp
colorbar
xlabel('sea level rise (mm/yr)')
ylabel('initial barrier width (m)')

w = transpose(330:-1:300);
slr = [0.001*ones(1,length(w)); 0.003*ones(1,length(w)); 0.005*ones(1,length(w));0.01*ones(1,length(w))];
n2 = [n2_w_sl1;n2_w_sl2;n2_w_sl3;n2_w_sl4];

subplot(2,2,2)
for i = 1:4
hold on
scatter3(slr(i,:),w,n2(i,:),[],n2(i,:))
end
shading interp
colorbar
xlabel('sea level rise (mm/yr)')
ylabel('initial barrier width (m)')

w = transpose(330:-1:300);
slr = [0.001*ones(1,length(w)); 0.003*ones(1,length(w)); 0.005*ones(1,length(w));0.01*ones(1,length(w))];
n2 = [n2_w_sl1;n2_w_sl2;n2_w_sl3;n2_w_sl4];

subplot(2,2,3)
for i = 1:4
hold on
scatter3(slr(i,:),w,n2(i,:),[],n2(i,:))
end
shading interp
colorbar
xlabel('sea level rise (mm/yr)')
ylabel('initial barrier width (m)')

w = transpose(330:-1:300);
slr = [0.001*ones(1,length(w)); 0.003*ones(1,length(w)); 0.005*ones(1,length(w));0.01*ones(1,length(w))];
mr2 = [mr2_1_sl1;mr2_1_sl2;mr2_1_sl3;mr2_1_sl4];

subplot(2,2,4)
for i = 1:4
hold on
scatter3(slr(i,:),w,mr2(i,:),[],mr2(i,:))
end
shading interp
colorbar
xlabel('sea level rise (mm/yr)')
ylabel('initial barrier width (m)')


