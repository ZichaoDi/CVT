function dvec = dindex_vecTN(XY,VXY)
sz = size(XY,2);szV = size(VXY,1);
%if (diff(XY,sz)==0) return;end
[v,c] = voronoin(XY');

dvec = zeros(szV,1);
ii=1;
for jj = 1:szV %loop in pixels (points VXY)
    while(ii<=size(c,1)) %loop in Voronoi cells
      
        TF=isinf(v(c{ii},:));
        if TF ==zeros(size(v(c{ii},:)))
            in = inpolygon(VXY(jj,1),VXY(jj,2),v(c{ii},1),v(c{ii},2));
            if (in==1) dvec(jj)=ii; break; end
        end
        ii=ii+1;
    end
    if (dvec(jj)==0) %if a problem with inpolygon occured
        dist  =[];
        
        %if (sz==1) minrad=1; maxrad = 1; return; end
        for gg=1:sz
            dist = [dist,norm(VXY(jj,:)-XY(:,gg)')];
        end
        
        [mindist,index] = min(dist);
        dvec(jj)=index;
        
    end
    
end