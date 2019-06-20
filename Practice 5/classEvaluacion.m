%import objClasificador
classdef classEvaluacion<handle
    properties
        set = [] %all set of vectors
        set_train = [] %set of vectors used for train
        set_test = [] %set of vectors used for test
        currentVector = [] %current vector for classify
        accuracyRS 
        accuracyCV
        accuracyLOO
    end
    
    methods
        function obj = classEvaluation() %constructor
            obj.set = []
            obj.set_train = []
            obj.set_test = []
            obj.currentVector = []
            obj.accuracyRS = []
            obj.accuracyCV = []
            obj.accuracyLOO = []
        end
        
        function confusionMatrix = reSustitution(obj,CLASES,clasificador,opcion)
                %{
                Inputs
                CLASES = Array wich contains instances of classClases
                clasificador = instance of classClasificador
                opcion = integer who tell's wich classifier we should use
            
                Outputs
            
                confusionMatrix = matrix that contains the number of well-sorted vectors and those that do not
                
                %}
                
                confusionMatrix = zeros(numel(CLASES));
                numClases = numel(CLASES);
                for i=1:numClases %for each class
                    obj.set = CLASES(i).matriz; %contains all the vectors of the current class
                    obj.set_train = CLASES(i).matriz; %contains all the vectors for training of the current class
                    obj.set_test = CLASES(i).matriz; %contains all the vectors for testing of the current class
                    numElementos = numel(CLASES(i).matriz(1,:));%gets all elements of each class to classify
                    fprintf('================================Vectores de clase %d==========================\n\n',i)
                    for j=1:numElementos %for each vector of each class
                        currentVector = [CLASES(i).matriz(1,j) CLASES(i).matriz(2,j)]; %gets the value of the "i" vector
                        distances = chooseClassifier(CLASES,currentVector,clasificador,opcion); %gets the distances or probability 
                        numClase = clasificador.clasePerteneciente(distances,opcion); %gets the number of class
                        fprintf('Vector %d clasificado como miembro de clase %d matrix(%d,%d)\n',j,numClase,i,numClase)
                        confusionMatrix(i,numClase) = confusionMatrix(i,numClase)+1; %add one
                    end
                end
                obj.accuracyRS = getAccuracy(confusionMatrix,numElementos,numClases); %gets the percentage of accuracy for each class
        end
        
        function [confusionMatrices,promMatrix] = crossValidation(obj,CLASES,clasificador,opcion)
            %{
            Inputs
            CLASES = Array wich contains instances of classClases
            clasificador = instance of classClasificador
            opcion = integer who tell's wich classifier we should use

            Outputs

            confusionMatrix = matrix that contains the number of well-sorted vectors and those that do not
            %}
            confusionMatrices = [];
            confusionMatrix = zeros(numel(CLASES));
            promMatrix = zeros(numel(CLASES));
            numClases = numel(CLASES);
            for z=1:20
                %[CLASES,eps] = getSets_Classes(CLASES,numClases);
                eps = getSets_Classes(CLASES,numClases);
                fprintf('=========================Iteracion %d=========================',z)
                %despliegaValores(CLASES,numClases)
                for i=1:numClases %for each class to classify
                    numElementos = numel(CLASES(i).set_test(1,:))%gets the number of vectors for testing
                    for j=1:numElementos %each vector of testing
                        currentVector = [CLASES(i).set_test(1,j) CLASES(i).set_test(2,j)];
                        distances = chooseClassifier(CLASES,currentVector,clasificador,opcion); %gets the distances or probability 
                        numClase = clasificador.clasePerteneciente(distances,opcion); %gets the number of class
                        fprintf('Vector %d clasificado como miembro de clase %d matrix(%d,%d)\n',j,numClase,i,numClase)
                        confusionMatrix(i,numClase) = confusionMatrix(i,numClase)+1; %add one
                    end
                end
                reiniciaValores(CLASES,numClases);
                confusionMatrices = [confusionMatrices;confusionMatrix];
                confusionMatrix = zeros(numel(CLASES));
                fprintf('=========================Iteracion %d=========================',z)
            end
            promMatrix = promediaMatrices(confusionMatrices,numClases);
            obj.accuracyCV = getAccuracy(promMatrix,eps,numClases); %gets the percentage of accuracy for each class
        end
        
        function confusionMatrix = leaveOneOut(obj,CLASES,clasificador,opcion)
            confusionMatrix = zeros(numel(CLASES));
            numClases = numel(CLASES);
            [~, col] = size(CLASES(1).matriz);
            numElementos = numel(CLASES(1).matriz(1,:));
            %numTotalVectors = numClases*col;
            for i=1:numClases            
                for j=1:numElementos
                    getVector(CLASES,i,j);
                    currentVector = [CLASES(i).set_test(1,1) CLASES(i).set_test(2,1)];
                    distances = chooseClassifier(CLASES,currentVector,clasificador,opcion); %gets the distances or probability 
                    numClase = clasificador.clasePerteneciente(distances,opcion); %gets the number of class
                    fprintf('Vector %d clasificado como miembro de clase %d matrix(%d,%d)\n',j,numClase,i,numClase)
                    confusionMatrix(i,numClase) = confusionMatrix(i,numClase)+1; %add one
                    reiniciaValores(CLASES,numClases);
                end
            end
            obj.accuracyLOO = getAccuracy(confusionMatrix,numElementos,numClases); %gets the percentage of accuracy for each class
        end
        
        function graphPercentage(obj,numClases,metodo)
            grafica = figure('Name','Porcentaje','NumberTitle','off');
            ejeClases = reshape(1:numClases,[1,numClases]); %creates an array with all the number of classes
            plot(ejeClases,obj.accuracyRS,'-or','MarkerFaceColor','r','MarkerSize',15,'DisplayName','ReSustitution');
            grid on 
            hold on %b--o
            str1 = 'Accuracy ';
            tituloG = strcat(str1,metodo);
            title(tituloG)
            plot(ejeClases,obj.accuracyCV,'-og','MarkerFaceColor','g','MarkerSize',15,'DisplayName','CrossValidation');
            plot(ejeClases,obj.accuracyLOO,'b--*','MarkerFaceColor','b','MarkerSize',15,'DisplayName','LeaveOneOut');
            xlabel('Clases');
            ylabel('Porcentaje'); 
            legend show
        end
        
    end
    
end

function getVector(CLASES,currentClass,position)
    CLASES(currentClass).set_test = CLASES(currentClass).matriz(:,position);%gets only one vector
    CLASES(currentClass).ejex(:,position) = []; %deletes the vector on axis "x"
    CLASES(currentClass).ejey(:,position) = []; %deletes the vector on axis "y"
    CLASES(currentClass).set_train = [CLASES(currentClass).ejex;CLASES(currentClass).ejey]; %gets the rest of vectors for train
    CLASES(currentClass).calculateMean(1);
    CLASES(currentClass).calculateSigma(1);
end

%function [CLASES,eps] = getSets_Classes(CLASES,numClases)
function eps = getSets_Classes(CLASES,numClases)
    numElements = numel(CLASES(1).ejex); 
    for i=1:numClases
        [CLASES(i).set_train, CLASES(i).set_test, eps] = getSets(CLASES(i).matriz,numElements);
         
        %UPDATING THE VALUES OF THE PROPERTIES OF THE CLASS
         CLASES(i).ejex = CLASES(i).set_train(1,:); %gets only the values of the vectors in the axis "x"
         CLASES(i).ejey = CLASES(i).set_train(2,:); %gets only the values of the vectors in the axis "y"
         
         %Calculates the new mean and sigma for the current vectors in training
         CLASES(i).calculateMean(1);
         CLASES(i).calculateSigma(1);                                                         
    end
end


function [setTrain,setTest,elementsPerSet] = getSets(set,numElements)
    elementsPerSet = numElements/2;
    if(mod(elementsPerSet,2)~=0) % if it's non pair
        elementsPerSet = round(elementsPerSet);
    end
    auxSet = set;
    setTrain = zeros(2,elementsPerSet);%creates the full set of training only with zeros
    n = numElements;
    %Getting the set Train
    for i=1:elementsPerSet
        position = randperm(n,1);%gets a random position of one vector in the full set of vectors,  1<=position<=numElements   
        setTrain(:,i) = auxSet(:,position); %gets the value of the vector in axis "x" and "y"
        auxSet(:,position) = []; %deletes the choosed vector
        n = n-1;%does the subtraction 
    end
    setTest = auxSet; %gets the rest of vectors who were not choosed for training
end

function despliegaValores(CLASES,numClases)
    for i=1:numClases
        fprintf('\nCLASE %d\n',i)
        CLASES(i).matriz
        %CLASES(i).ejex
        %CLASES(i).ejey
        fprintf('\ntrain\n')
        CLASES(i).set_train
        fprintf('\ntest\n')
        CLASES(i).set_test                    
        fprintf('\nCLASE %d\n',i)
    end
end

function reiniciaValores(CLASES,numClases)
    for i=1:numClases
        CLASES(i).ejex = CLASES(i).matriz(1,:); 
        CLASES(i).ejey = CLASES(i).matriz(2,:);
        CLASES(i).calculateMean(0);
        CLASES(i).calculateSigma(0);
        CLASES(i).set_train = [];
        CLASES(i).set_test = [];
    end
end

function distances = chooseClassifier(CLASES,currentVector,clasificador,opcion)
    switch opcion
        case 1
            distances = clasificador.Euclidiano(CLASES,currentVector); %classify the current vector
        case 2
            distances = clasificador.Mahalanobis(CLASES,currentVector); %classify the current vector
        case 3
            dist = clasificador.Mahalanobis(CLASES,currentVector); %classify the current vector
            distances = clasificador.MP(CLASES,dist); %classify the current vector
        case 4
            [Distances_id sortedDistances numberOfNeighborsForClass] = clasificador.KNN(CLASES,currentVector,clasificador.numberNeighbors);
            distances = numberOfNeighborsForClass;
    end
end

function [matrizProm] = promediaMatrices(Matrices,numClases)
    [row col] = size(Matrices)
    
    matrizProm = zeros(col) %creates a matrix of size col*col which is the number of classes
    start = 1;
    final = numClases;
    for i=1:20 %to get each matrix of the iteration
        m = Matrices(start:final,:);%gets the matrix from "start" row  to "final" row and gets all the columns in that space
        matrizProm = matrizProm+m; %add both matrices, the matrixProm who has the result of old addings and the new one's values in matriz "m"
        matrizProm;
        %moves the index of star to final
        start = start+numClases;
        final = final+numClases;
    end
    %pause
    
    matrizProm = (1/20)*matrizProm;
    
end

function [matrizAccuracy] = getAccuracy(confusionMatrix,totalElementos,numClases)
    matrizAccuracy = zeros(1,numClases)
    for i=1:numClases
        valueClass = confusionMatrix(i,i) %takes the value in the main diagonal of the matrix
        percentage = valueClass*(100/totalElementos);
        matrizAccuracy(i) = percentage;
    end
end