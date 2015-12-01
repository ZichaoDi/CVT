function plot_evalgrad
global nn fiter itertest giter;
clf;
load fs253;
fstar=fs253;
opt;
fstar=F;
%fiter=AAA(:,4);giter=AAA(:,5);itertest=sum(AAA(:,2:3),2);
error_opt=fiter-fstar;
iter_opt=itertest;
tt=2;mg; [f,g]=sfun(v);[f0,g0]=sfun(v0);fvmg(1)=f0;gvmg(1)=norm(g0,inf);iterg(1)=1;fvmg(2)=f;gvmg(2)=norm(g,inf); iterg(2)=0;
for j=1:length(N)
iterg(2)=iterg(2)+sum(NF(2:3,j))/(4^(j-1));
end
while(tt<=4)
    tt=tt+1;mgit;[f,g]=sfun(v);fvmg(tt)=f;gvmg(tt)=norm(g,inf);
    iterg(tt)=0;
    for j=1:length(N)
        iterg(tt)=iterg(tt)+sum(NF(2:3,j))/(4^(j-1));
    end
    if(norm(fvmg(tt)-fstar)<=1e-10);break;end
end 
error_mg=fvmg-fstar;
figure('Name','MG vs.OPT','NumberTitle','off');
semilogy(iter_opt,error_opt,'r.-');text(iter_opt(2),error_opt(2),' \leftarrow OPT','FontSize',18);
hold on;
semilogy(iterg,error_mg,'b.-');text(iterg(4),error_mg(4),' \leftarrow MG','FontSize',18);
title(['performance of MG vs.opt:' ,int2str(nn),' generators 2D-CVT,density:uniform;']);
xlabel('fine level gradient evaluations');
ylabel('error of objective function value');
end