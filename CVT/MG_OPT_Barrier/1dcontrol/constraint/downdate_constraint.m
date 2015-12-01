function [eqlin_H,ineqlin_H,eqnonlin_H,ineqnonlin_H]=downdate_constraint(eqlin,ineqlin,eqnonlin,ineqnonlin)
eqlin_H=downdate_variable(eqlin,0);
%ineqlin_H=ineqlin;
ineqlin_H1=downdate_variable(ineqlin(1:end/2),0);
ineqlin_H2=downdate_variable(ineqlin(end/2+1:end),0);
ineqlin_H=[ineqlin_H1;ineqlin_H2];
eqnonlin_H=eqnonlin;
ineqnonlin_H=ineqnonlin;