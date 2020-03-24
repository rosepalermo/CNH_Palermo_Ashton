% parameters explored

sl_a = 0.004;%[0.004 0.006 0.01 0.1]; % sl_a right now is 0.003
% sl_a = [0.004 0.01 0.1]; % sl_a right now is 0.003
Qow_max = [20];%[20 30 50 100];
% Qow_max = [20 30 40 50];
astfac = [0.1 0.3 0.5];
Dbb = [100];
Wstart = [316.667];
L = [100 500 700];% 102= ys
shape = ["gen"];% "gen"];

parfor i=1:get_flat_size(sl_a, Qow_max, astfac, Dbb, Wstart, L)
    [sl_a_i, Qow_max_i, astfac_i, Dbb_i, Wstart_i, L_i, sh_i] = get_flat_values(i, sl_a, Qow_max, astfac, Dbb, Wstart, L, shape);
    GeoBarrier_main(Qow_max_i,astfac_i,Dbb_i,Wstart_i,L_i,sl_a_i,sh_i)
end

            