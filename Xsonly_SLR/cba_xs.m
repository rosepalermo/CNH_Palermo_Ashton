function [nNB,mNB,bNB]=cba(nyears,alpha,b,slr,Wn,Wav,Wo,p,f,cost,Hav,Dsf,L,dr,dy,npropxs,npropll,subsidies)
% this function calculates the net benefit of nourishment and of managed
% retreat based on the work we did for 2017 AGU

% CROSS SHORE ONLY -- We assume no alongshore variation and calculate for a
% community of length L? BC of fixed costs, does not make sense to calc for
% 1m in alongshore length

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

Wnourished = Wn + Wav - idx*slr;
Wnourished(Wnourished<0)=0;

% this is alpha * nproperties * w^b
nBeta(1,idx+1) = npropll * nansum(npropxs)*L/dy* alpha * (((Wnourished)./ Wo).^b);

% nBeta(1,idx+1) = npropll*L/dy * alpha * (((Wn + Wav - idx*slr)./ Wo).^b - ((Wav-idx*slr) ./ Wo).^b) .* (nansum(nansum((dist2oc).^kappa))) .* nansum(nansum(((dist2bb).^kkappa)));

nBenefit = sum(nBeta./((1+dr).^idx));

% cost of nourishment
nCost = (f + cost/2 * Wn * L * Dsf + cost * Wn * Hav * L )*(1-subsidies);

% discount the cost --- we don't need to do this because idk(1) = 0;
% nCost = nCost./((1+dr).^idx(1));

% net benefit of nourishment
nNB = nBenefit - nCost;

%% managed retreat

% benefit of managed retreat
mBeta = nan(1,nyears+1);
mCost = nan;
idx = 0:nyears;
% if Wmin <=1

Wmanaged = p + Wav-idx*slr;
Wmanaged(Wmanaged<0)=0;

% marginal benefit? benefit the houses left recieve from the width of
% the beach
mBeta(1,idx+1) = (npropll * nansum(npropxs)*L/dy - npropll*L/dy)* alpha * (((Wmanaged)./ Wo).^b);

% this is alpha * nproperties * w^b
%     mBeta(1,idx+1) = npropll * nansum(npropxs)* alpha * ((((p + Wav)./ Wo).^b) - (((Wav-idx*slr) ./ Wo).^b));
%     mBeta(1,idx+1) = npropll*L/dy * alpha * ((((p + Wav)./ Wo).^b) - (((Wav-idx*slr) ./ Wo).^b)) .* (nansum(nansum((dist2oc).^kappa))) .* nansum(nansum(((dist2bb).^kkappa)));

% cost of managed retreat
%     mCost = npropll*L/dy * alpha; % this cost would be the
%     community buying out the properties
mCost = 0; % 0 assumes no buyout
% end

% net benefit of nourishment
mBenefit = sum(mBeta./((1+dr).^idx));
mNB = mBenefit - mCost;

%%
% the benefit the beach provides without any actions
bBeta = nan(1,nyears+1);
idx = 0:nyears;

Wexpected = Wav - idx*slr;
Wexpected(Wexpected<0) = 0;

% this is alpha * nproperties * w^b
bBeta(1,idx+1) = npropll * nansum(npropxs)*L/dy* alpha * (((Wexpected)./ Wo).^b);

% nBeta(1,idx+1) = npropll*L/dy * alpha * (((Wn + Wav - idx*slr)./ Wo).^b - ((Wav-idx*slr) ./ Wo).^b) .* (nansum(nansum((dist2oc).^kappa))) .* nansum(nansum(((dist2bb).^kkappa)));

bNB = sum(bBeta./((1+dr).^idx)); % cost is 0



