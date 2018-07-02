function makefig_sl_v_data(A,aa)
UFD = unique([A(aa).shape.astfac]);
UNDC = unique([A(aa).shape.NDC]);
for i = 1:length(UFD)
    figure()
    
    for iii = 1:length(UNDC)
        j = ([A(aa).shape.astfac] == UFD(i)) & ([A(aa).shape.NDC] == UNDC(iii));
        i_struct = A(aa).shape(j);
        [~,sorted_i] = sort([i_struct.sl_a]);
        
        subplot(2,4,1)
        hold on
        plot([i_struct(sorted_i).sl_a],[i_struct(sorted_i).MQsf],i_struct(1).color)
        xlabel('sl_a')
        ylabel('maximum Qsf over simulation')
        title(sprintf("%s %.2f",A(aa).shape(1).shape,UFD(i)))
        
        subplot(2,4,2)
        hold on
        plot([i_struct(sorted_i).sl_a],[i_struct(sorted_i).Mwidth],i_struct(1).color)
        xlabel('sl_a')
        ylabel('maximum width over simulation')
        
        subplot(2,4,3)
        hold on
        plot([i_struct(sorted_i).sl_a],[i_struct(sorted_i).Msc],i_struct(1).color)
        xlabel('sl_a')
        ylabel('maximum shoreline change over simulation')
        
        subplot(2,4,4)
        hold on
        plot([i_struct(sorted_i).sl_a],[i_struct(sorted_i).Mscr],i_struct(1).color)
        xlabel('sl_a')
        ylabel('maximum shoreline change rate over simulation')
        
        subplot(2,4,5)
        hold on
        plot([i_struct(sorted_i).sl_a],[i_struct(sorted_i).MQsfend],i_struct(1).color)
        xlabel('sl_a')
        ylabel('maximum Qsf after 200 years')
        
        subplot(2,4,6)
        hold on
        plot([i_struct(sorted_i).sl_a],[i_struct(sorted_i).Mwidthend],i_struct(1).color)
        xlabel('sl_a')
        ylabel('maximum width after 200 years')
    end
end

end