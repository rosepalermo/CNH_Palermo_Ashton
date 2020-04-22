function [sf_vol] = calc_shoreface_volume(w_sf,Dt,beta)

sf_vol = 0.5*w_sf.*(Dt-w_sf.*tan(beta));


end