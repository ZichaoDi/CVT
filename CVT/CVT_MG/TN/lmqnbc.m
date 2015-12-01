function [xstar, f, g, ierror] = ...
	lmqnbc (x, sfun, low, up, maxit, maxfun, stepmx, accrcy)
%---------------------------------------------------------
% This is a bounds-constrained truncated-newton method.
% The truncated-newton method is preconditioned by a 
% limited-memory quasi-newton method (computed by
% this routine) with a diagonal scaling (routine ndia3).
% For further details, see routine tnbc.
%---------------------------------------------------------
global hyk ykhyk hyr yksr ykhyr yrhyr sk yk sr yr ...
       hg gsk yksk yrsr 
global NF N current_n 
global fiter itertest giter convergence
%---------------------------------------------------------
% check that initial x is feasible and that the bounds 
% are consistent
%---------------------------------------------------------
[ipivot, ierror, x] = crash(x, low, up);
       %%%%%%%%%%%### Check active set ####################################
       indexl=find(ipivot==-1);
       indexu=find(ipivot==1);
       feas=find(ipivot==0);
       %%%%%%%%%%%%%#######################################################
if (ierror ~= 0);
   disp('LMQNBC: termination 0')
   fprintf(1,'LMQNBC: terminating (no feasible point)');
   f = 0;
   g = zeros(size(x));
   xstar = x;
   return;
end;
%---------------------------------------------------------
% initialize variables, parameters, and constants
%---------------------------------------------------------
fprintf(1,'  it     nf     cg           f             |g|\n')
nind   = find(N==current_n);
upd1   = 1;
ncg    = 0;
conv   = 0;
xnorm  = norm(x,'inf');
ierror = 0;
if (stepmx < sqrt(accrcy) | maxfun < 1);
  disp('LMQNBC: termination 1')
  ierror = -1;
  xstar = x; 
  return;
end;
%x=sort(x);
%---------------------------------------------------------
% compute initial function value and related information
%---------------------------------------------------------
[f, g] = feval (sfun, x);
oldf   = f;
gnorm  = norm(g,'inf');
nf     = 1;
nit    = 0;
flast  = f;
%---------------------------------------------------------
% Test if Lagrange multipliers are non-negative.
% Because the constraints are only bounds, the Lagrange
% multipliers are components of the gradient.
% Then form the projected gradient.
%---------------------------------------------------------
ind = find((ipivot ~= 2) & (ipivot.*g>0));
if (length(ind) > 0); 
  ipivot(ind) = zeros(length(ind),1);
end;
       %%%%%%%%%%%### Check active set ####################################
       indexl=find(ipivot==-1);
       indexu=find(ipivot==1);
       feas=find(ipivot==0);
       %%%%%%%%%%%%%#######################################################
g = ztime (g, ipivot);
gnorm = norm(g,'inf');
fprintf(1,'%4i   %4i   %4i   % .8e   %.1e\n', ...
          nit, nf, ncg, f, gnorm)
fiter(nit+1)=f;
giter(nit+1)=norm(g,inf);
itertest(nit+1)=nf+ncg;
%---------------------------------------------------------
% check if the initial point is a local minimum.
%---------------------------------------------------------
ftest = 1 + abs(f);
if (gnorm < .01*sqrt(eps)*ftest);
  disp('LMQNBC: termination 2')
  xstar = x;
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
ireset = 0;
bounds = 1;
difnew = 0;
epsred = .05;
fkeep  = f;
d      = ones(n,1);
%---------------------------------------------------------
% ..........main iterative loop..........
%---------------------------------------------------------
% compute the search direction
%---------------------------------------------------------
argvec = [accrcy gnorm xnorm];
%%%%%%%%%%%%%%%%%%%%%##############################
% x_tran = x'
%%%%%%%%%%%%%%%%%%%%%##############################
[p, gtp, ncg1, d, eig_val] = ...
	modlnp (d, x, g, maxit, upd1, ireset, bounds, ipivot, argvec, sfun);
ncg = ncg + ncg1;
while (~conv);
   oldg = g;
   pnorm = norm(p, 'inf');
   oldf = f;
%---------------------------------------------------------
% line search
%---------------------------------------------------------
   pe = pnorm + eps;
   spe = stpmax (stepmx, pe, x, p, ipivot, low, up);
   alpha = step1 (f, gtp, spe);
   
   %%%%%%%%%%%%##########################################################
%    [ipivot, ierror, x] = crash(x, low, up);
%    alpha=1;
   %%%%%%%%%%%%%########################################################
   alpha0 = alpha;
%
   %######################
   % [x, f, g, nf1, ierror, alpha] = lin1 (p, x, f, alpha0, g, sfun);
   [x_new, f_new, g_new, nf1, ierror, alpha] = lin1 (p, x, f, alpha0, g, sfun);
   %######################
%---------------------------------------------------------
   if (alpha == 0 & alpha0 ~= 0 | ierror == 3);
      
      fprintf('Error in Line Search\n');
      fprintf('    ierror = %3i\n',    ierror);
      fprintf('    alpha  = %12.6f\n', alpha);
      fprintf('    alpha0 = %12.6f\n', alpha0);
      fprintf('    g''p    = %12.4e\n', gtp);
      %############################
      fprintf('    |g|     = %12.4e\n', norm(g));
      fprintf('    |p|     = %12.4e\n', norm(p));
      disp('Hit any key to continue')
      pause
      %############################
   end;
   %#######################
   x   = x_new;
   f   = f_new;
   g   = g_new;
   %#######################
   nf  = nf  + nf1;
   nit = nit +   1;
%---------------------------------------------------------
% update active set, if appropriate
%---------------------------------------------------------
   newcon = 0;
   if (abs(alpha-spe) <= 10*eps);
      newcon = 1;
      ierror = 0;
      [ipivot, flast] = modz (x, p, ipivot, low, up, flast, f, alpha);
   end;
   if (ierror == 3);
      disp('LMQNBC: termination 3')
      xstar = x; 
      NF(1,nind) = NF(1,nind) + nit;
      NF(2,nind) = NF(2,nind) + nf;
      NF(3,nind) = NF(3,nind) + ncg;
      return; 
   end;
%---------------------------------------------------------
% stop if more than maxfun evaluations have been made
%---------------------------------------------------------
   if (nf > maxfun);
      disp('LMQNBC: termination 4')
      ierror = 2;
      xstar = x;
      NF(1,nind) = NF(1,nind) + nit;
      NF(2,nind) = NF(2,nind) + nf;
      NF(3,nind) = NF(3,nind) + ncg;
      return;
   end;
%---------------------------------------------------------
% set up for convergence and resetting tests
%---------------------------------------------------------
   difold = difnew;
   difnew = oldf - f;
   if(nit==1) dif0=difnew;end
   if (icycle == 1);
      if (difnew >  2*difold); epsred =  2*epsred; end;
      if (difnew < .5*difold); epsred = .5*epsred; end;
   end;
   gv    = ztime (g, ipivot);
   gnorm = norm(gv, 'inf');
   ftest = 1 + abs(f);
   xnorm = norm(x,'inf');
   fprintf(1,'%4i   %4i   %4i   % .8e   %.1e\n', ...
          nit, nf, ncg, f, gnorm)
      fiter(nit+1)=f;
      giter(nit+1)=norm(g,inf);
      itertest(nit+1)=nf+ncg;
%---------------------------------------------------------
% test for convergence
%---------------------------------------------------------
   [conv, flast, ipivot] = cnvtst (alpha, pnorm, xnorm, ...
	    difnew, ftest, gnorm, gtp, f, flast, g, ...
	    ipivot, accrcy);
   if (conv);
             convergence = (difnew/dif0)^(1/(nit));
      fprintf('convergence rate=%f\n',convergence);
      disp('LMQNBC: termination 5')
      xstar = x;
      NF(1,nind) = NF(1,nind) + nit;
      NF(2,nind) = NF(2,nind) + nf;
      NF(3,nind) = NF(3,nind) + ncg;
      return;
   end;
   g = ztime (g, ipivot);
%---------------------------------------------------------
% modify data for LMQN preconditioner
%---------------------------------------------------------
   if (~newcon);
      yk = g - oldg;
      sk = alpha*p;
      yksk = yk'*sk;
      ireset = (icycle == n-1 | difnew < epsred*(fkeep-f));
      if (~ireset);
         yrsr = yr'*sr;
         ireset = (yrsr <= 0);
      end;
      upd1 = (yksk <= 0);
   end;
%---------------------------------------------------------
% compute the search direction
%---------------------------------------------------------
   argvec = [accrcy gnorm xnorm];
%%%%%%%%%%%%%%%%%%%%%##############################
% x_tran = x'
%%%%%%%%%%%%%%%%%%%%%##############################
   [p, gtp, ncg1, d, eig_val] = ...
	   modlnp (d, x, g, maxit, upd1, ireset, bounds, ipivot, argvec, sfun);
   ncg = ncg + ncg1;
%---------------------------------------------------------
% update LMQN preconditioner
%---------------------------------------------------------
   if (~newcon);
      if (ireset);
         sr     = sk;
         yr     = yk;
         fkeep  = f;
         icycle = 1;
      else
         sr     = sr + sk;
         yr     = yr + yk;
         icycle = icycle + 1;
      end
   end;
end;
%save fiter itertest
