%----------------------------------------------------------------------
% Solve via traditional optimization
%----------------------------------------------------------------------
global current_n vstar 
global NF N   convergence     % NF counts # of function evals on each grid
%----------------------------------------------------------------------
do_setup;
more off;
NF   = [0*N; 0*N; 0*N]; 
it   = 1;
fnl  = 0*v0;
n    = N(1);
%global_setup(n);
current_n = n;
%----------------------------------------------------------------------
myfun = 'sfun';
t=cputime;
if (bounds);
    jj=length(v0);
   [v_low,v_up] = set_bounds(jj);
   [vstar,F,G,ierror] = tnbc (v0,myfun,v_low,v_up);
else
   [vstar,F,G,ierror] = tn   (v0,myfun);
end;
e=cputime-t;
 fprintf(['Time elapsed: ',num2str(e),' sec\n']);
doplot(0,vstar);
report_results(N);
more on;