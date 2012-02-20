function result = convertBinArrayToInt(binArray)
	%converts an arbitrary-length array of binary values into an integer 
	%find the most appropriate variable
	if(length(binArray)<9)
		result = uint8(0);
	elseif(length(binArray)<17)
		result = uint16(0);
	elseif(length(binArray)<33)
		result=uint32(0);
	elseif(length(binArray)<65)
		result = uint64(0)
	else
		result = 0;
		disp('Error in ConvertBinArrayToInt: The input array have a length of 64 or less');
		return;
	end
	%Convert the binary array into an integer value
	multiplier = 1;
	for i=1:length(binArray)
		result = result + binArray(i)*multiplier;
		multiplier = multiplier * 2;
	end
end