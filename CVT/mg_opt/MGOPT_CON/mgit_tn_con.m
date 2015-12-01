% Perform one iteration of multigrid.
% Can only be used after using mg_con.m or fmg_con.m
%----------------------------------------------------------------------
%----------------------------------------------------------------------
% Update the multi-grid solution: given current solution v
%----------------------------------------------------------------------
h_MG_graph = findobj('Tag', 'multigrid_graph');
if (~isempty(h_MG_graph))
  GRAPH_INDEX_OLD = GRAPH_INDEX_OLD+8;
  figure(h_MG_graph);
  hold on;
else
  GRAPH_N_OLD = N(1);
  GRAPH_INDEX_OLD = 1;
  h_MG_graph = figure('Tag', 'multigrid_graph', ...
					  'IntegerHandle', 'off', ...
					  'Name', 'Multigrid graph', ...
					  'Numbertitle', 'off', ...
					  'Visible', 'off');
end

title('Progress of Multigrid Iteration');
set(gca, 'XTickLabel', [], ...
		 'YTickMode', 'manual', 'YTick', [1:numel(N)], 'YTickLabel', N, ...
		 'YLimMode', 'manual', 'YLim', [1, numel(N)]);
hold on;
more off;
it = it + 1;
if(bounds_con)
    res_lb=zeros(size(v));res_ub=zeros(size(v));
else res_lb=[];res_ub=[];
end
sa=[];sc=[];sna=[];snc=[];
[v,lambda]=multigrid_tn_con(v,fnl,0,a,sa,c,sc,nonl_eq,sna,nonl_in,snc,res_lb,res_ub);
doplot(it,v);
report_results_con(N);
more on;