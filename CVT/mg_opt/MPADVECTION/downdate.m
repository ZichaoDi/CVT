function vH = downdate (vh, res_prob)

%-----------------------------------------
% Downdate to a smaller problem.
%

global X U N current_n

%--------------------------------------------------------------

j  = find(N==current_n);
%%%%%%%%%%%%==========================================
% for i=1:N(j+1)
%     vH(i)=vh(2*i-1)/2+vh(2*i)+vh(2*i+1)/2;
% end
% vH=vH';%1/2*
%%%%%%%%%%%%==========================================
xh = X(1:N(j),j);
xH = X(1:N(j+1),j+1);

nh = N(j);
nH = N(j+1);

%%%%####

%vH = interp1(xh,vh,xH);
%return

%%%%####

if (nh ~= 2*nH-1)
   error('WRONG FORMULA FOR DOWNDATE')
   if (nh == 4*nH-3);
      nhH = 2*nH-1;
      vhH = zeros(nhH,1);
      vH  = zeros(nH,1);
      for i = 1:nhH
         vhH(i) = vh(2*i-1);
      end
      for i = 2:2:nh
         vhH(i/2)     = vhH(i/2)     + 0.5 * vh(i);
         vhH(i/2 + 1) = vhH(i/2 + 1) + 0.5 * vh(i);
      end
      
      for i = 1:nH
         vH(i) = vH(i) + vhH(2*i-1);
      end
      for i = 2:2:nhH
         vH(i/2)     = vH(i/2)     + 0.5 * vhH(i);
         vH(i/2 + 1) = vH(i/2 + 1) + 0.5 * vhH(i);
      end 
      
      vH = 0.25*vH;

      return
   else
      exit ('Mesh refinement must be by a factor of 2');
   end
end

vH = zeros(nH,1);

%-----------------------------------------------------
% const X adjoint of linear interpolation

% if(res_prob==3)
% vH=vh(1:2:end);
% else
for i = 1:nH
  vH(i) = vH(i) + vh(2*i-1);
end

for i = 2:2:nh
  vH(i/2)     = vH(i/2)     + 0.5*vh(i);
  vH(i/2 + 1) = vH(i/2 + 1) + 0.5*vh(i);
end

vH =0.5*vH;% 
%end2/3*


return;
%-----------------------------------------------------

%-----------------------------------------------------
%disp('nh=2nH-3');
vH(1) = 0.5*(vh(1) + vh(2));
vH(1) = 0;
for i = 2:nH-1
  vH(i) = 0.25 * (vh(2*i-3) + 2*vh(2*i-2) + vh(2*i-1));
end
vH(nH) = 0.5*(vh(nh-1) + vh(nh));
vH(nH) = 0;

return;

