

foldername1 = '/Users/rosepalermo/Dropbox (MIT)/AGU2018/NJ/natural/';
foldername2 = '/Users/rosepalermo/Dropbox (MIT)/AGU2018/NJ/developedr/';
foldername3 = '/Users/rosepalermo/Dropbox (MIT)/AGU2018/NJ/developedc/';

addpath(foldername1,foldername2,foldername3)

filepattern = fullfile(foldername1,'*.mat');
theFiles1 = dir(filepattern);
filepattern = fullfile(foldername2,'*.mat');
theFiles2 = dir(filepattern);
filepattern = fullfile(foldername3,'*.mat');
theFiles3 = dir(filepattern);


theFiles = [theFiles1; theFiles2; theFiles3];

% astfac_all = [0.01;0.05;0.1;0.2;0.3;0.34;0.5];
gen = struct;
sWmid = struct;
gg = 1;


for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    %     fprintf(1, 'Now reading %s\n', fullFileName);
    load(fullFileName)
    shape = string(shape);
    
    if shape == string('bbay2')
        bbay(1,1).shape(gg).name = baseFileName;
        scr = cat(1,zeros(1,length(Y)-2*buff),xsl_saveall(101:end,:)-xsl_saveall(1:end-100,:));
        bbay(1,1).shape(gg).Mscr = max(max(scr));
        bbay(1,1).shape(gg).Msc = max(max(xsl_saveall(end,:) - xsl_saveall(1,:)));
        bbay(1,1).shape(gg).sl_a = sl_a;
        bbay(1,1).shape(gg).astfac = astfac;
        bbay(1,1).shape(gg).shape = shape;
        bbay(1,1).shape(gg).Qow_max = Qow_max;
        bbay(1,1).shape(gg).Qast_saveall = Qast_saveall;
        bbay(1,1).shape(gg).Y = Y;
        bbay(1,1).shape(gg).t = t;
%         bbay(1,1).shape(gg).QowB_saveall = QowB_saveall;
%         bbay(1,1).shape(gg).QowH_saveall = QowH_saveall;
        bbay(1,1).shape(gg).Qow_saveall = Qow_saveall;
        bbay(1,1).shape(gg).W_saveall = W_saveall;
        bbay(1,1).shape(gg).H_saveall = H_saveall;
        bbay(1,1).shape(gg).xsl_saveall = xsl_saveall;
        bbay(1,1).shape(gg).Wratio = Qow_saveall./-llxldot_saveall;
        bbay(1,1).shape(gg).llxldot_saveall = -llxldot_saveall;
%         bbay(1,1).shape(gg).slc_all = [zeros(1,size(xsl_saveall,2));(xsl_saveall(2:end,:) - xsl_saveall(1,:))];
%         bbay(1,1).shape(gg).mslc_all = max(max([zeros(1,size(xsl_saveall,2));(xsl_saveall(2:end,:) - xsl_saveall(1,:))]));
        bbay(1,1).shape(gg).buff = buff;
        bbay(1,1).shape(gg).Qsf_saveall = Qsf_saveall;
        bbay(1,1).shape(gg).NDC = string(bbay(1,1).shape(gg).name(1:3));
        [maxQsf, index] = max(max(abs(Qsf_saveall(:,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3)))));
%         bbay(1,1).shape(gg).MQsf = maxQsf * sign(Qsf_saveall(index));
        [maxQsf, index] = max(abs(Qsf_saveall(end,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3))));
%         bbay(1,1).shape(gg).MQsfend = maxQsf * sign(Qsf_saveall(end,index));
%         bbay(1,1).shape(gg).Mwidth = max(max(W_saveall(:,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3))));
%         bbay(1,1).shape(gg).Mwidthend = max(W_saveall(end,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3)));
        if bbay(1,1).shape(gg).NDC == 'NAT'
            bbay(1,1).shape(gg).color = 'k';
        elseif bbay(1,1).shape(gg).NDC == 'DR_'
            bbay(1,1).shape(gg).color = 'b';
        elseif bbay(1,1).shape(gg).NDC == 'DC_'
            bbay(1,1).shape(gg).color = 'm';
        elseif bbay(1,1).shape(gg).NDC == 'DCR'
            bbay(1,1).shape(gg).color = 'r';
        end
        gg = gg+1;
    end
    
end


% for aa = 1:length(A)
%     makefig_sl_v_data(A,aa)
% end



% %%
% for aa = 1:length(A)
%     h = figure()
%     h.Position = [0,0,1500,750]
%     for i = 1:length(A(aa).shape)
%         subplot(2,4,1)
%         hold on
%         scatter(A(aa).shape(i).sl_a,A(aa).shape(i).MQsf,A(aa).shape(i).color)
%         xlabel('sl_a')
%         ylabel('maximum Qsf over simulation')
%         title(sprintf(A(aa).shape.shape))
%         
%         subplot(2,4,2)
%         hold on
%         scatter(A(aa).shape(i).sl_a,A(aa).shape(i).Mwidth,A(aa).shape(i).color)
%         xlabel('sl_a')
%         ylabel('maximum width over simulation')
%         
%         subplot(2,4,3)
%         hold on
%         scatter(A(aa).shape(i).sl_a,A(aa).shape(i).Msc,A(aa).shape(i).color)
%         xlabel('sl_a')
%         ylabel('maximum shoreline change over simulation')
%         
%         subplot(2,4,4)
%         hold on
%         scatter(A(aa).shape(i).sl_a,A(aa).shape(i).Mscr,A(aa).shape(i).color)
%         xlabel('sl_a')
%         ylabel('maximum shoreline change rate over simulation')
%         
%         subplot(2,4,5)
%         hold on
%         scatter(A(aa).shape(i).sl_a,A(aa).shape(i).MQsfend,A(aa).shape(i).color)
%         xlabel('sl_a')
%         ylabel('maximum Qsf after 200 years')
%         
%         subplot(2,4,6)
%         hold on
%         scatter(A(aa).shape(i).sl_a,A(aa).shape(i).Mwidthend,A(aa).shape(i).color)
%         xlabel('sl_a')
%         ylabel('maximum width after 200 years')
%         
%         
%     end
% end
%%
%     hh = figure()
%     hh.Position= [0,0,1000,1000]
%     for i = 1:length(A(aa).shape)
%         % plot OW_H
%         ax1 = subplot(2,4,1);
%         pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).QowH_saveall))
%         colormap parula
%         colorbar
%         shading flat
%         set(gca,'clim',[0,mean(median(A(aa).shape(i).QowH_saveall))+2*mean(std(A(aa).shape(i).QowH_saveall))])
%         title('OW_H')
%
%
%         % plot OW_B
%         ax2 = subplot(2,4,2);
%         pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).QowB_saveall))
%         colormap parula
%         colorbar
%         shading flat
%         set(gca,'clim',[0,mean(median(A(aa).shape(i).QowB_saveall))+2*mean(std(A(aa).shape(i).QowB_saveall))])
%         title('OW_B')
%
%         % plot OW_
%         ax3 = subplot(2,4,3);
%         pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).Qow_saveall))
%         colormap parula
%         colorbar
%         shading flat
%         title('OW')
%         set(gca,'clim',[0,mean(median(A(aa).shape(i).Qow_saveall))+2*mean(std(A(aa).shape(i).Qow_saveall))])
%
%
%         % plot Qsf
%         ax4 = subplot(2,4,4);
%         pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).Qsf_saveall))
%         colormap parula
%         colorbar
%         shading flat
%         title('SF')
%
%         % plot Qxs
%         A(aa).shape(i).Qxs = A(aa).shape(i).Qsf_saveall + A(aa).shape(i).Qow_saveall;
%         ax5 = subplot(2,4,5);
%         pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).Qxs))
%         colormap parula
%         colorbar
%         shading flat
%         title('XS')
%
%
%         % plot Qast
%         ax6 = subplot(2,4,6);
%         pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).Qast_saveall))
%         colormap parula
%         colorbar
%         shading flat
%         title('AST')
%         if mean(median(A(aa).shape(i).Qast_saveall))>0
%             set(gca,'clim',[mean(median(A(aa).shape(i).Qast_saveall))-2*mean(std(A(aa).shape(i).Qast_saveall)),mean(median(A(aa).shape(i).Qast_saveall))+2*mean(std(A(aa).shape(i).Qast_saveall))])
%         end
%
%         % plot O
%         % O = advection/diffusion
%         ax7 = subplot(2,4,7);
%         % OR SHOULD THIS BE QXS??
%         A(aa).shape(i).O = abs(A(aa).shape(i).Qow_saveall)./abs(A(aa).shape(i).Qast_saveall); %Pe(Pe==Inf) = 9999;
%         pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).O))
%         colormap parula
%         colorbar
%         shading flat
%         title('Overwash/AST Ratio (O)')
%         set(gca, 'clim', [0 1]);
%
%
%
%         % plot W
%         ax8 = subplot(2,4,8);
%         pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).W_saveall))
%         colormap parula
%         colorbar
%         shading flat
%         title('Width')
%     end

%         % % plot shoreline change rate
%         hhh = figure()
%         hhh.Position = [0,0,1000,1000]
%         for i = 1:length(A(aa).shape)
%         subplot(1,2,1)
%         A(aa).shape(i).scr = cat(1,zeros(1,length(A(aa).shape(i).Y)-2*A(aa).shape(i).buff),A(aa).shape(i).xsl_saveall(101:end,:)-A(aa).shape(i).xsl_saveall(1:end-100,:));
%         pcolor(A(aa).shape(i).t(100:end),A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).scr))
%         colormap parula
%         colorbar
%         shading flat
%         title('SCR (M/YR)')
%
%
%         %plot total amount of shoreline change across barrier
%         subplot(1,2,2)
%         A(aa).shape(i).sc_total = xA(aa).shape(i).sl_saveall(end,:) - A(aa).shape(i).xsl_saveall(1,:);
%         plot(sA(aa).shape(i).c_total,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000)
%         title('Total Shoreline Change')
%         end
%
%
% %% THIS ISNT RIGHT-- ROSE FIX THIS
% 
% for ii = 1:4
%     sl_aii = [2.6;4.5;6.0;8.5];
%     for iii = 1:4
%         ndciii = ['NAT';'DR_';'DC_';'DCR'];
%         figure()
%         gcf.Position = [0,0,1500,500]
%         for i = 1: length(A(aa).shape)
%             % make figure described in my outline
%             % plot width, Qsf, AST, O, shoreline retreat
%             if A(aa).shape(i).NDC == ndciii(iii)
%                 
%                 if A(aa).shape(i).sl_a == sl_aii(ii)
%                     subplot(1,6,1)
%                     pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).W_saveall))
%                     colormap parula
%                     colorbar
%                     shading flat
%                     title('Width')
%                     
%                     subplot(1,6,2)
%                     pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).Qsf_saveall))
%                     colormap parula
%                     colorbar
%                     shading flat
%                     title('Qsf')
%                     
%                     subplot(1,6,3)
%                     pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).Qow_saveall))
%                     colormap parula
%                     colorbar
%                     shading flat
%                     title('Qow')
%                     
%                     
%                     subplot(1,6,4)
%                     pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).Qast_saveall))
%                     colormap parula
%                     colorbar
%                     shading flat
%                     title('AST')
%                     if mean(median(A(aa).shape(i).Qast_saveall))>0
%                         set(gca,'clim',[mean(median(A(aa).shape(i).Qast_saveall))-2*mean(std(A(aa).shape(i).Qast_saveall)),mean(median(A(aa).shape(i).Qast_saveall))+2*mean(std(A(aa).shape(i).Qast_saveall))])
%                     end
%                     
%                     subplot(1,6,5)
%                     A(aa).shape(i).O = abs(A(aa).shape(i).Qow_saveall)./abs(A(aa).shape(i).Qast_saveall);
%                     pcolor(A(aa).shape(i).t,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000,transpose(A(aa).shape(i).O))
%                     colormap parula
%                     colorbar
%                     shading flat
%                     title('Overwash/AST Ratio (O)')
%                     set(gca, 'clim', [0 1]);
%                     
%                     subplot(1,6,6)
%                     A(aa).shape(i).sc_total = A(aa).shape(i).xsl_saveall(end,:) - A(aa).shape(i).xsl_saveall(1,:);
%                     plot(A(aa).shape(i).sc_total,A(aa).shape(i).Y(1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff)/1000)
%                     title('Total Shoreline Change')
%                 end
%                 
%                 
%             end
%         end
%         
%         
%     end
% end
