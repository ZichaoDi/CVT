function [ax,cx]=eval_licon(Aeq,beq,A,b,v);
global bounds_con
if(bounds_con==0)
cx=A*v-b;
else
ax=[];
cx=[];
end