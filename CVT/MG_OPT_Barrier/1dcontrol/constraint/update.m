function vh = update (vH, res_prob)

%--------------------------------------------------------------
% Update to a larger problem
%

global X  N current_n

%--------------------------------------------------------------

j     = find(N==current_n);
xh    = X(1:N(j),j);
xH    = X(1:N(j+1),j+1);


vH_y=vH(1:N(j+1));
vH_u=vH(N(j+1)+1:end);
%%%%####

vh_y = interp1(xH,vH_y,xh);
vh_u = interp1(xH,vH_u,xh);
vh=[vh_y;vh_u];

return

