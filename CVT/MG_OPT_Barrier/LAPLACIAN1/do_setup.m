%----------------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular]
%----------------------------------------------------------------------
clear  functions
global bounds V_LOW V_UP
global grad_type
global B1023 B511 B255 B127 B63 B31 B15 B7
global b1023 b511 b255 b127 b63 b31 b15 b7
global X
global problem_name nn
%----------------------------------------------------------------------
% Specify technique for calculating gradient
%----------------------------------------------------------------------
grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
%----------------------------------------------------------------------
% Initialize arrays for discretizations
%----------------------------------------------------------------------
%N     = [511 255 127 63];        % discretization levels
N  = [2*nn+1 nn]; 
%N = [127 63];

build_interp;

nmax = N(1);
m = length(N);

X = zeros(nmax,m);
for j = 1:length(N)
  X(1:N(j),j) = linspace(0,1,N(j));
end
%----------------------------------------------------------------------
% Get data matrices and vectors
%----------------------------------------------------------------------
problem_name = 'the Laplacian';
disp('------------------------------------')
disp('Quadratic with Laplacian')
disp('------------------------------------')
disp(' ')
load('AA1023'); B1023 = Bh;
load( 'AA511');  B511 = Bh;
load( 'AA255');  B255 = Bh;
load( 'AA127');  B127 = Bh;
load(  'AA63');   B63 = Bh;
load(  'AA31');   B31 = Bh;
load(  'AA15');   B15 = Bh;
load(   'AA7');    B7 = Bh;
load( 'A1023'); b1023 = bh;
load(  'A511');  b511 = bh;
load(  'A255');  b255 = bh;
load(  'A127');  b127 = bh;
load(   'A63');   b63 = bh;
load(   'A31');   b31 = bh;
load(   'A15');   b15 = bh;
load(    'A7');    b7 = bh;
  
load('v0'); v0 = v0(1:N(1));
%----------------------------------------------------------------------
% Initialization for optimization
%----------------------------------------------------------------------
bounds = 0; % no bounds on variables