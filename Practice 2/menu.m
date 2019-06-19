%menu de practica 1 y 2

clc
clear all
close all
warning off all

numClases = input('Cuantas clases quieres?' )
numEjemplares = input('Cuántos ejemplares por cada clase?' ) 
CLASES = []; %VECTOR DE CLASES

%GENERANDO CLASES ALEATORIAS
CLASES = generaClases(numClases, numEjemplares)

%GRAFICANDO CLASES
dimension = size(CLASES);%INDICA LA DIMENSION
numFilas = dimension(1);
graficaClases(CLASES,numFilas,numClases);
legend show %muestra los datos de las clases
%calculando medias
MEDIAS = [];
MEDIAS = calculaMedias(numFilas,CLASES)
vectorUsuario = []
opcion = 1
firstTime = 0
matricesE = []
inverseE = []
while(opcion~=0)
    opcion = input('Que clasificador deseas usar? 0.-Salir 1-Euclidiano 2.-Mahalanobis ');
    
    if opcion==1
        %llamada a método de distancias euclidianas
        %First must check if there is a vector plotted
        elementosVector = numel(vectorUsuario);
        if elementosVector~=0 %if there is an old vector plotted
            plot(vectorUsuario(1),vectorUsuario(2),'vw','MarkerFaceColor','w','MarkerSize',10)%borra el punto
            vectorUsuario = [];
        end
        %Pidiendo al usuario ingresar vector
        vectorx = input('Ingresa el valor de la coordenada en x ')
        vectory = input('Ingresa el valor de la coordenada en y ')
        vectorUsuario = [vectorx vectory]
        plot(vectorx,vectory,'vm','MarkerFaceColor','m','MarkerSize',10)
        
        
        distanciasM = calculaDistancias(MEDIAS,vectorUsuario)
        MEDIAS
        %Se obtiene la clase a la que pertenece
        numClase = clasePerteneciente(distanciasM);
        fprintf('El vector pertenece a la clase %d ',numClase)
        
    elseif opcion==2
        %llamada a método de distancias mahalanobis
        %matricesE = [];%this matrix is going to stores all E matrices for all the classes
        distances =[];
        tam = size(CLASES);
        numFilas = tam(1);
        
        %First must check if there is a vector plotted
        elementosVector = numel(vectorUsuario);
        if elementosVector~=0 %if there is an old vector plotted we need to erase it
            plot(vectorUsuario(1),vectorUsuario(2),'vw','MarkerFaceColor','w','MarkerSize',10)%borra el punto
            vectorUsuario = [];
        end
        
        %Pidiendo al usuario ingresar vector
        vectorx = input('Ingresa el valor de la coordenada en x ');
        vectory = input('Ingresa el valor de la coordenada en y ');
        vectorUsuario = [vectorx vectory]
        plot(vectorUsuario(1),vectorUsuario(2),'vm','MarkerFaceColor','m','MarkerSize',10);
        
        if firstTime==0 %if its the first time to calculate all E matrices
            [matricesE,inverseE] = calculaMatricesE(CLASES,MEDIAS,numFilas,numEjemplares); %gets all matrices E for all classes
            firstTime = 1;
        end
        %gets the distances 
        distances = Mahalanobis(matricesE,MEDIAS,vectorUsuario,numFilas)
        
        CLASES
        MEDIAS
        matricesE
        distances
        numClass = clasePerteneciente(distances);
        fprintf('El vector pertenece a la clase %d \n\n',numClass)
        
    elseif opcion==3
        %llamada a método de distancias mahalanobis
        %matricesE = [];%this matrix is going to stores all E matrices for all the classes
        distances =[];
        tam = size(CLASES);
        numFilas = tam(1);
        
        %First must check if there is a vector plotted
        elementosVector = numel(vectorUsuario);
        if elementosVector~=0 %if there is an old vector plotted we need to erase it
            plot(vectorUsuario(1),vectorUsuario(2),'vw','MarkerFaceColor','w','MarkerSize',10)%borra el punto
            vectorUsuario = [];
        end
        
        %Pidiendo al usuario ingresar vector
        vectorx = input('Ingresa el valor de la coordenada en x ');
        vectory = input('Ingresa el valor de la coordenada en y ');
        vectorUsuario = [vectorx vectory]
        plot(vectorUsuario(1),vectorUsuario(2),'vm','MarkerFaceColor','m','MarkerSize',10);
        
        if firstTime==0 %if its the first time to calculate all E matrices
            [matricesE,inverseE] = calculaMatricesE(CLASES,MEDIAS,numFilas,numEjemplares); %gets all matrices E for all classes
            firstTime = 1;
        end
        %gets the distances 
        matricesE
        inverseE
        distances = Mahalanobis(matricesE,MEDIAS,vectorUsuario,numFilas)
    end


end