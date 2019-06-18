%Funcion que genera aleatoriamente elementos de las clases deseadas

function [Matriz] = generaClases(numClases,ejemplares)
   Matriz = [];
   for i=1:numClases
       ubicacionClase = input('ubicacion de clase:' )
       dispersionClase = input('dispercion de clase:' )
       %clasex = (randn(1,ejemplares)+ubicacionClase)*dispersionClase; %coordenadas en x
       %clasey = (randn(1,ejemplares)+ubicacionClase)*dispersionClase; %coordenadas en y
       clasex = randn(1,ejemplares)+ubicacionClase; %coordenadas en x
       clasey = (randn(1,ejemplares)+ubicacionClase)*dispersionClase; %coordenadas en y
       vector = [clasex;clasey];%vector con los valores corespondientes para X & Y
       Matriz = [Matriz;vector]; %se agrega al vector original(Matriz) su valor actual y el nuevo vector
   end
end

