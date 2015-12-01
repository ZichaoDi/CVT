function vh = update_foo (vH)

%--------------------------------------------------------------
% Update to a larger problem
%

global N current_n

%--------------------------------------------------------------

j     = find(N==current_n);
nh = N(j);
nH = N(j+1);

vh = zeros(nh,1);

%-----------------------------------------------------
% Linear interpolation

for i = 1:nH
  vh(2*i-1) = vH(i);
end

for i = 2:2:nh
  vh(i) = 0.5 * (vH(i/2) + vH(i/2 + 1));
end

return;
