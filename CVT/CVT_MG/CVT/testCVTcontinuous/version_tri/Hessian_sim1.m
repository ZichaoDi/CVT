function H=Hessian_sim1
global XYbd N
do_setup;
load vs55;
x=reshape(vs55,2*55,1);
n=length(x);
% [f,g]=sfun(x);H=zeros(n,n);delta=1e-7;
% %g=reshape(g,2,N(1));
% for i=1:n
%     v=0*x;
%     v(i)=1;
%     hg      = x + delta*v;
%     [f, gv] = sfun(hg);
%     %gv=reshape(gv,2,N(1));
%     gv      = (gv - g)/delta;
%     %gv= sqrt(gv(:,1).^2+gv(:,2).^2);
%     H(:,i)=gv;
% end
% H=(H+H')/2;
% save H H
% return;
load H;
[V,D]=eig(H);
[D,IN]=sort(diag(D),'ascend');
figure(111);plot(D)
VV1=V(1:2:end,IN(1:2:end));
VV2=V(2:2:end,IN(1:2:end));
VV3=V(1:2:end,IN(2:2:end));
VV4=V(2:2:end,IN(2:2:end));
     % msim1(1:n) = struct('cdata',[],'colormap',[]);
  %set(gca,'NextPlot','replacechildren');
    vs=[reshape(x,2,n/2),XYbd{1}];
    for i=1:n/2
        e3=zeros(n/2,1);
        e3(1:n/2)=VV1(:,i);
        e4=zeros(n/2,1);
        e4(1:n/2)=VV2(:,i);
        e5=zeros(n/2,1);
        e5(1:n/2)=VV3(:,i);
        e6=zeros(n/2,1);
        e6(1:n/2)=VV4(:,i);
    xtt = vs55(1,:);
    ytt = vs55(2,:);
    gridDelaunay = delaunay(xtt,ytt);
     figure(122);
    
     subplot(2,2,1)
    trimesh(gridDelaunay,xtt,ytt,e3);
    subplot(2,2,2)
    trimesh(gridDelaunay,xtt,ytt,e4);
    subplot(2,2,3)
    trimesh(gridDelaunay,xtt,ytt,e5);
    subplot(2,2,4)
    trimesh(gridDelaunay,xtt,ytt,e6);
   % msim1(i) = getframe;
    title([num2str(i)])
    pause(0.5);
    end
   % save msim1 msim1; 