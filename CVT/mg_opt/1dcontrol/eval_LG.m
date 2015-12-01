function Gv=eval_LG(grad,v,Aeq,A,lambda);
% Gv=grad+A'*lambda.ineqlin;%+lambda.lower+lambda.upper;
Gv=grad-lambda.lower+lambda.upper;
%Gv=grad;