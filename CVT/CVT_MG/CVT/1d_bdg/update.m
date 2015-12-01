function zh = update (zH,res_prob)
global  IHh1 IHh2  IHh3  N  bdr bdl
 n=length(zH);
ind=find(n==N);
nn=N(ind-1);
if (n==N(2))
    IHh=IHh1;
elseif(n==N(3))
    IHh=IHh2;
elseif(n==N(4))
    IHh=IHh3;
end
% if (mod(n,2)==0)
% zhh=[zH;maxx];
% zh=IHh*zhh;
% else
%    zh=IHh*zH;
% end
% if (mod(n,2)==0&mod(nn,2)==0)
% zH=[bdr; zH];
% zh=IHh*zH;
% else
%    zH=[bdl; zH;bdr];
   zh=IHh*zH;
%end
