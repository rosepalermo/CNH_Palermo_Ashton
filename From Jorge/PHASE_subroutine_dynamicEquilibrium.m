% clc; clear all;
T_H=zeros(nq,nk);T_W=zeros(nq,nk);OSC=zeros(nq,nk);DE=zeros(nq,nk);Mixed=zeros(nq,nk);
for i=1:nq; for j=1:nk; if tdrown_H(i,j)>0;T_H(i,j)=1;else T_H(i,j)=0;end; end; end
for i=1:nq; for j=1:nk; if tdrown_W(i,j)>0;T_W(i,j)=1;else T_W(i,j)=0;end; end; end
for i=1:nq; for j=1:nk; if T_W(i,j)==1; OSC(i,j)=0;elseif T_H(i,j)==1; OSC(i,j)=0; elseif WWpeak(i,j)==200;...
                OSC(i,j)=1;else OSC(i,j)=0;end; end; end
for i=1:nq; for j=1:nk; if T_W(i,j)==1; DE(i,j)=0;elseif T_H(i,j)==1;DE(i,j)=0; elseif OSC(i,j)==1;DE(i,j)=0;...
        elseif WWpeak(i,j)==400;DE(i,j)=1;else DE(i,j)=0;end; end; end
for i=1:nq; for j=1:nk; if T_W(i,j)==1; Mixed(i,j)=0;elseif T_H(i,j)==1;Mixed(i,j)=0; elseif OSC(i,j)==1;...
                Mixed(i,j)=0;elseif DE(i,j)==1;Mixed(i,j)=0; elseif WWpeak(i,j)==-200;Mixed(i,j)=1;else Mixed(i,j)=0;end;end; end


figure(1)
SOL=15*rot90(T_W)+25*rot90(Mixed)+35*rot90(DE)+45*rot90(OSC);
% SOLSOL=rot90(T_W)+rot90(Mixed)+rot90(DE)+rot90(OSC);
% nq=1;
% nk=1;
% T_W=zeros(nq,nk);
% % T_W=ones(nq,nk);
% SOL=45*rot90(T_W);
% imagesc(SOL,[0,45]);
% colormap(gray)

imagesc(Qow_max,K,SOL,[0,45]);
colormap(gray)
% colormap(jet)
axis square
xlabel('Q_{ow,max}');ylabel('K');