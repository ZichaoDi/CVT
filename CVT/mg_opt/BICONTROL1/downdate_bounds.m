function [bound_H]=downdate_bounds(bound);
%%--------------downdate bound constraint by the same way as variables;
res=1;
bound_H = downdate_variable(bound,res);