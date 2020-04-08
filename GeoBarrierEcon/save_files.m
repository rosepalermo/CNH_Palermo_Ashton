%     if xsonly
%         filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/xsonly_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*10);
%     elseif developed_on
%         if commercial
%             filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/developedc_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*10);
%         elseif residential
%             filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/developedr_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*10);
%         end
%     elseif community_on
%         filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/populated_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*10);
%     else
%         filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/10_2019/natural_%s_OW%d_SLa%d_diff%d_Dbb%d_Wstart%d_L%d',shape,Qow_max,sl_a*1000,astfac*10,Dbb,Wstart,L);
%         filename = sprintf('/home/rpalermo/GeoBarrierModelOutput/1_2020/natural_%s_OW%d_SLa%d_diff%d_Dbb%d_Wstart%d_L%d',shape,Qow_max,sl_a*1000,astfac*10,Dbb,Wstart,L);
        filename = sprintf('C:\\Users\\Rose Palermo\\Documents\\Alongshore_coupled\\GeoBarrierModelOutput\\2_2020_3\\natural_%s_OW%d_SLa%d_diff%d_Dbb%d_Wstart%d_L%d',shape,Qow_max,sl_a*1000,astfac*10,Dbb,round(Wstart),L);

        %     end
%     
%     if community_on
%         fig = '.fig'; figname = strcat(filename,fig);
%         saveas(h,figname)
%         save(filename,'QowB_save','QowH_save','Qow_save','Qsf_save','Qast_save','W_save','t','Y','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_save','xsl_save','com')
%     else
if plot_on
        fig = '.fig'; figname = strcat(filename,fig);
        saveas(h,figname)
end

if exist('tdrown_W')
    save(filename,'Qow_save','Qsf_save','Qast_save','W_save','t','Y','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xsl_save','Dbb','Wstart','L','Dsf','tdrown_W')
elseif exist('tdrown_H')
    save(filename,'Qow_save','Qsf_save','Qast_save','W_save','t','Y','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xsl_save','Dbb','Wstart','L','Dsf','tdrown_H')
else
    save(filename,'Qow_save','Qsf_save','Qast_save','W_save','t','Y','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xsl_save','Dbb','Wstart','L','Dsf')
end
        %     end