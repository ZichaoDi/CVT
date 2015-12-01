function plot_evalgrad
clear all;
global nn fiter itertest spec_bd;
% clf;
%load fs575u15;
% load fmins1151
% F=fmins1151;
% % load fs2s1151;
%fs=fs575u15;
% % %%-------------------------------------------------------------------------
% % %%#########################################################################
% load ACT15U;
%  AAA=ACT15U;
% fiter=AAA(:,3);itertest=AAA(:,2);
 opt;
 fs=F;
error_opt=abs(fiter-fs);
iter_opt=itertest;
%%-------------------------------------------------------------------------
% tt=2;mg_con; [f,g]=sfun(v);[f0,g0]=sfun(v0);fvmg_con(1)=f0;
% gvmg_con(1)=norm(g0,inf);iterg_con(1)=1;fvmg_con(2)=f;gvmg_con(2)=norm(g,inf); iterg_con(2)=0;
% for j=1:length(N)
% iterg_con(2)=iterg_con(2)+NF_con(j)/(2^(j-1));
% end
% while(tt<=10)
%     tt=tt+1;
%     mgit_con;[f,g]=sfun(v);fvmg_con(tt)=f;gvmg_con(tt)=norm(g,inf);
%     iterg_con(tt)=0;
%     for j=1:length(N)
%         iterg_con(tt)=iterg_con(tt)+NF_con(j)/(2^(j-1));
%     end
%     if(fvmg_con(tt)-fs<=1e-10);break;end
% end 
% error_mg_con=abs(fvmg_con-F);
%%------------------------------------------------------------------------
%%%------------------------------------------------------------------------
% %%%mg
tt=2;mg; [f,g]=sfun(v);[f0,g0]=sfun(v0);fvmg(1)=f0;
gvmg(1)=norm(g0,inf);iterg(1)=1;fvmg(2)=f;gvmg(2)=norm(g,inf); iterg(2)=0;
for j=1:length(N)
iterg(2)=iterg(2)+sum(NF(2:3,j))/(2^(j-1));
end
while(tt<=70)
    tt=tt+1;mgit;[f,g]=sfun(v);fvmg(tt)=f;gvmg(tt)=norm(g,inf);
    iterg(tt)=0;
    for j=1:length(N)
        iterg(tt)=iterg(tt)+sum(NF(2:3,j))/(2^(j-1));
    end
    if(fvmg(tt)-fs<=1e-10);break;end
end 
error_mg=abs(fvmg-fs);
% % %%-------------------------------------------------------------------------
% %%-----------------------------------------------------------------------
% --fmg
% tt=2;fmg; [f,g]=sfun(v);[f0,g0]=sfun(v0);fvmgf(1)=f0;gvmg(1)=norm(g0,inf);itergf(1)=1;fvmgf(2)=f;gvmg(2)=norm(g,inf); itergf(2)=0;
% for j=1:length(N)
% itergf(2)=itergf(2)+sum(NF(2:3,j))/(4^(j-1));
% end
% while(tt<=11)
%     tt=tt+1;mgit;[f,g]=sfun(v);fvmgf(tt)=f;gvmg(tt)=norm(g,inf);
%     itergf(tt)=0;
%     for j=1:length(N)
%         itergf(tt)=itergf(tt)+sum(NF(2:3,j))/(4^(j-1));
%     end
%     if(norm(fvmgf(tt)-fs)<=1e-10);break;end
% end 
% error_mg=fvmg-F;
% error_mgf=fvmgf-F;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','MG vs.OPT','NumberTitle','off');
semilogy(iterg,error_mg,'r*-');text(iterg(end),error_mg(end),' \leftarrow MG-tn','FontSize',18);hold on;
semilogy(iter_opt(1:end),error_opt(1:end),'b*-');text(iter_opt(end),error_opt(end),' \leftarrow OPT','FontSize',18);

hold on;
% semilogy(itergf,error_mgf,'go-');text(itergf(end),error_mgf(end),' \leftarrow FMG-tn','FontSize',18);
 hold on;
%semilogy(iterg_con(1:end),error_mg_con(1:end),'g.-');text(iterg_con(end),error_mg_con(end),' \leftarrow MG-fmincon','FontSize',18);
xlabel('fine level gradient evaluations');
ylabel('error of objective function value');
title({['performance of mg vs.opt: unconstrained 1d_control'];['variable size:',int2str(N(1))];...
    ['level discretization:',mat2str(N)];['MG\TN:smoothing iteration number:1\coarsest level smoothing iteration:25'];['MG\FMIN:smoothing iteration number:25\coarsest level smoothing iteration:50'];date});