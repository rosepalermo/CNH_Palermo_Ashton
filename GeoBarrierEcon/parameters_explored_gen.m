% parameters explored

sl_a = 0.003;%[0.004 0.006 0.01 0.1]; % sl_a right now is 0.003
% sl_a = [0.004 0.01 0.1]; % sl_a right now is 0.003
Qow_max = [20 30 50 100];
% Qow_max = [20 30 40 50];
astfac = [0.1 0.3 0.5];
Dbb = [3 6 100];
Wstart = [316.667];
L = [100 500 700];% 102= ys
shape = 'gen';

% for SL = 1:length(sl_a)
% parfor OW = 1:length(Qow_max)
%     for AF = 1:length(astfac)
%         for d = 1:length(Dbb)
%             for Ws = 1:length(Wstart)
%                 for l = 1:length(L)
%                 GeoBarrier_main(Qow_max(OW),astfac(AF),Dbb(d),Wstart(Ws),L(l),sl_a(SL))
%                 end
%             end
%         end
%     end
% end

parfor i=1:get_flat_size(sl_a, Qow_max, astfac, Dbb, Wstart, L)
    [sl_a_i, Qow_max_i, astfac_i, Dbb_i, Wstart_i, L_i] = get_flat_values(i, sl_a, Qow_max, astfac, Dbb, Wstart, L);
    GeoBarrier_main(Qow_max_i,astfac_i,Dbb_i,Wstart_i,L_i,sl_a_i,shape)
end

            