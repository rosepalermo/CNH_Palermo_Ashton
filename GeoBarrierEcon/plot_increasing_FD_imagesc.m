Usla = unique([A(aa).shape.sl_a]);
UNDC = unique([A(aa).shape.NDC]);
UFD = unique([A(aa).shape.astfac]);

for i = 2 % 1:length(Usla)
    figure()
    UNDCplot = [4;3;2;1];
    sp = 1;
    for iii = 1:length(UNDC)
        j = ([A(aa).shape.sl_a] == Usla(i)) & ([A(aa).shape.NDC] == UNDC(UNDCplot(iii)));
        i_struct = A(aa).shape(j);
        %         [~,sorted_i] = sort([i_struct.astfac]);
        sorted_i = [2;4;7]; % these are the ones I want to plot
        %         hh = figure()
        %         hh.Position= [0,0,1000,1000]
        Y = [i_struct(sorted_i(2)).Y];
        Y = Y((1+A(aa).shape(i).buff:length(A(aa).shape(i).Y)-A(aa).shape(i).buff))/1000;
        X = [i_struct(sorted_i(2)).t];
        %         % plot OW_
        %         ax3 = subplot(4,5,1);
        %         imagesc(X,Y,transpose([i_struct(sorted_i(2)).Qow_saveall]))
        %         colormap parula
        %         colorbar
        %         shading flat
        %         title('OW')
        % %         set(gca,'clim',[0,mean(median(A(aa).shape(i).Qow_saveall))+2*mean(std(A(aa).shape(i).Qow_saveall))])
        %
        %
        %         % plot Qsf
        %         ax4 = subplot(4,5,2);
        %         imagesc(X,Y,transpose([i_struct(sorted_i(2)).Qsf_saveall]))
        %         colormap parula
        %         colorbar
        %         shading flat
        %         title('SF')
        
        % plot Qxs
        i_struct(sorted_i(2)).Qxs = [i_struct(sorted_i(2)).Qsf_saveall] + [i_struct(sorted_i(2)).Qow_saveall];
        ax5 = subplot(4,5,sp);
        imagesc(X,Y,transpose([i_struct(sorted_i(2)).Qxs]))
        colormap parula
        colorbar
        shading flat
        title('XS')
        set(gca,'clim',[0 50])
        sp = sp+1;
        
        
        % plot Qast
        ax6 = subplot(4,5,sp);
        imagesc(X,Y,transpose([i_struct(sorted_i(2)).Qast_saveall]))
        colormap parula
        colorbar
        shading flat
        title('AST')
        set(gca,'clim',[-200 200])
        sp = sp+1;
        
        %         if mean(median(A(aa).shape(i).Qast_saveall))>0
        %             set(gca,'clim',[mean(median(A(aa).shape(i).Qast_saveall))-2*mean(std(A(aa).shape(i).Qast_saveall)),mean(median(A(aa).shape(i).Qast_saveall))+2*mean(std(A(aa).shape(i).Qast_saveall))])
        %         end
        
        % plot O
        % O = advection/diffusion
        ax7 = subplot(4,5,sp);
        % OR SHOULD THIS BE QXS??
        i_struct(sorted_i(2)).O = abs([i_struct(sorted_i(2)).Qow_saveall])./abs([i_struct(sorted_i(2)).Qast_saveall]); %Pe(Pe==Inf) = 9999;
        imagesc(X,Y,transpose(i_struct(sorted_i(2)).O))
        colormap parula
        colorbar
        shading flat
        title('Overwash/AST Ratio (W)')
        set(gca, 'clim', [0 1]);
        sp = sp+1;
        
        
        
        % plot W
        ax8 = subplot(4,5,sp);
        imagesc(X,Y,transpose([i_struct(sorted_i(2)).W_saveall]))
        colormap parula
        colorbar
        shading flat
        title('Width')
        set(gca,'clim',[0 350])
        sp = sp+1;
        
        
        % plot shoreline change
        subplot(4,5,sp)
        i_struct(sorted_i(2)).sc_total = [i_struct(sorted_i(2)).xsl_saveall(end,:)] - [i_struct(sorted_i(2)).xsl_saveall(1,:)];
        plot(i_struct(sorted_i(2)).sc_total,Y)
        title('Total Shoreline Change')
        sp = sp+1;
        
    end
end
