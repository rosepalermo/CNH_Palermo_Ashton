aa = 2;
Usla = unique([A_test(aa).shape.sl_a]);
UNDC = unique([A_test(aa).shape.NDC]);
UFD = unique([A_test(aa).shape.astfac]);
UQOW = unique([A_test(aa).shape.Qow_max]);
sizing = zeros(length(UQOW),length(UFD));
p = 1; pp = 1;
for i = 2 % 1:length(Usla)
    UNDCplot = [4;3;2;1];
    sp = 1;
    for iii = 1:length(UNDC)
        j = ([A_test(aa).shape.sl_a] == Usla(2)) & ([A_test(aa).shape.NDC] == UNDC(UNDCplot(iii)));
        j = j & ([A_test(aa).shape.astfac] == UFD(5)) & ([A_test(aa).shape.Qow_max] == UQOW(3));
        i_struct = A_test(aa).shape(j);
        
%         figure(1)
%         ax(pp) = subplot(2,2,pp);
%         imagesc(t,Y(1+buff:end-buff),[i_struct.Qsf_saveall]')
%         set(gca,'ydir','normal','FontSize',12)
%         set(gca,'clim',[0 0.3])
%         xlabel('time (years)')
%         ylabel('alongshore distance (m)')
%         %         title('Qsf')
%         colorbar
%         colormap(ax(pp),bluewhitered)
%         pp = pp+1;
%         
         p =1;
         hh = figure();
         hh.Position = [2 243 1437 562];         
         ax(p) = subplot(1,3,p)
         imagesc(t,Y(1+buff:end-buff),[i_struct.Qow_saveall]')
         set(gca,'ydir','normal','FontSize',20)
         set(gca,'clim',[0 20])
         set(gca,'ytick',[0:2000:10000])
         set(gca,'xtick',[0:100:200])
         %         if p>12
         xlabel('time (years)')
         %         end
         ylabel('alongshore distance (m)')
         %         if p<6
         title('Q_o_w')
         %         end
         colormap(ax(p),bluewhitered)
         c = colorbar;
         c.Label.String = 'Washover Ratio';
         p = p+1;
         
         ax(p) = subplot(1,3,p);
         imagesc(t,Y(1+buff:end-buff),[i_struct.llxldot_saveall]')
         set(gca,'ydir','normal','FontSize',12)
         set(gca,'clim',[-10 10])
         set(gca,'ytick',[0:2000:10000])
         set(gca,'xtick',[0:100:200])
         %         if p>16
         xlabel('time (years)')
         %         end
         %         ylabel('alongshore distance (m)')
         colormap(ax(p),redblue)
         %         if p<6
         title('\Delta Q_a_s_t')
         %         end
         colorbar
         p = p+1;
         
         ax(p) = subplot(1,3,p);
         imagesc(t,Y(1+buff:end-buff),([i_struct.Wratio]'))
         set(gca,'ydir','normal','FontSize',12)
         set(gca,'clim',[-2 2])
         %         if p>16
         xlabel('time (years)')
         set(gca,'ytick',[0:2000:10000])
         set(gca,'xtick',[0:100:200])
         %         end
         %         ylabel('alongshore distance (m)')
         %         if p<6
         title('Washover ratio (W)')
         %         end
         colormap(ax(p),parula(4))
         c =colorbar;
         filler = [c.Label.Position(1)./3.*2 c.Label.Position(2) c.Label.Position(3)];
         c.Label.Position = filler;
         p = p+1;
         
%          ax(p) = subplot(1,5,p);
%          imagesc(t,Y(1+buff:end-buff),[i_struct.W_saveall]')
%          set(gca,'ydir','normal','FontSize',12)
%          %         set(gca,'clim',[150 310])
%          %         if p>15
%          xlabel('time (years)')
%          %         end
%          %         ylabel('alongshore distance (m)')
%          %         if p<6
%          title('Width')
%          %         end
%          colorbar
%          colormap(ax(p),gray)
%          p = p+1;
%          
%          subplot(1,5,p)
%          %                 slcchange = [zeros(1,length(Y)-2*buff);i_struct.slc_all(2:end,:)-i_struct.slc_all(1,:)];
%          %                 imagesc(t,Y(1+buff:end-buff),slcchange')
%          plot([i_struct.slc_all(end,:)],Y(1+buff:end-buff),'k','LineWidth',2)
%          set(gca,'ydir','normal','FontSize',12)
%          set(gca,'xlim',[mean(i_struct.slc_all(end,:))-1.5 mean(i_struct.slc_all(end,:))+1.5])
%          %                 ylabel('alongshore distance (m)')
%          %                 if p>16
%          xlabel('shoreline change (meters)')
%          %                 end
%          %                 if p<6
%          title('\Delta x_s_l after 200 years')
%          %                 end
%          p = p+1;
         
         ppp=1;
         h = figure();
         h.Position = [2 243 1437 562];
         ax(ppp) = subplot(1,3,ppp);
         imagesc(t,Y(1+buff:end-buff),([i_struct.Wratio]'))
         set(gca,'ydir','normal','FontSize',20)
         set(gca,'ytick',[0:2000:10000])
         set(gca,'xtick',[0:100:200])
         set(gca,'clim',[-2 2])
         %         if p>16
         xlabel('time (years)')
         %         end
         %         ylabel('alongshore distance (m)')
         %         if p<6
%          title('Washover ratio (W)')
                 ylabel('alongshore distance (m)')
         %         end
         colormap(ax(ppp),parula(4))
         c =colorbar;
         c.Ticks = ([-2:1:2]);
         ppp = ppp+1;
         
         ax(ppp) = subplot(1,3,ppp);
         imagesc(t,Y(1+buff:end-buff),[i_struct.W_saveall]')
         set(gca,'ydir','normal','FontSize',20)
         set(gca,'clim',[140 310])
         %         if p>15
         xlabel('time (years)')
         set(gca,'ytick',[0:2000:10000])
         set(gca,'xtick',[0:100:200])
         c = colorbar;
         c.Label.String = 'Width (m)';
        filler = [c.Label.Position(1)./3.*2 c.Label.Position(2) c.Label.Position(3)];
        c.Label.Position = filler;
        c.Ticks = ([140 310]);
         %         end
         %         ylabel('alongshore distance (m)')
         %         if p<6
%          title('Width')
         %         end
         colormap(ax(ppp),gray)
         ppp = ppp+1;
         
        ax(ppp) = subplot(1,3,ppp);
        imagesc(t,Y(1+buff:end-buff),[i_struct.Qsf_saveall]')
        set(gca,'ydir','normal','FontSize',20)
        set(gca,'clim',[-0.3 0.3])
        set(gca,'ytick',[0:2000:10000])
        set(gca,'xtick',[0:100:200])
        xlabel('time (years)')
        c = colorbar;
        c.Ticks = ([-0.3 0 0.3]);
        c.Label.String = 'Qsf (m^3/m/yr)';
        filler = [c.Label.Position(1)./3.*2 c.Label.Position(2) c.Label.Position(3)];
        c.Label.Position = filler;
        %         title('Qsf')
        colormap(ax(ppp),bluewhitered)
        ppp = 1;         
       
        %         subplot(1,5,p)
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
