function plot_evalgrad
global nn fiter itertest ;
% clf;
%   load AA1025;
%   load fstar1025
% F=fstar1025;
%  AAA=AA1025;
%   fiter=AAA(:,4);itertest=AAA(:,2)+AAA(:,3);%/10^3
%   F=F*1e-4;
opt;
% save fiter fiter;
% save itertest itertest
% save F F;
% load fiter;
% load itertest
% load F
%  fs1s1025=F;
%  save fs1s1025 fs1s1025
error_opt=fiter-F;
iter_opt=itertest;
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
% tt=2;mg_con; [f,g]=sfun(v);[f0,g0]=sfun(v0);fvmg_con(1)=f0;gvmg_con(1)=norm(g0,inf);iterg_con(1)=1;fvmg_con(2)=f;gvmg_con(2)=norm(g,inf); iterg_con(2)=0;
% for j=1:length(N)
% iterg_con(2)=iterg_con(2)+NF_con(j)/(4^(j-1));
% end
% while(tt<=20)
%     tt=tt+1;mgit_con;[f,g]=sfun(v);fvmg_con(tt)=f;gvmg_con(tt)=norm(g,inf);
%     iterg_con(tt)=0;
%     for j=1:length(N)
%         iterg_con(tt)=iterg_con(tt)+NF_con(j)/(4^(j-1));
%     end
%     if(norm(fvmg_con(tt)-F)<=1e-10);break;end
% end 
% error_mg_con=fvmg_con-F;
% %%------------------------------------------------------------------------
%%%------------------------------------------------------------------------
tt=2;mg; [f,g]=sfun(v);[f0,g0]=sfun(v0);fvmg(1)=f0;gvmg(1)=norm(g0,inf);iterg(1)=1;fvmg(2)=f;gvmg(2)=norm(g,inf); iterg(2)=0;
for j=1:length(N)
iterg(2)=iterg(2)+sum(NF(2:3,j))/(2^(j-1));
end
while(tt<=7)
    tt=tt+1;
    mgit;
    [f,g]=sfun(v);fvmg(tt)=f;gvmg(tt)=norm(g,inf);
    iterg(tt)=0;
    for j=1:length(N)
        iterg(tt)=iterg(tt)+sum(NF(2:3,j))/(2^(j-1));
    end
    if(fvmg(tt)-F<=1e-9);break;end
end 
error_mg=fvmg-F;
%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
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
% error_mgf=fvmgf-F;
% eval_graph = findobj('Tag', 'MG vs. OPT');
% if (isempty(eval_graph))
%  eval_graph = figure('Tag', 'MG vs. OPT', ...
% 					  'IntegerHandle', 'off', ...
% 					  'Name', 'MG vs. OPT', ...
% 					  'Numbertitle', 'off', ...
% 					  'Visible', 'off');
%                   else
%   figure(eval_graph);
% end
figure('Name','MG vs.OPT','NumberTitle','off');
semilogy(iterg,error_mg,'r*-');text(iterg(end),error_mg(end),' \leftarrow MG/OPT','FontSize',18);
hold on;
semilogy(iter_opt,error_opt,'b+-');text(iter_opt(end),error_opt(end),' \leftarrow OPT','FontSize',18);
% hold on;
% semilogy(itergf,error_mgf,'go-');text(itergf(end),error_mgf(end),' \leftarrow FMG_tn','FontSize',18);
% hold on;
%semilogy(iterg_con,error_mg_con,'g.-');text(iterg_con(end),error_mg_con(end),' \leftarrow MG_fmincon','FontSize',18);
xlabel('fine level gradient evaluations');
ylabel('error of objective function value');
title({['performance of mg vs.opt: MP-Advection problem with bound constraint'];['variable size:',int2str(N(1))];...
    ['level discretization:',mat2str(N)];['MG\TN:smoothing iteration number:1\coarsest level smoothing iteration:25'];['MG\FMIN:smoothing iteration number:25\coarsest level smoothing iteration:200'];date});