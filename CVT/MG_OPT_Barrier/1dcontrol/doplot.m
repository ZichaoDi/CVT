function doplot(it,v)
%-------------------------------------------------------
% Plot solution at iteration "it", based on current
% values of the parameters "v"
%-------------------------------------------------------
% Usage: doplot(it,v)
%-------------------------------------------------------
global X  N current_n ustar
%-------------------------------------------------------
j = find(N==current_n);
x = X(1:N(j),j);
%-------------------------------------------------------

figure(1);% subplot(3,3,it+1);
plot(x,v); 
% subplot(3,3,it+2);
% plot(x,ustar{1});
T = sprintf('MG %1i',it);
title(T);

