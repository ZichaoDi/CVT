function [bound_H]=downdate_bounds(bound);
%%--------------downdate bound constraint by the same way as variables;

bound_H = downdate_variable(bound,1);