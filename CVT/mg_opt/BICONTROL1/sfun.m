function [J,g]=sfun(u)
global miu  L y N constraint it 
n2 = length(u);

nm = sqrt(n2);
ind=find(nm==N);
A=cell2mat(L(ind));
nx = nm + 2;
ny = nm + 2;
[x,y,hx,hy] = getborder(nx,ny);


%zc=zc*4^(ind-1);
% load g63;
% zc=zc-A*g63;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%constrained case%%%%%%%%%%%%%%%%%%%%%%
if(constraint)
    f=sin(2*pi*x)*sin(2*pi*y);
    z=1+sin(2*pi*x)*sin(2*pi*y);
    zc=reshape(z,n2,1);
    fc=reshape(f,n2,1);
    AA = A + spdiags(u,0,n2,n2);
    y=-AA\fc;%%constrained case
    w=AA\y;
    vv=AA\zc;
    g=(vv-w).*y+miu*u;
    J=1/2*(y-zc)'*(y-zc) + miu/2*(u)'*u;
    %J=J*hx^2;
    C=1e5;
    J=J*C;
    g=g*C;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%Hessian%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % c=inv(AA);
    % D=c^2;
    % % % % % %
    % % % % for i=1:n2
    % % % %     for j=1:n2
    % % % %         cij=zeros(n2,n2);
    % % % %         cij(j,i)=c(j,i);
    % % % %         H(i,j)=(3*fc'*c*c+2*zc'*c)*cij*c*fc;
    % % % %         if(i==j)
    % % % %             H(i,j)=H(i,j)+miu;
    % % % %         end
    % % % %     end
    % % % % end
    % % % % H_bi_v0=H*hx^2;
    % % % % save('H_bi_v0','H_bi_v0');
    % % % %
    % % %
    %%%%%%%%__________________________%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % for i=1:n2
    %     for j=1:n2
    %         H(i,j)=D(i,j)*y(i)*y(j) + c(i,j)*w(i)*y(j) +c(j,i)*w(j)*y(i)-c(i,j)*vv(i)*y(j)-c(j,i)*vv(j)*y(i) ;
    %         if(i==j)
    %             H(i,j)=H(i,j)+miu;
    %         end
    %     end
    % end
    % H3=H*hx^2;
    % save('H3','H3');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %unconstrained case
else
    f=ones(size(x*y));
    z=val(x,y);
    zc=reshape(z,n2,1);
    fc=reshape(f,n2,1);
    y=A\(-fc-u);
    % g=(A\(A\(u+fc)+zc)+miu*(D.*u));%*hx^2;
    % J=1/2*(y-zc)'*(y-zc)+miu/2*u'*(D.*u);%*hx^2;*1e4
    g=(A\(A\(u+fc)+zc)+miu*(u));
    J=(1/2*(y-zc)'*(y-zc)+miu/2*u'*(u));
    C = 1e5;
    g = C*g;
    J = C*J;
%   if(nm==N(1))
%     figure(121);
%     load vs1su15;
%     vst=vs1su15;
%     plot(1:n2,u,'r.-',1:n2,vst,'b.-');
%     %pause;
% ind=find(u>=37);
%      format long e
%     J
%   end
    % if(nm==7)
    % load lambda7
    % lam=lambda7;
    % AA=inv(A);
    % AAA=AA^2;
    % vsts=(AAA+miu*eye(nm^2))\(-lam-AAA*fc-AA*zc);
    % save vsts vsts;
    % end
    
     J=J*hx^2;%/
     g=g*hx^2;%/
    % % if(it>1)
    % J=J*4^(ind-1);
    % g=g*4^(ind-1);
    % end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
