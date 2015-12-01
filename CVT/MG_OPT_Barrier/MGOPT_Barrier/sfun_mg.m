function [F, G,FB,GB] = sfun_mg (v)
%--------------------------------------------------------------
% compute objective function and gradient [residual form]
%--------------------------------------------------------------
global current_fnl it hx
%--------------------------------------------------------------
[F,G,FB,GB] = sfun(v);

F     = F - v'*current_fnl;
G     = G - current_fnl;

FB     = FB - v'*current_fnl;
GB     = GB - current_fnl;

