% Test the gradient using finite differencing
do_setup;
sfun='sfun';
z=v0;
n = length(z);
h = sqrt(eps);
[f,g] = feval(sfun,z);
gh = g;

diff_ind = 0; % Use 0 for central differencing, 1 for forward differencing

if (diff_ind == 1);
    disp('Forward Differencing')
    fprintf(' i                g                gh         error\n')
    h = 1e-7;
    for i= 1:n;
        zh = z;
        zh(i) = zh(i) + h;
        [fh,gh] = feval(sfun,zh);
        gh(i) = (fh-f)/h;
        eee = abs(g(i)-gh(i))/(1+abs(g(i)));
        fprintf('%3i     %18.8e        %18.8e     %8.1e\n',i,g(i),gh(i),eee);
    end;
    err = norm(g-gh)/(1+norm(g))
else
    disp('Central Differencing')
    fprintf(' i               fh1                  fh2                  g                       gh              error\n')
    h = 1e-7;
    for i= 1:n;
        zh = z;
        zh(i) = zh(i) + h;
        [fh1,gh1] = feval(sfun,zh);
        zh = z;
        zh(i) = zh(i) - h;
        [fh2,gh2] = feval(sfun,zh);
        gh(i) = (fh1-fh2)/(2*h);
        eee = abs(g(i)-gh(i))/(1+abs(g(i)));
        fprintf('%3i     %18.8e  %18.8e  %18.8e  %18.8e     %8.1e\n',i,fh1,fh2,g(i),gh(i),eee);
    end;
    err = norm(g-gh,'inf')/(1+norm(g,'inf'))
end;