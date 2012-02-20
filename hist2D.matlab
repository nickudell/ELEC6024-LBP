function histogram = hist2D(data, minValue, maxValue, binSize)
	%computes the histogram of a 2D image
	histogram = zeros(ceil((maxValue - minValue)/binSize));

	for x = 1:size(data,1)
		for y = 1:size(data,2)
			%here each bin starts at the bin number, for bins that centre around the bin value, replace floor with round
			histogram(floor(data(x,y)-minValue/binSize)+1) = histogram(floor(data(x,y)-minValue/binSize)+1)+1;
		end
	end
end