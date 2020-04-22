function [b_vol] = calc_barrier_volume(w_b,h_b,beta,Dt,w_sf)

b_vol = w_b.*(h_b+Dt-w_sf.*tan(beta)) + 0.5*w_b.^2.*tan(beta);

end