function zH = downdate (zh,res_prob)
global current_n IhH1 IhH2  IhH3  IhH4 hH N

m2=length(zh);
n=m2/2;
zh=reshape(zh,2,n);
if(res_prob==3)
   [zH,bond,B0,B,globalind] = coarsen2_mlevel(zh,zh);
else
IhH=cell2mat(hH(1));
zH=zh*IhH;
end
m1=size(zH,2);
zH=reshape(zH,2*m1,1);


