function transform = postConvertToRI(data, P)
    transform = zeros(size(data,1),size(data,2));
    %lookup table for converting pattern types into rotation invariant
    %uniform patterns
    look_up = zeros(pow(2,P),1);
    for i = 1:pow(2,P)
        pattern = int2bin(i);
        U = getUniformity(pattern);
        if(U >2)
            look_up(i) = P+1;
        else
            look_up(i) = sum(pattern);
        end
    end
    for x=0:size(data,1)
        for y = 0:size(data,2)
            transform(x,y) = look_up(data(x,y));
        end
    end
end