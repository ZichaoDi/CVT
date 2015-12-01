%----------------------------------------------------------------------
% Solve via multi-grid
% Obtained from fmincon
%----------------------------------------------------------------------
global current_n
global NF N        % NF counts # of function evals on each grid
global GRAPH_N_OLD GRAPH_INDEX_OLD
global problem_name  bounds_con
%----------------------------------------------------------------------
% SETUP FOR MULTIGRID
%----------------------------------------------------------------------
more off;
do_setup;
NF   = [0*N; 0*N; 0*N];
it   = 1;
fnl  = 0*v0;
n    = N(end);
global_setup(n);
current_n = N(1);
%----------------------------------------------------------------------
% CREATE MULTIGRID GRAPH
%----------------------------------------------------------------------
h_MG_graph = findobj('Tag', 'multigrid_graph');
if (isempty(h_MG_graph))
  h_MG_graph = figure('Tag', 'multigrid_graph', ...
					  'IntegerHandle', 'off', ...
					  'Name', 'Multigrid graph', ...
					  'Numbertitle', 'off', ...
					  'Visible', 'off');
else
  figure(h_MG_graph);
end

clf
GRAPH_N_OLD = current_n;
GRAPH_INDEX_OLD = 1;
if (~isempty(problem_name))
  title(['Progress of Multigrid Iteration for ', problem_name]);
else
  title('Progress of Multigrid Iteration');
end
ylabel('Mesh parameter');
set(gca, 'XTickLabel', [], ...
		 'YTickMode', 'manual', 'YTick', [1:numel(N)], 'YTickLabel', N, ...
		 'YLimMode', 'manual', 'YLim', [1, numel(N)]);
hold on;
%----------------------------------------------------------------------
% MULTIGRID
%----------------------------------------------------------------------
if(bounds_con)
    res_lb=zeros(size(v0));res_ub=zeros(size(v0));
else res_lb=[];res_ub=[];
end
sa=[];sc=[];sna=[];snc=[];
[v,lambda]=multigrid_tn_con(v0,fnl,0,a,sa,c,sc,nonl_eq,sna,nonl_in,snc,res_lb,res_ub);
doplot(it,v);
report_results(N);
more on;
%----------------------------------------------------------------------
% UPDATE MULTIGRID GRAPH
%----------------------------------------------------------------------
figure(findobj('Tag', 'multigrid_graph'));
hold off;