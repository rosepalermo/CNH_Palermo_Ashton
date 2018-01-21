function [NBn,NBm]=cba(nyears,nproperties,L,dy,alpha,b,slr,Wn,Wav,Wo,p)
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
% Wo - reference beach width
% p - property cross shore length

% benefit of nourishment over nyears
Beta = zeros(1,nyears);
if nyears >= 1
    Beta(1,1) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav ./ Wo).^b;
end

if nyears >= 2
    Beta(1,2) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-2*slr ./ Wo).^b;
end

if nyears >= 3
    Beta(1,3) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-3*slr ./ Wo).^b;
end

if nyears >= 4
    Beta(1,4) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-4*slr ./ Wo).^b;
end

if nyears >= 5
    Beta(1,5) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-5*slr ./ Wo).^b;
end

if nyears >= 6
    Beta(1,6) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-6*slr ./ Wo).^b;
end

if nyears >= 7
    Beta(1,7) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-7*slr ./ Wo).^b;
end

if nyears >= 8
    Beta(1,8) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-8*slr ./ Wo).^b;
end

if nyears >= 9
    Beta(1,9) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-9*slr ./ Wo).^b;
end

if nyears >= 10
    Beta(1,10) = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - (Wav-10*slr ./ Wo).^b;
end

Benefit = sum(Beta);

% cost of nourishment
Cost
        % community 1 nourishment
        % Beta = annual benefit of this year and next 4 (community_year)
        Beta1_1(i,runn) = nproperties*L1/dy * alpha1 * ((((Wn1+W1av)./W1(1,1))^b) - mean(W1(i,:)./W1(1,1))^b);
        Beta1_2(i,runn) = nproperties*L1/dy * alpha1 * (((((Wn1+W1av)-2*slr1)./W1(1,1))^b) - (mean(W1(i,:)-2*slr1)./W1(1,1))^b);
        Beta1_3(i,runn) = nproperties*L1/dy * alpha1 * (((((Wn1+W1av)-3*slr1)./W1(1,1))^b) - (mean(W1(i,:)-3*slr1)./W1(1,1))^b);
        Beta1_4(i,runn) = nproperties*L1/dy * alpha1 * (((((Wn1+W1av)-4*slr1)./W1(1,1))^b) - (mean(W1(i,:)-4*slr1)./W1(1,1))^b);
        Beta1_5(i,runn) = nproperties*L1/dy * alpha1 * (((((Wn1+W1av)-5*slr1)./W1(1,1))^b) - (mean(W1(i,:)-5*slr1)./W1(1,1))^b);
        Benefit1(i,runn) = Beta1_1(i,runn)/(1+ir)+Beta1_2(i,runn)/((1+ir).^2)+Beta1_3(i,runn)/(1+ir).^3+Beta1_4(i,runn)/(1+ir).^4+Beta1_5(i,runn)/(1+ir).^5; % benefit assuming retreat rate of last year
        Cost1(i,runn) = f + c/2 * Wn1 * L1 * Dsf + c * Wn1 * mean(H(jjcom1)) * L1;
        NB1(i,runn) = Benefit1(i,runn)-Cost1(i,runn);
        
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
        
