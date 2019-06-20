function [ centroids ] = ChooseCentroids(samples,numMeans)
    
    %[numSamples,~]=size(samples)
    centroids = [];
    FCentroids = [];
    for i=1:numMeans
        fprintf('\n\nEligiendo centroide %d\n',i)
        [numCentroids,~] = size(centroids);
        switch numCentroids
            case 0
                newCentroid = samples(1,:);%takes the first sample of all
                centroids = [centroids;newCentroid];
            case 1
                newCentroid = findFarthestCentroid(centroids(1,:),samples);%finds the farthest centroid for j-centroid
                centroids = [centroids;newCentroid];
            otherwise
                for j=1:numCentroids
                    FCentroid = findFarthestCentroid(centroids(j,:),samples);%finds the farthest centroid for j-centroid
                    FCentroids = [FCentroids;FCentroid];%Stores the centroid
                end
                FCentroids
                newCentroid = mean(FCentroids);%does the mean between all the centroids
                centroids = [centroids;newCentroid];
        end
        fprintf('Centroide en [%d %d %d]',newCentroid(1),newCentroid(2),newCentroid(3))
    end
end

function newCentroid = findFarthestCentroid(centroid,samples)
    [numSamples,~] = size(samples);
    %[numCentroids,~] = size();
    
    allFarthestCentroids = [];
    allDistances = [];
    for i=1:numSamples
        currentSample = samples(i,:);%takes the i-sample
        distance = norm(centroid-currentSample);%gets the distance between the centroid and the i-sample
        allDistances = [allDistances distance];%stores the distance
    end
    maxDistance = max(allDistances); %gets the max distance
    numSample = find(allDistances==maxDistance);%find the position where the sample is
    newCentroid = samples(numSample(1),:);%gets the sample in the specified position
end

