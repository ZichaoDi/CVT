function zH = downdate (zh,res_prob)
global current_n IhH XY1

if(res_prob==3)
    zH=XY1;
else
    m2=length(zh);
    n=m2/2;
    zh=reshape(zh,2,n);
    IH=IhH{current_n};
    zH=zh*IH;
end
m1=size(zH,2);
zH=reshape(zH,2*m1,1);


