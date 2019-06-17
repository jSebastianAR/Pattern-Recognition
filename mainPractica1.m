clc
clear all
close all
warning off all

numClases = input('Cuantas clases quieres?' )
ejemplares = input('Cuántos ejemplares por cada clase?' ) 
CLASES = []; %VECTOR DE CLASES

%GENERANDO CLASES ALEATORIAS
CLASES = generaClases(numClases, ejemplares)

%GRAFICANDO CLASES
dimension = size(CLASES);%INDICA LA DIMENSION
numFilas = dimension(1);
graficaClases(CLASES,numFilas,numClases);
legend show %muestra los datos de las clases
%calculando medias
MEDIAS = [];
MEDIAS = calculaMedias(numFilas,CLASES)
%MEDIAS = calculaMedias(numFilas,numClases,CLASES)
    
    %CICLO WHILE PARA QUE EL USUARIO PUEDA EVALUAR LOS VECTORES QUE DESEE
    
    opcion = 1; %para entrar al while
    while opcion==1
        %Pidiendo al usuario ingresar vector
        vectorx = input('Ingresa el valor de la coordenada en x ')
        vectory = input('Ingresa el valor de la coordenada en y ')
        vectorUsuario = [vectorx;vectory]
        plot(vectorUsuario(1),vectorUsuario(2),'vm','MarkerFaceColor','m','MarkerSize',10)
    
        %calcula las distancias entre las medias de las clases y el vector del
        %usuario
        
        distanciasM = calculaDistancias(MEDIAS,vectorUsuario)
        MEDIAS
        %Se obtiene la clase a la que pertenece
        numClase = clasePerteneciente(distanciasM);
        fprintf('El vector pertenece a la clase %d',numClase)
        opcion = input('\nDeseas ingresar otro vector? 1-si 2-no ')
        if opcion == 1
            plot(vectorUsuario(1),vectorUsuario(2),'vw','MarkerFaceColor','w','MarkerSize',10)%borra el punto
            vectorUsuario = []
        end
    end