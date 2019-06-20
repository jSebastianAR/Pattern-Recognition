%   Funcion que calcula las distancias entre las clases y el vector a
%   clasificar

function [ distanciasM ] = calculaDistancias(CLASES,vectorUsuario)

    distanciasM = [];
    numClases = numel(CLASES)
    for i=1:numClases
        dist = norm(CLASES(i).media-vectorUsuario);%calcula distancia entre la media de la clase actual y el vector del usuario
        distanciasM = [distanciasM dist]; %guarda las distancias en un arreglo
    end
end

