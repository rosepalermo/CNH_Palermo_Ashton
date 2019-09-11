    if xsonly
        filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/xsonly_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*10);
    elseif developed_on
        if commercial
            filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/developedc_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*10);
        elseif residential
            filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/developedr_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*10);
        end
    elseif community_on
        filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/populated_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*10);
    else
        filename = sprintf('/Users/rosepalermo/Documents/Research/Alongshore coupled/GeoBarrierModelOutput/natural_%s_OW%d_K%d_SLa%d_diff%d',shape,Qow_max,Ksf,sl_a*1000,astfac*10);
    end
    
    if community_on
        fig = '.fig'; figname = strcat(filename,fig);
        saveas(h,figname)
        save(filename,'QowB_save','QowH_save','Qow_save','Qsf_save','Qast_save','W_save','t','Y','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_save','xsl_save','com')
    else
        fig = '.fig'; figname = strcat(filename,fig);
        saveas(h,figname)
        save(filename,'QowB_save','QowH_save','Qow_save','Qsf_save','Qast_save','W_save','t','Y','sl_a','sl_b','Qow_max','Ksf','shape','jplot','community_on','save_on','astfac','xbb_save','xsl_save')
    end