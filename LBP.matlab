function feature = LBP(data, cellSize)
	%perform get the local binary patterns in a dataset
	numCells = ceil(size(data)-2/cellSize);
	%create a 4D array of uint8s
	cells = uint8(zeros(numCells(1),numCells(2),cellSize+2,cellSize+2));
	for y=1:numCells(2)
		for x=1:numCells(1)
			%we extract the cell as well as a border surrounding it
			cell = data(x*cellSize:(x+1)*cellSize+2)
			%get the local binay patterns from the cell
			transform = getLBP(cell);
			%get the histogram of the transform, normalize it and concatenate it to our feature
			feature =[feature,hist2D(transform,1)/norm(hist2D(transform,1))];
		end
	end
end