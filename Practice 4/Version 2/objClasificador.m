classdef objClasificador<handle
    properties
        %userVector
        vectorUsuario
        %Euclidean
        distancesE
        %For KNN
        distancesKNN 
        sortedDistances
        %Mahalanobis
        distancesMahal
        %Maximum probability
        distancesMP
    end
    
    methods
        function obj = objClasificador()
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
            obj.distancesE = []
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
            maxNumber = max(numberOfNeighborsForClass)%gets the maxim number of the vector
            cnt = histc(numberOfNeighborsForClass,maxNumber) %counts the number of repetitions of that vector
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
            obj.distancesMahal = []
            for i=1:numClases %goes through all classes
                resta = restaVectores(vectorUsuario,CLASES(i).media);%calls local function
                m = (resta)*(CLASES(i).matrixSigmaI);
                distancia = sqrt(m*resta');%formula de las distancias
                distances = [distances distancia]; %returns all the distances 
                obj.distancesMahal = [obj.distancesMahal distancia];
            end
        end
        
        function [ P,PN ] = Bayesiano(obj,CLASES,distancesMahal)
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
            obj.distancesMP = []
            numClases = numel(CLASES);
            for i=1:numClases %go through all rows with step of two to get only one matrix per iteration
                distance = distancesMahal(i)%gets the distance for the matrix E evaluated
                prob = probability(CLASES(i).matrixSigma,distance);
                P = [P prob]; %stores the value p at last position of the P vector
            end

            sumP = sum(P)%sum all values in P
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
    fprintf('Entre a funcion privada \n')
    n = 2;
    detM = sqrt(det(matrix));
    %detM = det(matrix)
    f = 2*pi;
    %m1 = f*detM
    c = f*detM;
    a = 1/c

    m = (-1/2)*distanceM;
    b = exp(m)

    p = b/a
    %p = round(p)%round to two decimals
end

