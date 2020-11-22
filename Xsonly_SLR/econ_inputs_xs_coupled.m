% econ inputs
nyears = 5;         % nyears - number of years into the future the benefit is calculated (how
                    % long the project is/is expected to last)
dy = 50;            % dy - alongshore length between cells (m)
L = 20*dy;          % L - length of community (nourishment project) in meters
P = 1.5e6;          % NRM 2013 (1.5e6)
dr = 0.07;          % 7% discount rate
n_exp = 25;         % 25 years (NRM 2013)
alpha = P*dr;       % annual value of community 1/m along x axis% alpha - annual value of community
b = 0.2632;         % b - exponent
sl_retreat = 1;            % slr - shoreline retreat rate based on previous year (m/yr)
Wn = 20;            % Wn - width of nourishment project
Wav(1,1) = 50;      % Wav - average width of the beach in front of the community
Wo = 50;            % Wo - reference beach width
p = 50;             % p - property cross shore length
f = 1e6;            % f - fixed cost of nourishment
cost = 7;              % c - per unit cost of nourishment sand
Hav = 2;            % Hav - average height of barrier to nourish
Dsf = 10;           % Dsf - depth of shoreface
npropxs = floor(W(1)/p)-1;       % Width of the barrier / property width
npropll = 2;
subsidies = 0;