function report_results_con(N)
%-------------------------------------------
% Print the grid sizes, as well as the
% # of function evaluations on each grid.
%
% The grid sizes are in N, the totals in NF_con.
%-------------------------------------------
% Usage: report_results(N)
%-------------------------------------------
global NF_con
%-------------------------------------------
fprintf('\n')
drawline(N);
fprintf('Constraint Optimization costs per grid\n')

drawline(N);

fprintf('N:     ');
fprintf(' %5i',N);
fprintf('\n');

drawline(N);

fprintf('NF_con(it): ');
for i=1:length(N)
fprintf('%5i ',NF_con(i));
end
fprintf('\n');
drawline(N);
fprintf('\n');
%===========================================
function drawline(N)

fprintf('-------');
for i=1:length(N);
   fprintf('------');
end;
fprintf('\n');