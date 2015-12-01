%Lloyd's method on unit interval of 1-dimension
%density function r(x)=1

%close all;
fid = fopen('Ctab1_lloyd.txt','a');
fprintf(fid,'size           cycle_number               time                    convergence factor\n');

for i=6:9
    error=[];
    ener=[];
    m=2^(3+i);
    Nmax = 10000;
    epsilon = 1e-6;
    x = sort(rand(m,1));
    %figure(3);plot(x,1,'b*')
    xex=zeros(m,1);
    for i=1:m
        xex(i) = (2*i-1)/(2*m);
    end
    %enerex=energy(xex)*m^2;
    n=1;
    t=cputime;
    while (n>=1)
        %if (mod(n,100)==0) n, end
%                 ener(n) = energy(x)*m^2;
%                 eee=ener(n);
        y=zeros(m,1);
        y(1)=(x(1)+x(2))/4;
        for i=2:m-1
            y(i)=(x(i-1)+2*x(i)+x(i+1))/4;
        end
        y(m)=(x(m-1)+x(m)+2)/4;


 
        error(n) = norm(x-xex);
        err=error(n);
      
        if (error(n)<epsilon)
            break; end
        x=y;
        n = n+1;
        %lloy dplot = findobj('Tag', 'TN vs.OPT');
        %figure(3); hold on; plot(n,err,'r.-'); drawnow
        %hold on; semilogy(n,eee-enerex,'g*-');
        %drawnow;
        % figure(3); drawnow; plot(x,1,'r.',xex,1,'b.')
    end
    convergence=(error(n)/error(1))^(1/n);
    e=cputime-t;
    fprintf(fid,'%4i            %4i                    %6.2f                    %6.6f\n',m,n,e,convergence);

end
fclose(fid);

