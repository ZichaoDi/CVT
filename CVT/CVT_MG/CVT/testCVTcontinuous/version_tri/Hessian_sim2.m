function H=Hessian_sim2;
global XYbd N
do_setup;
load vs55;
x=reshape(vs55,2*55,1);
n=length(x);
% [f,g]=sfun(x);
% H1=zeros(n/2,n/2);
% H2=zeros(n/2,n/2);
% delta=1e-7;
% g1=g(1:2:end);
% g2=g(2:2:end);
% for i=1:n/2
%     v1=zeros(n,1);
%     v2=zeros(n,1);
%     v1(2*i-1)=1;
%     v2(2*i)=1;
%     hg1 = x + delta*v1;
%     hg2 = x + delta*v2;
%     [f, gv1] = sfun(hg1);
%     [f, gv2] = sfun(hg2);
%     gv1     = (gv1(1:2:end) - g1)/delta;
%     gv2     = (gv2(2:2:end) - g1)/delta;
%     %gv= sqrt(gv(:,1).^2+gv(:,2).^2);
%     H1(:,i)=gv1;
%     H2(:,i)=gv2;
% end
% H1=(H1+H1')/2;
% H2=(H2+H2')/2;
load H1;
load H2;
[V1,D1]=eig(H1);
[D1,IN]=sort(diag(D1),'ascend');
VV1=V1(:,IN);
[V2,D2]=eig(H2);
[D2,IN]=sort(diag(D2),'ascend');
VV2=V2(:,IN);
%      mov(1:N(1)) = struct('cdata',[],'colormap',[]);
%  set(gca,'NextPlot','replacechildren');
    vs=[reshape(x,2,n/2),XYbd{1}];
    for i=1:n/2
        e3=zeros(n/2,1);
        e3=VV1(:,i);
        e4=zeros(n/2,1);
        e4(1:n/2)=VV2(:,i);
    xtt = vs55(1,:);
    ytt = vs55(2,:);
    gridDelaunay = delaunay(xtt,ytt);
     figure(122);
     subplot(1,2,1)
    trimesh(gridDelaunay,xtt,ytt,e3);
    subplot(1,2,2)
    trimesh(gridDelaunay,xtt,ytt,e4);
    %mov(i) = getframe;
    title([num2str(i)])
    pause;%(0.5);
    end
    %save mov mov; 