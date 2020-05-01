% plot the constant volume surface

beta = 0.015;
Dt = 10;

w_sf = linspace(500,Dt/tan(beta),20);
w_b = linspace(150,300,20);
h_b = linspace(1,2,20);

[W_sf,W_b,H_b] = meshgrid(w_sf,w_b,h_b);

% shoreface volume
[sf_vol] = calc_shoreface_volume(W_sf,Dt,beta);

% barrier volume
[b_vol] = calc_barrier_volume(W_b,H_b,beta,Dt,W_sf);

total_vol = sf_vol + b_vol;

for vol = 500:500:2500
isosurface(W_sf,W_b,H_b,total_vol,vol)
hold on
end
zlabel('Height')
xlabel('shoreface width')
ylabel('barrier width')