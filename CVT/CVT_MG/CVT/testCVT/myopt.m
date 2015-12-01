%----------------------------------------------------------------------
% Solve via traditional optimization
%----------------------------------------------------------------------
global current_n
global NF N        % NF counts # of function evals on each grid
global array XY  XY2 XY3
%----------------------------------------------------------------------
% do_setup;
% more off;
do_setup_continuous;
NF   = [0; 0 ; 0]; 
% it   = 1;
% fnl  = 0*v0;
% n    = N(1);
% global_setup(n);
N=1;
current_n = N;
%----------------------------------------------------------------------
% myfun = 'sfun';
% if (bounds);
%    [v_low,v_up] = set_bounds(1);
%    [v,F,G,ierror] = tnbc (v0,myfun,v_low,v_up);
% else

z0=XY2;

%array=load('voronoi_2d_binning_example.txt');
m=size(z0,2);
z0=reshape(z0,2*m,1);
%for i=1:m
    [zstar,f,g,ierror] = tn(z0,@sfun);
%end
% end;
% doplot(0,v);
% report_results(N);
% more on;
