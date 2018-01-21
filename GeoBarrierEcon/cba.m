function [nNB,mNB]=cba(nyears,nproperties,L,dy,alpha,b,slr,Wn,Wav,Wmin,Wo,p,f,c,Hav,Dsf,ir)
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

%%%
% ROSE TALK TO ANDREW ABOUT THIS. INCLUDES B(0)->B(NYEARS)
%%%
nBeta = nan(1,nyears+1);
idx = 0:nyears;
nBeta(1,idx+1) = nproperties*L/dy * alpha * (((Wn + Wav - idx*slr)./ Wo).^b - ((Wav-idx*slr) ./ Wo).^b);
nBenefit = sum(nBeta./((1+ir).^idx));

% cost of nourishment
nCost = f + c/2 * Wn * L * Dsf + c * Wn * Hav * L;

% net benefit of nourishment
nNB = nBenefit - nCost;

%% managed retreat

% benefit of managed retreat
mBeta = nan(1,nyears+1);
mCost = nan;
idx = 0:nyears;
if Wmin <=1
    mBeta(1,idx+1) = nproperties*L/dy * alpha * (((p + Wav)./ Wo).^b - ((Wav-idx*slr) ./ Wo).^b);
    
    % cost of managed retreat
    mCost = nproperties*L/dy * alpha;
end
% net benefit of nourishment
mBenefit = sum(mBeta./((1+ir).^idx));
mNB = mBenefit - mCost;

