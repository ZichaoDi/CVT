function vh = update (vH, res_prob)

%--------------------------------------------------------------
% Update to a larger problem
%

global X U N current_n

%--------------------------------------------------------------

j     = find(N==current_n);
if(length(N)==2)
    j=1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IHh=zeros(N(j),N(j+1));
% IHh(1,1)=1/2;
% for i=1:N(j+1)-1
%     IHh(2*i,i)=1;
%     IHh(2*i+1,i)=1/2;IHh(2*i+1,i+1)=1/2;
% end
% IHh(N(j)-1,N(j+1))=1;
% IHh(N(j),N(j+1))=1/2;
% vh=4*IHh*vH;
% return;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xh    = X(1:N(j),j);
xH    = X(1:N(j+1),j+1);

nh = N(j);
nH = N(j+1);

%%%%####

%vh = interp1(xH,vH,xh);
%return

%%%%####

if (nh ~= 2*nH-1)
   error('WRONG FORMULA FOR UPDATE')
   if (nh == 4*nH-3);
      nhH = 2*nH-1;
      
      vh = zeros(nh,1);
      vhH = zeros(nhH,1);
      
      for i = 1:nH
         vhH(2*i-1) = vH(i);
      end

      for i = 2:2:nhH
         vhH(i) = 0.5 * (vH(i/2) + vH(i/2 + 1));
      end
      
      for i = 1:nhH
         vh(2*i-1) = vhH(i);
      end

      for i = 2:2:nh
         vh(i) = 0.5 * (vhH(i/2) + vhH(i/2 + 1));
      end

      return
      
   else
      exit ('Mesh refinement must be by a factor of 2');
   end
end

%v = interp1(xH, v2, xh, 'linear');

vh = zeros(nh,1);

%-----------------------------------------------------
% Linear interpolation

for i = 1:nH
  vh(2*i-1) = vH(i);
end

for i = 2:2:nh
  vh(i) = 0.5 * (vH(i/2) + vH(i/2 + 1));
end

% vh=4*vh;
 
return;


%-----------------------------------------------------

vh(1) = vh(1) + 0.5*vH(1);
vh(2) = vh(2) + 0.5*vH(1);

for i = 2:nH-1
  vh(2*i-3) = vh(2*i-3) + 0.25*vH(i);
  vh(2*i-2) = vh(2*i-2) + 0.5 *vH(i);
  vh(2*i-1) = vh(2*i-1) + 0.25*vH(i);
end

vh(nh-1) = vh(nh-1) + 0.5*vH(nH);
vh(nh)   = vh(nh)   + 0.5*vH(nH);
return;
