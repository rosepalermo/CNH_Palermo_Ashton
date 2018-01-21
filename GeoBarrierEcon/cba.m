function [NBn,NBm]=cba(nyears,nproperties,L,dy,alpha,b,slr,Wn,Wav,Wo)
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

if nyears>=1
    
    Beta = nproperties*L/dy * alpha * ((Wn + Wav)./ Wo).^b - 
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
        
        
        % community 2 nourishment
        Beta2_1(i,runn) = nproperties*L2/dy * alpha1 * ((((Wn2+W2av)./W2(1,1))^b) - mean(W2(i,:)./W2(1,1))^b);
        Beta2_2(i,runn) = nproperties*L2/dy * alpha1 * (((((Wn2+W2av)-2*slr2)./W2(1,1))^b) - (mean(W2(i,:)-1*slr2)./W2(1,1))^b);
        Beta2_3(i,runn) = nproperties*L2/dy * alpha1 * (((((Wn2+W2av)-3*slr2)./W2(1,1))^b) - (mean(W2(i,:)-2*slr2)./W2(1,1))^b);
        Beta2_4(i,runn) = nproperties*L2/dy * alpha1 * (((((Wn2+W2av)-4*slr2)./W2(1,1))^b) - (mean(W2(i,:)-3*slr2)./W2(1,1))^b);
        Beta2_5(i,runn) = nproperties*L2/dy * alpha1 * (((((Wn2+W2av)-5*slr2)./W2(1,1))^b) - (mean(W2(i,:)-4*slr2)./W2(1,1))^b);
        Benefit2(i,runn) = Beta2_1(i,runn)/(1+ir)+Beta2_2(i,runn)/(1+ir).^2+Beta2_3(i,runn)/(1+ir).^3+Beta2_4(i,runn)/(1+ir).^4+Beta2_5(i,runn)/(1+ir).^5; % benefit assuming that retreat rate of last year
        Cost2(i,runn) = f + c/2 * Wn2 * L2 * Dsf + c * Wn2 * mean(H(jjcom2)) * L2;
        NB2(i,runn) = Benefit2(i,runn)-Cost2(i,runn);
        
        % community 2 managed retreat
        if min(W2(i,:))<=1
            Beta2mr_1(i,runn) = nproperties*L2/dy * alpha1 * ((((Wn2+W2av)./W2(1,1))^b) - mean(W2(i,:)./W2(1,1))^b);
            Beta2mr_2(i,runn) = nproperties*L2/dy * alpha1 * (((((Wn2+W2av)-2*slr2)./W2(1,1))^b) - (mean(W2(i,:)-1*slr2)./W2(1,1))^b);
            Beta2mr_3(i,runn) = nproperties*L2/dy * alpha1 * (((((Wn2+W2av)-3*slr2)./W2(1,1))^b) - (mean(W2(i,:)-2*slr2)./W2(1,1))^b);
            Beta2mr_4(i,runn) = nproperties*L2/dy * alpha1 * (((((Wn2+W2av)-4*slr2)./W2(1,1))^b) - (mean(W2(i,:)-3*slr2)./W2(1,1))^b);
            Beta2mr_5(i,runn) = nproperties*L2/dy * alpha1 * (((((Wn2+W2av)-5*slr2)./W2(1,1))^b) - (mean(W2(i,:)-4*slr2)./W2(1,1))^b);
            Benefit2mr(i,runn) = Beta2mr_1(i,runn)/(1+ir)+Beta2mr_2(i,runn)/(1+ir).^2+Beta2mr_3(i,runn)/(1+ir).^3+Beta2mr_4(i,runn)/(1+ir).^4+Beta2mr_5(i,runn)/(1+ir).^5; % benefit assuming that retreat rate of last year
            %         Benefit2mr(i,runn) = Beta2mr(i,runn)/(1+ir)+Beta2mr(i,runn)/(1+ir).^2+Beta2mr(i,runn)/(1+ir).^3+Beta2mr(i,runn)/(1+ir).^4+Beta2mr(i,runn)/(1+ir).^5; % benefit assuming that width will not change over next 5 years
            %Cost2mr(i,runn) = dem*dy/nproperties*propertysize + alpha2*nproperties*L2/dy;
            %Cost2mr(i,runn) = alpha2*nproperties*L2/dy;
            Cost2mr(i,runn) = nproperties*alpha2;
            NB2mr(i,runn) = Benefit2mr(i,runn)-Cost2mr(i,runn);
        end
        
        
        
        