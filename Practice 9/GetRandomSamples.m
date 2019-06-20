function [ samples ] = GetRandomSamples(imagen,numSamples)
samples = [];
[rows,cols,~] = size(imagen);
RGB = permute(imagen,[3,1,2]);%change the position for the image
    for i=1:numSamples
        %axis_X = randi([50,cols-50]); %gets a value between 50 and cols-50
        %axis_Y = randi([50,rows-50]); %gets a value between 50 and rows-50
        axis_X = randi([1,cols]); %gets a value between 50 and cols-50
        axis_Y = randi([1,rows]); %gets a value between 50 and rows-50
        currentSample = RGB(:,axis_Y,axis_X).';
        samples = [samples;currentSample];
    end
    
end

