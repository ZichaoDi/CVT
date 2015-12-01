function [eqlin_H,ineqlin_H,eqnonlin_H,ineqnonlin_H]=downdate_constraint(eqlin,ineqlin,eqnonlin,ineqnonlin)
eqlin_H=eqlin;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%=================two sides bound====================
% ineqlin_H=ineqlin;
% ineqlin_H1=downdate_variable(ineqlin(1:end/2),1);
% ineqlin_H2=downdate_variable(ineqlin(end/2+1:end),1);
% ineqlin_H=[ineqlin_H1;ineqlin_H2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%=================one side bound====================
%ineqlin_H=downdate_variable(ineqlin,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%=================no bound==========================
ineqlin_H=ineqlin;
%%%===================================================
eqnonlin_H=eqnonlin;
ineqnonlin_H=ineqnonlin;