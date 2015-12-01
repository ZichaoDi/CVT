global nn xs;
clc
% for ii=1:4
% fid = fopen('more_rand_mg.txt','a');
% fprintf(fid,'size           cycle_number               time                    convergence factor               energy                        ||g||\n');
% 
% load fstar_nonr
% dif=[];
for i=7
    fstar=1/12;%fstar_nonr(iii-1);
    nn=2^i;
    e=[1:nn];
%         xs=[];
%         for ii=1:nn
%             xs(ii)=1/(2*nn)*(2*ii-1);
%         end
        xs=1/(2*nn).*(2.*e-1);
    opt;
%     j=1;
%     t=cputime;
%     mg;
%     v=sort(v);
%     [f,g]=sfun(v);
%     dif=[];
%     dif(1)=norm(f-fstar);
%     while(j>=0)
%         j=j+1;
%         
%         mgit;
%         v=sort(v);
%         [f,g]=sfun(v);
%         dif(j)=norm(f-fstar);
%         conv=(dif(j)<=1e-8);
%         
%         
%         
%         if(conv)
%             convergence=(norm(dif(j))/norm(dif(1)))^(1/j);
%             %fprintf('convergence factor=%f\n',convergence);
%             break;
%         end
%         
%     end
%     e=cputime-t;
%     fprintf(fid,'%4i            %4i                    %6.2f                    %6.6f                        %6.5f                     %6.8f\n',nn,j,e,convergence,f,norm(g));
% end
% fclose(fid);

end