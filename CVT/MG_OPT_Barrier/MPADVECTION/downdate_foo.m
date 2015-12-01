function vH = downdate_foo (vh)

%-----------------------------------------
% Downdate to a smaller problem.
%

global N current_n

%--------------------------------------------------------------

j  = find(N==current_n);
nh = N(j);
nH = N(j+1);

vH = zeros(nH,1);

%-----------------------------------------------------
% const X adjoint of linear interpolation

for i = 1:nH
  vH(i) = vH(i) + vh(2*i-1);
end

for i = 2:2:nh
  vH(i/2)     = vH(i/2)     + 0.5*vh(i);
  vH(i/2 + 1) = vH(i/2 + 1) + 0.5*vh(i);
end

vH = 0.5*vH;

return;
