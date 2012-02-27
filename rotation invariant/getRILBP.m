function transform = getRILBP(data, R, P)
	transform = uint8(zeros(size(data,1)-R-R-1,size(data,1)-R-R-1));
	%Get rotation-invariant LBP using uniformity    
    %compute the set of points on the circle
    %these points will offset the x and y coordinates in our search, which will define
    %the center of the circle
    %R = radius of the circle
    %P = # of points
    points = zeros(P,2);
    for p = 1:P
        points(p,1) = round(-R*sin((2*pi*p)/P));
        points(p,2) = round(R*cos((2*pi*p)/P));
    end
	for x=R+1:size(data,1)-R
		for y=R+1:size(data,2)-R
            %get the binary pattern at point (x,y)
			currentPattern = false(P,1);
            val = data(x,y);
            for p = 1:P
                offset = points(p,:);
                currentPattern(p) = data(x+offset(1),y+offset(2)) > val;
            end
            %get the uniformity of the pattern
            uniformity = getUniformity(currentPattern);
            %lump all values of uniformity >2 in one bin
            if(uniformity <=2)
                transform(x-R,y-R) = sum(sum(currentPattern));
            else
                transform(x-R,y-R) = P + 1;
            end
		end
	end
end