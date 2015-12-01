function [x,iter,conv]=Gauss_Seidel(D,L,U,x,f_h,miter)
%%Gauss Seidel iteration
global partial gap
m=length(f_h);
n=0;
err=[];
A=(D-L-U);
% lam=eig(A);
% figure(11);plot(1:m,lam,'r.-',1:m,diag(D),'b.-')
gamaminus=max(sum(abs(-L),2).*(1./diag(D)));
gamaplus=max(sum(abs(-U),2).*(1./diag(D)));
gama=1/((1+gamaminus)*(1+gamaplus));


B=(D-L);
vs=A\f_h;

while(n>=0 & n<=miter)
    n=n+1;
    oldx=x;
    %    error=vs-x;
    %     figure(2);plot(1:length(f_h),error,'r.-');
    %     for i=1:m
    %         text(i,error(i),num2str(i),'Fontsize',18);
    %     end
    %     pause;
    eero=vs-x;
    x=x+B\(f_h-A*x);
    x(1:gap:partial)=oldx(1:gap:partial);
    %     x(3+[0:1:6]*7)=oldx(3+[0:1:6]*7);
    %     x(4+[0:1:6]*7)=oldx(4+[0:1:6]*7);
%     eer=vs-x;
%     left=eero'*(f_h-A*oldx)-eer'*(f_h-A*x)
%          right=abs([f_h-A*oldx]).^2.*(1./diag(D));
%          right=sum(right);
%          right=gama*right
% %%%%++++++++++++++++++++++++++++++++++++++++++++
% %%%%% Trottenberg p438
% %     right=[f_h-A*oldx]'*inv(D)*[f_h-A*oldx]
% %     left=eero'*(f_h-A*oldx)
% %%%%++++++++++++++++++++++++++++++++++++++++++++
%     
%     pause;
    er=norm(f_h-A*x,inf);
    err(n)=er;
    
    if(err(n)<=1e-6)
        fprintf('solution convergent\n');
        break;
    end;
    
end
iter=n;
conv=(err(n)/err(1))^(1/iter);
% figure(3); hold on; drawnow;
% plot(x,'ks-');
% pause;