function [nNB,mNB]=cba(nyears,npropertiesll,L,dy,alpha,b,slr,Wn,Wav,Wmin,Wo,p,f,cost,Hav,Dsf,dr,dist2oc0,dist2oc,dist2bb0,dist2bb,kappa,kkappa,npropxs,subsidies)
% this function calculates the net benefit of nourishment and of managed
% retreat based on the work we did for 2017 AGU

% nyears - number of years into the future the benefit is calculated (how
% long the project is/is expected to last)
% nproperties - number of properties per dy
% L - length of community (nourishment project) in meters
% dy - alongshore length between cells (m)
% alpha - annual value of community
% b - exponent
% slr - shoreline retreat rate based on previous year
% Wn - width of nourishment project
% Wav - average width of the beach in front of the community
% Wmin - minimum width of beach in front of the community at this timestep
% Wo - reference beach width
% p - property cross shore length
% f - fixed cost of nourishment
% c - per unit cost of nourishment sand
% Hav - average height of barrier to nourish
% Dsf - depth of shoreface


%% nourishment

% benefit of nourishment over nyears
nBeta = nan(1,nyears+1);
idx = 0:nyears;

% this is alpha * nproperties * w^b
nBeta(1,idx+1) = npropertiesll * nansum(npropxs)* alpha * ((((Wn + Wav - idx*slr)./ Wo).^b) - (((Wav-idx*slr) ./ Wo).^b));

% nBeta(1,idx+1) = npropertiesll*L/dy * alpha * (((Wn + Wav - idx*slr)./ Wo).^b - ((Wav-idx*slr) ./ Wo).^b) .* (nansum(nansum((dist2oc).^kappa))) .* nansum(nansum(((dist2bb).^kkappa)));

nBenefit = sum(nBeta./((1+dr).^idx));

% cost of nourishment
nCost = (f + cost/2 * Wn * L * Dsf + cost * Wn * Hav * L )*(1-subsidies);

% net benefit of nourishment
nNB = nBenefit - nCost;

%% managed retreat

% benefit of managed retreat
mBeta = nan(1,nyears+1);
mCost = nan;
idx = 0:nyears;
% if Wmin <=1
    
    % marginal benefit? benefit the houses left recieve from the width of
    % the beach
    mBeta(1,idx+1) = (npropertiesll * nansum(npropxs) - npropertiesll*L/dy)* alpha * ((((p + Wav-idx*slr)./ Wo).^b) - (((Wav-idx*slr) ./ Wo).^b));
    
    % this is alpha * nproperties * w^b
    %     mBeta(1,idx+1) = npropertiesll * nansum(npropxs)* alpha * ((((p + Wav)./ Wo).^b) - (((Wav-idx*slr) ./ Wo).^b));
    %     mBeta(1,idx+1) = npropertiesll*L/dy * alpha * ((((p + Wav)./ Wo).^b) - (((Wav-idx*slr) ./ Wo).^b)) .* (nansum(nansum((dist2oc).^kappa))) .* nansum(nansum(((dist2bb).^kkappa)));
    
    % cost of managed retreat
    %     mCost = npropertiesll*L/dy * alpha; % this cost would be the
    %     community buying out the properties
    mCost = 0; % 0 assumes no buyout
% end
% net benefit of nourishment
mBenefit = sum(mBeta./((1+dr).^idx));
mNB = mBenefit - mCost;

