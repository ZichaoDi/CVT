%----------------------------------------------------------------------
% Solve via traditional optimization
%----------------------------------------------------------------------
global current_n  maxiter
global NF_con N        % NF_con counts # of function evals on each grid
%----------------------------------------------------------------------
do_setup;
NF_con=[0*N];
more off;
it   = 1;
fnl  = 0*v0;
n    = N(1);
current_n = n;
%----------------------------------------------------------------------
myfun = 'sfun';
t=cputime;
%maxiter=100;
[A,b,Aeq,beq,lb,ub,options]=setup_par(v0,maxiter,0);
nonlcon=mycon(v0);
[v,fval,exitflag,output,lambda,grad]  = fmincon(myfun,v0,A,b,Aeq,beq,lb,ub,nonlcon,options);
NF_con(1)=output.iterations;
e=cputime-t;
fprintf(['Time elapsed: ',num2str(e),' sec\n']);
doplot(0,v);
% report_results_con(N);
% more on;