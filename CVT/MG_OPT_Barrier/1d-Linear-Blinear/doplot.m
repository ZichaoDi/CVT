function doplot(it,v)
%-------------------------------------------------------
% Plot solution at iteration "it", based on current
% values of the parameters "v"
%-------------------------------------------------------
% Usage: doplot(it,v)
%-------------------------------------------------------
global X  N current_n y
%-------------------------------------------------------
j = find(N==current_n);
x = X(1:N(j)+2,j);
%-------------------------------------------------------

figure(1);
subplot(2,1,1);
vs=[0;v;0];
plot(x,vs,'r.-');  title('control variable')
ys=[0;y;0];
subplot(2,1,2);
plot(x,ys,'b.-'); %title('state variable');
T = sprintf('MG %1i',it);
title(T);

