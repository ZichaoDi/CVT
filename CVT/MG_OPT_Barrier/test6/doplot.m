function doplot(it,v)
%-------------------------------------------------------
% Plot solution at iteration "it", based on current
% values of the parameters "v"
%-------------------------------------------------------
% Usage: doplot(it,v)
%-------------------------------------------------------
global N
%-------------------------------------------------------

figure(1);% subplot(3,3,it+1);
plot(1:N,v); 
% subplot(3,3,it+2);
% plot(x,ustar{1});
T = sprintf('MG %1i',it);
title(T);

