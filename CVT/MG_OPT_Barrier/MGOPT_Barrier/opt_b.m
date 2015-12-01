%----------------------------------------------------------------------
% Solve via traditional optimization
%----------------------------------------------------------------------
global current_n
global NF N        % NF counts # of function evals on each grid
global v_low v_up add_term
%----------------------------------------------------------------------
do_setup;
more off;
NF   = [0*N; 0*N; 0*N];
it   = 1;
fnl  = 0*v0;
n    = N(1);
global_setup(n);
current_n = n;
%----------------------------------------------------------------------
myfun = 'sfun';
e=cputime;
maxouter=25;
add_term=0;
[v,F,G,ierror] = tn   (v0,myfun,v_low,v_up,maxouter);
time=cputime-e;
disp(['time elpased is  ' , num2str(time)])
doplot(0,v);
report_results(N);
more on;