close all

load('AGUPlot_WORKING')
% for i=1:20
%     filename = sprintf('sla_%03d_W_300_330.mat',i);
%     load(filename)
% end
% 
% sla = .001:.001:.02;
% w = transpose(330:-1:300);
% 
% n1 = [n1_w_sl1; n1_w_sl_002; n1_w_sl2; n1_w_sl_004; n1_w_sl3; n1_w_sl_006;
%     n1_w_sl_007; n1_w_sl_008; n1_w_sl_009; n1_w_sl4; n1_w_sl_011;
%     n1_w_sl_012; n1_w_sl_013; n1_w_sl_014; n1_w_sl_015; n1_w_sl_016;
%     n1_w_sl_017; n1_w_sl_018; n1_w_sl_019; n1_w_sl_02];
% 
% n2 = [n2_w_sl1; n2_w_sl_002; n2_w_sl2; n2_w_sl_004; n2_w_sl3; n2_w_sl_006;
%     n2_w_sl_007; n2_w_sl_008; n2_w_sl_009; n2_w_sl4; n2_w_sl_011;
%     n2_w_sl_012; n2_w_sl_013; n2_w_sl_014; n2_w_sl_015; n2_w_sl_016;
%     n2_w_sl_017; n2_w_sl_018; n2_w_sl_019; n2_w_sl_02];
% 
% mr1 = [mr1_w_sl1; mr1_w_sl_002; mr1_w_sl2; mr1_w_sl_004; mr1_w_sl3; mr1_w_sl_006;
%     mr1_w_sl_007; mr1_w_sl_008; mr1_w_sl_009; mr1_w_sl4; mr1_w_sl_011;
%     mr1_w_sl_012; mr1_w_sl_013; mr1_w_sl_014; mr1_w_sl_015; mr1_w_sl_016;
%     mr1_w_sl_017; mr1_w_sl_018; mr1_w_sl_019; mr1_w_sl_02];
% 
% mr2 = [mr2_1_sl1; mr2_1_sl_002; mr2_1_sl2; mr2_1_sl_004; mr2_1_sl3; mr2_1_sl_006;
%       mr2_1_sl_007; mr2_1_sl_008; mr2_1_sl_009; mr2_1_sl4; mr2_1_sl_011;
%       mr2_1_sl_012; mr2_1_sl_013; mr2_1_sl_014; mr2_1_sl_015; mr2_1_sl_016;
%       mr2_1_sl_017; mr2_1_sl_018; mr2_1_sl_019; mr2_1_sl_02];

subplot(2,2,1);
pcolor(sl,w,n1')
title('N1')
set(gca,'CLim',[0 13],'YDir','reverse')
colorbar
shading flat
xlabel('Rate of Sea Level Rise (m/yr)')
ylabel('Initial Width of Barrier (m)')
set(gca,'FontSize',14)

subplot(2,2,2);
pcolor(sl,w,n2')
set(gca,'CLim',[0 13],'YDir','reverse')
title('N2')
colorbar
shading flat
xlabel('Rate of Sea Level Rise (m/yr)')
ylabel('Initial Width of Barrier (m)')
set(gca,'FontSize',14)

subplot(2,2,3);
pcolor(sl,w,mr1')
set(gca,'CLim',[0 13],'YDir','reverse')
title('MR1')
colorbar
shading flat
xlabel('Rate of Sea Level Rise (m/yr)')
ylabel('Initial Width of Barrier (m)')
set(gca,'FontSize',14)

subplot(2,2,4);
pcolor(sl,w,mr2')
set(gca,'CLim',[0 13],'YDir','reverse')
title('MR2')
shading flat
colorbar
colormap(parula)
xlabel('Rate of Sea Level Rise (m/yr)')
ylabel('Initial Width of Barrier (m)')
set(gca,'FontSize',14)
  
 %%
% load('sla_001_W_300_330')
% load('sla_003_W_300_330')
% load('sla_005_W_300_330')
% load('sla_010_W_300_330')
% % load('sla5_W_300_330')
% 
% w = transpose(330:-1:300);
% slr = [0.001*ones(1,length(w)); 0.003*ones(1,length(w)); 0.005*ones(1,length(w));0.01*ones(1,length(w))];
% n1 = [n1_w_sl1;n1_w_sl2;n1_w_sl3;n1_w_sl4];
% 
% subplot(2,2,1)
% for i = 1:4
% hold on
% scatter3(slr(i,:),w,n1(i,:),[],n1(i,:))
% end
% shading interp
% colorbar
% xlabel('sea level rise (mm/yr)')
% ylabel('initial barrier width (m)')
% 
% wtest = transpose(330:-1:300);
% slrtest = [0.001*ones(1,length(w)); 0.003*ones(1,length(w)); 0.005*ones(1,length(w));0.01*ones(1,length(w))];
% n2test = [n2_w_sl1;n2_w_sl2;n2_w_sl3;n2_w_sl4];
% 
% subplot(2,2,2)
% for i = 1:4
% hold on
% scatter3(slr(i,:),w,n2(i,:),[],n2(i,:))
% end
% shading interp
% colorbar
% xlabel('sea level rise (mm/yr)')
% ylabel('initial barrier width (m)')
% 
% w = transpose(330:-1:300);
% slr = [0.001*ones(1,length(w)); 0.003*ones(1,length(w)); 0.005*ones(1,length(w));0.01*ones(1,length(w))];
% n2 = [n2_w_sl1;n2_w_sl2;n2_w_sl3;n2_w_sl4];
% 
% subplot(2,2,3)
% for i = 1:4
% hold on
% scatter3(slr(i,:),w,n2(i,:),[],n2(i,:))
% end
% shading interp
% colorbar
% xlabel('sea level rise (mm/yr)')
% ylabel('initial barrier width (m)')
% 
% w = transpose(330:-1:300);
% slr = [0.001*ones(1,length(w)); 0.003*ones(1,length(w)); 0.005*ones(1,length(w));0.01*ones(1,length(w))];
% mr2 = [mr2_1_sl1;mr2_1_sl2;mr2_1_sl3;mr2_1_sl4];
% 
% subplot(2,2,4)
% for i = 1:4
% hold on
% scatter3(slr(i,:),w,mr2(i,:),[],mr2(i,:))
% end
% shading interp
% colorbar
% xlabel('sea level rise (mm/yr)')
% ylabel('initial barrier width (m)')
% 
% 
