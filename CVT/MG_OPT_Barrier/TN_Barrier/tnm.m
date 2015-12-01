function [xstar, f, g, ierror, varargout] = tnm (x,sfun,low,up,maxiter)
%---------------------------------------------------------
% this routine solves:  minimize f(x): MULTIGRID VERSION
%
% parameters:
%
% ierror  <-  error code
%             ( 0 => normal return)
%             ( 2 => more than maxfun evaluations)
%             ( 3 => line search failed (may not be serious)
%             (-1 => error in input parameters)
% x        -> initial estimate of the solution
% sfun     -> function routine: [f,g] = sfun(x)
% maxiter  -> maximum # of outer iterations
% xstar   <-  computed solution
% g       <-  final value of the gradient
% f       <-  final value of the objective function
%
% This function sets up the parameters for lmqn. They are:
% maxfun   -  maximum allowable number of function evaluations
% stepmx   -  maximum allowable step in the linesearch
% accrcy   -  accuracy of computed function values
% maxit    -  maximum number of inner iterations per step
%---------------------------------------------------------
% usage: [xstar, f, g, ierror] = tn (x)
%---------------------------------------------------------
global tn_max_maxit tn_maxfun miu upper lower ipivot
%---------------------------------------------------------
if (isempty(tn_max_maxit))
  max_maxit=50;
else
  max_maxit = tn_max_maxit;
end;
n      = length(x);
maxit  = 1 + round((n+1)/2);
if (exist('max_maxit'))
  maxit  = min(max_maxit, maxit);
else
  maxit  = min(50, maxit);
end;
if (isempty(tn_maxfun))
  maxfun = 150*n;
else
  maxfun = tn_maxfun;
end
stepmx = 10;
accrcy = 100*eps;
%---------------------------------------------------------
miu=0;
[f, g, F, G] = feval (sfun, x);
if(lower)
    q=1./(x-low);
elseif(upper)
    q=-1./(up-x);
else
    q=[1./(x-low);-1./(up-x)];
end
miu=norm(g,2)*10/norm(q,2);
%---------------------------------------------------------
itba=0;
while(itba<=0)
        miu=miu/10;
   [xstar, f, g, F, G, ierror,ipivot, eig_val] ...
           = lmqnm (x, sfun,low, up, maxiter, maxit, maxfun, stepmx, accrcy,miu);

    g = ztime (g, ipivot);
    gnorm = norm(g,inf);
    fprintf('f=%.8e   gnorm=%.1e    penalty=%.1e   it=%i\n',f, gnorm, miu ,itba);
        conv = cnvtem_outer(xstar,low,up,sfun);
    if(conv)
        break;
    end
    itba=itba+1;
end

if (nargout == 5)
  varargout{1} = eig_val;
end
