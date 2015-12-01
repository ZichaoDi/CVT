%---------------------------------------------------------------
% Set up a problem for optimization [multigrid or regular].
%---------------------------------------------------------------
% MODIFIED: PRE-COMPUTE USTAR ON ALL LEVELS
%

global N 
global bounds 
global grad_type 
global lower upper  extrap v_low v_up

%--------------------------------------------------
% Select technique for gradient calculation.
%

grad_type = 'adj';  % 'adj' = adjoint/exact
                    % 'fdr' = finite-difference [real]
                    % 'fdi' = finite-difference [complex]
					
%--------------------------------------------
% Initialize arrays for discretizations
         
N        = 1000;
m        = length(N);

bounds   = 0;  % no bound constraints
lower=1;
upper=1;
extrap=0; %% 1: Apply extrapolation for the initial estimate of Barrier method

[v_low,v_up] = set_bounds(1,0);
%randn('state',0);
%v0=randn(N,1);
v0=1/N*ones(N,1);
ineql=find(v0<v_low); 
if(~isempty(ineql))
v0(ineql)=v_low(ineql)+0.5;
end

inequ=find(v0>v_up); 
if(~isempty(inequ))
v0(inequ)=v_up(inequ)-0.5;
end

eql=find(v0==v_low); 
if(~isempty(eql))
v0(eql)=v_low(eql)+1e-4;
end

equ=find(v0==v_up); 
if(~isempty(equ))
v0(equ)=v_up(eql)-1e-4;
end