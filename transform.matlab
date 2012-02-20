function transform = getLBP(data, position, width, height)
	transform = uint8(zeros(size(data,1)-2,size(data,1)-2));
	%start with a naive approach, pretty sure we can use some array tricks to speed this up
	%for each pixel in the cell, compare with surrounding neighbours
	%this function returns a map of value (0-256) which is a binary representation of whether each neighbour is greater than the centre
	%e.g. 142 = [1,0,0,0,1,1,1,0] 
	for x=2:size(data,1)-1
		for y=2:size(data,2)-1
			currentCell = false(8);
			%top-left pixel
			offset= = [-1,-1];
			i = 1;
			currentCell(i) = data(x+offset(1),y+offset(1)) > data(x,y);
			%top pixel
			offset= = [0,-1];
			i = 2;
			currentCell(i) = data(x+offset(1),y+offset(1)) > data(x,y);
			%top-right pixel
			offset= = [1,-1];
			i = 3;
			currentCell(i) = data(x+offset(1),y+offset(1)) > data(x,y);
			%middle-right pixel
			offset= = [1,0];
			i = 4;
			currentCell(i) = data(x+offset(1),y+offset(1)) > data(x,y);
			%bottom-right pixel
			offset= = [1,1];
			i = 5;
			currentCell(i) = data(x+offset(1),y+offset(1)) > data(x,y);
			%bottom pixel
			offset= = [0,1];
			i = 6;
			currentCell(i) = data(x+offset(1),y+offset(1)) > data(x,y);
			%bottom-left pixel
			offset= = [-1,1];
			i = 7;
			currentCell(i) = data(x+offset(1),y+offset(1)) > data(x,y);
			%middle-left pixel
			offset= = [-1,0];
			i = 8;
			currentCell(i) = data(x+offset(1),y+offset(1)) > data(x,y);
			%convert the binary array to an integer and store
			transform(x-1,y-1)=convertBinArrayToInt(currentCell);
		end
	end
end