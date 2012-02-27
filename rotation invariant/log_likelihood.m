function lsm = log_likelihood(sample, model)
    B = min(length(sample),length(model));
    lsm = 0;
    %run for each bin
    for b = 1:B
        lsm = lsm + sample(b)*log(model(b));
    end
end