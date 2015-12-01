function doplot(it,v)
%-------------------------------------------------------
% Plot solution at iteration "it", based on current
% values of the parameters "v"
%-------------------------------------------------------
% Usage: doplot(it,v)
%-------------------------------------------------------
global X U N current_n v_low v_up
%-------------------------------------------------------
j = find(N==current_n);
x = X(1:N(j),j);
%-------------------------------------------------------
%return

figure(1); %subplot(it,1,it);

%[u,dx,dt] = advect_getu(x, v, v_low, v_up);

plot(x,v); 

T = sprintf('MG %1i',it);
title(T);

