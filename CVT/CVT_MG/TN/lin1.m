function [xnew, fnew, gnew, nf1, ierror, alpha1, varargout] = ...
	lin1 (p, x, f, alpha, g, sfun)
global N c2 XY
%---------------------------------------------------------
% line search (naive)
%---------------------------------------------------------
% set up
%---------------------------------------------------------
% x=sort(x);
 p(2*c2)=0;
 p(2*c2-1)=0;
 xs=XY{1};
 err=reshape(xs,2*length(xs),1)-x;
figure(12);plot(1:length(p),p,'r.-',1:length(p),err,'b.-');
badin=find(abs(p)>0.1);
for ii=1:length(badin)
    text(badin(ii),p(badin(ii)),num2str(badin(ii)));end
pause;
ierror = 3;
xnew   = x;
fnew   = f;
gnew   = g;
maxit  = 30;
% disp('### In LINE SEARCH: lin1 ###')
% fprintf(' g''p = %e\n',g'*p);
if (alpha == 0); ierror = 0; maxit = 1; end;
alpha1 = alpha;
%---------------------------------------------------------
% line search
%---------------------------------------------------------
for itcnt = 1:maxit;
    xt = x + alpha1*p;
   [ft, gt] = feval (sfun, xt);
   if (ft < f);
      ierror = 0;
      xnew   = xt;
      fnew   = ft;
      gnew   = gt;
      break;
   end;
   alpha1 = alpha1 / 2;
end;
if (ierror == 3); alpha1 = 0; end;
nf1 = itcnt;

if (nargout == 7)
  dfdp = dot(gt, p);
  varargout{1} = dfdp;
end
