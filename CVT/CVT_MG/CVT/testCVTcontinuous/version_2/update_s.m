function zh=update_s(zH)
n=length(zH)/2;
zH=reshape(zH,2,n);
tri=delaunay(zH(1,:),zH(2,:));
m=length(tri);
for i=1:n
    for j=1:m
        ind=find(tri(j,:)==i);
        if(~isempty(ind))
        globalind(i,tri(j,:))=tri(j,:);
        end
    end
end
j=1;
for i=1:n
    ind=find(globalind(i,:)>i);
    t=length(ind);
    zh(:,j)=zH(:,i);
    for k=1:t
        zh(:,j+k)=(zH(:,i)+zH(:,globalind(i,ind(k))))/2;
    end
        j=j+t+1;
end
nn=size(zh,2)*2;
zh=reshape(zh,nn,1);
        
    
        