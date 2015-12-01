function [F, G] = sfun_mg (v)
%--------------------------------------------------------------
% compute objective function and gradient [residual form]
%--------------------------------------------------------------
global current_fnl it hx
%--------------------------------------------------------------
[F,G] = sfun(v);

F     = F - v'*current_fnl;
G     = G - current_fnl;

