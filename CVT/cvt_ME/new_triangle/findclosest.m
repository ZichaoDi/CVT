function [nearest,distance] = findClosest( cellGens, point )
%global N;
    size(point);
    size(cellGens);
	distance = realmax;
	N = size( cellGens,1 );
	for i = 1:N
		
		distSq = sum( ( cellGens(i,1:2) - point ).^2 );
		if distSq < distance 
			distance = distSq;
			nearest = i;
		end 
	end
	distance = sqrt( distance );
