% loop gen barrier through shapes
for AA = 1:9
    for sl = 1:4
        sl
        for ndc = 1:4
            ndc
            for m = 2 % 1:7
                m
                Geobarrier_main_loop_sl_shapes_ndc(m,sl,ndc,AA)
                close all;
                clearvars -except m sl ndc AA
            end
        end
    end
end