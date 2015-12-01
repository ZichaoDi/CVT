function zH = downdate (zh,res_prob)
global IHh inner N B XYbd bd

m2=length(zh);
n=m2/2;
ind=find(n==N);
inH=inner{ind+1};
zh=reshape(zh,2,n);
if(res_prob==3)
    bond=XYbd{ind};
    index=inner{ind};
    xytot(:,index)=zh;
    outdex=bd{ind};
    xytot(:,outdex)=bond;
    zH=xytot(:,inH);
    %    inH
    %    figure(111);plot(zh(1,:),zh(2,:),'ro',zH(1,:),zH(2,:),'b*')
    %    for iii=1:n
    %        text(zh(1,iii),zh(2,iii),num2str(iii));end
    %    return;
else
    B=IHh{ind};
    zH=zh*B;
end
m1=size(zH,2);
zH=reshape(zH,2*m1,1);


