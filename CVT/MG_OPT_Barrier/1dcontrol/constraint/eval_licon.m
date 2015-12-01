function [ax,cx]=eval_licon(Aeq,beq,A,b,v);
ax=Aeq*v-beq;
%cx=[];
cx=A*v-b;