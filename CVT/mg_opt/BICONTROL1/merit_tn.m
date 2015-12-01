function [F,G]=merit_tn(v,f,g)
global v_low v_up lambdatn row ind_lower
lambda_low=zeros(length(v),1);
pert=eps*1e4;
lambdaind0=find(v<v_low+pert& g>0);
lambda_low(lambdaind0)=g(lambdaind0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda_upper=zeros(length(v),1);
lambdaind1=find(v>v_up-pert& g<0);
lambda_upper(lambdaind1)=-g(lambdaind1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambdatn=struct('lower',lambda_low,'upper',lambda_upper);

row=1;
violation_lower=max((-v+v_low),0);
violation_upper=max((v-v_up),0);
ind_upper=find(violation_upper~=0);
ind_lower=find(violation_lower~=0);
f_low = violation_lower'*lambdatn.lower+row/2*violation_lower'*violation_lower;
f_up = violation_upper'*lambdatn.upper+row/2*violation_upper'*violation_upper;
vtest=v;
vtest(ind_upper)=37;
[ftest,gtest]=sfun(vtest);
F = f+f_low+f_up;
% format long e
% originalf=f
% cutf=ftest
% meritf=F
if(isempty(ind_upper) & isempty(ind_lower) )
    disp('no violation')
    G=g;
elseif(isempty(ind_lower) &  ~isempty(ind_upper))
    disp('only upper violation')
%         format long e
%     ind_upper
%     v(ind_upper)
%     v_up(ind_upper)
    G=g+lambdatn.upper+row*violation_upper;
elseif(~isempty(ind_lower) & isempty(ind_upper))
   disp('only lower violation')
%     format long e
%     ind_lower
%     v(ind_lower)
%     v_low(ind_lower)
    G=g-lambdatn.lower-row*violation_lower;
else
    %disp('lower and upper violation')
    G=g-lambdatn.lower-row*violation_lower+lambdatn.upper+row*violation_upper;
end