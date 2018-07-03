Usla = unique([A(aa).shape.sl_a]);
UNDC = unique([A(aa).shape.NDC]);
UFD = unique([A(aa).shape.astfac]);
UQOW = unique([A(aa).shape.Qow_max]);
sizing = zeros(length(UQOW),length(UFD));
figure()
p = 1;
for i = 2 % 1:length(Usla)
    UNDCplot = [4;3;2;1];
    sp = 1;
    for iii = 1:length(UNDC)
        j = ([A(aa).shape.sl_a] == Usla(i)) & ([A(aa).shape.NDC] == UNDC(UNDCplot(iii)));
        i_struct = A(aa).shape(j);
        
        subplot(4,5,p)
        imagesc(t./100,Y(1+buff:end-buff),[i_struct(iii).Qow_saveall]')
        set(gca,'ydir','normal','FontSize',14)
        xlabel('time(years)')
        ylabel('alongshore distance (meters)')
        title('Qow')
        colorbar
        p = p+1;
        
        subplot(4,5,p)
        imagesc(t./100,Y(1+buff:end-buff),[i_struct(iii).Qast_saveall]')
        set(gca,'ydir','normal','FontSize',14)
        xlabel('time (years)')
        ylabel('alongshore distance (meters)')
        title('Qast')
        colorbar
        p = p+1;
        
        subplot(4,5,p)
        imagesc(t./100,Y(1+buff:end-buff),[i_struct(iii).Wratio]')
        set(gca,'ydir','normal','FontSize',14)
        xlabel('time(years)')
        ylabel('alongshore distance (meters)')
        title('Washover ratio (Qow/Qast)')
        colorbar
        p = p+1
        
        subplot(4,5,p)
        plot(Y(1+buff:end-buff),[i_struct(iii).Mslc])
        set(gca,'ydir','normal','FontSize',14)
        xlabel('time(years)')
        ylabel('alongshore distance (meters)')
        title('maximum shoreline change after 200 years')
        p = p+1;
        
        subplot(4,5,p)
        plot(Y(1+buff:end-buff),[i_struct(iii).mslc_all])
        set(gca,'ydir','normal','FontSize',14)
        xlabel('time(years)')
        ylabel('alongshore distance (meters)')
        title('maximum shoreline change throughout simulation')
        p = p+1;
        
    end
end
