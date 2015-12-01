function conv = cnvtem_outer(x,low,up,sfun)

global upper lower row eps3 add_term lambda miu
%--------------------------------------------------------------------
%outer convergence test for barried method
%--------------------------------------------------------------------
[f, g] = feval (sfun, x);
if(upper && ~lower)
    y=norm(lambda.*(up-x),inf);
    DL=g+lambda;
elseif(lower && ~upper)
    [y]=norm(lambda.*(x-low),inf);
    DL=g-lambda;
else
    lambda1=lambda(1:length(lambda)/2);
    lambda2=lambda(length(lambda)/2+1:end);
    y=norm([lambda1.*(x-low);lambda2.*(up-x)],inf);
    DL=g-lambda1+lambda2;
end
% ee=lambdain-lambda;
% eep=lambdain(ind)-lambda(ind);
% length(ind)
% figure(14);plot(1:length(x),ee,'r.-',1:length(ind),eep,'bo-')
% pause;
eps1=1e-8;
eps2=1e-5;
test_lam=y/(1+abs(f));
test_Lag=norm(DL,inf)/(1+abs(f));
conv= test_lam <=eps1 & test_Lag<=eps2;

if(test_Lag<=eps3 && y/(1+abs(f))<=row*eps1 && test_Lag >eps2  && eps3>eps2)
    add_term=1;
else 
    add_term=0;
end

% lam1=miu./(x-low);
% lam2=g;
% ee1=lambda-lam1;
% ee2=lam1-lam2;
% ee3=lambda-lam2;
% norm(ee3)
% norm(ee1)
% norm(ee2)
% figure(33);plot(1:length(x),ee1,'r.-',1:length(x),ee2,'bo-')