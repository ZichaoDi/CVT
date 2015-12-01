%----------------------------------------------------------------------
% Test problems from Vallejos and Borzi (2008)
%----------------------------------------------------------------------
clear  functions
global grad_type
global Av fv zv nu IND
global N
global A1 f1 z1
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
N  = [255 127 63 31 15 7];
% N = [127 63 31 15];
for k = 1:length(N);
    n = N(k);
    fv{k} = getf(n);
    zv{k} = getz(n);
    Av{k} = getA(n);
end;
%############################
n = N(1);
f1 = getf(n);
z1 = getz(n);
A1 = getA(n);
%############################
nu = 1e-4;
IND = 2; % 1 = linear, 2 = bilinear
rand('twister',5489);
n  = N(1);
u  = rand(n,n);
u  = u(:);
%=====================================
% if (n==127 & IND==1); % load special initial guess
%     load v127; % solution of linear problem
%     disp('Loading special initial guess')
%     u = v127 + 1e0*randn(size(v127));
% end;
i_special = 0;
if (n==127 & IND==2 & i_special==1); % load special initial guess
    load ui127; % initial guess obtained from linear problem
    disp('Loading special initial guess')
    u = ui127;
end;
%=====================================
v0 = u;
%----------------------------------------------------------------------
% Get data matrices and vectors
%----------------------------------------------------------------------
problem_name = 'Linear Example';
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
bounds = 0; % no bounds on variables