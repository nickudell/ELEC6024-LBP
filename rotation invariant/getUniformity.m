function U = getUniformity(pattern)
    %gets the uniformity value U of a pattern
    P = length(pattern);
    U = 0;
    for p = 1:P-1
        U = U + (pattern(p) ~= pattern(p+1));
    end
    U = U + (pattern(P) ~= pattern(1));
end