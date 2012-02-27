function [best_model, distances] = comparePatternsNN(image, models, cellSize, radius, num_points, LBPtype)
    %compares the textures in an image against a set of models, this uses a
    %nearest neighbour approach
    %we extract the cell as well as a border surrounding it
    datasize = round(size(image)/2);
    cell = image(datasize(1)-round(cellSize/2):datasize(1)+round(cellSize/2),datasize(2)-round(cellSize/2):datasize(2)+round(cellSize/2));
    %get the local binay pattern from the cell
    if(strcmpi(LBPtype, 'BASIC'))
        transform = getLBP(cell, radius, num_points);
        histo = hist2D(transform,2^num_points);
    elseif(strcmpi(LBPtype,'RI'))
        transform = getRILBP(cell, radius, num_points);
        histo = hist2D(transform,num_points+1);
    else
        
    end
    %set empty bins to 1 in order to retain compatibility with models
    %generated to work with log-likelihood tests
    feature = abs(histo-0.5) + 0.5;
    feature = feature/sum(feature);
    minDist = 10000;
    distances = zeros(size(models,1),1);
    for m = 1: size(models,1)
        distances(m) = norm(feature-models(m,:)');
        if(distances(m) < minDist)
            minDist = distances(m);
            best_model = m;
        end
    end
    
end