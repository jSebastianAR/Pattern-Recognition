clc
clear all
close all
warning off all

numClases = input('Cuantas clases quieres?' )
ejemplares = input('Cuántos ejemplares por cada clase?' ) 
CLASES = [] %VECTOR DE CLASES

%GENERANDO CLASES ALEATORIAS
for i=1:numClases
   ubicacionClase = input('ubicacion de clase:' )
   dispersionClase = input('dispercion de clase:' )
   clasex = (randn(1,ejemplares)+ubicacionClase)*dispersionClase; %coordenadas en x
   clasey = (randn(1,ejemplares)+ubicacionClase)*dispersionClase; %coordenadas en y
   vector = [clasex;clasey];%vector con los valores corespondientes para X & Y
   CLASES = [CLASES;vector]; %se agrega al vector original(CLASES) su valor actual y el nuevo vector
end

%for i=1:
dimension = size(CLASES);%INDICA LA DIMENSION
numCol = length(CLASES);%NUMERO DE columnas
numFilas = dimension(1);
numElementos = numel(CLASES);%NUMERO DE ELEMENTOS EN LA MATRIZ
aux=1
%GRAFICANDO CLASES
for i=1:2:numFilas
    clasex = CLASES(i:2*numClases:end);
    clasey = CLASES(i+1:2*numClases:end);
    if aux==1 %clase 1
        plot(clasex(1,:),clasey(1,:),'ob','MarkerFaceColor','b','MarkerSize',15,'DisplayName','clase1')% (vector en x, vector en y, color, )
        grid on 
        hold on
        title('Grafica de datos en el espacio euclidiano')
        aux=aux+1
    elseif aux==2 %clase 2
        plot(clasex(1,:),clasey(1,:),'ok','MarkerFaceColor','k','MarkerSize',15,'DisplayName','clase2')% (vector en x, vector en y, color, )
        aux=aux+1
    elseif aux==3 %clase 3
        plot(clasex(1,:),clasey(1,:),'or','MarkerFaceColor','r','MarkerSize',15,'DisplayName','clase3')% (vector en x, vector en y, color, )
        aux=aux+1
    elseif aux==4 %clase 4
        plot(clasex(1,:),clasey(1,:),'og','MarkerFaceColor','g','MarkerSize',15,'DisplayName','clase4')% (vector en x, vector en y, color, )
        aux=aux+1
    elseif aux==5 %clase 5
        plot(clasex(1,:),clasey(1,:),'oy','MarkerFaceColor','y','MarkerSize',15,'DisplayName','clase5')% (vector en x, vector en y, color, )
        aux=aux+1
    elseif aux==6 %clase 6
        plot(clasex(1,:),clasey(1,:),'oc','MarkerFaceColor','c','MarkerSize',15,'DisplayName','clase6')% (vector en x, vector en y, color, )
        aux=aux+1
    elseif aux==7 %clase 7
        plot(clasex(1,:),clasey(1,:),'om','MarkerFaceColor','m','MarkerSize',15,'DisplayName','clase7')% (vector en x, vector en y, color, )
        aux=aux+1
    elseif aux==8 %clase 8
        plot(clasex(1,:),clasey(1,:),'ow','MarkerFaceColor','w','MarkerSize',15,'DisplayName','clase8')% (vector en x, vector en y, color, )
        aux=1
    end  
end

legend show

vectorx = input('Ingresa el valor de la coordenada en x ')
vectory = input('Ingresa el valor de la coordenada en y ')
vectorUsuario = [vectorx;vectory]
plot(vectorx,vectory,'vm','MarkerFaceColor','m','MarkerSize',15)

MEDIAS = [];
distanciasM = [];
%calculando medias
for i=1:2:numFilas%
    clasex = CLASES(i:2*numClases:end)%obtiene los valores de una fila de ejes en x
    clasey = CLASES(i+1:2*numClases:end)%obtiene valores de una fila de ejes en y
    mediax = mean(clasex,2)%media para valores en x
    mediay = mean(clasey,2)%media para valores en y
    vectMedia = [mediax;mediay]%crea el vector media
    dist = norm(vectMedia-vectorUsuario)%calcula distancia entre la media de la clase actual y el vector del usuario
    distanciasM = [distanciasM dist]%guarda las distancias
    MEDIAS = [MEDIAS;vectMedia]%se guardan todos las coordenadas de las medias en vectores
end

distanciasM
minimo = min(distanciasM)%obtiene el valor minimo obtenido de las distancias
numClase = find(distanciasM==minimo)%ubica la posicion del arreglo donde esta el minimo para decir de qué clase es
fprintf('El vector pertenece a la clase %d',numClase)