%----------------------------------------------------------------------
% Solve via full multi-grid
% For multigrid without full initialization, use mg.m
%----------------------------------------------------------------------
% MODIFIED:  04/15/06
%----------------------------------------------------------------------
global current_n
global NF N        % NF counts # of function evals on each grid
global GRAPH_N_OLD GRAPH_INDEX_OLD
%----------------------------------------------------------------------
% SETUP FOR FULL MULTIGRID
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
  set(gca, 'XTickLabel', [], ...
		   'YTickMode', 'manual', 'YTick', [1:numel(N)], 'YTickLabel', N, 'YLim', [1, numel(N)]);
else
  figure(h_MG_graph);
end

clf
GRAPH_N_OLD = current_n;
GRAPH_INDEX_OLD = 1;
title('Progress of Multigrid Iteration');
ylabel('Mesh parameter');
set(gca, 'XTickLabel', [], ...
		 'YTickMode', 'manual', 'YTick', [1:numel(N)], 'YTickLabel', N, ...
		 'YLimMode', 'manual', 'YLim', [1, numel(N)]);
hold on;
%----------------------------------------------------------------------
% FULL MULTIGRID
%----------------------------------------------------------------------
v = fmgrid(v0,fnl,0);
doplot(it,v);
report_results(N);
more on;
%----------------------------------------------------------------------
% UPDATE MULTIGRID GRAPH
%----------------------------------------------------------------------
figure(findobj('Tag', 'multigrid_graph'));
hold off;