P=rand(5,2);
t = delaunay ( P(:,1), P(:,2) );
xs = rand ( 10, 1 );
ys = rand ( 10, 1 );
voronoi ( P(:,1), P(:,2), t )
hold on
k(1:10,1) = dsearch ( P(:,1), P(:,2), t, xs, ys );
 count(1:5) = accumarray ( k, ones(10,1) );
      centroid(1,1:5) = accumarray ( k, xs );
      centroid(2,1:5) = accumarray ( k, ys );

    
      for i = 1 : 10
        j = k(i);
        count(j) = count(j) + 1;
        centroid(1,j) = centroid(1,j) + xs(i);
        centroid(2,j) = centroid(2,j) + ys(i);
      end
%  plot(centroid(1,1:5),centroid(2,1:5))
   
