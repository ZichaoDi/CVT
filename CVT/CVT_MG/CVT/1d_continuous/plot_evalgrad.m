function plot_evalgrad
clear all
close all
global nn fiter itertest giter;
clf; i=9;
    nn=2^i;
    %opt;
load AA512;
load fstar512
AAA=AA512;
F=fstar512;


    fiter=AAA(:,4);giter=AAA(:,5);itertest=sum(AAA(:,2:3),2);
    error_opt=fiter-F;
    iter_opt=itertest;
    tt=2;mg; [f,g]=sfun(v);[f0,g0]=sfun(v0);fvmg(1)=f0;gvmg(1)=norm(g0,inf);iterg(1)=1;fvmg(2)=f;gvmg(2)=norm(g,inf); iterg(2)=0;
    for j=1:length(N)
        iterg(2)=iterg(2)+sum(NF(2:3,j))/(2^(j-1));
    end
    while(tt<=7)
        tt=tt+1;mgit;[f,g]=sfun(v);fvmg(tt)=f;gvmg(tt)=norm(g,inf);
        iterg(tt)=0;
        for j=1:length(N)
            iterg(tt)=iterg(tt)+sum(NF(2:3,j))/(2^(j-1));
        end
        if(norm(fvmg(tt)-F)<=1e-10);break;end
    end
    error_mg=fvmg-F;
    figure('Name','MG vs.OPT','NumberTitle','off');
    
    semilogy(iter_opt,error_opt,'r*-');text(iter_opt(end),error_opt(end),' \leftarrow OPT','FontSize',18);
    hold on;
    semilogy(iterg,error_mg,'bo-');text(iterg(end),error_mg(end),' \leftarrow MG','FontSize',18);
xlabel('fine level gradient evaluations');
    ylabel('error of objective function value');
    title({['performance of MG vs.opt:' ,int2str(nn),' 1D_CVT'];['variable size:',int2str(N(1))];['density:6.*x.^2.*exp(-2*x.^3)'];...
        ['level discretization:',mat2str(N)];['smoothing iteration number:1\coarsest level smoothing iteration:25'];date});%
    