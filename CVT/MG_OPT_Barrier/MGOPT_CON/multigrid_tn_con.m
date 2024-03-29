function [v,lambda]=multigrid_con(v0,fnl,res_prob,a,sa,c,sc,nonl_eq,sna,nonl_in,snc,res_lb,res_ub);
global current_n N current_fnl NF
global options
global GRAPH_N_OLD GRAPH_INDEX_OLD
h_MG_graph = findobj('Tag', 'multigrid_graph');
figure(h_MG_graph);

GRAPH_N_NEW = current_n;
IND_OLD = find(N==GRAPH_N_OLD);
IND_NEW = find(N==GRAPH_N_NEW);
plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW]);
plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW],'x');
GRAPH_N_OLD = current_n;
GRAPH_INDEX_OLD = GRAPH_INDEX_OLD+1;
if(res_prob)
    myfun='sfun_mg';
else
    myfun='sfun';
end
current_fnl = fnl;
%--------------------------------------------------------------------------
%---------------------------coarsest presmoothing:-------------------------
if(current_n<=min(N))
    disp('-----------------------------------------------------------------------------------');
    fprintf('mesh grid is %d\n',current_n);
    nit=200;
    [A,b,Aeq,beq,lb,ub,options]=setup_par(v0,nit);
    b=b+sc;beq=beq+sa;
    lb=lb-res_lb;
    ub=ub+res_ub;
    nonlcon=mycon(v0);
        load lambda257un;
    lambda=lambda257un;
    %[v,fval,exitflag,output,lambda]=fmincon(myfun,v0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    nit = 25; [v,F,G,ierror]  = tnm  (v0,myfun,nit);
    %jj=find(N==current_n);NF(jj)=NF(jj)+output.funcCount;      %counting iterations;
    %--------------------------------------------------------------------------
else
    %presmoothing:
    nit=25;
    [A,b,Aeq,beq,lb,ub,options]=setup_par(v0,nit);     %%set up all the constaints;
    if(res_prob)
        b=b+sc;beq=beq+sa;
        lb=lb-res_lb;
        ub=ub+res_ub;
    end
    disp('-----------------------------------------------------------------------------------');
    fprintf('mesh grid is %d\n',current_n);
    nonlcon=mycon(v0);
    %[v,fval,exitflag,output,lambda,grad]  = fmincon(myfun,v0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    nit = 1; [v,F,G,ierror,eig_val]  = tnm  (v0,myfun,nit);
    grad=G;
    jj=find(N==current_n);
    %NF(jj)=NF(jj)+output.funcCount;
    %----------------------------------------------------------------------
    %construct shifted function :if for constraint problem, downdate will
    %be worked on lagrangian gradient;
    
    [Fvmg,Gvmg]=sfun_mg(v);
    current_v=downdate_variable(v,1);
    
    %restrict variables and constraints to coarse level;
    load lambda257un;
    lambda=lambda257un;
    [current_lameqlin,current_lamineqlin,current_lameqnonlin,current_lamineqnonlin]=downdate_constraint(lambda.eqlin,lambda.ineqlin,lambda.eqnonlin,lambda.ineqnonlin); 
%     [current_lamlower]=downdate_bounds(lambda.lower);
%     [current_lamupper]=downdate_bounds(lambda.upper);
%     current_lambda=struct('eqlin',{current_lameqlin},'ineqlin',{current_lamineqlin},'eqnonlin',{current_lameqnonlin},'ineqnonlin',{current_lamineqnonlin},'lower',{current_lamlower},'upper',{current_lamupper});
current_lambda=lambda;
    [nonl_ineq,nonl_eq]=mycon(v);
    [ax,cx]=eval_licon(Aeq,beq,A,b,v);
    [current_a,current_c,current_nonl_eq,current_nonl_ineq]=downdate_constraint(ax,cx,nonl_eq,nonl_ineq);
    [current_sa,current_sc,current_sna,current_snc]=downdate_constraint(sa,sc,sna,snc);
    [Fv,Gv]=sfun(v);
    dGv=downdate_variable(Gv,1);
    [current_A,current_b,current_Aeq,current_beq,current_lb,current_ub,options]=setup_par(current_v,nit);
    [current_nonlineq,current_nonleq]=mycon(current_v);
%     current_res_lb=downdate_bounds(res_lb)+current_lb-current_v-downdate_bounds(lb-v);
%     current_res_ub=downdate_bounds(res_ub)+current_v-current_ub-downdate_bounds(v-ub);
    current_res_lb=zeros(size(current_v));
    current_res_ub=zeros(size(current_v));
    [current_ax,current_cx]=eval_licon(current_Aeq,current_beq,current_A,current_b,current_v);
    current_sa=current_sa+current_ax-current_a;
    current_sc=current_sc+current_cx-current_c;
    current_sna=current_sna+current_nonleq-current_nonl_eq;
    current_snc=current_snc+current_nonlineq-current_nonl_ineq;
    fnl2=downdate_variable(fnl,1);
    j=find(N==current_n);
    j=j+1;
    current_n =N(j);
    [fv2,Gv2]=sfun(current_v);
    %Gv2=eval_LG(Gv2,current_v,current_Aeq,current_A,current_lambda);
    tau         = Gv2 - dGv;
    fnl2        = fnl2 + tau;
    [e2,lambda]=multigrid_tn_con(current_v,fnl2,1,current_a,current_sa,current_c,current_sc,current_nonleq,current_sna,current_nonlineq,current_snc,current_res_lb,current_res_ub);
    
    j=j-1;
    current_n=N(j);
    figure(findobj('Tag', 'multigrid_graph'));
    GRAPH_N_NEW = current_n;
    IND_OLD = find(N==GRAPH_N_OLD);
    IND_NEW = find(N==GRAPH_N_NEW);
    plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW]);
    plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW],'x');
    GRAPH_N_OLD = current_n;
    GRAPH_INDEX_OLD = GRAPH_INDEX_OLD+1;
    
    e = update(e2-current_v,1);% update correction;
    current_fnl = fnl;
%    [Fvmg,Gvmg]=eval_merit(Fvmg,Gvmg,v,Aeq,beq,A,b,output,lambda);
    testd       = e'*Gvmg; % test if it's decent direction
    
    if (testd<0)
        alpha0 = 1;
        %[v] = lin(e, v, Fvmg, alpha0, myfun,Aeq,beq,A,b,output,lambda); % use Amijo to find step size;
        [v, Fv, Gv, nf1, alpha, ierror, dfdp] = ...
		   lin2 (e, v, Fvmg, alpha0, Gvmg, myfun);
    else
        disp('No descent direction: no step taken')
        v  = v + 0*e;
    end;
    
    
    disp('-----------------------------------------------------------------------------------');
    %--------------------------------post-smoothing:-----------------------
    fprintf('mesh grid is %d\n',current_n);
    nit=25;
    [A,b,Aeq,beq,lb,ub,options]=setup_par(v,nit);
    if(res_prob)
        b=b+sc;beq=beq+sa;
        lb=lb-res_lb;
        ub=ub+res_ub;
    end
    nonlcon=mycon(v);
    %[v,fval,exitflag,output,lambda]  = fmincon(myfun,v,A,b,Aeq,beq,lb,ub,nonlcon,options);
    nit = 1; [v,F,G,ierror]  = tnm  (v,myfun,nit);
    jj=find(N==current_n);
    %NF(jj)=NF(jj)+output.funcCount;
end






