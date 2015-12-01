function comple_diag
% k=50; H=zeros(5,5); H(1,1)=3/2; H(k,k)=3/2; H(1,2)=-1/2; H(k-1,k)=-1/2;
% for i=2:k-1, H(i,i)=1; H(i,i-1)=-1/2; H(i,i+1)=-1/2;end
% [V,D]=eig(H);
% [D,IN]=sort(diag(D),'ascend');
% VV=V(:,IN);
% figure(111);for i=1:k plot(VV(:,i),'r.-');pause; end

%%%=========================================================
%%% Jocabian of Lloyd map
k=50;T=zeros(k,k); T(1,1)=1/4; T(k,k)=1/4; T(1,2)=1/4; T(k-1,k)=1/4;
for i=2:k-1, T(i,i)=1/2; T(i,i-1)=1/4; T(i,i+1)=1/4;end
T=T(2:k-1,2:k-1);
[V,D]=eig(T);
[D,IN]=sort(diag(D),'ascend');
% VV=V(:,IN);
% figure(111);for i=1:k plot(VV(:,i),'r.-');pause; end
figure(111);plot(D)
%%%=========================================================