global level convergence;
clc
fid = fopen('Ctable2_OPT.txt','a');
fprintf(fid,'size           cycle_number               time                    convergence factor               energy                        ||g||\n');
for i=5
    level=i;
    opt;
    fstarlow(i)=F;
    nn=length(v0)/2;
    fprintf(fid,'%4i            %4i                    %6.2f                    %6.6f                        %6.5f                     %6.8f\n',nn,NF(1,1),e,convergence,F,norm(G));
end
save fstarlow fstarlow
fclose(fid);