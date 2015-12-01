% Test the gradient using finite differencing

% z0=load('coarsencentroid2.txt');
% z0 = z0';
% z = z0(:);
load zstar107;
z = zstar;
n = length(z);
h = sqrt(eps);
[f,g] = sfun(z);
diff_ind = 0; % Use 0 for central differencing, 1 for forward differencing

if (diff_ind == 1);
    disp('Forward Differencing')
    fprintf(' i                g                gh         error\n')
    h = sqrt(eps);
    for i= 1:n;
        zh = z;
        zh(i) = zh(i) + h;
        [fh,gh] = sfun(zh);
        gh(i) = (fh-f)/h;
        eee = abs(g(i)-gh(i))/(1+abs(g(i)));
        fprintf('%3i     %18.8e        %18.8e     %8.1e\n',i,g(i),gh(i),eee);
    end;
    err = norm(g-gh)/(1+norm(g))
else
    disp('Central Differencing')
    fprintf(' i               fh1                  fh2                  g                       gh              error\n')
    h = eps^(1/3);
    for i= 1:n;
        zh = z;
        zh(i) = zh(i) + h;
        [fh1,gh1] = sfun(zh);
        zh = z;
        zh(i) = zh(i) - h;
        [fh2,gh2] = sfun(zh);
        gh(i) = (fh1-fh2)/(2*h);
        eee = abs(g(i)-gh(i))/(1+abs(g(i)));
        fprintf('%3i     %18.8e  %18.8e  %18.8e  %18.8e     %8.1e\n',i,fh1,fh2,g(i),gh(i),eee);
    end;
   
    err = norm(g-gh')/(1+norm(g))
end;