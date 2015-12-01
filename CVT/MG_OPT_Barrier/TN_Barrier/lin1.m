function [xnew, fnew, gnew, nf1, ierror, alpha1, varargout] = ...
    lin1 (p, x, f, alpha, g, sfun)
global bounds
%---------------------------------------------------------
% line search (naive)
%---------------------------------------------------------

ierror = 3;
xnew   = x;
fnew   = f;
gnew   = g;
maxit  = 15;
if (alpha == 0); ierror = 0; maxit = 1; end;
alpha1 = alpha;
%---------------------------------------------------------
% line search
%---------------------------------------------------------
for itcnt = 1:maxit;
    xt = x + alpha1.*p;
    [ft, gt,Ft,Gt] = feval (sfun, xt);
    if (Ft < f);
        ierror = 0;
        xnew   = xt;
        fnew   = Ft;
        gnew   = Gt;
        break;
    end;
    alpha1 = alpha1 ./ 2;
end;
if (ierror == 3); alpha1 = 0; end;
nf1 = itcnt;

if (nargout == 7)
    dfdp = dot(gt, p);
    varargout{1} = dfdp;
end