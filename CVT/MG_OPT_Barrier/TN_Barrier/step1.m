function spe = step1 (x,p,low,up)
%---------------------------------------------------------
% Initialization of alpha
%---------------------------------------------------------
al=1;
au=1;
delta=0.98;
% %%------------------------------------------------
indu = find(p > 0);
if (length(indu) > 0);
   tu   = up (indu) - x(indu);
   [au,ind]   = min(tu./p(indu));
end;
% %%------------------------------------------------
indl = find( p < 0);
if (length(indl) > 0);
   tl   = low(indl) - x(indl);
   [al,ind]   = min(tl./p(indl));
end;
spe  = min([1 delta*al delta*au]);
