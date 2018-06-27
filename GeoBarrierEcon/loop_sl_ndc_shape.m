% loop gen barrier through shapes
for sl = 1:4 %1:4
    sl
    for ndc = 1:4 %1:4
        ndc
        for m = 1:2 % 1:7
            m
            Geobarrier_main_loop_sl_shapes_ndc(m,sl,ndc)
            close all;
            clearvars -except m sl ndc
        end
    end
end