function transform = getLBP(data, R, P)
	transform = uint8(zeros(size(data,1)-R-R-1,size(data,1)-R-R-1));
	%start with a naive approach, pretty sure we can use some array tricks to speed this up
	%for each pixel in the cell, compare with surrounding neighbours
	%this function returns a map of values (0-256) which is a binary representation of whether each neighbour is greater than the centre
	%e.g. 142 = [1,0,0,0,1,1,1,0]
    %compute the set of points on the circle
    %these points will offset the x and y coordinates in our search, which will define
    %the center of the circle
    %R = radius of the circle
    %P = # of points
    points = zeros(P,2);
    for p = 1:P
        points(p,1) = round(-R*sin(2*pi*p/P));
        points(p,2) = round(R*cos(2*pi*p/P));
    end
	for x=R+1:size(data,1)-R
		for y=R+1:size(data,2)-R
            %get the binary pattern at point (x,y)
			currentPattern = false(P);
            for p = 1:P
                offset = points(p,:);
                currentPattern(p) = data(x+offset(1),y+offset(2)) > data(x,y);
            end
			%convert the binary array to an integer and store
			transform(x-R,y-R)=convertBinArrayToInt(currentPattern);
		end
	end
end