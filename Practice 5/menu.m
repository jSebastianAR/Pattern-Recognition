%menu de practica 
clc
clear all
close all
warning off all
import classClase %import for class that contents all elements for each created class
import classClasificador %class that contents all classifier methods
import classEvaluacion

numClases = input('Cuantas clases quieres?  ')
numEjemplares = input('Cu�ntos ejemplares por cada clase?  ') 
CLASES = []; %VECTOR DE CLASES

%INSTANCIANDO CLASFICADOR
clasificador = classClasificador();
%INSTANCIANDO CLASFICADOR

%GENERANDO CLASES ALEATORIAS
CLASES = generaClases(numClases, numEjemplares); %generate all the objects of clases
%GENERANDO CLASES ALEATORIAS

%INSTANCIANDO EL EVALUADOR DE ALGORITMOS
evaluador = classEvaluacion()
%INSTANCIANDO EL EVALUADOR DE ALGORITMOS

%GRAFICANDO CLASES
graficaClases(CLASES,numClases);
legend show %muestra los datos de las clases
%GRAFICANDO CLASES


vectorUsuario = [];
newVector = [];
opcion = 1;
while(opcion~=0)
    opcion = input('Que clasificador deseas usar? 0.-Salir 1-Euclidiano 2.-Mahalanobis 3.-MP 4.-KNN ');
    switch opcion
        
        case 1 %M�TODO EUCLIDIANO
            evaluacion = input('Deseas evaluar el algoritmo? 1.-Si 2.-No ')
            if(evaluacion~=1)%If the user does not want evaluate the algorithm
                vectorUsuario = newVector; %we need to put the value of the new vector to vectorUsuario for check if its an old vector plotted
                newVector = enterVector(vectorUsuario);
                %obteniendo las distancias con el m�todo euclidiano
                %distancias = calculaDistancias(CLASES,newVector)
                distancias = clasificador.Euclidiano(CLASES,newVector)
                %Se obtiene la clase a la que pertenece
                %numClase = clasePerteneciente(distancias,opcion);
                numClase = clasificador.clasePerteneciente(distancias,opcion);
                fprintf('El vector pertenece a la clase %d \n\n',numClase)
            else %if the user wants to evaluate
                matrizRS = evaluador.reSustitution(CLASES,clasificador,opcion);
                [matricesCV,promMatrix] = evaluador.crossValidation(CLASES,clasificador,opcion);
                matrizLOO = evaluador.leaveOneOut(CLASES,clasificador,opcion);
                matrizRS
                evaluador.accuracyRS
                meanRS = mean(evaluador.accuracyRS,2)
                matricesCV
                promMatrix
                evaluador.accuracyCV = evaluador.accuracyCV-1;
                evaluador.accuracyCV
                meanCV = mean(evaluador.accuracyCV,2)
                matrizLOO
                evaluador.accuracyLOO
                meanLOO = mean(evaluador.accuracyLOO,2)
                evaluador.graphPercentage(numClases,'Euclidiano')
            end
            
        case 2 %M�TODO MAHALANOBIS
            
            evaluacion = input('Deseas evaluar el algoritmo? 1.-Si 2.-No ')
            if(evaluacion~=1)%If the user does not want evaluate the algorithm
                distancias =[];
                vectorUsuario = newVector; %we need to put the value of the new vector to vectorUsuario for check if its an old vector plotted
                newVector = enterVector(vectorUsuario);%Asks for a new vector to user
                %gets the distances 
                %distancias = Mahalanobis(CLASES,newVector)
                distancias = clasificador.Mahalanobis(CLASES,newVector)
                distancias
                %numClass = clasePerteneciente(distancias,opcion);
                numClase = clasificador.clasePerteneciente(distancias,opcion);
                fprintf('El vector pertenece a la clase %d \n\n',numClase)
             else %if the user wants to evaluate
                matrizRS = evaluador.reSustitution(CLASES,clasificador,opcion);
                [matricesCV,promMatrix] = evaluador.crossValidation(CLASES,clasificador,opcion);
                matrizLOO = evaluador.leaveOneOut(CLASES,clasificador,opcion);
                matrizRS
                evaluador.accuracyRS
                meanRS = mean(evaluador.accuracyRS,2)
                matricesCV
                promMatrix
                evaluador.accuracyCV = evaluador.accuracyCV-1;
                evaluador.accuracyCV
                meanCV = mean(evaluador.accuracyCV,2)
                matrizLOO
                evaluador.accuracyLOO
                meanLOO = mean(evaluador.accuracyLOO,2)
                evaluador.graphPercentage(numClases,'Mahalanobis')
            end   
            
        case 3 %M�TODO M�XIMA PROBABILIDAD
            evaluacion = input('Deseas evaluar el algoritmo? 1.-Si 2.-No ')
            if(evaluacion~=1)%If the user does not want evaluate the algorithm
                distancias =[];
                vectorUsuario = newVector; %we need to put the value of the new vector to vectorUsuario for check if its an old vector plotted
                newVector = enterVector(vectorUsuario);%Asks for a new vector to user
                %gets the distances 
                %distancias = Mahalanobis(CLASES,newVector)
                distancias = clasificador.Mahalanobis(CLASES,newVector)
                distancias = (1/10)*(distancias)

                %[P,PN] = Bayesiano(CLASES,distancias);
                [P,PN] = clasificador.MP(CLASES,distancias);
                P
                PN
                %numClase = clasePerteneciente(PN,opcion);
                numClase = clasificador.clasePerteneciente(PN,opcion);
                fprintf('El vector pertenece a la clase %d \n\n',numClase)
            else %if the user wants to evaluate
                matrizRS = evaluador.reSustitution(CLASES,clasificador,opcion);
                [matricesCV,promMatrix] = evaluador.crossValidation(CLASES,clasificador,opcion);
                matrizLOO = evaluador.leaveOneOut(CLASES,clasificador,opcion);
                matrizRS
                evaluador.accuracyRS
                meanRS = mean(evaluador.accuracyRS,2)
                matricesCV
                promMatrix
                evaluador.accuracyCV = evaluador.accuracyCV-1;
                evaluador.accuracyCV
                meanCV = mean(evaluador.accuracyCV,2)
                matrizLOO
                evaluador.accuracyLOO
                meanLOO = mean(evaluador.accuracyLOO,2)
                evaluador.graphPercentage(numClases,'Maxima Probabilidad')
            end   
            
        case 4 %KNN
              
            evaluacion = input('Deseas evaluar el algoritmo? 1.-Si 2.-No ')
            if(evaluacion~=1)%If the user does not want evaluate the algorithm  
                  vectorUsuario = newVector; %we need to put the value of the new vector to vectorUsuario for check if its an old vector plotted
                  newVector = enterVector(vectorUsuario);%Asks for a new vector to user
                  %gets the distances 
                    K = input('Inserta los k vecinos(Impar): ' );
                    while(mod(K,2)==0) %do it while is a pair number
                        K = input('Inserta los k vecinos(Impar): ' );
                    end
                  [clasificador.distancesKNN clasificador.sortedDistances neighborsNumber] = clasificador.KNN(CLASES,newVector,K); %gets the distances between the user vector and all the classes
                  All = [clasificador.distancesKNN clasificador.sortedDistances]
                  neighborsNumber
                  %Finds the class with more vectors in neighborsNumber
                  %numClase = clasePerteneciente(neighborsNumber,4);
                  numClase = clasificador.clasePerteneciente(neighborsNumber,opcion);
                  fprintf('El vector pertenece a la clase %d \n\n',numClase)
           else %if the user wants to evaluate
                clasificador.numberNeighbors = input('Inserta los k vecinos(Impar): ' );
                while(mod(clasificador.numberNeighbors,2)==0) %do it while is a pair number
                    clasificador.numberNeighbors = input('Inserta los k vecinos(Impar): ' );
                end
            
                matrizRS = evaluador.reSustitution(CLASES,clasificador,opcion);
                [matricesCV,promMatrix] = evaluador.crossValidation(CLASES,clasificador,opcion);
                matrizLOO = evaluador.leaveOneOut(CLASES,clasificador,opcion);
                matrizRS
                evaluador.accuracyRS
                meanRS = mean(evaluador.accuracyRS,2)
                matricesCV
                promMatrix
                evaluador.accuracyCV = evaluador.accuracyCV-1;
                evaluador.accuracyCV
                meanCV = mean(evaluador.accuracyCV,2)
                matrizLOO
                evaluador.accuracyLOO
                meanLOO = mean(evaluador.accuracyLOO,2)
                evaluador.graphPercentage(numClases,'KNN');
           end  
    end
end



