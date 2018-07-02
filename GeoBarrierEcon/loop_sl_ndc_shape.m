% loop gen barrier through shapes
parfor QW = 1:6
    for AA = 1:7 % 1:9
        for sl = 1:6
            sl
            for ndc = 1%:4
                ndc
                for m = 1:2 % 1:7
                    m
                    Geobarrier_main_loop_sl_shapes_ndc(m,sl,ndc,AA, QW)
                    close all;
%                     clearvars -except m sl ndc AA QW
                end
            end
        end
    end
end