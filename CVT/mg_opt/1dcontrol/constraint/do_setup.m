%---------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular].
%---------------------------------------------------------------
% MODIFIED: PRE-COMPUTE USTAR ON ALL LEVELS
%

global X N
global ustar
global grad_type bounds_con
global beta L

%--------------------------------------------------
% Select technique for gradient calculation.
%

grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
					
%--------------------------------------------
% Initialize arrays for discretizations
%

beta  = 1;
x_L=0;
x_U=1;

 N        = [1025 513 257 129 65 33 17];% 4097 2049          % discretization levels
%N        = [129 65 33 17]; % discretization levels
N = [257 129];
m        = length(N);
for i=1:length(N)
    hh(i)=1/(N(i)+1);
    uu=laplacian_1d(N(i));
    L{i}= [uu/hh(i)^2];
end
bounds_con=0;

for j = 1:m;
  X(1:N(j),j) = linspace(x_L,x_U,N(j))';
end;


for j=1:length(N);
    xx = X(1:N(j),j);
    %ustar{j} = -(xx-1/2).^2+1/4;
    t  = xx(2:end-1);
    %ys = 4000*( sin(pi*t) + 1.25*sin(4*pi*t) - 1.75*sin(6*pi*t) + 4.0*sin(8*pi*t) ) + 5*sin(16*pi*t);
    ys = 40*( sin(pi*t) + 1.25*sin(4*pi*t) - 4*sin(6*pi*t) + 16*sin(8*pi*t) ) + 32*sin(16*pi*t);
    yy = [0; ys; 0];
    ustar{j} =yy;
end
    


% Specify initial guess for optimization.

randn('state',0);
v0=randn(2*N(1),1); 


Aeq=[L{1},-eye(N(1))];beq=zeros(N(1),1);
a=Aeq*v0-beq;c=[];
[nonl_in,nonl_eq]=mycon(v0);
