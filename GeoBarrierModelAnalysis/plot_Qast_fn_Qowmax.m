%  plot slx, max,mean Qast as a function of changing Qow_max


% foldername = "/Users/rosepalermo/Documents/Research/Alongshorecoupled/GeoBarrierModelOutput/Cluster/GeoBarrierModelOutput/10_2019/";
foldername = "/Users/rosepalermo/Documents/Research/Alongshorecoupled/GeoBarrierModelOutput/Cluster/1_2020/";

filepattern = fullfile(foldername,'*.mat');
files = dir(filepattern);

% FILTER ONLY THE RUNS I WANT
%     filter_L = @(params) params.L <= 30;
filter_func = @(params) filter_L(params, 1000, 1000) && ... % range is 10-90
    filter_astfac(params, 0.1, 0.1) && ... % range is 0.1-0.5
    filter_sl_a(params, 0.05, 0.05) && ... % range is 0.003-0.1
    filter_Qow_max(params, 5, 50) && ... % range is 5-50
    filter_Dbb(params, 2, 2) && ... % range is 2-10
    filter_Wstart(params, 200, 200); % range is 150-400

% LOOP FILES
figure()
ii = 1;
subplot(1,3,1)
for i=1:length(files)
    params = get_params_from_name(files(i).name);
    if filter_func(params)
        files(i).name
        fullFileName = fullfile(files(i).folder, files(i).name);
        %     fprintf(1, 'Now reading %s\n', fullFileName);
        
        % PROCESS DATA
        result = model_output_processing(fullFileName, files(i).name);
        
        % SAVE DATA I NEED
        qow_all(ii) =params.Qow_max;
        meanQast(ii,:) = abs(nanmean(result.Qast_save,2))';
        maxQast(ii,:) = abs(nanmax(result.Qast_save,[],2))';
        slx(ii,:) = result.mean_slx;
        ii = ii+1;
    end
end

subplot(1,3,1)
for i = 1:(ii-1)
    plot(1:length(meanQast),meanQast(i,:),'LineWidth',2)
    hold on
end
legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
ylabel('mean Qast')
xlabel('time')
set(gca,'FontSize',14)

subplot(1,3,2)
for i = 1:(ii-1)
    plot(length(meanQast),maxQast(i,:),'LineWidth',2)
    hold on
end
legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
ylabel('max Qast')
xlabel('time')
set(gca,'FontSize',14)

subplot(1,3,3)
for i = 1:(ii-1)
    plot(length(meanQast),slx(i,:),'LineWidth',2)
    hold on
end
legend('Qow max = 5','Qow max = 10','Qow max = 20','Qow max = 30','Qow max = 40','Qow max = 50','location','northwest')
ylabel('slx')
xlabel('time')
set(gca,'FontSize',14)


% filter functions

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
end