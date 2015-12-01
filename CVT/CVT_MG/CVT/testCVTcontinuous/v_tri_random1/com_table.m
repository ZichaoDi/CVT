global level
clc
fid = fopen('2D_triangle.txt','a');
fprintf(fid,'size           cycle_number               time                    convergence factor               energy                        ||g||\n');
load fstarlow
dif=[];
for i=4
    fs=fstarlow(i);
%     load fstar4400;
%     fs=fstar4400
    level=i;
    j=1;
    t=cputime;
    mg;
    nn=length(v0)/2;
    [f,g]=sfun(v);
    dif(i,1)=norm(f-fs);
    while(j>=0)
        j=j+1;
        oldf=f;
        mgit;
        [f,g]=sfun(v);
        dif(i,j)=norm(f-oldf);
        conv=(dif(i,j)<=1e-7);
        
        
        
        if(conv)
            convergence=(norm(dif(i,j))/norm(dif(i,1)))^(1/j);
            %fprintf('convergence factor=%f\n',convergence);
            break;
        end
        
    end
    e=cputime-t;
    fprintf(fid,'%4i            %4i                    %6.2f                    %6.6f                        %6.5f                     %6.8f\n',nn,j,e,convergence,f,norm(g));
end
fclose(fid);