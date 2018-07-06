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
        i_struct = A(aa).shape(j);
        
        figure(1)
        subplot(4,4,p)
        imagesc(t./100,Y(1+buff:end-buff),[i_struct(4).Qsf_saveall]')
        set(gca,'ydir','normal','FontSize',12)
        set(gca,'clim',[0 0.3])
        xlabel('time(years)')
        ylabel('alongshore distance (m)')
%         title('Qsf')
        colorbar
        p = p+1;
        
        subplot(4,4,p)
        imagesc(t./100,Y(1+buff:end-buff),abs([i_struct(4).Wratio]'))
        set(gca,'ydir','normal','FontSize',12)
        set(gca,'clim',[0 2])
        xlabel('time (years)')
        ylabel('alongshore distance (m)')
%         title('Washover ratio')
        colorbar
        p = p+1;
        
        subplot(4,4,p)
        imagesc(t./100,Y(1+buff:end-buff),abs([i_struct(4).W_saveall])')
        set(gca,'ydir','normal','FontSize',12)
        set(gca,'clim',[150 310])
        xlabel('time(years)')
        ylabel('alongshore distance (m)')
%         title('Width (meters)')
        colorbar
        p = p+1;
        
        subplot(4,4,p)
        plot([i_struct(4).slc_all(end,:)],Y(1+buff:end-buff),'k','LineWidth',2)
        set(gca,'ydir','normal','FontSize',12)
        set(gca,'xlim',[110 130])
        ylabel('alongshore distance (m)')
        xlabel('shoreline change (meters)')
%         title('shoreline change after 200 years (meters)')
        p = p+1;
        
%         subplot(4,4,p)
%         plot(max([i_struct(4).slc_all]),Y(1+buff:end-buff))
%         set(gca,'ydir','normal','FontSize',12)
%         set(gca,'xlim',[110 130])
%         ylabel('alongshore distance (m)')
%         xlabel('shoreline change (meters)')
%         title('shoreline change throughout sim (meters)')
%         p = p+1;
        
%         figure(2)
%         subplot(4,3,pp)
%         imagesc(t./100,Y(1+buff:end-buff),[i_struct(4).Qsf_saveall]')
%         xlabel('time(years)')
%         ylabel('alongshore distance (m)')
%         title('Qsf (m^3/yr)')
%         set(gca,'clim',[0 0.3])
%         set(gca,'FontSize',12)
%         set(gca,'ydir','normal','FontSize',12)
%         colorbar
%         pp = pp+1;
%         
%         subplot(4,3,pp)
%         imagesc(t./100,Y(1+buff:end-buff),[i_struct(4).W_saveall]')
%         xlabel('time(years)')
%         ylabel('alongshore distance (m)')
%         title('Width')
%         colorbar
%         set(gca,'FontSize',12)
%         set(gca,'ydir','normal','FontSize',12)
%         pp = pp+1;
%         
%         subplot(4,3,pp)
%         plot([i_struct(4).slc_all(end,:)],Y(1+buff:end-buff))
%         set(gca,'ydir','normal','FontSize',12)
%         ylabel('alongshore distace')
%         xlabel('shoreline change (meters)')
%         title('maximum shoreline change after 200 years (meters)')
%         set(gca,'ydir','normal','FontSize',12)
%         pp = pp+1;
    end
end
