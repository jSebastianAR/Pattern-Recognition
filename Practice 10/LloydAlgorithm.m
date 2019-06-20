function LloydAlgorithm(GROUPS,samples)
    umbral_LR = input('Ingrese el umbral para el algoritmo de Lloyd: ')
    umbral_vectors = input('Ingrese el umbral para la diferencia entre vectores: ')
    numCentroids = length(GROUPS);
    %proposedCentroids = getRandomCentroids(numCentroids) %Gets the random centroids
    proposedCentroids = ChooseCentroids(samples,numCentroids) %Gets the random centroids
    oldCentroids = [];
    completed = 0;
    [numSamples,~] = size(samples);
    originalCentroids = extractCentroids(GROUPS);
    fprintf('\nComienzo\n')
    proposedCentroids
    originalCentroids
    fprintf('\nComienzo\n')
    while completed<numCentroids %while the difference is greater than umbral 
        for i=1:numSamples
            pause
            currentSample = samples(i,:); %takes the i-sample
            fprintf('\nEvalua Sample %d [%d %d %d]\n',i,currentSample(1),currentSample(2),currentSample(3))
            %proposedCentroids
            %originalCentroids
            plotCentroids(proposedCentroids);
            [~,numCentroid] = distancesZ(proposedCentroids,currentSample);%finds the centroid to be changed
            oldCentroid = proposedCentroids(numCentroid,:); %gets the old centroid
            newCentroid = updateCentroid(oldCentroid,umbral_LR,currentSample); %updates the numCentroid-Centroid
            proposedCentroids(numCentroid,:) = newCentroid; %substitute the oldCentroid with the newCentroid
            proposedCentroids
            originalCentroids
            completed = compareCentroids(proposedCentroids,originalCentroids,numCentroids,umbral_vectors);%gets the mean for each centroid
            fprintf('\nTermina Sample %d perteneciente a centroide %d completed=%d\n',i,numCentroid,completed)
            %pause
            if completed==numCentroids %if all centroids accomplished the umbral_vectors difference
                fprintf('\nTermino algoritmo de Lloyd\n')
                break
            end
        end
    end

end

function completed = compareCentroids(proposedCentroids,originalCentroids,numCentroids,umbral_vectors)
    distances = [];
    completed = 0;
    for i=1:numCentroids
        d = norm(proposedCentroids(i,:)-originalCentroids(i,:));
        if d<=umbral_vectors %if the distance accomplish
            completed = completed+1; 
        end
    end
end

function originalCentroids = extractCentroids(GROUPS)
   numGroups = length(GROUPS);
   originalCentroids = [];
   for i=1:numGroups
       originalCentroids = [originalCentroids;GROUPS(i).Z];
   end
end

function newCentroid = updateCentroid(oldCentroid,LR,currentSample)
    newCentroid = oldCentroid + LR*(currentSample-oldCentroid);
end

function centroids = getRandomCentroids(numGroups)
    centroids = [];
    for i=1:numGroups
        r = randi([0,255]); %gets a random value for r
        g = randi([0,255]); %gets a random value for g
        b = randi([0,255]); %gets a random value for b
        centroid = [r g b];
        centroids = [centroids;centroid];
    end
end

function [distances,numGroup] = distancesZ(centroids,sample)
%{
INPUTS
GROUPS = current centroids 
sample = current sample to classify

OUTPUTS
distances = array with all the distances between the current sample and all the means
numGroup = number of group wich the sample belongs
%}
    distances = [];
    [numCentroids,~] = size(centroids);
    for i=1:numCentroids
        distance = norm(centroids(i,:)-sample);
        distances = [distances distance];
    end
    
    dmin = min(distances);%find the group who belongs the sample
    Group = find(distances==dmin);
    numGroup = Group(1);
end


function plotCentroids(centroids)
    [rows,~] = size(centroids);
    f = figure; %creates a new figure window
    %figure(f); %all actions for plot will be appear on the f window 
    
    for i=1:rows
        %fprintf('\n\nPlotteando centroide %d [%d %d %d]\n\n',i,centroids(i,1),centroids(i,2),centroids(i,3))
        switch i
            case 1
                c1 = plot3(centroids(i,1),centroids(i,2),centroids(i,3), 'y+', 'MarkerSize', 10, 'LineWidth', 2);%,'Clase 1');% (vector en x, vector en y, color, )
                grid on
                hold on
                c1.DisplayName='Clase 1';
            %title('Grafica de datos en el espacio euclidiano')
            case 2
                c2 = plot3(centroids(i,1),centroids(i,2),centroids(i,3), 'g+', 'MarkerSize', 10, 'LineWidth', 2);%,'Clase 2');% (vector en x, vector en y, color, )  
                c2.DisplayName='Clase 2';
            case 3
                c3 = plot3(centroids(i,1),centroids(i,2),centroids(i,3), 'b+', 'MarkerSize', 10, 'LineWidth', 2);%,'Clase 3');% (vector en x, vector en y, color, )
                c3.DisplayName='Clase 3';
            case 4
                c4 = plot3(centroids(i,1),centroids(i,2),centroids(i,3), 'r+', 'MarkerSize', 10, 'LineWidth', 2);%,'Clase 4');% (vector en x, vector en y, color, )  
                c4.DisplayName='Clase 4';
            case 5
                c5 = plot3(centroids(i,1),centroids(i,2),centroids(i,3), 'c+', 'MarkerSize', 10, 'LineWidth', 2);%,'Clase 5');% (vector en x, vector en y, color, )
                c5.DisplayName='Clase 5';
            case 6
                c6 = plot3(centroids(i,1),centroids(i,2),centroids(i,3), 'm+', 'MarkerSize', 10, 'LineWidth', 2);%,'Clase 6');% (vector en x, vector en y, color, )
                c6.DisplayName='Clase 6';
            case 7
                c7 = plot3(centroids(i,1),centroids(i,2),centroids(i,3), 'w+', 'MarkerSize', 10, 'LineWidth', 2);%,'Clase 7');% (vector en x, vector en y, color, )
                c7.DisplayName='Clase 7';
            case 8
                c8 = plot3(centroids(i,1),centroids(i,2),centroids(i,3), 'k+', 'MarkerSize', 10, 'LineWidth', 2);%,'Clase 8');% (vector en x, vector en y, color, )
                c8.DisplayName='Clase 8';
        end
        
    end
    legend show
end