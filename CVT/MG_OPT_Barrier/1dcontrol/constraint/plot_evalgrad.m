function plot_evalgrad
global nn fiter itertest ;
% clf;
 load AB257;
load fb257
F=fb257;
AAA=AB257;
 fiter=AAA(:,3);itertest=AAA(:,2);
%opt;
% save fiter fiter;
% save itertest itertest
% save F F;
% load fiter;
% load itertest
% load F
error_opt=abs(fiter-F);
iter_opt=itertest;
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
tt=2;mg_con; [f,g]=sfun(v);[f0,g0]=sfun(v0);fvmg_con(1)=f0;gvmg_con(1)=norm(g0,inf);iterg_con(1)=1;fvmg_con(2)=f;gvmg_con(2)=norm(g,inf); iterg_con(2)=0;
for j=1:length(N)
iterg_con(2)=iterg_con(2)+NF_con(j)/(2^(j-1));
end
while(tt<=5)
    tt=tt+1;mgit_con;[f,g]=sfun(v);fvmg_con(tt)=f;gvmg_con(tt)=norm(g,inf);
    iterg_con(tt)=0;
    for j=1:length(N)
        iterg_con(tt)=iterg_con(tt)+NF_con(j)/(2^(j-1));
    end
    if(norm(fvmg_con(tt)-F)<=1e-10);break;end
end 
error_mg_con=abs(fvmg_con-F);
% %%------------------------------------------------------------------------
%%%------------------------------------------------------------------------
% tt=2;mg; [f,g]=sfun(v);[f0,g0]=sfun(v0);fvmg(1)=f0;gvmg(1)=norm(g0,inf);iterg(1)=1;fvmg(2)=f;gvmg(2)=norm(g,inf); iterg(2)=0;
% for j=1:length(N)
% iterg(2)=iterg(2)+sum(NF(2:3,j))/(4^(j-1));
% end
% while(tt<=11)
%     tt=tt+1;mgit;[f,g]=sfun(v);fvmg(tt)=f;gvmg(tt)=norm(g,inf);
%     iterg(tt)=0;
%     for j=1:length(N)
%         iterg(tt)=iterg(tt)+sum(NF(2:3,j))/(4^(j-1));
%     end
%     if(norm(fvmg(tt)-F)<=1e-10);break;end
% end 
% error_mg=fvmg-F;
% %%-------------------------------------------------------------------------
% %%-------------------------------------------------------------------------
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
%     if(norm(fvmgf(tt)-F)<=1e-10);break;end
% end 
% error_mg=fvmg-F;
% error_mgf=fvmgf-F;
figure('Name','MG vs.OPT','NumberTitle','off');
% semilogy(iterg,error_mg,'r*-');text(iterg(end),error_mg(end),' \leftarrow MG_tn','FontSize',18);
% hold on;
semilogy(iter_opt,error_opt,'b+-');text(iter_opt(end),error_opt(end),' \leftarrow OPT_fmincon','FontSize',18);
hold on;
% semilogy(itergf,error_mgf,'go-');text(itergf(end),error_mgf(end),' \leftarrow FMG_tn','FontSize',18);
% hold on;
semilogy(iterg_con,error_mg_con,'g.-');text(iterg_con(end),error_mg_con(end),' \leftarrow MG_fmincon','FontSize',18);
xlabel('fine level gradient evaluations');
ylabel('error of objective function value');
title({['performance of mg vs.opt: 1d-control problem with constraint'];['variable size:',int2str(N(1))];...
    ['level discretization:',mat2str(N)];['MG\TN:smoothing iteration number:1\coarsest level smoothing iteration:25'];['MG\FMIN:smoothing iteration number:25\coarsest level smoothing iteration:50'];date});