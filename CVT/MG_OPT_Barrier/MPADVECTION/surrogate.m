function [res_lb,res_ub,sa,sc,sna,snc]=surrogate(N)
global bounds_con
if(bounds_con==0)
res_lb=[];res_ub=[];
else
res_lb=zeros(N,1);res_ub=zeros(N,1);
end
sa=[];
sc=[];
%sc=zeros(2*N,1);
sna=[];snc=[];
