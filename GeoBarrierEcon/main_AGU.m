% AGU experiments
% loop gen barrier through shapes
QW = 3;%1:6
AA = 2;%1:7
sl = 2;
shape_ =3; % first half of barnegat bay
ndc_ = [1 2]; % natural and residential
for ndc = 1:2%:4
    ndc
    Geobarrier_AGU([],sl,ndc,AA,QW,shape_)
end
