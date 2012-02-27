function models = buildModels(filePaths, cellSize, R, P, technique)
    %WARNING: This algorithm takes a WHILE and is only ever intended to be
    %run once.
    M = size(filePaths,1);
    F = size(filePaths,2);
    if(strcmpi(technique, 'BASIC'))
        models = zeros(M,2^P+1);
    else
        models = zeros(M,P+2);
    end
    for m = 1: M
        %generate the model
        if(strcmpi(technique, 'BASIC'))
            model = zeros(2^P+1,1);
        else
            model = zeros(P + 2,1);
        end
        for f = 1: 1
            %load the image
            data = imread(filePaths{m,f});
            %get the local binay pattern from the entire image
            numCells = floor(size(data,1)/cellSize)*floor(size(data,2)/cellSize);
            for x = 1:cellSize: size(data,1)-cellSize +1
                for y = 1:cellSize: size(data,2)-cellSize + 1
                    cell = data(x:x+cellSize-1,y:y+cellSize-1);
                    if(strcmpi(technique, 'BASIC'))
                        transform = getLBP(cell, R, P);
                        histo = hist2D(transform,2^P);
                    elseif(strcmpi(technique,'RI'))
                        transform = getRILBP(cell, R, P);
                        histo = hist2D(transform,P+1);
                    else
                        model = zeros(P + 2,1);
                    end
                    %set empty bins to 1 in order to avoid infinity values in
                    %log-likelihood tests
                    %histo = abs(histo-0.5)+0.5;
                    %model = model + histo/sum(histo);
                    model = model + histo;
                end
            end
        end
        disp(strcat('Model ', num2str(m), ' of ', num2str(M), ' complete.'));
        model = abs(model-0.5)+0.5;
        models(m,:) = model/sum(model);
    end
end
    