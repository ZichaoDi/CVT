function [res_lb,res_ub,sa,sc,sna,snc]=surrogate(N)
res_lb=[];res_ub=[];
sa=zeros(N(1),1);
%sc=[];
sc=zeros(2*N(1),1);
sna=[];snc=[];