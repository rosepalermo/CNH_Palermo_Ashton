% loop gen barrier through shapes

for m = 1:7
    m
    GeoBarrier_main_loop_shapes(m)
    close all; 
    clearvars -except m
end