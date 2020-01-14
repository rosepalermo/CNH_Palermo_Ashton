% parameter exploration data

foldername = "/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/10_2019/";
filepattern = fullfile(foldername,'*.mat');
theFiles = dir(filepattern);
addpath(foldername)

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    %     fprintf(1, 'Now reading %s\n', fullFileName);
    load(fullFileName)
    shape = string(shape);
    
        NO(k).name = baseFileName;
        scr = cat(1,zeros(1,length(Y)),xsl_save(101:end,:)-xsl_save(1:end-100,:));
        NO(k).Mscr = nanmax(nanmax(scr));
        NO(k).Msc = nanmax(nanmax(xsl_save(end,:) - xsl_save(1,:)));
        NO(k).sl_a = sl_a;
        NO(k).astfac = astfac;
        NO(k).Dbb = Dbb;
        NO(k).Wstart = Wstart;
%         NO(k).shape = shape;
        NO(k).Qow_max = Qow_max;
%         NO(k).Qast_save = Qast_save;
%         NO(k).Y = Y;
%         NO(k).t = t;
%         NO(k).QowB_save = QowB_save;
%         NO(k).QowH_save = QowH_save;
%         NO(k).Qow_save = Qow_save;
%         NO(k).W_save = W_save;
%         NO(k).xsl_save = xsl_save;
%         NO(k).Qsf_save = Qsf_save;
        NO(k).NDC = string(NO(k).name(1:3));
        NO(k).slc_all = [zeros(1,size(xsl_save,2));(xsl_save(1,:) - xsl_save(2:end,:))];
        NO(k).mslc_all = nanmax(nanmax([zeros(1,size(xsl_save,2));(xsl_save(2:end,:) - xsl_save(1,:))]));
        [nanmaxQsf, index] = nanmax(nanmax(abs(Qsf_save(:,(length(Qsf_save(end,:))/3):(length(Qsf_save(end,:))*2/3)))));
        NO(k).MQsf = nanmaxQsf * sign(Qsf_save(index));
        [nanmaxQsf, index] = nanmax(abs(Qsf_save(end,(length(Qsf_save(end,:))/3):(length(Qsf_save(end,:))*2/3))));
        NO(k).MQsfend = nanmaxQsf * sign(Qsf_save(end,index));
        NO(k).Mwidth = nanmax(nanmax(W_save(:,(length(Qsf_save(end,:))/3):(length(Qsf_save(end,:))*2/3))));
        NO(k).Mwidthend = nanmax(W_save(end,(length(Qsf_save(end,:))/3):(length(Qsf_save(end,:))*2/3)));
        if NO(k).NDC == 'NAT'
            NO(k).color = 'k';
        elseif NO(k).NDC == 'DR_'
            NO(k).color = 'b';
        elseif NO(k).NDC == 'DC_'
            NO(k).color = 'm';
        elseif NO(k).NDC == 'DCR'
            NO(k).color = 'r';
        end
        NO(k).L = L;
 
end