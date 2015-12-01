function zh = update (zH,res_prob)
global    CIHh N  bdr bdl minx maxx updating
n=length(zH);
ind=find(n==N);
nn=N(ind-1);
IHh=cell2mat(CIHh(ind-1));

if (mod(nn,2)==0)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if(updating)
%         bdl=2*minx-zH(1);
%         bdr=2*maxx-zH(end);
%         if(res_prob==4)
%             zhh=[bdl;zH];
%         else
%             zhh=[-zH(1);zH];
%         end
%     else
%         bdr=1;
%         bdl=0;
%         if(res_prob==4)
%             zhh=[bdl;zH;bdr];
%         else
%             zhh=[-zH(1);zH;-zH(end)];
%         end
%     end
%     zh=IHh*zhh;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    zh=IHh*zH;
elseif (mod(nn,2)~=0)
    if(res_prob==4)
        zhh=[bdl;zH;bdr];
    else
        zhh=[-zH(1); zH;-zH(end)];
    end
    zh=IHh*zhh;
end

