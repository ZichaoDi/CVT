function gv = gtims (v, x, g, ipivot, accrcy, xnorm, sfun,miu)
%%%%%%%%%%%%%%%%%##################
global upper lower v_low v_up
%global A current_star
%%%%%%%%%%%%%%%%%##################
%---------------------------------------------------------
% compute the product of the Hessian times the vector v;
% store result in the vector gv 
% (finite-difference version)
%---------------------------------------------------------
%%%%%%%%%%%%%%%%%##################
%%##  delta   = sqrt(accrcy)*(1 + xnorm);
%delta   = sqrt(accrcy)*(1 + xnorm)/norm(v);
delta = sqrt(eps);
hg      = x + delta*v;
%%%%%%%%%%%%%%%%%##################
%ind=find(ipivot==0);
ind=1:length(x);
[f, gv] = feval (sfun, x);
[f1, gv1] = feval (sfun, hg);
gvo      = (gv1 - gv)/delta;
%%%%%%%######################################################
% G_testv=(Gv1-Gv)/delta;
%  g_testv=A*v;
% error=(A*(x + delta*v)-A*x)/delta-A*v;
% error1=(A*(x)-A*x + delta.*A*(v))./delta-A*v;
% error2=(A*(x)+ A*(delta.*v)-A*x )./delta-A*v;
% err=norm(abs(error)./(1+abs(A*v)),inf)
% err1=norm(abs(error1)./(1+abs(A*v)),inf)
% err2=norm(abs(error2)./(1+abs(A*v)),inf)

%%%%%%%######################################################
BG=zeros(size(x));
if(upper&~lower)
    BG(ind)=miu*v(ind)./((v_up(ind)-x(ind)).^2);
elseif(lower&~upper)
    BG(ind)=miu*v(ind)./((x(ind)-v_low(ind)).^2);
else
    BG(ind)=miu*(v(ind)./((x(ind)-v_low(ind)).^2)+v(ind)./(v_up(ind)-x(ind)).^2);
end
gv      = gvo+BG;
% %########################################################
% BGexact=BG+v.*(2*miu*x.^2+2*miu*ones(length(x),1))./(x.^2-1).^2;
% gvex=gvo+BGexact;
%  exactb=abs(gvex);
% % errorb=abs(G_testv-gvex);
% % figure(12);plot(1:length(x),G_testv,'ro-',1:length(x),gv,'b.-');
%  errorb1=abs(gv-gvex);
% % errb=norm(errorb./(1+exactb),inf)
% errb1=norm(errorb1./(1+exactb),inf)
% % pause;