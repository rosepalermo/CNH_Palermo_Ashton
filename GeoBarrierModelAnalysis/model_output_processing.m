% calculate some stuff about the file

function result = model_output_processing(fullFileName,name)

load(fullFileName)
result.tmax=t(end);
result.name = name;
result.scr = cat(1,zeros(1,length(Y)),xsl_save(101:end,:)-xsl_save(1:end-100,:));
result.Mscr = nanmax(nanmax(result.scr));
result.Msc = nanmax(nanmax(xsl_save(end,:) - xsl_save(1,:)));
result.mean_slx = nanmean(xsl_save,2);
[result.idrown,~] = find(isnan(xsl_save),1);
result.NDC = string(result.name(1:3));
result.slc_all = [zeros(1,size(xsl_save,2));(xsl_save(1,:) - xsl_save(2:end,:))];
result.mslc_all = nanmax(nanmax([zeros(1,size(xsl_save,2));(xsl_save(2:end,:) - xsl_save(1,:))]));
[nanmaxQsf, index] = nanmax(nanmax(abs(Qsf_save(:,(length(Qsf_save(end,:))/3):(length(Qsf_save(end,:))*2/3)))));
result.MQsf = nanmaxQsf * sign(Qsf_save(index));
[nanmaxQsf, index] = nanmax(abs(Qsf_save(end,(length(Qsf_save(end,:))/3):(length(Qsf_save(end,:))*2/3))));
result.MQsfend = nanmaxQsf * sign(Qsf_save(end,index));
result.Mwidth = nanmax(nanmax(W_save(:,(length(Qsf_save(end,:))/3):(length(Qsf_save(end,:))*2/3))));
result.Mwidthend = nanmax(W_save(end,(length(Qsf_save(end,:))/3):(length(Qsf_save(end,:))*2/3)));
if result.NDC == 'NAT'
    result.color = 'k';
elseif result.NDC == 'DR_'
    result.color = 'b';
elseif result.NDC == 'DC_'
    result.color = 'm';
elseif result.NDC == 'DCR'
    result.color = 'r';
end
result.Qast_save = Qast_save;
result.Y = Y;
result.t = t;
% result.QowB_save = QowB_save;
% result.QowH_save = QowH_save;
result.Qow_save = Qow_save;
result.W_save = W_save;
result.xsl_save = xsl_save;
result.Qsf_save = Qsf_save;
result.WRatio_save = Qow_save./Qast_save;
