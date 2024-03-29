function out = cutpoly(vert, in)
global mminx mminy mmaxx mmaxy;

bad = length(in);
num = size(vert,1);
out = []; ii=1;
array = find(in);
for index = 1:num

    if (ismember(index,array))
        out(ii,:) = vert(index,:); ii = ii+1; continue;
    end
    if (index==1) prev = num; else prev = index-1; end

        if (vert(index,2)==vert(prev,2)) % horizontal line
            ys = vert(index,2); xs = mminx;
            a1 = (xs-vert(index,1))/(vert(prev,1)-vert(index,1));
            if (a1>=0 & a1<=1 & ys>=mminy & ys<=mmaxy)
                out(ii,:) = [xs ys]; ii=ii+1;
                continue;
            end
            xs = mmaxx;
            a1 = (xs-vert(index,1))/(vert(prev,1)-vert(index,1));
            if (a1>=0 & a1<=1 & ys>=mminy & ys<=mmaxy)
                out(ii,:) = [xs ys]; 
                ii = ii+1;
                continue;
            end
        elseif (vert(index,1)==vert(prev,1)) % vertical line
            ys = mminy; xs = vert(index,1);
            a2 = (ys-vert(index,2))/(vert(prev,2)-vert(index,2));
            if (a2>=0 & a2<=1 & xs>=mminx & xs<=mmaxx)
                out(ii,:) = [xs ys];
                ii = ii+1; 
                continue;
            end
            ys = mmaxy;
            a2 = (ys-vert(index,2))/(vert(prev,2)-vert(index,2));
            if (a2>=0 & a2<=1 & xs>=mminx & xs<=mmaxx)
                out(ii,:) = [xs ys];
                ii = ii+1; 
                continue;
            end
        else % general case
            k = (vert(index,2)-vert(prev,2))/(vert(index,1)-vert(prev,1)); %slope

            ys3 = vert(index,2) + k *(mminx - vert(index,1)); xs3 = mminx;
            a1 = (xs3-vert(index,1))/(vert(prev,1)-vert(index,1));
            %a2 = (ys3-vert(index,2))/(vert(prev,2)-vert(index,2))
            if (a1>=0 & a1<=1 & ys3>=mminy & ys3<=mmaxy)
                out(ii,:) = [xs3 ys3]; ii = ii+1; %disp('3 worked');
                continue;
            end
            ys4 = vert(index,2) + k *(mmaxx - vert(index,1)); xs4 = mmaxx;
            a1 = (xs4-vert(index,1))/(vert(prev,1)-vert(index,1));
            %a2 = (ys4-vert(index,2))/(vert(prev,2)-vert(index,2))
            if (a1>=0 & a1<=1 & ys4>=mminy & ys4<=mmaxy)               
                out(ii,:) = [xs4 ys4]; ii = ii+1; %disp('4 worked');
                continue;
            end
            xs1 = vert(index,1) + (mminy - vert(index,2))/k; ys1 = mminy;
            a1 = (xs1-vert(index,1))/(vert(prev,1)-vert(index,1));
            %a2 = (ys1-vert(index,2))/(vert(prev,2)-vert(index,2))
            if (a1>=0 & a1<=1 & xs1>=mminx & xs1<=mmaxx)
                out(ii,:) = [xs1 ys1]; ii = ii+1; %disp('1 worked');
                continue;
            end
            xs2 = vert(index,1) + (mmaxy - vert(index,2))/k; ys2 = mmaxy;
            a1 = (xs2-vert(index,1))/(vert(prev,1)-vert(index,1));
            %a2 = (ys2-vert(index,2))/(vert(prev,2)-vert(index,2))
            if (a1>=0 & a1<=1 & xs2>=mminx & xs2<=mmaxx)
                out(ii,:) = [xs2 ys2]; ii = ii+1; %disp('2 worked');
                continue;
            end
        end
    %end
end
for index=1:num
    if (ismember(index,array))
        out(ii,:) = vert(index,:); ii = ii+1; continue;
    end
    if (index==num) prev = 1; else prev = index+1; end

        if (vert(index,2)==vert(prev,2)) % horizontal line
            ys = vert(index,2); xs = mminx;
            a1 = (xs-vert(index,1))/(vert(prev,1)-vert(index,1));
            if (a1>=0 & a1<=1 & ys>=mminy & ys<=mmaxy)
                out(ii,:) = [xs ys]; ii = ii+1; %disp('hor worked');
                continue;
            end
            xs = mmaxx;
            a1 = (xs-vert(index,1))/(vert(prev,1)-vert(index,1));
            if (a1>=0 & a1<=1 & ys>=mminy & ys<=mmaxy)
                out(ii,:) = [xs ys]; ii = ii+1; %disp('hor worked');
                continue;
            end
        elseif (vert(index,1)==vert(prev,1)) % vertical line
            ys = mminy; xs = vert(index,1);
            a2 = (ys-vert(index,2))/(vert(prev,2)-vert(index,2));
            if (a2>=0 & a2<=1 & xs>=mminx & xs<=mmaxx)
                out(ii,:) = [xs ys]; ii = ii+1; %disp('vert worked');
                continue;
            end
            ys = mmaxy;
            a2 = (ys-vert(index,2))/(vert(prev,2)-vert(index,2));
            if (a2>=0 & a2<=1 & xs>=mminx & xs<=mmaxx)
                out(ii,:) = [xs ys]; ii = ii+1; %disp('vert worked');
                continue;
            end
        else
            k = (vert(index,2)-vert(prev,2))/(vert(index,1)-vert(prev,1)); %slope

            xs1 = vert(index,1) + (mminy - vert(index,2))/k; ys1 = mminy;
            a1 = (xs1-vert(index,1))/(vert(prev,1)-vert(index,1));
            %a2 = (ys1-vert(index,2))/(vert(prev,2)-vert(index,2))
            if (a1>=0 & a1<=1 & xs1>=mminx & xs1<=mmaxx)
                out(ii,:) = [xs1 ys1]; ii = ii+1; %disp('with mminy');
                continue;
            end
            xs2 = vert(index,1) + (mmaxy - vert(index,2))/k; ys2 = mmaxy;
            a1 = (xs2-vert(index,1))/(vert(prev,1)-vert(index,1));
            %a2 = (ys2-vert(index,2))/(vert(prev,2)-vert(index,2))
            if (a1>=0 & a1<=1 & xs2>=mminx & xs2<=mmaxx)
                out(ii,:) = [xs2 ys2]; ii = ii+1; %disp('with mmaxy');
                continue;
            end
            ys3 = vert(index,2) + k *(mminx - vert(index,1)); xs3 = mminx;
            a1 = (xs3-vert(index,1))/(vert(prev,1)-vert(index,1));
            %a2 = (ys3-vert(index,2))/(vert(prev,2)-vert(index,2))
            if (a1>=0 & a1<=1 & ys3>=mminy & ys3<=mmaxy)
                out(ii,:) = [xs3 ys3]; ii = ii+1; %disp('with mminx');
                continue;
            end
            ys4 = vert(index,2) + k *(mmaxx - vert(index,1)); xs4 = mmaxx;
            a1 = (xs4-vert(index,1))/(vert(prev,1)-vert(index,1));
            %a2 = (ys4-vert(index,2))/(vert(prev,2)-vert(index,2))
            if (a1>=0 & a1<=1 & ys4>=mminy & ys4<=mmaxy)
                out(ii,:) = [xs4 ys4]; ii = ii+1; %disp('with mmaxx');
                continue;
            end
        end
    %end
end

