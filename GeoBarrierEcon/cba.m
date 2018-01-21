function [nNB,mNB]=cba(nyears,nproperties,L,dy,alpha,b,slr,Wn,Wav,Wmin,Wo,p,f,c,Hav,Dsf)
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
nBeta = zeros(1,nyears);
idx = 1:nyears;
nBeta(1,idx) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-idx*slr ./ Wo).^b;
nBenefit = sum(nBeta);

% cost of nourishment
nCost = f + c/2 * Wn * L * Dsf + c * Wn * Hav * L1;

% net benefit of nourishment
nNB = nBenefit - nCost;

%% managed retreat

% benefit of managed retreat
mBeta = zeros(1,nyears);
idx = 1:nyears;
mBeta(1,idx) = nproperties*L/dy * alpha * ((p + Wav)./ Wo).^b - (Wav-idx*slr ./ Wo).^b;
mBenefit = sum(mBeta);

% cost of managed retreat
mCost = nproperties*L/dy * alpha;

% net benefit of nourishment
mNB = mBenefit - mCost;
        
        % community 1 managed retreat
        if min(W1(i,:))<=1
            Beta1mr_1(i,runn) = nproperties*L1/dy * alpha1 * ((((Wn1+W1av)./W1(1,1))^b) - mean(W1(i,:)./W1(1,1))^b);
            Beta1mr_2(i,runn) = nproperties*L1/dy * alpha1 * (((((Wn1+W1av)-2*slr1)./W1(1,1))^b) - (mean(W1(i,:)-2*slr1)./W1(1,1))^b);
            Beta1mr_3(i,runn) = nproperties*L1/dy * alpha1 * (((((Wn1+W1av)-3*slr1)./W1(1,1))^b) - (mean(W1(i,:)-3*slr1)./W1(1,1))^b);
            Beta1mr_4(i,runn) = nproperties*L1/dy * alpha1 * (((((Wn1+W1av)-4*slr1)./W1(1,1))^b) - (mean(W1(i,:)-4*slr1)./W1(1,1))^b);
            Beta1mr_5(i,runn) = nproperties*L1/dy * alpha1 * (((((Wn1+W1av)-5*slr1)./W1(1,1))^b) - (mean(W1(i,:)-5*slr1)./W1(1,1))^b);
            Benefit1mr(i,runn) = Beta1mr_1(i,runn)/(1+ir)+Beta1mr_2(i,runn)/(1+ir).^2+Beta1mr_3(i,runn)/(1+ir).^3+Beta1mr_4(i,runn)/(1+ir).^4+Beta1mr_5(i,runn)/(1+ir).^5; % benefit assuming that retreat rate of last year
            %Cost1mr(i,runn) = dem*dy/nproperties*propertysize + alpha1*nproperties*L1/dy;
            %         Cost1mr(i,runn) = alpha1*nproperties*L1/dy;
            Cost1mr(i,runn) = nproperties*alpha1;
            NB1mr(i,runn) = Benefit1mr(i,runn)-Cost1mr(i,runn);
        end
        
