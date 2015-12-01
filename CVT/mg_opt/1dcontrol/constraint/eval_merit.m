function [Fvmg,Gvmg]=eval_merit(F,G,v,Aeq,beq,A,b,output,lambda);
Fvmg=F+(Aeq*v-beq)'*lambda.eqlin+output.constrviolation/2*(Aeq*v-beq)'*(Aeq*v-beq);%+(A*v-b)'*lambda.ineqlin+output.constrviolation/2*(A*v-b)'*(A*v-b);
Gvmg=G+Aeq'*lambda.eqlin+output.constrviolation*Aeq'*(Aeq*v-beq);%+A'*lambda.ineqlin+output.constrviolation*A'*(A*v-b);