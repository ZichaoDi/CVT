global nn convergence;
clc
    fid = fopen('Ctable1_OPT.txt','a'); 
    fprintf(fid,'size           cycle_number               time                    convergence factor               energy                        ||g||\n');    
%     load fstar_nonr
%     fstar=fstar_nonr;
for iii=5
   nn=2^iii;
%     xstar=[];
%     for ii=1:nn
%         xstar(ii)=1/(2*nn)*(2*ii-1);
%     end
   opt;
   fs_uni(iii)=F;
    fprintf(fid,'%4i            %4i                    %6.2f                    %6.6f                        %6.5f                     %6.8f\n',nn,NF(1,1),e,convergence,F,norm(G));
end
    save fs_uni fs_uni
fclose(fid);