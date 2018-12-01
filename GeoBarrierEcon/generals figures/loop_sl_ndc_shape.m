% loop gen barrier through shapes
parfor QW = 3%1:6
    for AA = 5%1:7
        for sl = 2
            sl
            for ndc = 1%:4
                ndc
                for m = 1 % 1:7
                    m
                    Geobarrier_main_loop_sl_shapes_ndc(m,sl,ndc,AA, QW)
%                     title(num2str(AA))
%                     close all;
%                     clearvars -except m sl ndc AA QW
                end
            end
        end
    end
end