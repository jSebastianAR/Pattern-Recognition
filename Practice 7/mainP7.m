clc
clear all
close all
warning off all
import classGroup
numImagen = input('Imagen deseada 1-italia 2-alemania 3-francia 4-peppers ')
switch numImagen
    case 1
        a=imread('italia.jpg');
    case 2
        a=imread('alemania.jpg');
    case 3
        a=imread('francia.png');
    case 4
        a=imread('peppers.png');
end

%samples = [0 0;0 4;1 0;3 0;1 3]
samples=impixel(a)
numSamples = length(samples);
GROUPS = [];
allGROUPS = [];
originalSamples = [];
combinedSamples = [];
indexForGroup = [];
%creates the first groups that contains each sample
for i=1:numSamples
   originalSamples = [originalSamples,i];
   indexForGroup = [indexForGroup,i]; 
   sample = [i]; 
   newGroup = createGroup(i,sample); 
   GROUPS=[GROUPS newGroup];
   allGROUPS=[allGROUPS newGroup];
end

numGroups = length(GROUPS)+1;% index of the next group to be created
distancesMatrix = calculateDistances(GROUPS,samples,originalSamples,allGROUPS)%calculate the distances between the firs groups of the algorithm
arrayIndices = 1:numSamples;%creates an array with the index of each group
%pause

createdGroups = [];
iteracion = 1;
Continue = true;
OBJECTS = [];
while Continue==true
     fprintf('\n======================Iteracion %d======================\n',iteracion)   
     
     [minvalue,position]=findMin(distancesMatrix)%*****
     addedGroups = [arrayIndices(position(1)),arrayIndices(position(2))]%gets the indices where we need to search the real index for each group %*****
     OBJECTS = [OBJECTS;addedGroups(1) addedGroups(2) minvalue];
     indices = [addedGroups(1),addedGroups(2)];%gets the indices where we need to search the real index for each group %****
     newGroup = classGroup(numGroups); %add a sample
     combinedSamples = [combinedSamples;addedGroups]%samples created thath contains two original samples
     indexForGroup = [indexForGroup,numGroups]%index for each created group
     for i=1:2
        newGroup.addSample(indices(i)); %adds the index to the array samples
     end
     %Adding the new index of the new group and deleting the indices of the groups which now are contained in the new group
     
     arrayIndices
     arrayIndices(position(2)) = []; %*****
     arrayIndices(position(1)) = []; %*****
     arrayIndices = [arrayIndices numGroups]
     distancesMatrix
     createdGroups = [createdGroups newGroup];%adding the new group
     distancesMatrix = deleteSamples(distancesMatrix,position);%delete the specific groups from the matrix which went added to the new group 
     distancesMatrix
     %delete both groups addded from GROUPS
     GROUPS(position(2)) = [];% deletes the group selected with the biggest sample 
     GROUPS(position(1)) = [];%% deletes the group selected with the lowest sample
     GROUPS = [GROUPS newGroup];%adds the new groups
     allGROUPS = [allGROUPS newGroup];
     %allGROUPS = [allGROUPS newGroup];%adds the new groups
     numGroups = numGroups+1; %add one value
     %calculate the new matrix
     distancesMatrix = calculateDistances(GROUPS,samples,originalSamples,allGROUPS);
     distancesMatrix
     [row col] = size(distancesMatrix);
     if row==1 & col==1
        Continue = false
        
     end
     fprintf('\n======================Iteracion %d======================\n',iteracion)
     iteracion=iteracion+1;
end



OBJECTS
dendrogram(OBJECTS)


newGroup = classGroup(0);
createdGroups = [createdGroups newGroup];


%distancesMatrix = squareform(pdist(samples));%gets the first distances 
%objects = linkage(distancesMatrix);
%numGroups = length(objects);
numGroups = length(OBJECTS);
%add the real indices of the samples in each group
for i=1:numGroups
    samp = OBJECTS(i,1:2); %gets the value of the samples
    createdGroups(i).samples = samp; %stores the indices of the samples
    
end

allGROUPS = [allGROUPS createdGroups];%adds the createdGroups with their real values 


numGroups = length(allGROUPS);
for i=1:numGroups-1
    fprintf('Grupo %d',i)
    allGROUPS(i).samples
end

