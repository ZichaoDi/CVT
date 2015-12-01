function H=Hessian_sim 
global XYbd N
do_setup;
load vs55;
x=reshape(vs55,2*55,1);
n=length(x);
[f,g]=sfun(x);H=zeros(N(1),N(1));delta=1e-7;
g=reshape(g,2,N(1));
for i=1:N(1)
    v=0*x;
    v(2*i-1:2*i)=1;
    hg      = x + delta*v;
    [f, gv] = sfun(hg);
    gv=reshape(gv,2,N(1));
    gv      = (gv' - g')/delta;
    gv= sqrt(gv(:,1).^2+gv(:,2).^2);
    H(:,i)=gv;
end
H=(H+H')/2;
[V,D]=eig(H);
[D,IN]=sort(diag(D),'ascend');
%figure(111);plot(D)
min(D)
VV=V(:,IN);
%      mov(1:N(1)) = struct('cdata',[],'colormap',[]);
%  set(gca,'NextPlot','replacechildren');
    vs=[reshape(x,2,N(1)),XYbd{1}];
    for i=1:N(1)
        e3=zeros(length(vs),1);
        e3(1:N(1))=VV(:,i);
    xtt = vs(1,:);
    ytt = vs(2,:);
    gridDelaunay = delaunay(xtt,ytt);
     figure(122);
    trimesh(gridDelaunay,xtt,ytt,e3);
    %mov(i) = getframe;
    pause;
    end
    %save mov mov; 