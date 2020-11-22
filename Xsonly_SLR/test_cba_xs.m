% test cba only econ

% initialize
tmax = 108;
Wav = zeros(1,tmax);
nNB = zeros(1,tmax);
mNB = zeros(1,tmax);
bNB = zeros(1,tmax);
nnourish = zeros(1,tmax);
action = zeros(1,tmax);

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
slr = 10;            % slr - shoreline retreat rate based on previous year (m/yr)
Wn = 20;            % Wn - width of nourishment project
Wav(1,1) = 50;      % Wav - average width of the beach in front of the community
Wo = 49;            % Wo - reference beach width
p = 50;             % p - property cross shore length
f = 1e6;            % f - fixed cost of nourishment
cost = 7;              % c - per unit cost of nourishment sand
Hav = 2;            % Hav - average height of barrier to nourish
Dsf = 10;           % Dsf - depth of shoreface
npropxs = 10;
npropll = 2;
subsidies = 0;


% constant inputs
for i = 1:tmax
[nNB(i),mNB(i),bNB(i)]=cba_xs(nyears,alpha,b,slr,Wn,Wav(i),Wo,p,f,cost,Hav,Dsf,L,dr,dy,npropxs,npropll,subsidies);
if bNB(i)>nNB(i) &  Wav(i)>0   % if width >0 & bNB>nNB continue                  
    Wav(i+1) = Wav(i)-slr;
    action(i) = 1;
elseif mNB(i)<nNB(i) &  Wav(i)<=0   % if width <=0 & mNB<nNB nourish
    Wav(i+1) = Wav(i)+20;
    action(i)=2;
elseif mNB(i)>nNB(i) &  Wav(i)<0 %if width<0 and nNB < mNB --> retreat
    Wav(i+1) = Wav(i)+p;
    npropxs = npropxs-1;
    action(i)=3;
elseif bNB(i)<nNB(i) & Wav(i)>0 %if width>0 and bNB > mNB --> nourish
    Wav(i+1) = Wav(i)+20;
    action(i) = 4;
end
% slr = slr*1.5;
end

figure()
plot(nNB,mNB)
xlabel('nourishment net benefit')
ylabel('managed retreat net benefit')

figure()
plot(1:tmax,Wav(1:end-1))
xlabel('time')
ylabel('width')

figure()
plot(1:tmax,nNB-mNB)
xlabel('time')
ylabel('nNB-mNB')

figure()
plot(1:tmax,nNB-bNB)
xlabel('time')
ylabel('nNB-bNB')


figure()
plot(1:tmax,action)

