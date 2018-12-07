% loop gen barrier through shapes
foldername = 'D:\GeoBarrierModelOutput\';
addpath(genpath(foldername))
QW_ = [5;10;20;30;40;50];
parfor QW = 1:6
    for AA = 1:7 % 1:9
        AA_ = [1;5;10;20;30;40;50];
        for sl = 1:6
            sl_ = [3;4;5;10;50;100];
            for ndc = 1:4
                ndc_ = [string('NAT');string('DC');string('DR');string('DCR')];
                for m = 1:2 % 1:7
                    m_ = [string('gen');string('sWmid')];
                    savenamecheck = sprintf('%s_%s_OW%d_K200_SLa%d_diff%d',ndc_(ndc),m_(m),AA_(AA),sl_(sl),QW_(QW));
                    if ~exist(savenamecheck,'file')
                        savenamecheck
                        Geobarrier_main_loop_sl_shapes_ndc(m,sl,ndc,AA, QW)
                        close all;
%                     clearvars -except m sl ndc AA QW
                    end
                end
            end
        end
    end
end