%menu de practica 
clc
clear all
close all
warning off all
import classClase %import for class that contents all elements for each created class
import classClasificador %class that contents all classifier methods
%import classEvaluacion



%INSTANCIANDO CLASFICADOR
clasificador = classClasificador();
%INSTANCIANDO CLASFICADOR

opcion = 1;
while(opcion~=0)
    typeClassifier = input('Que tipo de entrenamiento deseas usar 1-Supervisado 2-No supervisado ')
    switch typeClassifier
        case 1
            numClases = input('Cuantas clases quieres?  ')
            numEjemplares = input('Cuántos ejemplares por cada clase?  ') 
            CLASES = []; %VECTOR DE CLASES
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
            
            while opcionCS~=0
            opcionCS = input('Que clasificador deseas usar? 0.-Salir 1-Euclidiano 2.-Mahalanobis 3.-MP 4.-KNN ');
                switch opcionCS

                    case 1 %MÉTODO EUCLIDIANO
                        evaluacion = input('Deseas evaluar el algoritmo? 1.-Si 2.-No ')
                        if(evaluacion~=1)%If the user does not want evaluate the algorithm
                            vectorUsuario = newVector; %we need to put the value of the new vector to vectorUsuario for check if its an old vector plotted
                            newVector = enterVector(vectorUsuario);
                            %obteniendo las distancias con el método euclidiano
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

                    case 2 %MÉTODO MAHALANOBIS

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

                    case 3 %MÉTODO MÁXIMA PROBABILIDAD
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
            
        case 2
            a = clasificador.selectImage();
            opcionCNS = 100;
            while opcionCNS~=0
            opcionCNS = input('Selecciona el tipo de entrenamiento 0-Salir 1-Hierarchical 2-Kmeans ')
                switch opcionCNS
                    
                    case 1 %Hierarchical
                        samples=impixel(a)
                        numSamples = length(samples);
                        clasificador.Hierarchical(numSamples,samples)
                        
                    case 2 %KMEANS
                        km = input('Cuantos centros quieres?')
                        
                        samples=impixel(a)
                        imshow(a)
                        hold on
                        %creates the first groups that contains each sample

                        GROUPS = [];
                        %Gets all the means required 
                        for i=1:km
                            newGroup = createGroup(i,[]); %creates a new group
                            newGroup.Z = samples(i,:) %adds the i-sample from all matrix of samples for the i-group
                            GROUPS = [GROUPS newGroup]; %stores the i-group in GROUPS
                        end
                        clasificador.Kcentros(GROUPS,samples,km,a)
                end
            end
            
    end
end



