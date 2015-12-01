function gv = mv_product (v, x, sfun,miu)
%%%%%%%%%%%%%%%%%##################
global upper lower v_low v_up
%%%%%%%%%%%%%%%%%##################
%---------------------------------------------------------
% compute the product of the Hessian times the vector v;
% store result in the vector gv 
% (finite-difference version)
%---------------------------------------------------------
%%%%%%%%%%%%%%%%%##################
delta = sqrt(eps);
hg      = x + delta*v;
%%%%%%%%%%%%%%%%%##################
[f, gv, F, G] = feval (sfun, x);
[f1, gv1, F1, G1] = feval (sfun, hg);
gv      = (gv1 - gv)/delta;

if(upper&~lower)
    BG=miu*v./(v_up-x).^2;
elseif(lower&~upper)
    BG=miu*v./(x-v_low).^2;
else
    BG=miu*(v./(x-v_low).^2+v./(v_up-x).^2);
end
gv      = gv+BG;

%########################################################
