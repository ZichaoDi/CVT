itba=1;
miu=[64, 32, 16, 8, 4, 2,1,0.5,0.25, 0.125]';
maxouter=length(miu);
extra=cell(maxouter,4);
xstar=19-17.*miu+3.*miu.^2+2.*miu.^3
%xstar=19-17.*miu+3.*miu.^2
row=2;
format short e
% x{1}=[1.5527902 1.3328244];
% x{2}=[1.1593310 1.6413662];
% x{3}=[1.0398432 1.7111091];
% x{4}=[1.0099207 1.7269415];
% x{5}=[1.0024774 1.7307819];
ext2=[];
while(itba<=maxouter)
    if (itba>4)
        order=4;
    else
        order=itba;
    end
    extra{itba,1}=xstar(itba);
    
    if (itba>2)
    for j=order:-1:2
       x=((row^(j-1)-1)*x+extra{itba-1,j-1})/row^(j-1);
    end
    ext2(itba)=x;
    else
    ext2(itba)=xstar(itba);
    end
    if(itba==2)
        extra{2,2}=(row.*extra{2,1}-extra{1,1})/(row-1);
        x=extra{itba,2};
    elseif(itba>2)
        for j=2:order
            extra{itba,j}=(row^(j-1).*extra{itba,j-1}-extra{itba-1,j-1})/(row^(j-1)-1);
        end
         x=extra{itba,order};   
    end

    itba=itba+1;
end
ext2'
extra