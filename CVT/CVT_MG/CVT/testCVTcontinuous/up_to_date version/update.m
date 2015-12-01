function zh = update (zH,res_prob)

global  current_n   N Hh 
n=length(zH)/2;
zH=reshape(zH,2,n);
 in=find(current_n==N);
 IHh=cell2mat(Hh(in));
 zh=IHh*zH';
m=size(zh,1);
zh=reshape(zh',2*m,1);
