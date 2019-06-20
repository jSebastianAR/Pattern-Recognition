classdef classClasificador<handle
    properties
        %userVector
        vectorUsuario
        %Euclidean
        distancesE
        %For KNN
        distancesKNN 
        sortedDistances
        numberNeighbors
        %Mahalanobis
        distancesMahal
        %Maximum probability
        distancesMP
    end
    
    methods
        function obj = classClasificador()
            %For Supervised learning
            obj.vectorUsuario = [];
            obj.distancesE = [];
            obj.distancesKNN = [];
            obj.distancesMahal = [];
            obj.distancesMP = [];
            
            
        end
        
        %Euclidean Classifier
        function [distancias] = Euclidiano(obj,CLASES,vector)
        %{
        Output args: 
        distances = Array with all Euclidean distances 

        Input args:
        CLASES = Array with all classes object
        vector = vector entered by the user    
        %}
            obj.vectorUsuario = vector;
            distancias = [];
            numClases = numel(CLASES);
            obj.distancesE = [];
            for i=1:numClases
                dist = norm(CLASES(i).media-obj.vectorUsuario);%calcula distancia entre la media de la clase actual y el vector del usuario
                distancias = [distancias dist]; %guarda las distancias en un arreglo
                obj.distancesE = [obj.distancesE dist]; %guarda las distancias en un arreglo
            end
        end
        
        %KNN Classifier
        function [Distances_id sortedDistances numberOfNeighborsForClass] = KNN(obj,CLASES,vectorUsuario,Kneighbors)
            %{
                Output args: 
                Distances_id = Matrix with all the distances and its number
                of class
            
                sortedDistances = Array with all sorted distances

                numberOfNeighborsForClass = Array with all number of neighbors for each class
                
                Input args:
                CLASES = Array with all objects of classes
            
                vectorUsuario = vector entered by the user
            
                Kneighbors = number of neighbors considered for the classification (should be non pair)
            %}
            numClases = numel(CLASES);
            Distances_id = []; %contains the distances for all vectors of all classes and its id's
            sortedDistances = []; %contains only the sorted distances of all vectors in all classes
            numberOfNeighborsForClass = zeros(1,numClases); %contains the number of neighbors of each class for the userVector 
            
            %GETS THE DISTANCES BETWEEN ALL VECTORS OF THE CLASSES AND THE USER VECTOR
            for i=1:numClases %for each class
                numElements = numel(CLASES(i).ejex);%gets the number of elements of each class
                for j=1:numElements %for each vector in the class
                    vectorClass = [CLASES(i).ejex(j) CLASES(i).ejey(j)]; %gets both values for the element "j" in the axes "x" and "y"
                    %vectorClass = [CLASES(i).matriz(1,j) CLASES(i).matriz(2,j)]; %gets both values for the element "j" in the axes "x" and "y"
                    distance = norm(vectorClass-vectorUsuario);%calculate the distance between each vector of each class and the user vector
                    Distances_id = [Distances_id;distance i];%stores the distance of the neighbor and its id of the class
                end
            end
            sortedDistances = sort([Distances_id(:,1)]);%gets only the distances
            %sortedDistances = sort(sortedDistances);%sort from the minimum distance to maximum distance
            
            %COUNT THE NEIGHBORS OF EACH CLASS
            for z=1:Kneighbors %from the first neighbor till the last one in sortedDistances
                %fprintf('vecino no: %d',z)
                dNeighbor = sortedDistances(z);%gets the vector in "z" position
                index = find(Distances_id==dNeighbor); %search the index where the neighbor is in the full array
                noClase = Distances_id(index,2);%gets the id of the class for the current vector
                newValue = numberOfNeighborsForClass(noClase)+1; %adds the old value plus one
                numberOfNeighborsForClass(noClase) = newValue; %increase the value  
                
            end
            
            %CHECKS IF THERE IS NO REPETITION BETWEEN THE MAXIM NUMBER OF VECTORS
            maxNumber = max(numberOfNeighborsForClass);%gets the maxim number of the vector
            cnt = histc(numberOfNeighborsForClass,maxNumber); %counts the number of repetitions of that vector
            if cnt>1 % if there are two or more classes with the maximum number of neighbors
                dNeighbor = sortedDistances(Kneighbors+1); %takes one more vector instead the number of vectors asked for the user
                index = find(Distances_id==dNeighbor); %search the index where the neighbor is in the full array
                noClase = Distances_id(index,2);%gets the id of the class for the current vector
                newValue = numberOfNeighborsForClass(noClase)+1; %adds the old value plus one
                numberOfNeighborsForClass(noClase) = newValue; %increase the value   
            end

        end
        
        function [distances] = Mahalanobis(obj,CLASES,vectorUsuario)
        %{
        Output args: 
        distances = Array with all Mahalanobis distances 

        Input args:
        CLASES = Array with all classes object
        vectorUsuario = vector entered by the user    
        %}
            obj.vectorUsuario = vectorUsuario;
            distances = [];
            numClases = numel(CLASES);
            obj.distancesMahal = [];
            for i=1:numClases %goes through all classes
                resta = restaVectores(vectorUsuario,CLASES(i).media);%calls local function
                m = (resta)*(CLASES(i).matrixSigmaI);
                distancia = sqrt(m*resta');%formula de las distancias
                distances = [distances distancia]; %returns all the distances 
                obj.distancesMahal = [obj.distancesMahal distancia];
            end
        end
        
        function [ P,PN ] = MP(obj,CLASES,distancesMahal) %MAXIMA PROBABILIDAD
        %{
        Output args: 
        P = Matrix with all probability values, 
        PN = Matrix with all normalized probability values

        Input args:
        matricesE = All matrices E
        distancesMahal = This argument contains all the distances that we got in   
        mahal function
        %}
            P = [];
            PN = [];
            obj.distancesMP = [];
            numClases = numel(CLASES);
            for i=1:numClases %go through all rows with step of two to get only one matrix per iteration
                distance = distancesMahal(i);%gets the distance for the matrix E evaluated
                prob = probability(CLASES(i).matrixSigma,distance);
                P = [P prob]; %stores the value p at last position of the P vector
            end

            sumP = sum(P);%sum all values in P
            for i=1:numel(P)
               pn = (P(i)/sumP)*100; %normalize all values in P 
               PN = [PN pn];%stores the value pn at last position of the PN vector
               obj.distancesMP = [obj.distancesMP pn];
            end
        end
        
        %Funcion que define la clase a la que pertenece el vector a clasificar

        function [numClase] = clasePerteneciente(obj,distanciasM,opcion) %Recibe el arreglo que guarda todas las distancias de las medias de las clases y el vector dado por el usuario
             if opcion==1 || opcion==2
                distanciaMinima = min(distanciasM);%encuentra la distancia más corta
                numClase = find(distanciasM==distanciaMinima); %encuentra la posicion donde se ubica la distancia minima en el arreglo de distancias 
             elseif opcion==3 || opcion==4
                distanciaMinima = max(distanciasM);%encuentra la probabilidad mas grande
                numClase = find(distanciasM==distanciaMinima); %encuentra la posicion donde se ubica la distancia minima en el arreglo de distancias 
            
             end
        end
        
        %========================Functions for Non Supervised learning=======================
        function Hierarchical(obj,numSamples,samples)
                import classGroup
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
        end
        
        function PP = Kcentros(obj,GROUPS,samples,km,a)
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
                    
                    %Updates the means
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

                    %Compare the means
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
                   pause
                end


                for i=1:km
                    fprintf('\n===================Grupo %d===================\n',i)
                    GROUPS(i).samplesKmeans
                    length(GROUPS(i).samplesKmeans)
                    fprintf('\n===================Grupo %d===================\n',i)
                end

                %PP = [];
                RGB = permute(a,[3,1,2]); %change the position of the values in the matrix
                %PP = plottingPoints(RGB,GROUPS);
                %PP
                %[num,~] = size(PP);
                %for i=1:num
                   %plot(PP(:,1),PP(:,2), 'm+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, ) 
                %end
                %GROUPS = getAllPositions(GROUPS,PP);
                GROUPS = plotAllSamples(GROUPS,RGB);
        end
        
        function [image] = selectImage(obj)
             numImagen = input('Imagen deseada 1-italia 2-alemania 3-francia 4-peppers ')
                switch numImagen
                    case 1
                        image=imread('italia.jpg');
                    case 2
                        image=imread('alemania.jpg');
                    case 3
                        image=imread('francia.png');
                    case 4
                        image=imread('peppers.png');
                end
        end
        
    end
    
end

function [ subtracVectors ] = restaVectores(minuendo,sustraendo)%minuendo = vector al que se resta, sustraendo = vector que resta
            subtracVectors = minuendo - sustraendo;
end
        
function [p] = probability(matrix,distanceM)
    % Outputs: p = probability for "matrix"
    % Inputs:
    % matrix = it's a specific matrix E 
    % distanceM = distance Mahal of the matrix
    %fprintf('Entre a funcion privada \n')
    n = 2;
    detM = sqrt(det(matrix));
    %detM = det(matrix)
    f = 2*pi;
    %m1 = f*detM
    c = f*detM;
    a = 1/c;

    m = (-1/2)*distanceM;
    b = exp(m);

    p = b/a;
    %p = round(p)%round to two decimals
end

function [ PP ] = plottingPoints(RGB,GROUPS)
%{
This function gets the plotting points of the centroids of each class

INPUTS
RGB : This is the 3d array of the image(x,y,z), 
where x = refers to the three values of the rgb, 
y = number of row in the image, 
z = number of column in the image

GROUPS: All the created groups/classes

OUTPUTS
PP: Plotting Points of each centroid
%}

diferencia = 100; %assign a random value 
PP = [];%array to store the plotting points of each centroid
[rgb rows columns] = size(RGB); %gets the size of the image's matrix 
numGroups = length(GROUPS); %gets the number of all the created groups
    for i=1:numGroups %for each group
        %fprintf('\nInicia GROUP %d\n',i)
            while ~(diferencia>=0 && diferencia<=5) %if the difference its between 0-5
                randomRow = randi([50,rows-50]);%gets a random position for a row from the image
                randomCol = randi([50,columns-50]);%gets a random position for a column from the image
                rgbIm = RGB(:,randomRow,randomCol).';%gets the rgb value in the position(randomRow,randomCol)
                rgbIm = double(rgbIm);%cast to double
                kmean = GROUPS(i).samplesKmeans(1,:);%gets the centroid 
                %class(sample)
                diference = norm(rgbIm-kmean); %gets the distance between the random vector and the current centroid
                if(diference>=0 && diference<=10)%if difference is in range between 0-10
                    %fprintf('\nI got a new position :)\n')
                    PP = [PP;randomCol randomRow];%adds the random position into the 
                    break
                end
            end
        %fprintf('\nTermina GROUP %d\n',i)
    end
end

function [GROUPS] = getAllPositions(GROUPS,plottedPoints)
%{
This function gets the positions of all samples of each group

INPUTS
GROUPS: Array that contains all the groups created
plottedPoints: the main position of all centroid

OUTPUTS
returns the groups
%}
numGroups = length(GROUPS);%gets the number of groups
    for i=1:numGroups %FOR EACH GROUP
        [elements,~] = size(GROUPS(i).samplesKmeans); %gets the number of samples for the i-GROUP
        fprintf('\nGRUPO %d\n',i)
        for j=1:elements %for each element/sample 
            ejex = randi([plottedPoints(i,1)-elements plottedPoints(i,1)+elements]); %gets a random position for axis x based on the i-PlottedPoint, and expands the range of minimum value and the maximum
            ejey = randi([plottedPoints(i,2)-elements plottedPoints(i,2)+elements]); %gets a random position for axis y based on the i-PlottedPoint, and expands the range of minimum value and the maximum
            fprintf('\nplot in [%d,%d]\n',ejex,ejey)
            plotAllGroups(ejex,ejey,i)%plot the specific point
            GROUPS(i).plotPoints = [GROUPS(i).plotPoints;ejex,ejey];
        end
        fprintf('\nGRUPO %d\n',i)
    end 
end

function plotAllGroups(ejex,ejey,numGroup)
    if numGroup==1 %clase 1
        plot(ejex,ejey, 'y+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
        %grid on
        hold on
        %title('Grafica de datos en el espacio euclidiano')
    elseif numGroup==2 %clase 2
        plot(ejex,ejey, 'g+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==3 %clase 3
        plot(ejex,ejey, 'b+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==4 %clase 4
        plot(ejex,ejey, 'r+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==5 %clase 5
        plot(ejex,ejey, 'c+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==6 %clase 6
        plot(ejex,ejey, 'm+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==7 %clase 7
        plot(ejex,ejey, 'w+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==8 %clase 8
        plot(ejex,ejey, 'k+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    end
end

function [distances,numGroup] = calculateDistance(GROUPS,sample)

%{
INPUTS
GROUPS = instances of classGroup wich contains the samples and the mean(Z) value
sample = current sample to classify

OUTPUTS
distances = array with all the distances between the current sample and all the means
numGroup = number of group wich the sample belongs
%}
    distances = [];
    numGroups = length(GROUPS);
    for i=1:numGroups
        distance = norm(GROUPS(i).Z-sample);
        distances = [distances distance];
    end
    
    dmin = min(distances);%find the group who belongs the sample
    Group = find(distances==dmin);
    numGroup = Group(1);
end
    
function [distance] = distanceVectors(vector1,vector2)
    distance = norm(vector1-vector2);
end

function [samples] = getRealSamples(samples1,IndexOriginalsamples,GROUPS)
    samples = [];
    IndexOriginalsamples;
    for sample = samples1
        sample;
        repeat = numel(find(IndexOriginalsamples==sample)); %found if sample is content in Originalsamples
        if repeat>0
            samples = [samples,sample];
        else
            samples = [samples,getRealSamples(GROUPS(sample).samples,IndexOriginalsamples,GROUPS)];
        end
    end
    samples;
end

function [ matrixDistances ] = calculateDistances(GROUPS,SAMPLES,indexForGroup,allGROUPS)
    numGroups = length(GROUPS); %takes the number of groups added in the matrix "GROUPS"
    matrixDistances = zeros(numGroups); %reserve space for the distances
    size(matrixDistances);
    for i=1:numGroups %for each group
        %fprintf('\n====================Grupo %d====================\n',i)
        numSamples_iGroup = length(GROUPS(i).samples); %gets all the number of samples contained in the i-group
        for j=1:numGroups %calculate the distance between the i-group and all the j-groups
            %fprintf('\n====================Grupo %d====================\n',j)
            numSamples_jGroup = length(GROUPS(j).samples); %gets all the number of samples contained in the j-group
            matrixSamples = zeros(numSamples_iGroup,numSamples_jGroup);
            if i~=j %if it is not the same group
                GROUPS(i).samples;
                GROUPS(j).samples;
                isamples = getRealSamples(GROUPS(i).samples,indexForGroup,allGROUPS);
                jsamples = getRealSamples(GROUPS(j).samples,indexForGroup,allGROUPS);
                numSamples_iGroup = length(isamples);
                numSamples_jGroup = length(jsamples);
                for k=1:numSamples_iGroup %for each sample in i-group
                    for l=1:numSamples_jGroup %for each sample in j-group
                        kSample = SAMPLES(isamples(k),:); %takes the i-sample
                        lSample = SAMPLES(jsamples(l),:); %takes the j-sample
                        %fprintf('\nisample = %d %d %d vs jsample=%d %d %d\n',kSample(1),kSample(2),kSample(3),lSample(1),lSample(2),lSample(3))
                        distance = distanceVectors(kSample,lSample); %gets the distance between both vectors
                        matrixSamples(k,l) = distance; %stores the distance in the position i,j which says that is the distance between the i-sample and the j-sample
                    end
                end
                %matrixSamples;
                %pause
                %minvalue=min(matrixSamples(matrixSamples>0))%gets the min distance of all the calculated distances between the samples of i-group and the samples of  j-group    
                %minvalue=min(matrixSamples)%gets the min distance of all the calculated distances between the samples of i-group and the samples of  j-group    
                [rows,cols] = size(matrixSamples);
                if rows==1 && cols==1
                    minvalue = matrixSamples(1,1);
                else
                    [minvalue,~] = findMin(matrixSamples);
                end
                
                matrixDistances;
                matrixDistances(i,j) = minvalue; %stores the distance in the position i,j which says that is the distance between the i-sample and the j-sample
            else
                matrixDistances;
                matrixDistances(i,j) = 0; %stores a distance o zero because is the same group
            end    
            %[rows cols] = find(abs(distancesMatrix-minvalue)<0.001)
            %fprintf('\n====================Grupo %d====================\n',j)
        end
        %fprintf('\n====================Grupo %d====================\n',i)
    end
end

function [ newMatrix ] = deleteSamples(Matrix,numSamples)
    %{
     INPUTS:
        Matrix = Original matrix 
        numSamples = array with the position of all the samples
        
    %}
    maxSample = max(numSamples);
    minSample = min(numSamples);
    %
    Matrix(maxSample,:)=[];
    Matrix(:,maxSample)=[];
    Matrix(minSample,:)=[];
    Matrix(:,minSample)=[];
    newMatrix = Matrix;
end

function [globalMin,globalPosition] = findMin(matrix)
    matrix;
    [rows,cols] = size(matrix);
    numCeros = numel(find(matrix==0));
    
    if rows==1 || cols==1 %if array is in one dimension
        if numCeros==0
           globalMin = min(matrix(matrix>0));
           [rows,cols] = find(abs(matrix-globalMin)<0.001);
           globalPosition = [rows(1) cols(1)];
        else
           globalMin = min(matrix); 
           [rows,cols] = find(matrix==globalMin);
           globalPosition = [rows(1) cols(1)];
        end 
    else
        if numCeros==0 || numCeros==rows
           globalMin = min(matrix(matrix>0));
           [rows,cols] = find(abs(matrix-globalMin)<0.001);
           globalPosition = [rows(1) cols(1)];
        else
            for i=1:rows
                for j=1:cols
                    value = matrix(i,j);
                    if(value==0 && i~=j)
                        globalMin = value;
                        globalPosition = [i,j];
                        return
                    end
                end
           end
        end
    end
    maxVal = max(globalPosition);
    minVal = min(globalPosition);
    globalPosition = [minVal maxVal];
end

