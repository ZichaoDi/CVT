function [v,lambda]=fmgrid_con(v0,fnl,res_prob,a,sa,c,sc,nonl_eq,sna,nonl_in,snc,res_lb,res_ub);
%--------------------------------------------------
% Full Multigrid algorithm (McCormick, pp. 70-71)
%--------------------------------------------------
% Usage: v = fmgrid(v0,fnl,res_prob)
%--------------------------------------------------
global current_fnl
global N current_n 
global NF_con
global GRAPH_N_OLD GRAPH_INDEX_OLD
%----------------------------------------------------------------------
% UPDATE MULTIGRID GRAPH
%----------------------------------------------------------------------
figure(findobj('Tag', 'multigrid_graph'));
GRAPH_N_NEW = current_n;
IND_OLD = find(N==GRAPH_N_OLD);
IND_NEW = find(N==GRAPH_N_NEW);
plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW]);
plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW],'x');
GRAPH_N_OLD = current_n;
GRAPH_INDEX_OLD = GRAPH_INDEX_OLD+1;
%--------------------------------------------------
n = current_n;

%--------------------------------------------------
current_fnl = fnl;
j           = find(N==current_n);
nmin        = N(end);
%--------------------------------------------------
if (res_prob);
  myfun = 'sfun_mg';
else
  myfun = 'sfun';
end;
%--------------------------------------------------
T  = ['In FMGRID: n = ' num2str(current_n)];
disp(T)
if (current_n <= nmin);
  %--------------------------------------------------
  % solve (exactly) problem on coarsest grid
  %--------------------------------------------------
    disp('-----------------------------------------------------------------------------------');
    fprintf('mesh grid is %d\n',current_n);
    nit=100;
    [A,b,Aeq,beq,lb,ub,options]=setup_par(v0,nit);
    nonlcon=mycon(v0);
    [v,fval,exitflag,output,lambda,grad]=fmincon(myfun,v0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    jj=find(N==current_n);NF_con(jj)=NF_con(jj)+output.funcCount;%counting iterations;
else
  fnl_d     = downdate_variable(fnl,1);
  v0_d      = downdate_variable(v0,1);
  j         = j+1;
  current_n = N(j);
[v_d,lambda]=fmgrid_con(v0_d,fnl_d,res_prob,a,sa,c,sc,nonl_eq,sna,nonl_in,snc,res_lb,res_ub);

  j         = j-1;
  current_n = N(j);
  %--------------------------------------------------
  n = current_n;
  v_u       = update(v_d,1);
  [v,lambda]=multigrid_con(v_u,fnl,res_prob,a,sa,c,sc,nonl_eq,sna,nonl_in,snc,res_lb,res_ub);
  T  = ['In FMGRID: n = ' num2str(current_n)];
  disp(T)
end;
