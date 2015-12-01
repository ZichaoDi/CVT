function [v_low,v_up] = set_bounds1(ind,bind,vlow,vup)
%-----------------------------------------------
%%%%%%%%Apply the bounds set from Toint
%-----------------------------------------------

global N current_n bindH

% v_low_fine = vlow{ind-1};
% v_low=zeros(N(ind),N(ind));
% finev=bind{ind};
% nm=N(ind-1);
% v_low_fine= reshape(v_low_fine,nm,nm);
% zsh  = reshape(finev,nm,nm);
% currentv=bindH{ind};
% nm=N(ind);
% zsH  = reshape(currentv,nm,nm);
% for i=1:nm     %%% from top row of nine point_stencil
%     for j=1:nm
%         if (i==1 && j==1)
%             low1=4*(v_low_fine(1,1)-zsh(1,1)+1/4*zsH(1,1));
%             low2=2*(v_low_fine(1,2)-zsh(1,2)+1/2*zsH(1,1));
%             low3=(v_low_fine(1,3)-2*zsh(1,3)+zsH(1,1));
%             low4=2*(v_low_fine(2,1)-zsh(2,1)+1/2*zsH(1,1));
%             low5=v_low_fine(2*i,2*j)-zsh(2*i,2*j)+zsH(i,j);
%             low6=v_low_fine(2*i,2*j+1)-zsh(2*i,2*j+1)+zsH(i,j);
%             low7=(v_low_fine(3,1)-2*zsh(3,1)+zsH(1,1));
%             low8=v_low_fine(2*i+1,2*j)-zsh(2*i+1,2*j)+zsH(i,j);
%             low9=v_low_fine(2*i+1,2*j+1)-zsh(2*i+1,2*j+1)+zsH(i,j);
%             diffv=[low1,low2,low3,low4,low5,low6, low7, low8, low9];
%             [vl,index]=max(diffv);
%             v_low(i,j)=vl;
%         elseif(i==1 && j==nm)
%             low1=(v_low_fine(1,2*j-1)-2*zsh(1,2*j-1)+zsH(i,j));
%             low2=2*(v_low_fine(1,2*j)-zsh(1,2*j)+1/2*zsH(i,j));
%             low3=4*(v_low_fine(1,2*j+1)-zsh(1,2*j+1)+1/4*zsH(i,j));
%             low4=v_low_fine(2*i,2*j-1)-zsh(2*i,2*j-1)+zsH(i,j);
%             low5=v_low_fine(2*i,2*j)-zsh(2*i,2*j)+zsH(i,j);
%             low6=2*(v_low_fine(2,2*j+1)-zsh(2,2*j+1)+1/2*zsH(i,j));
%             low7=v_low_fine(2*i+1,2*j-1)-zsh(2*i+1,2*j-1)+zsH(i,j);
%             low8=v_low_fine(2*i+1,2*j)-zsh(2*i+1,2*j)+zsH(i,j);
%             low9=(v_low_fine(2*i+1,2*j+1)-2*zsh(2*i+1,2*j+1)+zsH(i,j));
%             diffv=[low1,low2,low3,low4,low5,low6, low7, low8, low9];
%             [vl,index]=max(diffv);
%             v_low(i,j)=vl;
%         elseif(i==nm && j==1)
%             low1=(v_low_fine(2*i-1,2*j-1)-2*zsh(2*i-1,2*j-1)+zsH(i,j));
%             low2=v_low_fine(2*i-1,2*j)-zsh(2*i-1,2*j)+zsH(i,j);
%             low3=v_low_fine(2*i-1,2*j+1)-zsh(2*i-1,2*j+1)+zsH(i,j);
%             low4=2*(v_low_fine(2*i,2*j-1)-zsh(2*i,2*j-1)+1/2*zsH(i,j));
%             low5=v_low_fine(2*i,2*j)-zsh(2*i,2*j)+zsH(i,j);
%             low6=v_low_fine(2*i,2*j+1)-zsh(2*i,2*j+1)+zsH(i,j);
%             low7=4*(v_low_fine(2*i+1,2*j-1)-zsh(2*i+1,2*j-1)+1/4*zsH(i,j));
%             low8=2*(v_low_fine(2*i+1,2*j)-zsh(2*i+1,2*j)+1/2*zsH(i,j));
%             low9=(v_low_fine(2*i+1,2*j+1)-2*zsh(2*i+1,2*j+1)+zsH(i,j));
%             diffv=[low1,low2,low3,low4,low5,low6, low7, low8, low9];
%             [vl,index]=max(diffv);
%             v_low(i,j)=vl;
%         elseif(i==nm && j==nm)
%             low1=v_low_fine(2*i-1,2*j-1)-zsh(2*i-1,2*j-1)+zsH(i,j);
%             low2=v_low_fine(2*i-1,2*j)-zsh(2*i-1,2*j)+zsH(i,j);
%             low3=(v_low_fine(2*i-1,2*j+1)-2*zsh(2*i-1,2*j+1)+zsH(i,j));
%             low4=v_low_fine(2*i,2*j-1)-zsh(2*i,2*j-1)+zsH(i,j);
%             low5=v_low_fine(2*i,2*j)-zsh(2*i,2*j)+zsH(i,j);
%             low6=2*(v_low_fine(2*i,2*j+1)-zsh(2*i,2*j+1)+1/2*zsH(i,j));
%             low7=(v_low_fine(2*i+1,2*j-1)-2*zsh(2*i+1,2*j-1)+zsH(i,j));
%             low8=2*(v_low_fine(2*i+1,2*j)-zsh(2*i+1,2*j)+1/2*zsH(i,j));
%             low9=4*(v_low_fine(2*i+1,2*j+1)-zsh(2*i+1,2*j+1)+1/4*zsH(i,j));
%             diffv=[low1,low2,low3,low4,low5,low6, low7, low8, low9];
%             [vl,index]=max(diffv);
%             v_low(i,j)=vl;
%             
%         elseif(i==1)
%             for jj=2:nm-1
%                 low1=(v_low_fine(1,2*jj-1)-2*zsh(1,2*jj-1)+zsH(i,jj));
%                 low2=2*(v_low_fine(1,2*jj)-zsh(1,2*jj)+1/2*zsH(i,jj));
%                 low3=(v_low_fine(1,2*jj+1)-2*zsh(1,2*jj+1)+zsH(i,jj));
%                 low4=v_low_fine(2*i,2*jj-1)-zsh(2*i,2*jj-1)+zsH(i,jj);
%                 low5=v_low_fine(2*i,2*jj)-zsh(2*i,2*jj)+zsH(i,jj);
%                 low6=v_low_fine(2*i,2*jj+1)-zsh(2*i,2*jj+1)+zsH(i,jj);
%                 low7=v_low_fine(2*i+1,2*jj-1)-zsh(2*i+1,2*jj-1)+zsH(i,jj);
%                 low8=v_low_fine(2*i+1,2*jj)-zsh(2*i+1,2*jj)+zsH(i,jj);
%                 low9=v_low_fine(2*i+1,2*jj+1)-zsh(2*i+1,2*jj+1)+zsH(i,jj);
%                 diffv=[low1,low2,low3,low4,low5,low6, low7, low8, low9];
%                 [vl,index]=max(diffv);
%                 v_low(i,jj)=vl;
%             end
%         elseif(i==nm)
%             for jj=2:nm-1
%                 low1=v_low_fine(2*i-1,2*jj-1)-zsh(2*i-1,2*jj-1)+zsH(i,jj);
%                 low2=v_low_fine(2*i-1,2*jj)-zsh(2*i-1,2*jj)+zsH(i,jj);
%                 low3=v_low_fine(2*i-1,2*jj+1)-zsh(2*i-1,2*jj+1)+zsH(i,jj);
%                 low4=v_low_fine(2*i,2*jj-1)-zsh(2*i,2*jj-1)+zsH(i,jj);
%                 low5=v_low_fine(2*i,2*jj)-zsh(2*i,2*jj)+zsH(i,jj);
%                 low6=v_low_fine(2*i,2*jj+1)-zsh(2*i,2*jj+1)+zsH(i,jj);
%                 low7=(v_low_fine(2*i+1,2*jj-1)-2*zsh(2*i+1,2*jj-1)+zsH(i,jj));
%                 low8=2*(v_low_fine(2*i+1,2*jj)-zsh(2*i+1,2*jj)+1/2*zsH(i,jj));
%                 low9=(v_low_fine(2*i+1,2*jj+1)-2*zsh(2*i+1,2*jj+1)+zsH(i,jj));
%                 diffv=[low1,low2,low3,low4,low5,low6, low7, low8, low9];
%                 [vl,index]=max(diffv);
%                 v_low(i,jj)=vl;
%             end
%         elseif(j==1)
%             for ii=2:nm-1
%                 low1=(v_low_fine(2*ii-1,2*j-1)-2*zsh(2*ii-1,2*j-1)+zsH(ii,j));
%                 low2=v_low_fine(2*ii-1,2*j)-zsh(2*ii-1,2*j)+zsH(ii,j);
%                 low3=v_low_fine(2*ii-1,2*j+1)-zsh(2*ii-1,2*j+1)+zsH(ii,j);
%                 low4=2*(v_low_fine(2*ii,2*j-1)-zsh(2*ii,2*j-1)+1/2*zsH(ii,j));
%                 low5=v_low_fine(2*ii,2*j)-zsh(2*ii,2*j)+zsH(ii,j);
%                 low6=v_low_fine(2*ii,2*j+1)-zsh(2*ii,2*j+1)+zsH(ii,j);
%                 low7=(v_low_fine(2*ii+1,2*j-1)-2*zsh(2*ii+1,2*j-1)+zsH(ii,j));
%                 low8=v_low_fine(2*ii+1,2*j)-zsh(2*ii+1,2*j)+zsH(ii,j);
%                 low9=v_low_fine(2*ii+1,2*j+1)-zsh(2*ii+1,2*j+1)+zsH(ii,j);
%                 diffv=[low1,low2,low3,low4,low5,low6, low7, low8, low9];
%                 [vl,index]=max(diffv);
%                 v_low(ii,j)=vl;
%             end
%         elseif(j==nm)
%             for ii=2:nm-1
%                 low1=v_low_fine(2*ii-1,2*j-1)-zsh(2*ii-1,2*j-1)+zsH(ii,j);
%                 low2=v_low_fine(2*ii-1,2*j)-zsh(2*ii-1,2*j)+zsH(ii,j);
%                 low3=(v_low_fine(2*ii-1,2*j+1)-2*zsh(2*ii-1,2*j+1)+zsH(ii,j));
%                 low4=v_low_fine(2*ii,2*j-1)-zsh(2*ii,2*j-1)+zsH(ii,j);
%                 low5=v_low_fine(2*ii,2*j)-zsh(2*ii,2*j)+zsH(ii,j);
%                 low6=2*(v_low_fine(2*ii,2*j+1)-zsh(2*ii,2*j+1)+1/2*zsH(ii,j));
%                 low7=v_low_fine(2*ii+1,2*j-1)-zsh(2*ii+1,2*j-1)+zsH(ii,j);
%                 low8=v_low_fine(2*ii+1,2*j)-zsh(2*ii+1,2*j)+zsH(ii,j);
%                 low9=(v_low_fine(2*ii+1,2*j+1)-2*zsh(2*ii+1,2*j+1)+zsH(ii,j));
%                 diffv=[low1,low2,low3,low4,low5,low6, low7, low8, low9];
%                 [vl,index]=max(diffv);
%                 v_low(ii,j)=vl;
%             end
%         else
%             low1=v_low_fine(2*i-1,2*j-1)-zsh(2*i-1,2*j-1);
%             low2=v_low_fine(2*i-1,2*j)-zsh(2*i-1,2*j);
%             low3=v_low_fine(2*i-1,2*j+1)-zsh(2*i-1,2*j+1);
%             low4=v_low_fine(2*i,2*j-1)-zsh(2*i,2*j-1);
%             low5=v_low_fine(2*i,2*j)-zsh(2*i,2*j);
%             low6=v_low_fine(2*i,2*j+1)-zsh(2*i,2*j+1);
%             low7=v_low_fine(2*i+1,2*j-1)-zsh(2*i+1,2*j-1);
%             low8=v_low_fine(2*i+1,2*j)-zsh(2*i+1,2*j);
%             low9=v_low_fine(2*i+1,2*j+1)-zsh(2*i+1,2*j+1);
%             diffv=[low1,low2,low3,low4,low5,low6, low7, low8, low9];
%             [vl,index]=max(diffv);
%             v_low(i,j)=vl+zsH(i,j);
%         end
%     end
% end
%         v_low  = v_low(:);
%         v_up=1e10*ones(N(ind)^2,1); %%%%%%%%%one side bound

%%%%%%%%%%%%%%%%%%%%#######################################################
v_up_fine = vup{ind-1};
v_up=zeros(N(ind),N(ind));
finev=bind{ind};
nm=N(ind-1);
v_up_fine= reshape(v_up_fine,nm,nm);
zsh  = reshape(finev,nm,nm);
currentv=bindH{ind};
nm=N(ind);
zsH  = reshape(currentv,nm,nm);
for i=1:nm     %%% from top row of nine point_stencil
    for j=1:nm
        if (i==1 && j==1)
            up1=4*(v_up_fine(1,1)-zsh(1,1)+1/4*zsH(1,1));
            up2=2*(v_up_fine(1,2)-zsh(1,2)+1/2*zsH(1,1));
            up3=(v_up_fine(1,3)-2*zsh(1,3)+zsH(1,1));
            up4=2*(v_up_fine(2,1)-zsh(2,1)+1/2*zsH(1,1));
            up5=v_up_fine(2*i,2*j)-zsh(2*i,2*j)+zsH(i,j);
            up6=v_up_fine(2*i,2*j+1)-zsh(2*i,2*j+1)+zsH(i,j);
            up7=(v_up_fine(3,1)-2*zsh(3,1)+zsH(1,1));
            up8=v_up_fine(2*i+1,2*j)-zsh(2*i+1,2*j)+zsH(i,j);
            up9=v_up_fine(2*i+1,2*j+1)-zsh(2*i+1,2*j+1)+zsH(i,j);
            diffv=[up1,up2,up3,up4,up5,up6, up7, up8, up9];
            [vl,index]=min(diffv);
            vl=max(vl,zsH(i,j));
            v_up(i,j)=vl;
        elseif(i==1 && j==nm)
            up1=(v_up_fine(1,2*j-1)-2*zsh(1,2*j-1)+zsH(i,j));
            up2=2*(v_up_fine(1,2*j)-zsh(1,2*j)+1/2*zsH(i,j));
            up3=4*(v_up_fine(1,2*j+1)-zsh(1,2*j+1)+1/4*zsH(i,j));
            up4=v_up_fine(2*i,2*j-1)-zsh(2*i,2*j-1)+zsH(i,j);
            up5=v_up_fine(2*i,2*j)-zsh(2*i,2*j)+zsH(i,j);
            up6=2*(v_up_fine(2,2*j+1)-zsh(2,2*j+1)+1/2*zsH(i,j));
            up7=v_up_fine(2*i+1,2*j-1)-zsh(2*i+1,2*j-1)+zsH(i,j);
            up8=v_up_fine(2*i+1,2*j)-zsh(2*i+1,2*j)+zsH(i,j);
            up9=(v_up_fine(2*i+1,2*j+1)-2*zsh(2*i+1,2*j+1)+zsH(i,j));
            diffv=[up1,up2,up3,up4,up5,up6, up7, up8, up9];
            [vl,index]=min(diffv);
            vl=max(vl,zsH(i,j));
            v_up(i,j)=vl;
        elseif(i==nm && j==1)
            up1=(v_up_fine(2*i-1,2*j-1)-2*zsh(2*i-1,2*j-1)+zsH(i,j));
            up2=v_up_fine(2*i-1,2*j)-zsh(2*i-1,2*j)+zsH(i,j);
            up3=v_up_fine(2*i-1,2*j+1)-zsh(2*i-1,2*j+1)+zsH(i,j);
            up4=2*(v_up_fine(2*i,2*j-1)-zsh(2*i,2*j-1)+1/2*zsH(i,j));
            up5=v_up_fine(2*i,2*j)-zsh(2*i,2*j)+zsH(i,j);
            up6=v_up_fine(2*i,2*j+1)-zsh(2*i,2*j+1)+zsH(i,j);
            up7=4*(v_up_fine(2*i+1,2*j-1)-zsh(2*i+1,2*j-1)+1/4*zsH(i,j));
            up8=2*(v_up_fine(2*i+1,2*j)-zsh(2*i+1,2*j)+1/2*zsH(i,j));
            up9=(v_up_fine(2*i+1,2*j+1)-2*zsh(2*i+1,2*j+1)+zsH(i,j));
            diffv=[up1,up2,up3,up4,up5,up6, up7, up8, up9];
            [vl,index]=min(diffv);
            vl=max(vl,zsH(i,j));
            v_up(i,j)=vl;
        elseif(i==nm && j==nm)
            up1=v_up_fine(2*i-1,2*j-1)-zsh(2*i-1,2*j-1)+zsH(i,j);
            up2=v_up_fine(2*i-1,2*j)-zsh(2*i-1,2*j)+zsH(i,j);
            up3=(v_up_fine(2*i-1,2*j+1)-2*zsh(2*i-1,2*j+1)+zsH(i,j));
            up4=v_up_fine(2*i,2*j-1)-zsh(2*i,2*j-1)+zsH(i,j);
            up5=v_up_fine(2*i,2*j)-zsh(2*i,2*j)+zsH(i,j);
            up6=2*(v_up_fine(2*i,2*j+1)-zsh(2*i,2*j+1)+1/2*zsH(i,j));
            up7=(v_up_fine(2*i+1,2*j-1)-2*zsh(2*i+1,2*j-1)+zsH(i,j));
            up8=2*(v_up_fine(2*i+1,2*j)-zsh(2*i+1,2*j)+1/2*zsH(i,j));
            up9=4*(v_up_fine(2*i+1,2*j+1)-zsh(2*i+1,2*j+1)+1/4*zsH(i,j));
            diffv=[up1,up2,up3,up4,up5,up6, up7, up8, up9];
            [vl,index]=min(diffv);
            vl=max(vl,zsH(i,j));
            v_up(i,j)=vl;
            
        elseif(i==1)
            for jj=2:nm-1
                up1=(v_up_fine(1,2*jj-1)-2*zsh(1,2*jj-1)+zsH(i,jj));
                up2=2*(v_up_fine(1,2*jj)-zsh(1,2*jj)+1/2*zsH(i,jj));
                up3=(v_up_fine(1,2*jj+1)-2*zsh(1,2*jj+1)+zsH(i,jj));
                up4=v_up_fine(2*i,2*jj-1)-zsh(2*i,2*jj-1)+zsH(i,jj);
                up5=v_up_fine(2*i,2*jj)-zsh(2*i,2*jj)+zsH(i,jj);
                up6=v_up_fine(2*i,2*jj+1)-zsh(2*i,2*jj+1)+zsH(i,jj);
                up7=v_up_fine(2*i+1,2*jj-1)-zsh(2*i+1,2*jj-1)+zsH(i,jj);
                up8=v_up_fine(2*i+1,2*jj)-zsh(2*i+1,2*jj)+zsH(i,jj);
                up9=v_up_fine(2*i+1,2*jj+1)-zsh(2*i+1,2*jj+1)+zsH(i,jj);
                diffv=[up1,up2,up3,up4,up5,up6, up7, up8, up9];
                [vl,index]=min(diffv);
                vl=max(vl,zsH(i,jj));
                v_up(i,jj)=vl;
            end
        elseif(i==nm)
            for jj=2:nm-1
                up1=v_up_fine(2*i-1,2*jj-1)-zsh(2*i-1,2*jj-1)+zsH(i,jj);
                up2=v_up_fine(2*i-1,2*jj)-zsh(2*i-1,2*jj)+zsH(i,jj);
                up3=v_up_fine(2*i-1,2*jj+1)-zsh(2*i-1,2*jj+1)+zsH(i,jj);
                up4=v_up_fine(2*i,2*jj-1)-zsh(2*i,2*jj-1)+zsH(i,jj);
                up5=v_up_fine(2*i,2*jj)-zsh(2*i,2*jj)+zsH(i,jj);
                up6=v_up_fine(2*i,2*jj+1)-zsh(2*i,2*jj+1)+zsH(i,jj);
                up7=(v_up_fine(2*i+1,2*jj-1)-2*zsh(2*i+1,2*jj-1)+zsH(i,jj));
                up8=2*(v_up_fine(2*i+1,2*jj)-zsh(2*i+1,2*jj)+1/2*zsH(i,jj));
                up9=(v_up_fine(2*i+1,2*jj+1)-2*zsh(2*i+1,2*jj+1)+zsH(i,jj));
                diffv=[up1,up2,up3,up4,up5,up6, up7, up8, up9];
                [vl,index]=min(diffv);
                vl=max(vl,zsH(i,jj));
                v_up(i,jj)=vl;
            end
        elseif(j==1)
            for ii=2:nm-1
                up1=(v_up_fine(2*ii-1,2*j-1)-2*zsh(2*ii-1,2*j-1)+zsH(ii,j));
                up2=v_up_fine(2*ii-1,2*j)-zsh(2*ii-1,2*j)+zsH(ii,j);
                up3=v_up_fine(2*ii-1,2*j+1)-zsh(2*ii-1,2*j+1)+zsH(ii,j);
                up4=2*(v_up_fine(2*ii,2*j-1)-zsh(2*ii,2*j-1)+1/2*zsH(ii,j));
                up5=v_up_fine(2*ii,2*j)-zsh(2*ii,2*j)+zsH(ii,j);
                up6=v_up_fine(2*ii,2*j+1)-zsh(2*ii,2*j+1)+zsH(ii,j);
                up7=(v_up_fine(2*ii+1,2*j-1)-2*zsh(2*ii+1,2*j-1)+zsH(ii,j));
                up8=v_up_fine(2*ii+1,2*j)-zsh(2*ii+1,2*j)+zsH(ii,j);
                up9=v_up_fine(2*ii+1,2*j+1)-zsh(2*ii+1,2*j+1)+zsH(ii,j);
                diffv=[up1,up2,up3,up4,up5,up6, up7, up8, up9];
                [vl,index]=min(diffv);
                vl=max(vl,zsH(ii,j));
                v_up(ii,j)=vl;
            end
        elseif(j==nm)
            for ii=2:nm-1
                up1=v_up_fine(2*ii-1,2*j-1)-zsh(2*ii-1,2*j-1)+zsH(ii,j);
                up2=v_up_fine(2*ii-1,2*j)-zsh(2*ii-1,2*j)+zsH(ii,j);
                up3=(v_up_fine(2*ii-1,2*j+1)-2*zsh(2*ii-1,2*j+1)+zsH(ii,j));
                up4=v_up_fine(2*ii,2*j-1)-zsh(2*ii,2*j-1)+zsH(ii,j);
                up5=v_up_fine(2*ii,2*j)-zsh(2*ii,2*j)+zsH(ii,j);
                up6=2*(v_up_fine(2*ii,2*j+1)-zsh(2*ii,2*j+1)+1/2*zsH(ii,j));
                up7=v_up_fine(2*ii+1,2*j-1)-zsh(2*ii+1,2*j-1)+zsH(ii,j);
                up8=v_up_fine(2*ii+1,2*j)-zsh(2*ii+1,2*j)+zsH(ii,j);
                up9=(v_up_fine(2*ii+1,2*j+1)-2*zsh(2*ii+1,2*j+1)+zsH(ii,j));
                diffv=[up1,up2,up3,up4,up5,up6, up7, up8, up9];
                [vl,index]=min(diffv);
                vl=max(vl,zsH(ii,j));
                v_up(ii,j)=vl;
            end
        else
            up1=v_up_fine(2*i-1,2*j-1)-zsh(2*i-1,2*j-1);
            up2=v_up_fine(2*i-1,2*j)-zsh(2*i-1,2*j);
            up3=v_up_fine(2*i-1,2*j+1)-zsh(2*i-1,2*j+1);
            up4=v_up_fine(2*i,2*j-1)-zsh(2*i,2*j-1);
            up5=v_up_fine(2*i,2*j)-zsh(2*i,2*j);
            up6=v_up_fine(2*i,2*j+1)-zsh(2*i,2*j+1);
            up7=v_up_fine(2*i+1,2*j-1)-zsh(2*i+1,2*j-1);
            up8=v_up_fine(2*i+1,2*j)-zsh(2*i+1,2*j);
            up9=v_up_fine(2*i+1,2*j+1)-zsh(2*i+1,2*j+1);
            diffv=[up1,up2,up3,up4,up5,up6, up7, up8, up9];
            [vl,index]=min(diffv);
            v_up(i,j)=max(vl+zsH(i,j), zsH(i,j));
        end
    end
end
        v_up  = v_up(:);
       % figure(124);hold on; plot(1:N(ind)^2,37,'r.-',1:N(ind)^2,v_up,'b.-');% subplot(2,1,2); plot(v_up,'b.-')
%         figure(134);subplot(2,1,1);plot(1:N(ind-1)^2,finv,'r.-');
%     subplot(2,1,2);
%     plot(1:N(ind)^2,currentv,'b.-');pause
        v_low=-1e10*ones(N(ind)^2,1); %%%%%%%%%one side bound

        
        
