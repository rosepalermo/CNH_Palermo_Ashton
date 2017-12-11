
sl = 0.001:0.001:0.02;
w = 330:-1:300;
n1 = zeros(length(sl),length(w));
n2 = zeros(size(n1));
mr1 = zeros(size(n1));
mr2 = zeros(size(n1));

for my_index=1:7
    tic
    sl_aAGU = sl(my_index);
    GeoBarrier_RP_AGU2017_1com_residential_ij;
    
    n1(my_index,:) = nnourished1;
    n2(my_index,:) = nnourished2;
    mr1(my_index,:) = nmanret1;
    mr2(my_index,:) = nmanret2;
    my_index
    toc
end

save('AGUPlot', 'sl', 'w', 'n1', 'n2', 'mr1', 'mr2')

