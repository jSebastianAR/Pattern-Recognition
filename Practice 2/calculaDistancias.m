%   Funcion que calcula las distancias entre las clases y el vector a
%   clasificar

function [ distanciasM ] = calculaDistancias(MatrizMedias, vectorUsuario)

    dimension = size(MatrizMedias);
    numFilas = dimension(1);
    distanciasM = [];
    MatrizMedias
    matrixUser = [vectorUsuario(1);vectorUsuario(2)]

    for i=1:2:numFilas
        ejex = MatrizMedias(i,1); %obtiene la coordenada de la media en el eje x
        ejey = MatrizMedias(i+1,1); %obtiene la coordenada de la media en el eje y
        vectorMedia = [ejex;ejey]; %se compone el vector media de la clase evaluada
        dist = norm(vectorMedia-matrixUser);%calcula distancia entre la media de la clase actual y el vector del usuario
        distanciasM = [distanciasM dist]; %guarda las distancias en un arreglo
    end


end

