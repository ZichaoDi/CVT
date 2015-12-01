fprintf(1,'meshed size      condition number\n');
for i=10
    x=[0.5:9.5];
    n=length(x);
    H=Hessian1d(x);%*i/5;
    H;
    A=cond(H);
    fprintf(1,'%d             %e\n',n,      A);
end