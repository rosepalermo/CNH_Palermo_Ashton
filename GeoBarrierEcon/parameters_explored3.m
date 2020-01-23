% parameters explored

sl_a = [0.003 0.004 0.005 0.01 0.05 0.1]; % sl_a right now is 0.003
Qow_max = [5 10 20 30 40 50];
astfac = [0.1 0.2 0.3 0.4 0.5];
Dbb = 2:10;
Wstart = 150:50:500;
L = [100 500 1000 5000 7000];% 102= ys
SL = 3%:length(sl_a)
parfor OW = 1:length(Qow_max)
    for AF = 1:length(astfac)
        for d = 1:length(Dbb)
            for Ws = 1:length(Wstart)
                for l = 1:length(L)
                GeoBarrier_func(Qow_max(OW),astfac(AF),Dbb(d),Wstart(Ws),L(l),sl_a(SL))
                end
            end
        end
    end
end

            