Usla = unique([NO(aa).shape.sl_a]);
UNDC = unique([NO(aa).shape.NDC]);
UFD = unique([NO(aa).shape.astfac]);
UQOW = unique([NO(aa).shape.Qow_max]);
sizing = zeros(length(UQOW),length(UFD));
figure()
for i = 2 % 1:length(Usla)
%     UNDCplot = [4;3;2;1];
    sp = 1;
    for iii = 1:length(UNDC)
        j = ([NO(aa).shape.sl_a] == Usla(i)) & ([NO(aa).shape.NDC] == UNDC(iii));
        i_struct = NO(aa).shape(j);
        
        x = [[i_struct.Qow_max]', [i_struct.astfac]',[i_struct.Msc]'];
        x = sortrows(x);
        x_ = reshape(x(:,1),7,6);
        y_ = reshape(x(:,2),7,6);
        z_ = reshape(x(:,3),7,6);
        subplot(2,2,1)
        imagesc(x_(1,:),y_(:,1),z_)
        set(gca,'ydir','normal','FontSize',14,'clim',[110 190])
        xlabel('Maximum overwash flux')
        ylabel('Fractional diffusivity')
        title('maximum shoreline change at end')
        colorbar
        
        subplot(2,2,2)
        x = [[i_struct.Qow_max]', [i_struct.astfac]',[i_struct.mslc_all]'];
        x = sortrows(x);
        x_ = reshape(x(:,1),7,6);
        y_ = reshape(x(:,2),7,6);
        z_ = reshape(x(:,3),7,6);
        
        imagesc(x_(1,:),y_(:,1),z_)
        set(gca,'ydir','normal','FontSize',14,'clim',[110 190])
        xlabel('Maximum overwash flux')
        ylabel('Fractional diffusivity')
        title('maximum shoreline change over whole simulation')
        colorbar
        
        subplot(2,2,3)
        x = [[i_struct.Qow_max]', [i_struct.astfac]',[i_struct.Mwidthend]'];
        x = sortrows(x);
        x_ = reshape(x(:,1),7,6);
        y_ = reshape(x(:,2),7,6);
        z_ = reshape(x(:,3),7,6);
        
        imagesc(x_(1,:),y_(:,1),z_)
        set(gca,'ydir','normal','FontSize',14)
        xlabel('Maximum overwash flux')
        ylabel('Fractional diffusivity')
        title('maximum width after 200 years')
        colorbar
        
        
        subplot(2,2,4)
        x = [[i_struct.Qow_max]', [i_struct.astfac]',[i_struct.Mscr]'];
        x = sortrows(x);
        x_ = reshape(x(:,1),7,6);
        y_ = reshape(x(:,2),7,6);
        z_ = reshape(x(:,3),7,6);
        imagesc(x_(1,:),y_(:,1),z_)
        set(gca,'ydir','normal','FontSize',14)
        xlabel('Maximum overwash flux')
        ylabel('Fractional diffusivity')
        title('maximum shoreline change rate in simulation')
        colorbar
        
    end
end
