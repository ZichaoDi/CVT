function  energia = energy_continuousTN(XY)
global mminx mmaxx mminy mmaxy  bd
warning off MATLAB:divideByZero
m=size(XY,2);energia=0;
B=zeros(length(bd),1);
for i=1:length(bd)
    dist=[];
    for j=1:m
        dist(j)=(XY(1,j)-bd(1,i))^2+(XY(2,j)-bd(2,i))^2;
    end
    [val,ind]=min(dist);
    B(i)=ind;
end
% B=zeros(length(bd),1);
% for i=1:length(bd)
%     dist=[];
%     for j=1:80
%         dist(j)=(XY(1,j)-bd(1,i))^2+(XY(2,j)-bd(2,i))^2;
%     end
%     [val,ind]=min(dist);
%     B(i)=ind;
% end
[v,c] = voronoin(XY');
test1 = find(XY(1,:)<mminx |XY(1,:)>mmaxx);
                test2 = find(XY(2,:)<mminy | XY(2,:)>mmaxy);
                if (~isempty(test1) | ~isempty(test2)),XY(1,test1),XY(2,test2),fprintf('out of bound\n'); return; end
for i=1:m
    
    func=@(x,y)(((x-XY(1,i))^2+(y-XY(2,i))^2));
    vc=v(c{i},:);
    infind=find(vc(:,1)==inf);
    outind=find(vc(:,1)>mmaxx|vc(:,1)<mminx|vc(:,2)<mminy|vc(:,2)>mmaxy);
subenergy=0;
    if (isempty(infind)&&isempty(outind))
        tri=delaunay(vc(:,1),vc(:,2));
        
        for j=1:size(tri,1)
            sub=triangleQuad(func,[vc(tri(j,1),1);vc(tri(j,2),1);vc(tri(j,3),1)],[vc(tri(j,1),2);vc(tri(j,2),2);vc(tri(j,3),2)]);
            subenergy=subenergy+sub;
        end
    else 
%         gind=find(vc(:,1)~=inf);
%         in=inpolygon(bd(1,:),bd(2,:),vc(gind,1),vc(gind,2));goodind=find(vc(:,1)~=inf&vc(:,1)<=mmaxx&vc(:,1)>=mminx&vc(:,2)>=mminy&vc(:,2)<=mmaxy);
%         bx=[bd(1,in),vc(goodind,1)'];
%         by=[bd(2,in),vc(goodind,2)'];in=length(in);goodind=length(goodind);
gind=find(B==i);
        goodind=find(vc(:,1)~=inf&vc(:,1)<=mmaxx&vc(:,1)>=mminx&vc(:,2)>=mminy&vc(:,2)<=mmaxy);
         bx=[bd(1,gind),vc(goodind,1)'];
         by=[bd(2,gind),vc(goodind,2)']; 
        conind=convhull(bx,by);
        %         rep=find(conind<=in);
        %         if(length(unique(bd(1,rep)))==1) ay=find(max(bd(2,rep)));iy=find(min(bd(2,rep)));bx=[bd(1,iy),bd(1,ay),vc(goodind,1)'];
        %             by=[bd(2,iy),bd(2,ay),vc(goodind,2)'];conind=convhull(bx,by);
        %         elseif(length(unique(bd(2,rep)))==1)ax=find(max(bd(1,rep)));ix=find(min(bd(1,rep)));bx=[bd(1,ix),bd(1,ax),vc(goodind,1)'];
        %             by=[bd(2,ix),bd(2,ax),vc(goodind,2)'];conind=convhull(bx,by);
        %         else ay=find(max(bd(2,rep)));iy=find(min(bd(2,rep)));ax=find(max(bd(1,rep)));ix=find(min(bd(1,rep)));
        %             if(ix==iy)
        %                 bx=[bd(1,ix),bd(1,ix),bd(1,ax),vc(goodind,1)'];by=[bd(2,ay),bd(2,iy),bd(2,iy),vc(goodind,2)'];conind=convhull(bx,by);
        %             elseif(ax==iy)bx=[bd(1,ix),bd(1,ax),bd(1,ax),vc(goodind,1)'];by=[bd(2,iy),bd(2,iy),bd(2,ay),vc(goodind,2)'];conind=convhull(bx,by);
        %             elseif(ax==ay)bx=[bd(1,ax),bd(1,ax),bd(1,ix),vc(goodind,1)'];by=[bd(2,iy),bd(2,ay),bd(2,ay),vc(goodind,2)'];conind=convhull(bx,by);
        %             else bx=[bd(1,ix),bd(1,ix),bd(1,ax),vc(goodind,1)'];by=[bd(2,iy),bd(2,ay),bd(2,ay),vc(goodind,2)'];conind=convhull(bx,by);
        %             end
        %
        
        tri=delaunay(bx(conind),by(conind));
        bx1=bx(conind);by1=by(conind);
        for j=1:size(tri,1)
            sub=triangleQuad(func,[bx1(tri(j,1));bx1(tri(j,2));bx1(tri(j,3))],[by1(tri(j,1));by1(tri(j,2));by1(tri(j,3))]);
            subenergy=subenergy+sub;
        end
%         if(i==27) 
%             figure(4);triplot(tri,bx(conind),by(conind),'r.-');hold on;plot(XY(1,27),XY(2,27),'BX');pause(1);end
    end
    
    
    energia  = energia +subenergy;
end


