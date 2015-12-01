function [xnew,ierror] = ...
	lin (p, x, f, alphamax, sfun,Aeq,beq,A,b,lb,ub,output,lambda)
%---------------------------------------------------------
% line search 
%---------------------------------------------------------
% set up
%---------------------------------------------------------
ROW=[1,10,100];
alpha  = alphamax;
xnew   = x;
ierror=3;
%=======================================================
%===========test merit function=========================
% alp=linspace(0,1,20);
% for j=1:3
%     row=ROW(j);
% for i=1:length(alp)
%     vt=x+alp(i)*p;
%     [F,G]=feval(sfun,vt);
%     [fm,gm]=eval_merit(F,G,vt,Aeq,beq,A,b,output,lambda,row);
%     meritf(i)=fm;
% end
% figure(22);subplot(3,1,j);plot(alp,meritf,'r.-');
% end
%======================================================
for itcnt = 1:20;
   xt = x + alpha*p;
%    ind=find(xt>=ub);
%    xt(ind)= ub(ind)-1e-3;
   [F,G]=feval(sfun,xt);
   [ft, gt] = eval_merit(F,G,xt,Aeq,beq,A,b,lb,ub,output,lambda,100);
   if (ft < f);
      xnew   = xt;
      fnew   = ft;
      gnew   = gt;
      ierror=0;
      fprintf('MG/Opt line search: alpha = %16.8e\n',alpha)
      break;
   end;
   alpha = alpha / 2;
end;

