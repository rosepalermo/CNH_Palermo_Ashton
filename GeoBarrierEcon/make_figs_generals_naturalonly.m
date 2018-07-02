

% foldername1 = '/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/natural/';
% foldername2 = '/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/developedr/';
% foldername3 = '/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/developedc/';
% foldername4 = '/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/developedcr/';
% 
% addpath(foldername1,foldername2,foldername3,foldername4)
% 
% filepattern = fullfile(foldername1,'*.mat');
% theFiles1 = dir(filepattern);
% filepattern = fullfile(foldername2,'*.mat');
% theFiles2 = dir(filepattern);
% filepattern = fullfile(foldername3,'*.mat');
% theFiles3 = dir(filepattern);
% filepattern = fullfile(foldername4,'*.mat');
% theFiles4 = dir(filepattern);
% 
% theFiles = [theFiles1; theFiles2; theFiles3; theFiles4];

foldername = "/Volumes/Rose Palermo hard drive/GeoBarrierModelOutput/natural only/";
filepattern = fullfile(foldername,'*.mat');
theFiles = dir(filepattern);
addpath(foldername)

% astfac_all = [0.01;0.05;0.1;0.2;0.3;0.34;0.5];
gen = struct;
sWmid = struct;
gg = 1;
sm = 1;



for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    %     fprintf(1, 'Now reading %s\n', fullFileName);
    load(fullFileName)
    shape = string(shape);
    
    if shape == string('gen')
        NO(1,1).shape(gg).name = baseFileName;
        scr = cat(1,zeros(1,length(Y)-2*buff),xsl_saveall(101:end,:)-xsl_saveall(1:end-100,:));
        NO(1,1).shape(gg).Mscr = max(max(scr));
        NO(1,1).shape(gg).Msc = max(max(xsl_saveall(end,:) - xsl_saveall(1,:)));
        NO(1,1).shape(gg).sl_a = sl_a;
        NO(1,1).shape(gg).astfac = astfac;
%         NO(1,1).shape(gg).shape = shape;
        NO(1,1).shape(gg).Qow_max = Qow_max;
%         NO(1,1).shape(gg).Qast_saveall = Qast_saveall;
%         NO(1,1).shape(gg).Y = Y;
%         NO(1,1).shape(gg).t = t;
%         NO(1,1).shape(gg).QowB_saveall = QowB_saveall;
%         NO(1,1).shape(gg).QowH_saveall = QowH_saveall;
%         NO(1,1).shape(gg).Qow_saveall = Qow_saveall;
%         NO(1,1).shape(gg).W_saveall = W_saveall;
%         NO(1,1).shape(gg).xsl_saveall = xsl_saveall;
%         NO(1,1).shape(gg).buff = buff;
%         NO(1,1).shape(gg).Qsf_saveall = Qsf_saveall;
        NO(1,1).shape(gg).NDC = string(NO(1,1).shape(gg).name(1:3));
        [maxQsf, index] = max(max(abs(Qsf_saveall(:,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3)))));
        NO(1,1).shape(gg).MQsf = maxQsf * sign(Qsf_saveall(index));
        [maxQsf, index] = max(abs(Qsf_saveall(end,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3))));
        NO(1,1).shape(gg).MQsfend = maxQsf * sign(Qsf_saveall(end,index));
        NO(1,1).shape(gg).Mwidth = max(max(W_saveall(:,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3))));
        NO(1,1).shape(gg).Mwidthend = max(W_saveall(end,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3)));
        if NO(1,1).shape(gg).NDC == 'NAT'
            NO(1,1).shape(gg).color = 'k';
        elseif NO(1,1).shape(gg).NDC == 'DR_'
            NO(1,1).shape(gg).color = 'b';
        elseif NO(1,1).shape(gg).NDC == 'DC_'
            NO(1,1).shape(gg).color = 'm';
        elseif NO(1,1).shape(gg).NDC == 'DCR'
            NO(1,1).shape(gg).color = 'r';
        end
        gg = gg+1;
        
    elseif shape == string('sWmid')
        NO(2,1).shape(sm).name = baseFileName;
        scr = cat(1,zeros(1,length(Y)-2*buff),xsl_saveall(101:end,:)-xsl_saveall(1:end-100,:));
        NO(2,1).shape(sm).Mscr = max(max(scr));
        NO(2,1).shape(sm).Msc = max(max(xsl_saveall(end,:) - xsl_saveall(1,:)));
        NO(2,1).shape(sm).sl_a = sl_a;
        NO(2,1).shape(sm).astfac = astfac;
%         NO(2,1).shape(sm).shape = shape;
        NO(2,1).shape(sm).Qow_max = Qow_max;
%         NO(2,1).shape(sm).Qast_saveall = Qast_saveall;
%         NO(2,1).shape(sm).Y = Y;
%         NO(2,1).shape(sm).t = t;
%         NO(2,1).shape(sm).QowB_saveall = QowB_saveall;
%         NO(2,1).shape(sm).QowH_saveall = QowH_saveall;
%         NO(2,1).shape(sm).Qow_saveall = Qow_saveall;
%         NO(2,1).shape(sm).W_saveall = W_saveall;
%         NO(2,1).shape(sm).xsl_saveall = xsl_saveall;
%         NO(2,1).shape(sm).buff = buff;
%         NO(2,1).shape(sm).Qsf_saveall = Qsf_saveall;
        NO(2,1).shape(sm).NDC = string(NO(2,1).shape(sm).name(1:3));
        [maxQsf, index] = max(max(abs(Qsf_saveall(:,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3)))));
        NO(2,1).shape(sm).MQsf = maxQsf * sign(Qsf_saveall(index));
        [maxQsf, index] = max(abs(Qsf_saveall(end,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3))));
        NO(2,1).shape(sm).MQsfend = maxQsf * sign(Qsf_saveall(end,index));
        NO(2,1).shape(sm).Mwidth = max(max(W_saveall(:,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3))));
        NO(2,1).shape(sm).Mwidthend = max(W_saveall(end,(length(Qsf_saveall(end,:))/3):(length(Qsf_saveall(end,:))*2/3)));
        if NO(2,1).shape(sm).NDC == 'NAT'
            NO(2,1).shape(sm).color = 'k';
        elseif NO(2,1).shape(sm).NDC == 'DR_'
            NO(2,1).shape(sm).color = 'b';
        elseif NO(2,1).shape(sm).NDC == 'DC_'
            NO(2,1).shape(sm).color = 'm';
        elseif NO(2,1).shape(sm).NDC == 'DCR'
            NO(2,1).shape(sm).color = 'r';
            
        end
        sm = sm+1;
    end
    
end

