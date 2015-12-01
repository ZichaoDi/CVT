function [J,g]=sfun(u)
global beta  L y N constraint  current_n

ind=find(current_n==N);
A=cell2mat(L(ind));
nx = current_n + 2;
[x,hx] = getborder(nx);


%%%%%%%%%%%%%%%%%%%%%%%%%%=====================constrained: -Ay-uy=f;
if(constraint)
    f=sin(2*pi*x);
    z=1+sin(2*pi*x);
    AA = A + spdiags(u,0,current_n,current_n);
    y=-AA\f;
    w=AA\y;
    vv=AA\z;
    g=(vv-w).*y+beta*u;
    J=1/2*(y-z)'*(y-z) + beta/2*(u)'*u;
    
%%%%%%%%%%%%%%%%%%%%%%=============================unconstrained: -Ay=f+u;
else
    f=ones(size(x));
    z=val(x);
    y=A\(-f-u);
    g=(A\(A\(u+f)+z)+beta*(u));
    J=(1/2*(y-z)'*(y-z)+beta/2*u'*(u));
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
