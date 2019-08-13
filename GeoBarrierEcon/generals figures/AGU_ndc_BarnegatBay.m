aa = 1;
Usla = unique([bbay(aa).shape.sl_a]);
UNDC = unique([bbay(aa).shape.NDC]);
UFD = unique([bbay(aa).shape.astfac]);
UQOW = unique([bbay(aa).shape.Qow_max]);
sizing = zeros(length(UQOW),length(UFD));
p = 1; pp = 1; ppp =1;
for i = 2 % 1:length(Usla)
    UNDCplot = [3;2;1];
    sp = 1;
    for iii = 1:length(UNDC)
        j = ([bbay(aa).shape.sl_a] == Usla(1)) & ([bbay(aa).shape.NDC] == UNDC(UNDCplot(iii)));
        j = j & ([bbay(aa).shape.astfac] == UFD(1)) & ([bbay(aa).shape.Qow_max] == UQOW(1));
        i_struct = bbay(aa).shape(j);
        
%         figure(1)
%         ax(pp) = subplot(2,2,pp);
%         imagesc(t,Y(1+buff:end-buff),[i_struct.Qsf_saveall]')
%         set(gca,'ydir','reverse','FontSize',12)
%         set(gca,'clim',[0 0.3])
%         xlabel('time (years)')
%         ylabel('alongshore distance (m)')
%         %         title('Qsf')
%         colorbar
%         colormap(ax(pp),bluewhitered)
%         pp = pp+1;
%         
%          p =1;
%          figure()
%          ax(p) = subplot(1,5,p)
%          imagesc(t,Y(1+buff:end-buff),[i_struct.Qow_saveall]')
%          set(gca,'ydir','reverse','FontSize',12)
%          set(gca,'clim',[0 20])
%          %         if p>12
%          xlabel('time (years)')
%          %         end
%          ylabel('alongshore distance (m)')
%          %         if p<6
%          title('Q_o_w')
%          %         end
%          colormap(ax(p),bluewhitered)
%          colorbar
%          p = p+1;
%          
%          ax(p) = subplot(1,5,p);
%          imagesc(t,Y(1+buff:end-buff),[i_struct.llxldot_saveall]')
%          set(gca,'ydir','reverse','FontSize',12)
%          set(gca,'clim',[-10 10])
%          %         if p>16
%          xlabel('time (years)')
%          %         end
%          %         ylabel('alongshore distance (m)')
%          colormap(ax(p),redblue)
%          %         if p<6
%          title('\Delta Q_a_s_t')
%          %         end
%          colorbar
%          p = p+1;
%          
%          ax(p) = subplot(1,5,p);
%          imagesc(t,Y(1+buff:end-buff),([i_struct.Wratio]'))
%          set(gca,'ydir','reverse','FontSize',12)
%          set(gca,'clim',[-2 2])
%          %         if p>16
%          xlabel('time (years)')
%          %         end
%          %         ylabel('alongshore distance (m)')
%          %         if p<6
%          title('Washover ratio (W)')
%          %         end
%          colormap(ax(p),parula(4))
%          colorbar
%          p = p+1;
%          
%          ax(p) = subplot(1,5,p);
%          imagesc(t,Y(1+buff:end-buff),[i_struct.W_saveall]')
%          set(gca,'ydir','reverse','FontSize',12)
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
%          set(gca,'ydir','reverse','FontSize',12)
%          set(gca,'xlim',[mean(i_struct.slc_all(end,:))-1.5 mean(i_struct.slc_all(end,:))+1.5])
%          %                 ylabel('alongshore distance (m)')
%          %                 if p>16
%          xlabel('shoreline change (meters)')
%          %                 end
%          %                 if p<6
%          title('\Delta x_s_l after 200 years')
%          %                 end
%          p = p+1;
         
%          ppp=1;
         ax(ppp) = subplot(1,3,ppp);
         imagesc(t,Y(1+buff:end-buff)/1000,([i_struct.Wratio]'))
         set(gca,'ydir','reverse','FontSize',20)
         set(gca,'clim',[-2 2])
         if ppp ==1
            set(gca,'ytick',[0:15:30])
         else
             set(gca,'ytick',[])
         end
         set(gca,'xtick',[0:1000:2000])
         %         if p>16
         xlabel('time (years)')
         %         end
         if ppp == 1
                 ylabel('alongshore distance (km)')
         end
         %         if p<6
         %         end
         colormap(ax(ppp),parula(4))
%          if ppp ==3
%          c =colorbar;
%          c.Ticks = ([-2:1:2]);
%          end
         ppp = ppp+1;
         
%          ax(ppp) = subplot(1,3,ppp);
%          imagesc(t,Y(1+buff:end-buff),[i_struct.W_saveall]')
%          set(gca,'ydir','reverse','FontSize',12)
%                  set(gca,'clim',[200 1000])
%          %         if p>15
%          xlabel('time (years)')
%          %         end
%          %         ylabel('alongshore distance (m)')
%          %         if p<6
%          title('Width')
%          %         end
%          colorbar
%          colormap(ax(ppp),gray)
%          ppp = ppp+1;
         
%         ax(ppp) = subplot(1,3,ppp);
%         imagesc(t,Y(1+buff:end-buff),[i_struct.Qsf_saveall]')
%         set(gca,'ydir','reverse','FontSize',12)
%         set(gca,'clim',[-1.2 0.1])
%         xlabel('time (years)')
%         ylabel('alongshore distance (m)')
%         %         title('Qsf')
%         colorbar
%         colormap(ax(ppp),bluewhitered)
%         ppp = 1;         
       
%         ax(ppp) = subplot(1,3,ppp);
%         imagesc(t,Y(1+buff:end-buff),[i_struct.H_saveall]')
%         set(gca,'ydir','reverse','FontSize',12)
% %         set(gca,'clim',[0 0.15])
%         xlabel('time (years)')
%         ylabel('alongshore distance (m)')
%         %         title('Qsf')
%         colorbar
%         colormap(ax(ppp),bluewhitered)
%         ppp = 1;    
        
        %         subplot(1,5,p)
        %         plot(max([i_struct.slc_all]),Y(1+buff:end-buff))
        %         set(gca,'ydir','reverse','FontSize',12)
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
        %         set(gca,'ydir','reverse','FontSize',12)
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
        %         set(gca,'ydir','reverse','FontSize',12)
        %         pp = pp+1;
        %
        %         subplot(4,3,pp)
        %         plot([i_struct.slc_all(end,:)],Y(1+buff:end-buff))
        %         set(gca,'ydir','reverse','FontSize',12)
        %         ylabel('alongshore distace')
        %         xlabel('shoreline change (meters)')
        %         title('maximum shoreline change after 200 years (meters)')
        %         set(gca,'ydir','reverse','FontSize',12)
        %         pp = pp+1;
    end
end
