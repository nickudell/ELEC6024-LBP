function result = hist2D(data, maxValue)
    %computes the histogram of 2D data
	result = zeros(maxValue+1,1);
    for x = 1:size(data,1)
        for y = 1:size(data,2)
            for z = 1:size(data,3)
                result(round(data(x,y,z)+1)) = result(round(data(x,y,z)+1)) + 1;
            end
        end
    end
end