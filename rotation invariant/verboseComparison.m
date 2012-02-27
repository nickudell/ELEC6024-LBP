function verboseComparison(sample, basic_models, RI_models,cellSize,R,P)
    [best, probs] = comparePatterns(sample, basic_models, cellSize, R, P, 'BASIC');
    if(best == 1)
        disp(strcat('Basic LBP thinks the sample is bark, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 2)
        disp(strcat('Basic LBP thinks the sample is brick, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 3)
        disp(strcat('Basic LBP thinks the sample is bubbles, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 4)
        disp(strcat('Basic LBP thinks the sample is grass, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 5)
        disp(strcat('Basic LBP thinks the sample is leather, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 6)
        disp(strcat('Basic LBP thinks the sample is pigskin, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 7)
        disp(strcat('Basic LBP thinks the sample is raffia, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 8)
        disp(strcat('Basic LBP thinks the sample is sand, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 9)
        disp(strcat('Basic LBP thinks the sample is straw, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 10)
        disp(strcat('Basic LBP thinks the sample is water, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 11)
        disp(strcat('Basic LBP thinks the sample is weave, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 12)
        disp(strcat('Basic LBP thinks the sample is wood, with a log likelihood of ', num2str(probs(best))));
    end
        
    disp(strcat('All Basic LBP log-likelihoods: ', num2str(probs)));
    
    [best, probs] = comparePatterns(sample, RI_models, cellSize, R, P, 'RI');
    if(best == 1)
        disp(strcat('Rotation-Invariant LBP thinks the sample is bark, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 2)
        disp(strcat('Rotation-Invariant LBP thinks the sample is brick, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 3)
        disp(strcat('Rotation-Invariant LBP thinks the sample is bubbles, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 4)
        disp(strcat('Rotation-Invariant LBP thinks the sample is grass, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 5)
        disp(strcat('Rotation-Invariant LBP thinks the sample is leather, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 6)
        disp(strcat('Rotation-Invariant LBP thinks the sample is pigskin, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 7)
        disp(strcat('Rotation-Invariant LBP thinks the sample is raffia, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 8)
        disp(strcat('Rotation-Invariant LBP thinks the sample is sand, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 9)
        disp(strcat('Rotation-Invariant LBP thinks the sample is straw, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 10)
        disp(strcat('Rotation-Invariant LBP thinks the sample is water, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 11)
        disp(strcat('Rotation-Invariant LBP thinks the sample is weave, with a log likelihood of ', num2str(probs(best))));
    end
    if(best == 12)
        disp(strcat('Rotation-Invariant LBP thinks the sample is wood, with a log likelihood of ', num2str(probs(best))));
    end
        
    disp(strcat('All Rotation-Invariant LBP log-likelihoods: ', num2str(probs)));
    
     [best, probs] = comparePatternsNN(sample, RI_models, cellSize, R, P, 'RI');
    if(best == 1)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is bark, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 2)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is brick, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 3)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is bubbles, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 4)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is grass, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 5)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is leather, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 6)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is pigskin, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 7)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is raffia, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 8)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is sand, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 9)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is straw, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 10)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is water, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 11)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is weave, with a total histogram difference of ', num2str(probs(best))));
    end
    if(best == 12)
        disp(strcat('Rotation-Invariant LBP, using a nearest-neighbor classifier, thinks the sample is wood, with a total histogram difference of ', num2str(probs(best))));
    end
        
    disp(strcat('All Rotation-Invariant LBP distances: ', num2str(probs)));
    
    
end