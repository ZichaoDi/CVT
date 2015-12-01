function v = fmgrid1(v0,fnl,res_prob)
%--------------------------------------------------
% Full Multigrid algorithm (McCormick, pp. 70-71)
%--------------------------------------------------
% Usage: v = fmgrid(v0,fnl,res_prob)
%--------------------------------------------------
global current_fnl
global N current_n 
global bounds
global GRAPH_N_OLD GRAPH_INDEX_OLD
%----------------------------------------------------------------------
% UPDATE MULTIGRID GRAPH
%----------------------------------------------------------------------
%figure(findobj('Tag', 'multigrid_graph'));
GRAPH_N_NEW = current_n;
IND_OLD = find(N==GRAPH_N_OLD);
IND_NEW = find(N==GRAPH_N_NEW);
% plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW]);
% plot([GRAPH_INDEX_OLD GRAPH_INDEX_OLD+1],[IND_OLD IND_NEW],'x');
GRAPH_N_OLD = current_n;
GRAPH_INDEX_OLD = GRAPH_INDEX_OLD+1;
%--------------------------------------------------
n = current_n;

%--------------------------------------------------
current_fnl = fnl;
j           = find(N==current_n);
nmin        = N(end);
if (bounds);
    jj=length(v0);
   [v_low,v_up] = set_bounds(jj);
end;
%--------------------------------------------------
if (res_prob);
  myfun = 'sfun_mg';
else
  myfun = 'sfun';
end;
%--------------------------------------------------
% T  = ['In FMGRID: n = ' num2str(current_n)];
% disp(T)
%--------------------------------------------------
if (current_n>nmin) global_setup(n,v0);end
if (current_n <= nmin);
  %--------------------------------------------------
  % solve (exactly) problem on coarsest grid
  %--------------------------------------------------
  if (bounds);
	nit=75; [v,F,G,ierror] = tnbcm1 (v0,myfun,v_low,v_up,nit);
  else
	nit=75;
    [v,F,G,ierror] = tnm1   (v0,myfun,nit);	
  end;
else
  fnl_d     = downdate(fnl,1);
  v0_d      = downdate(v0,3);
  j         = j+1;
  current_n = N(j);

  v_d       = fmgrid1(v0_d,fnl_d,res_prob);

  j         = j-1;
  current_n = N(j);
  %--------------------------------------------------
  n = current_n;
  %global_setup(n);
  %--------------------------------------------------
  v_u       = update(v_d,4);
  
  step_bnd  = 0;
  v         = mgrid1(v_u,fnl,res_prob,step_bnd);
%   T  = ['In FMGRID: n = ' num2str(current_n)];
%   disp(T)
end;
