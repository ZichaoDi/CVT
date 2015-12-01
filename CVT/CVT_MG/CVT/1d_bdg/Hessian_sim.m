function H= Hessian_sim (x)
n=length(x);
[f,g]=sfun(x);H=zeros(n,n);delta=1e-12;
for i=1:n
    v=0*x;
    v(i)=1;
    hg      = x + delta*v;
    [f, gv] = sfun(hg);
    gv      = (gv - g)/delta;
    H(:,i)=gv;
end
H=(H+H')/2;
% HH=[];
%  for i=1:2:160
% HH(:,(i+1)/2)=Hsim(:,i)+Hsim(:,i+1);end
% HHH=[];
% for i=1:2:160
% HHH((i+1)/2,:)=HH(i,:)+HH(i+1,:);end
% H=HHH;
