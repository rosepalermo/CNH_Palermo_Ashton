%  plot slx, max,mean Qast as a function of changing Qow_max

% foldername = "/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/Cluster/GeoBarrierModelOutput/10_2019/";
% foldername = "/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/Cluster/1_2020/";
foldername = 'C:\\Users\\Rose Palermo\\Documents\\Alongshore_coupled\\GeoBarrierModelOutput\\2_2020_3\\Periodic_behavior\\';

filepattern = fullfile(foldername,'*.mat');
files = dir(filepattern);

% FILTER ONLY THE RUNS I WANT
filter_func = @(params) filter_L(params, 334, 334) && ... % range is 10-90
    filter_astfac(params, 0.5, 0.5) && ... % range is 0.1-0.5
    filter_sl_a(params, 0.004, 0.004) && ... % range is 0.003-0.1
    filter_Qow_max(params, 100, 100) && ... % range is 5-50
    filter_Dbb(params, 100, 100) && ... % range is 2-10
    filter_Wstart(params, 300, 317);% && ... % range is 150-400
%     filter_shape(params,'gen');
    
% LOOP FILES
% figure()
ii = 1;
for i=1:length(files)
    params = get_params_from_name(files(i).name);
    if filter_func(params)
        files(i).name
        fullFileName = fullfile(files(i).folder, files(i).name);
        %     fprintf(1, 'Now reading %s\n', fullFileName);
        
        % PROCESS DATA
        result = model_output_processing(fullFileName, files(i).name);
        
        % SAVE DATA I NEED
        Dbb_all(ii) =params.Dbb;
%         Qow_max(ii) = params.Qow_max;
        Qast_all(:,:,ii) = result.Qastgrad;
        Qow_all(:,:,ii) = result.Qow_save(:,:);
        WRatio_all(:,:,ii) = result.WRatio_save(:,:);
        xsl_all(:,:,ii) = result.xsl_save(:,:);
        slx(ii,:) = result.mean_slx;
        ii = ii+1;
    end
end


% for i = 1:(ii-1)
%     subplot(ceil((ii-1)/2),ceil((ii-1)/3),i)
%     imagesc(Qast_all(:,:,i)')
%     title(sprintf('L = %G',ast_all(i)))
%     caxis([min(Qast_all,[],'all') max(Qast_all,[],'all')])
% end
% % legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
% ylabel('alongshore position')
% xlabel('time')
% set(gca,'FontSize',14)

% figure()
% for i = 1:(ii-1)
%     subplot(ceil((ii-1)/2),ceil((ii-1)/3),i)
%     imagesc(Qow_all(:,:,i)')
%     title(sprintf('L = %G',ast_all(i)))
%     caxis([0 Qow_max(i)])
% end
% % legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
% ylabel('alongshore position')
% xlabel('time')
% set(gca,'FontSize',14)

% figure()
% for i = 1:(ii-1)
%     ax(i) = subplot(3,1,i);
%     imagesc(WRatio_all(:,:,i)')
%     title(sprintf('D_b_b = %G',Dbb_all(i)))
% %     caxis([0 5])
%     set(gca,'clim',[-2 2])
%     colormap(ax(i),parula(4))
% end
% % legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
% ylabel('alongshore position')
% xlabel('time (10s years)')

figure()
for i = 2:(ii-1)
%     ax(i) = subplot(2,1,i);
    imagesc(WRatio_all(:,:,i)')
%     title(sprintf('D_b_b = %G',Dbb_all(i)))
%     caxis([0 5])
    set(gca,'clim',[-2 2])
    colormap(parula(4))
end
% legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
ylabel('alongshore position')
xlabel('time (10s years)')
set(gca,'Fontsize',14)

figure()
for i = 1:(ii-1)
    plot(slx(i,:))
    hold on
end
% legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
ylabel('shoreline change (m)')
xlabel('time (10s years)')
set(gca,'Fontsize',14)
legend('XS only','Coupled','location','southeast')


% figure()
% for i = 1:(ii-1)
%     ax(i) = subplot(3,1,i);
%     imagesc(Qow_all(:,:,i)')
%     title(sprintf('D_b_b = %G',Dbb_all(i)))
% %     caxis([0 5])
% %     set(gca,'clim',[-2 2])
%     colormap(ax(i),parula)
% end

% figure()
% for i = 1:(ii-1)
%     ax(i) = subplot(3,1,i);
%     imagesc(Qast_all(:,:,i)')
%     title(sprintf('D_b_b = %G',Dbb_all(i)))
% %     caxis([0 5])
%     set(gca,'clim',[-2 2])
%     colormap(ax(i),parula(2))
% end
% % legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
% ylabel('alongshore position')
% xlabel('time (10s years)')

% figure()
% for i = 150
% plot(result.xsl_save(i,:),'b'); hold on; plot(result.xsl_save(i,:)+result.W_save(i,:),'r')
% end

% figure()
% for i = 1:(ii-1)
%     subplot(ceil((ii-1)/2),ceil((ii-1)/3),i)
%     imagesc(xsl_all(:,:,i)')
%     title(sprintf('L = %G',ast_all(i)))
%     caxis([0 max(xsl_all,[],'all')])
% end
% % legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
% ylabel('alongshore position')
% xlabel('time')
% set(gca,'FontSize',14)

% filter functions

function keep = filter_shape(params, shape);
keep = isequal(params.shape,shape);
end

function keep = filter_astfac(params, lb, ub);
keep = (params.astfac <= ub) && (params.astfac >= lb);
end

function keep = filter_sl_a(params, lb, ub);
keep = (params.sl_a <= ub) && (params.sl_a >= lb);
end

function keep = filter_L(params, lb, ub)
keep = (params.L <= ub) && (params.L >= lb);
end

function keep = filter_Qow_max(params, lb, ub);
keep = (params.Qow_max <= ub) && (params.Qow_max >= lb);
end

function keep = filter_Dbb(params, lb, ub);
keep = (params.Dbb <= ub) && (params.Dbb >= lb);
end

function keep = filter_Wstart(params, lb, ub);
keep = (params.Wstart <= ub) && (params.Wstart >= lb);
end

function result = get_params_from_name(filename)
C = strsplit(filename(1:end-4), '_');
result = struct();
result.Qow_max = str2double(C{3}(3:end));
result.sl_a = str2double(C{4}(4:end))/1000.0;
result.astfac = str2double(C{5}(5:end))/10.0;
result.Dbb = str2double(C{6}(4:end));
result.Wstart = str2double(C{7}(7:end));
result.L = str2double(C{8}(2:end));
result.shape = string(C(2));
end