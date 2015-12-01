function [xstar, f, g, F, G, ierror,ipivot, eig_val] ...
           = lmqnm (x, sfun,low, up, maxiter, maxit, maxfun, stepmx, accrcy,miu)
%---------------------------------------------------------
% truncated-newton method for unconstrained minimization
% (customized version)
%---------------------------------------------------------
global hyk ykhyk hyr yksr ykhyr yrhyr sk yk sr yr ...
       hg gsk yksk yrsr 
global NF N current_n
%---------------------------------------------------------
% set up
%---------------------------------------------------------
format compact
format short e
fprintf(1,'  it     nf     cg           f           |g|\n')
ncg  = 0;
xnorm  = norm(x,'inf');
ierror = 0;
eig_val{1} = [];
if (stepmx < sqrt(accrcy) | maxfun < 1);
  ierror = -1;
  xstar  = x; 
  return;
end;
%---------------------------------------------------------
% compute initial function value and related information
%---------------------------------------------------------
[f, g, F, G] = feval (sfun, x);
oldf   = F;
gnorm  = norm(G,'inf');
nf     = 1;
nit    = 0;
nind   = find(N==current_n);
fprintf(1,'%4i   %4i   %4i   % .8e   %.1e\n', ...
           nit, nf, ncg, F, gnorm)
%---------------------------------------------------------
% check for small gradient at the starting point.
%---------------------------------------------------------
[ipivot, ierror, x] = crash(x, low, up);
ftest = 1 + abs(F);
if (gnorm < .01*sqrt(eps)*ftest);
    ierror = 0;
    xstar  = x;
    NF(1,nind) = NF(1,nind) + nit;
    NF(2,nind) = NF(2,nind) + nf;
    NF(3,nind) = NF(3,nind) + ncg;
    return;
end;
%---------------------------------------------------------
% set initial values to other parameters
%---------------------------------------------------------
n      = length(x);
icycle = n-1;
toleps = sqrt(accrcy) + sqrt(eps);
rtleps = accrcy + eps;
difnew = 0;
epsred = .05;
fkeep  = F;
conv   = 0;
ipivot = 0;
%---------------------------------------------------------
% initialize diagonal preconditioner to the identity
%---------------------------------------------------------
upd1   = 1;
ireset = 0;
d      =  ones(n,1);
%---------------------------------------------------------
% ..........main iterative loop..........
%---------------------------------------------------------
% compute search direction
%---------------------------------------------------------
argvec = [accrcy gnorm xnorm];
[p, gtp, ncg1, d, eig_val{nit+1}] = ...
	modlnp (d, x, g, maxit, upd1, ireset, 0, ipivot, argvec, sfun,miu);
ncg = ncg + ncg1;
while (~conv);
   oldg   = G;
   pnorm  = norm(p,'inf');
   oldf   = F;
%---------------------------------------------------------
% line search
%---------------------------------------------------------
%    pe     = pnorm + eps;
%    spe    = stepmx/pe;
%    alpha  = step1 (f, gtp, spe);
% %
%    [x, f, g, nf1, ierror, alpha] = lin1 (p, x, f, alpha, g, sfun);
 [x, F, G, nf1, ierror, alpha] = lin_Barrier (p, x, F, G, sfun,ipivot);
   nf = nf + nf1;
%---------------------------------------------------------
   nit = nit + 1;
   gnorm = norm(G,'inf');
   fprintf(1,'%4i   %4i   %4i   % .8e   %.1e\n', ...
           nit, nf, ncg, F, gnorm)
   if (ierror == 3);
     if isempty(ncg), ncg = 0; end;
     xstar = x; 
     NF(1,nind) = NF(1,nind) + nit;
     NF(2,nind) = NF(2,nind) + nf;
     NF(3,nind) = NF(3,nind) + ncg;
     return; 
   end;
%---------------------------------------------------------
% stop if more than maxfun evalutations have been made
%---------------------------------------------------------
   if (nf >= maxfun);
     ierror = 2;
     xstar  = x;
     NF(1,nind) = NF(1,nind) + nit;
     NF(2,nind) = NF(2,nind) + nf;
     NF(3,nind) = NF(3,nind) + ncg;
     return;
   end;
%---------------------------------------------------------
% set up for convergence and resetting tests
%---------------------------------------------------------
   ftest  = 1 + abs(f);
   xnorm  = norm(x,'inf');
   difold = difnew;
   difnew = oldf - F;
   yk     = G - oldg;
   sk     = alpha*p;
   if (icycle == 1);
       if (difnew >   2*difold); epsred =   2*epsred; end;
       if (difnew < 0.5*difold); epsred = 0.5*epsred; end;
   end;
%---------------------------------------------------------
% update lmqn preconditioner
%---------------------------------------------------------
   yksk = yk'*sk;
   ireset = (icycle == n-1 | difnew < epsred*(fkeep-F));
   if (~ireset);
       yrsr = yr'*sr;
       ireset = (yrsr <= 0);
   end;
   upd1 = (yksk <= 0);
%---------------------------------------------------------
% convergence test
%---------------------------------------------------------
conv = cnvtem_inner(miu,x,low,up,sfun);
conv =conv | nit   >= maxiter;
   if (conv);
     ierror = 0;
     xstar = x;
     NF(1,nind) = NF(1,nind) + nit;
     NF(2,nind) = NF(2,nind) + nf;
     NF(3,nind) = NF(3,nind) + ncg;
     return;
   end;
%---------------------------------------------------------
% compute search direction
%---------------------------------------------------------
   argvec = [accrcy gnorm xnorm];
   [p, gtp, ncg1, d, eig_val{nit+1}] = ...
	   modlnp (d, x, G, maxit, upd1, ireset, 0, ipivot, argvec, sfun,miu);
   ncg = ncg + ncg1;
%---------------------------------------------------------
% store information for lmqn preconditioner
%---------------------------------------------------------
   if (ireset);
       sr = sk;
       yr = yk;
       fkeep = F;
       icycle = 1;
   else
       sr = sr + sk;
       yr = yr + yk;
       icycle = icycle + 1;
   end;
end;
