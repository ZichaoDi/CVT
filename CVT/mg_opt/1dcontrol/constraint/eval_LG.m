function Gv=eval_LG(grad,v,Aeq,A,lambda);
Gv=grad-Aeq'*lambda.eqlin-A'*lambda.ineqlin;