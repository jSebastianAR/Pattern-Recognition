%menu de practica 
clc
clear all
close all
warning off all
import Clase %import for class that contents all elements for each created class
import objClasificador %class that contents all classifier methods

numClases = input('Cuantas clases quieres?  ')
numEjemplares = input('Cuántos ejemplares por cada clase?  ') 
CLASES = []; %VECTOR DE CLASES
%INSTANCIANDO CLASFICADOR
clasificador = objClasificador();

%GENERANDO CLASES ALEATORIAS
CLASES = generaClases(numClases, numEjemplares); %generate all the objects of clases
%GENERANDO CLASES ALEATORIAS

%GRAFICANDO CLASES
graficaClases(CLASES,numClases);
legend show %muestra los datos de las clases
%GRAFICANDO CLASES


vectorUsuario = [];
newVector = [];
opcion = 1;
while(opcion~=0)
    opcion = input('Que clasificador deseas usar? 0.-Salir 1-Euclidiano 2.-Mahalanobis 3.-Bayesiano 4.-KNN  ');
    switch opcion
        
        case 1 %MÉTODO EUCLIDIANO
            vectorUsuario = newVector; %we need to put the value of the new vector to vectorUsuario for check if its an old vector plotted
            newVector = enterVector(vectorUsuario);
            %obteniendo las distancias con el método euclidiano
            %distancias = calculaDistancias(CLASES,newVector)
            distancias = clasificador.Euclidiano(CLASES,newVector)
            %Se obtiene la clase a la que pertenece
            numClase = clasePerteneciente(distancias,opcion);
            fprintf('El vector pertenece a la clase %d \n\n',numClase)
            
        case 2 %MÉTODO MAHALANOBIS
            distancias =[];
            vectorUsuario = newVector; %we need to put the value of the new vector to vectorUsuario for check if its an old vector plotted
            newVector = enterVector(vectorUsuario);%Asks for a new vector to user
            %gets the distances 
            %distancias = Mahalanobis(CLASES,newVector)
            distancias = clasificador.Mahalanobis(CLASES,newVector)
            distancias
            numClass = clasePerteneciente(distancias,opcion);
            fprintf('El vector pertenece a la clase %d \n\n',numClass)
            
        case 3 %MÉTODO MÁXIMA PROBABILIDAD
            distancias =[];
            vectorUsuario = newVector; %we need to put the value of the new vector to vectorUsuario for check if its an old vector plotted
            newVector = enterVector(vectorUsuario);%Asks for a new vector to user
            %gets the distances 
            %distancias = Mahalanobis(CLASES,newVector)
            distancias = clasificador.Mahalanobis(CLASES,newVector)
            distancias = (1/10)*(distancias)

            %[P,PN] = Bayesiano(CLASES,distancias);
            [P,PN] = clasificador.Bayesiano(CLASES,distancias);
            P
            PN
            numClase = clasePerteneciente(PN,opcion);
            fprintf('El vector pertenece a la clase %d \n\n',numClase)
            
        case 4 %KNN
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
              numClase = clasePerteneciente(neighborsNumber,4);
              fprintf('El vector pertenece a la clase %d \n\n',numClase)
    
    end
end

%Funcion que define la clase a la que pertenece el vector a clasificar

function [numClase] = clasePerteneciente(distanciasM,opcion) %Recibe el arreglo que guarda todas las distancias de las medias de las clases y el vector dado por el usuario
     if opcion==1 || opcion==2
        distanciaMinima = min(distanciasM);%encuentra la distancia más corta
        numClase = find(distanciasM==distanciaMinima); %encuentra la posicion donde se ubica la distancia minima en el arreglo de distancias 
     elseif opcion==3 || opcion==4
        distanciaMinima = max(distanciasM);%encuentra la probabilidad mas grande
        numClase = find(distanciasM==distanciaMinima); %encuentra la posicion donde se ubica la distancia minima en el arreglo de distancias 
     end
end

