aa = 2;
Usla = unique([A(aa).shape.sl_a]);
UNDC = unique([A(aa).shape.NDC]);
UFD = unique([A(aa).shape.astfac]);
UQOW = unique([A(aa).shape.Qow_max]);
sizing = zeros(length(UQOW),length(UFD));
p = 1; pp = 1;
for i = 2 % 1:length(Usla)
    UNDCplot = [4;3;2;1];
    sp = 1;
    for iii = 1:length(UNDC)
        j = ([A(aa).shape.sl_a] == Usla(i)) & ([A(aa).shape.NDC] == UNDC(UNDCplot(iii)));
        j = j & ([A(aa).shape.astfac] == UFD(5)) & ([A(aa).shape.Qow_max] == UQOW(3));
        i_struct = A(aa).shape(j);
        
        figure(1)
        ax(pp) = subplot(2,2,pp);
        imagesc(t,Y(1+buff:end-buff),[i_struct.Qsf_saveall]')
        set(gca,'ydir','normal','FontSize',12)
        set(gca,'clim',[0 0.3])
        xlabel('time (years)')
        ylabel('alongshore distance (m)')
        %         title('Qsf')
        colorbar
        colormap(ax(pp),bluewhitered)
        pp = pp+1;
        
        figure(2)
        ax(p) = subplot(4,4,p)
        imagesc(t,Y(1+buff:end-buff),[i_struct.Qow_saveall]')
        set(gca,'ydir','normal','FontSize',12)
        set(gca,'clim',[0 20])
        xlabel('time (years)')
        ylabel('alongshore distance (m)')
        if p<5
            title('Q overwash')
        end
        colormap(ax(p),bluewhitered)
        colorbar
        p = p+1;
        
        ax(p) = subplot(4,4,p);
        imagesc(t,Y(1+buff:end-buff),[i_struct.llxldot_saveall]')
        set(gca,'ydir','normal','FontSize',12)
        set(gca,'clim',[-10 10])
        xlabel('time (years)')
        ylabel('alongshore distance (m)')
        colormap(ax(p),redblue)
        if p<5
            title('AST Gradient')
        end
        colorbar
        p = p+1;
        
        ax(p) = subplot(4,4,p);
        imagesc(t,Y(1+buff:end-buff),([i_struct.Wratio]'))
        set(gca,'ydir','normal','FontSize',12)
        set(gca,'clim',[-2 2])
        xlabel('time (years)')
        ylabel('alongshore distance (m)')
        if p<5
            title('Washover ratio (W)')
        end
        colormap(ax(p),gray(4))
        colorbar
        p = p+1;
        
        ax(p) = subplot(4,4,p);
        imagesc(t,Y(1+buff:end-buff),abs([i_struct.W_saveall])')
        set(gca,'ydir','normal','FontSize',12)
        set(gca,'clim',[150 310])
        xlabel('time (years)')
        ylabel('alongshore distance (m)')
        if p<5
            title('Width')
        end
        colorbar
        colormap(ax(p),gray)
        p = p+1;
        
        %         subplot(4,4,p)
        %         plot([i_struct.slc_all(end,:)],Y(1+buff:end-buff),'k','LineWidth',2)
        %         set(gca,'ydir','normal','FontSize',12)
        %         set(gca,'xlim',[70 130])
        %         ylabel('alongshore distance (m)')
        %         xlabel('shoreline change (meters)')
        % %         title('shoreline change after 200 years (meters)')
        %         p = p+1;
        
        %         subplot(4,4,p)
        %         plot(max([i_struct.slc_all]),Y(1+buff:end-buff))
        %         set(gca,'ydir','normal','FontSize',12)
        %         set(gca,'xlim',[110 130])
        %         ylabel('alongshore distance (m)')
        %         xlabel('shoreline change (meters)')
        %         title('shoreline change throughout sim (meters)')
        %         p = p+1;
        
        %         figure(2)
        %         subplot(4,3,pp)
        %         imagesc(t,Y(1+buff:end-buff),[i_struct.Qsf_saveall]')
        %         xlabel('time (years)')
        %         ylabel('alongshore distance (m)')
        %         title('Qsf (m^3/yr)')
        %         set(gca,'clim',[0 0.3])
        %         set(gca,'FontSize',12)
        %         set(gca,'ydir','normal','FontSize',12)
        %         colorbar
        %         pp = pp+1;
        %
        %         subplot(4,3,pp)
        %         imagesc(t,Y(1+buff:end-buff),[i_struct.W_saveall]')
        %         xlabel('time (years)')
        %         ylabel('alongshore distance (m)')
        %         title('Width')
        %         colorbar
        %         set(gca,'FontSize',12)
        %         set(gca,'ydir','normal','FontSize',12)
        %         pp = pp+1;
        %
        %         subplot(4,3,pp)
        %         plot([i_struct.slc_all(end,:)],Y(1+buff:end-buff))
        %         set(gca,'ydir','normal','FontSize',12)
        %         ylabel('alongshore distace')
        %         xlabel('shoreline change (meters)')
        %         title('maximum shoreline change after 200 years (meters)')
        %         set(gca,'ydir','normal','FontSize',12)
        %         pp = pp+1;
    end
end
