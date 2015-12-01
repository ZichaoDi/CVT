function [xstar, f, g, ierror] = ...
    lmqn (x, sfun, maxit, maxfun, stepmx, accrcy)
%---------------------------------------------------------
% truncated-newton method for unconstrained minimization
% (customized version)
%---------------------------------------------------------
global hyk ykhyk hyr yksr ykhyr yrhyr sk yk sr yr ...
    hg gsk yksk yrsr
global NF N current_n convergence fiter itertest
global XY XYbd xs 
%---------------------------------------------------------
% set up
%---------------------------------------------------------
format compact
format short e
fprintf(1,'  it     nf     cg           f             |g|\n')
upd1 = 1;
ncg  = 0;
nind = find(N==current_n);
xnorm  = norm(x,'inf');
ierror = 0;
if (stepmx < sqrt(accrcy) | maxfun < 1);
    ierror = -1;
    xstar = x;
    return;
end;
%---------------------------------------------------------
% compute initial function value and related information
%---------------------------------------------------------
[f, g] = feval (sfun, x);
oldf   = f;
Hess=cell(15,1);
GS=cell(15,1);
fiter(1)=oldf;
% Hess{1}=Hessian_sim(x);
% GS{1}=g;
gnorm  = norm(g,'inf');
nf     = 1;
nit    = 0;
itertest(1)=nf+ncg;
fprintf(1,'%4i   %4i   %4i   % .8e   %.1e\n', ...
    nit, nf, ncg, f, gnorm)
%---------------------------------------------------------
% check for small gradient at the starting point.
%---------------------------------------------------------
ftest = 1 + abs(f);
if (gnorm < .01*sqrt(eps)*ftest);
    ierror = 0;
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
toleps = sqrt(accrcy) + sqrt(eps);
rtleps = accrcy + eps;
difnew = 0;
epsred = .05;
fkeep  = f;
conv   = 0;
ireset = 0;
ipivot = 0;

%---------------------------------------------------------
% initialize diagonal preconditioner to the identity
%---------------------------------------------------------
d   =  ones(n,1);
%---------------------------------------------------------
% ..........main iterative loop..........
%---------------------------------------------------------
% compute search direction
%---------------------------------------------------------
argvec = [accrcy gnorm xnorm];
[p, gtp, ncg1, d, eig_val] = ...
    modlnp (d, x, g, maxit, upd1, ireset, 0, ipivot, argvec, sfun);
ncg = ncg + ncg1;
oldx=x;
 mov(1:1000) = struct('cdata',[],'colormap',[]);
 set(gca,'NextPlot','replacechildren');
while (~conv);
%%++++++++++++++++++++++++++++++++++++++error damping plot
       xs=XY{1};
       xxs=reshape(xs,110,1);

%        load vs253;
%        xs=vs253;
%     xs=[xs,XYbd{1}];
     vs=reshape(x,2,N(1));
%     error=sqrt(erro(1,:).^2+erro(2,:).^2);
%     figure(99);plot(1:N(1),error,'r.-');
%     for i=1:N(1); text(i,error(i),num2str(i),'Fontsize',18);end
%     pause;
%     vs=[vs,XYbd{1}];
          figure(111);
          plot(vs(1,:),vs(2,:),'ro',xs(1,:),xs(2,:),'b*');
         for iii=1:length(vs)
             text(vs(1,iii),vs(2,iii),num2str(iii),'FontSize',18);
         end
%     e3=sqrt((xs(1,:)-vs(1,:)).^2+(xs(2,:)-vs(2,:)).^2);
%     xtt = xs(1,:);
%     ytt = xs(2,:);
%     gridDelaunay = delaunay(xtt,ytt);
%      figure(122);
%      plot(1:N(1),xs'-x,'r.-')
 %    pause;
%     trimesh(gridDelaunay,xtt,ytt,e3);
% %     hold on;
% %      for it=1:N(1)
% %       text(vs(1,it),vs(2,it),num2str(it),'FontSize',18);
% %      end
% %  hold off;
% %     figure(123);
% %     plot(1:length(e3),e3,'r.-')
%       pause;
%     mov(nit+1) = getframe;
    %%++++++++++++++++++++++++++++++++++++++++++++++++++++++
    oldg   = g;
    pnorm  = norm(p,'inf');
    oldf   = f;
    fiter(nit+2)=oldf;
    itertest(nit+2)=nf+ncg;
%     Hess{nit+2}=Hessian_sim(x);
%     GS{nit+2}=g;
%     save Hess Hess;
%     save GS GS;
    
    %---------------------------------------------------------
    % line search
    %---------------------------------------------------------
    pe     = pnorm + eps;
    spe    = stepmx/pe;
    alpha0 = step1 (f, gtp, spe);
    oldx=x;
    [x, f, g, nf1, ierror, alpha] = lin1 (p, x, f, alpha0, g, sfun);
    err(nit+1)=norm(x-oldx);
    save err err;
    nf = nf + nf1;
    %---------------------------------------------------------
    nit = nit + 1;
    gnorm = norm(g,'inf');
    fprintf(1,'%4i   %4i   %4i   % .8e   %.1e\n', ...
        nit, nf, ncg, f, gnorm)
    if (ierror == 3);
        if isempty(ncg); ncg = 0; end;
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
        xstar = x;
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
    difnew = oldf - f;
    if(nit==1) dif0=difnew;end
    yk     = g - oldg;
    sk     = alpha*p;
    if (icycle == 1);
        if (difnew >   2*difold); epsred =   2*epsred; end;
        if (difnew < 0.5*difold); epsred = 0.5*epsred; end;
    end;
    %---------------------------------------------------------
    % convergence test
    %---------------------------------------------------------
    conv = (alpha*pnorm < toleps*(1 + xnorm) ...
        & abs(difnew) < rtleps*ftest     ...
        & gnorm < accrcy^(1/3)*ftest)    ...
        | gnorm < .01*sqrt(accrcy)*ftest;
    %+++++++++++++++++++++++++++++++++++++++++++++++++++
%      conv = (gnorm < 1d-12*ftest);
    %+++++++++++++++++++++++++++++++++++++++++++++++++++
    if (conv);
        convergence = (difnew/dif0)^(1/(nit));
        fprintf('convergence rate=%f\n',convergence);
        ierror = 0;
        xstar = x;
        NF(1,nind) = NF(1,nind) + nit;
        NF(2,nind) = NF(2,nind) + nf;
        NF(3,nind) = NF(3,nind) + ncg;
                 mov1000=mov(1:nit+1);
                 save mov1000 mov1000
        %         save ee ee;
        return;
    end;
    %dif0=difnew;
    %---------------------------------------------------------
    % update lmqn preconditioner
    %---------------------------------------------------------
    yksk = yk'*sk;
    ireset = (icycle == n-1 | difnew < epsred*(fkeep-f));
    if (~ireset);
        yrsr = yr'*sr;
        ireset = (yrsr <= 0);
    end;
    upd1 = (yksk <= 0);
    %---------------------------------------------------------
    % compute search direction
    %---------------------------------------------------------
    argvec = [accrcy gnorm xnorm];
    [p, gtp, ncg1, d, eig_val] = ...
        modlnp (d, x, g, maxit, upd1, ireset, 0, ipivot, argvec, sfun);
    ncg = ncg + ncg1;
    %---------------------------------------------------------
    % store information for lmqn preconditioner
    %---------------------------------------------------------
    if (ireset);
        sr = sk;
        yr = yk;
        fkeep = f;
        icycle = 1;
    else
        sr = sr + sk;
        yr = yr + yk;
        icycle = icycle + 1;
    end;
end;
