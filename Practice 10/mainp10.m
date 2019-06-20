clc
clear all
close all
warning off all
import classGroup

km = input('Cuantos centros quieres?')
numImagen = input('Imagen deseada 1-italia 2-alemania 3-francia 4-peppers ')
switch numImagen
    case 1
        imagen=imread('italia.jpg');
    case 2
        imagen=imread('alemania.jpg');
    case 3
        imagen=imread('francia.png');
    case 4
        imagen=imread('peppers.png');
end

op = input('1-Random Samples 2-Manual Samples ')
switch op
    case 1
        numS = input('Ingresa número de samples: ')
        samples = GetRandomSamples(imagen,numS);
    case 2
        samples=impixel(imagen);
end

%[samples,imagen,km] = StaticSamples()

imshow(imagen)
hold on
%creates the first groups that contains each sample
GROUPS = [];
%Gets all the means required 
%{
for i=1:km
    newGroup = createGroup(i,[]); %creates a new group
    newGroup.Z = samples(i,:) %adds the i-sample from all matrix of samples for the i-group
    GROUPS = [GROUPS newGroup]; %stores the i-group in GROUPS
end
%}

centroids = [];
centroids = ChooseCentroids(samples,km)
pause
for i=1:km
    newGroup = createGroup(i,[]); %creates a new group
    newGroup.Z = centroids(i,:) %adds the i-centroid from all matrix of centroids for the i-group
    GROUPS = [GROUPS newGroup]; %stores the i-group in GROUPS
end

numSamples = length(samples);
start = 0;
Continue = true;%flag for the loop
first = true; %denotes if its the first time for take the sample of means(z1 = x1,z2 = x2,z3 = x3)
zmeans = []; %array which contains all the k-means
old_means = [];
new_means = [];
iteracion = 1;
while Continue==true
    fprintf('\n\n===================Comienza iteracion %d===================\n\n',iteracion)
    if(first==true) %if its the first iteration for the classifier
        start = km+1;%then start avoids the km first samples because these ones are the k-means
        first=false;
        for i=1:km
            GROUPS(i).samplesKmeans = [GROUPS(i).Z];
        end
    else
        start = 1;%else takes every sample in the matrix samples
    end

    %classify all the samples
    for i=start:numSamples
        currentSample = samples(i,:)%takes the i sample
        [Distances,numGroup] = calculateDistance(GROUPS,currentSample)
        GROUPS(numGroup).samplesKmeans = [GROUPS(numGroup).samplesKmeans;currentSample]; %stores the current sample into the chosen group        
    end
    
    for i=1:km
      fprintf('\nempieza GROUP %d\n',i)    
      fprintf('\nold z\n')  
      GROUPS(i).Z  
      old_means = [old_means;GROUPS(i).Z];%stores the old means
      GROUPS(i).updateMean(); %updates the mean
      fprintf('\nnew z\n')  
      GROUPS(i).Z
      new_means = [new_means;GROUPS(i).Z];%stores the new means
      fprintf('\nsamples\n')  
      GROUPS(i).samplesKmeans
      fprintf('\ntermina GROUP %d\n',i)
    end
    
    old_means
    new_means
    equal = old_means == new_means %compares if both matrices are equal
    itsEqual = mean(sum(equal)); %does the mean of the sum of all values into the matrix "equal"
    
      if itsEqual==km %if there is no change of the means we can finish the iteration, if itsEqual its equal to the number of k-means created
          Continue = false
      else
        for i=1:km %reset each matrix samplesKmeans of each group
            GROUPS(i).resetSamplesK();
        end
        old_means = [];
        new_means = [];
        equal = [];
      end
   fprintf('\n\n===================Finaliza iteracion %d===================\n\n',iteracion)
   iteracion = iteracion+1;
   %pause
end


for i=1:km %reset each matrix samplesKmeans of each group
    fprintf('\n===================Grupo %d===================\n',i)
    GROUPS(i).samplesKmeans
    length(GROUPS(i).samplesKmeans)
    fprintf('\n===================Grupo %d===================\n',i)
end



%PP = [];
RGB = permute(imagen,[3,1,2]);
%PP = plottingPoints(RGB,GROUPS);
%PP
%[num,~] = size(PP);
%for i=1:num
%   plot(PP(:,1),PP(:,2), 'm+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, ) 
%end
GROUPS = plotAllSamples(GROUPS,RGB);
%compare with all rgb values in the matrix
LloydAlgorithm(GROUPS,samples);
