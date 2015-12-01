% Test the gradient using finite differencing
do_setup;
global miu
sfun='sfun';
z=v0;
n = length(z);
h = sqrt(eps);
[f,g,F,G] = feval(sfun,z);
gh = g;

diff_ind = 1; % Use 0 for central differencing, 1 for forward differencing

if (diff_ind == 1);
    disp('Forward Differencing')
    fprintf(' i                g                gh         error\n')
    %h = 1e-5;
    for i= 1:n;
        zh = z;
        zh(i) = zh(i) + h;
        [fh,gh,Fh,Gh] = feval(sfun,zh);
        Gh(i) = (Fh-F)/h;
        eee = abs(G(i)-Gh(i))/(1+abs(G(i)));
        fprintf('%3i     %18.8e        %18.8e     %8.1e\n',i,g(i),gh(i),eee);
    end;
    err = norm(G-Gh)/(1+norm(G))
else
    disp('Central Differencing')
    fprintf(' i               fh1                  fh2                  g                       gh              error\n')
    h = 1e-7;
    for i= 1:n;
        zh = z;
        zh(i) = zh(i) + h;
        [fh1,gh1,Fh1,Gh1] = feval(sfun,zh);
        zh = z;
        zh(i) = zh(i) - h;
        [fh2,gh2,Fh2,Gh2] = feval(sfun,zh);
        gh(i) = (Fh1-Fh2)/(2*h);
        eee = abs(G(i)-Gh(i))/(1+abs(g(i)));
        fprintf('%3i     %18.8e  %18.8e  %18.8e  %18.8e     %8.1e\n',i,fh1,fh2,g(i),gh(i),eee);
    end;
    err = norm(G-Gh,'inf')/(1+norm(G,'inf'))
end;