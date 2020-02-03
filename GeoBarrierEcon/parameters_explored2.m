% parameters explored

sl_a = [0.003 0.004 0.005 0.01 0.05 0.1]; % sl_a right now is 0.003
Qow_max = [5 10 20 30 40 50];
astfac = [0.1 0.2 0.3 0.4 0.5];
Dbb = 2:10;
Wstart = 150:50:500;
L = [100 500 1000 5000 7000];% 102= ys
SL = 2%:length(sl_a)
shape = 'sWmid';
for OW = 1:2%;length(Qow_max)
    parfor AF = 1:length(astfac)
        for d = 1:length(Dbb)
            for Ws = 1:length(Wstart)
                for l = 1:length(L)
                GeoBarrier_func(Qow_max(OW),astfac(AF),Dbb(d),Wstart(Ws),L(l),sl_a(SL))
%                         filename = sprintf('/home/rpalermo/GeoBarrierModelOutput/1_2020/natural_%s_OW%d_SLa%d_diff%d_Dbb%d_Wstart%d_L%d',shape,Qow_max,sl_a*1000,astfac*10,Dbb,Wstart,L);

                end
            end
        end
    end
end

            