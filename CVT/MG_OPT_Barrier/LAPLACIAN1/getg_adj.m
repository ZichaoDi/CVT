function g = getg_adj(v)
%-----------------------------------------------------
% Compute the gradient g(v) via an adjoint calculation
%-----------------------------------------------------
% Usage: g = p_getg(v)
%-----------------------------------------------------
% MODIFIED: 04/18/06
%----------------------------------------------
global B1023 B511 B255 B127 B63 B31 B15 B7
global b1023 b511 b255 b127 b63 b31 b15 b7
%----------------------------------------------
n = length(v);
if (n==1023);
   B = B1023;
   b = b1023;
end;
if (n==511);
   B = B511;
   b = b511;
end;
if (n==255);
   B = B255;
   b = b255;
end;
if (n==127);
   B = B127;
   b = b127;
end;
if (n==63);
   B = B63;
   b = b63;
end;
if (n==31);
   B = B31;
   b = b31;
end;
if (n==15);
   B = B15;
   b = b15;
end;
if (n==7);
   B = B7;
   b = b7;
end;

h = 1/(n-1); 
h = 1;
% g = 100 * h * (B*v - b);
g = (B*v - b)*h;
