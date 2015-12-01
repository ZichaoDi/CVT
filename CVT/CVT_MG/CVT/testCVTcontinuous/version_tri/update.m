function zh = update (zH,res_prob)

global  current_n   N IHh IHhtot XYbd inner bd
    
n=length(zH)/2;
zH=reshape(zH,2,n);
ind=find(current_n==N);
indH=ind+1;
if(res_prob==4)
    B=IHhtot{ind};
    bond=XYbd{indH};
    index=inner{indH};
    inh=inner{ind};
zHtot(:,index)=zH;
outdex=bd{indH};
zHtot(:,outdex)=bond;
zh=zHtot*B';
zh=zh(:,inh);
else
B=IHh{ind};
zh=zH*4*B';
end
m=size(zh,2);
zh=reshape(zh,2*m,1);
