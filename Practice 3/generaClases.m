%Funcion que genera aleatoriamente elementos de las clases deseadas

function [Matriz] = generaClases(numClases,ejemplares)
   Matriz = [];
   for i=1:numClases
       ubicacionClasex = input('ubicacion de clase en x:' )
       ubicacionClasey = input('ubicacion de clase en y:' )
       dispersionClasey = input('dispercion de clase:' )
       %clasex = (randn(1,ejemplares)+ubicacionClase)*dispersionClase; %coordenadas en x
       %clasey = (randn(1,ejemplares)+ubicacionClase)*dispersionClase; %coordenadas en y
       
           if dispersionClasey==0 %si la dispersion es cero entonces no se hace ninguna multiplicacion
                clasex = randn(1,ejemplares)+ubicacionClasex; %coordenadas en x
                clasey = randn(1,ejemplares)+ubicacionClasey; %coordenadas en y
                %clasex = round(randn(1,ejemplares)+ubicacionClase); %coordenadas en x
                %clasey = round(randn(1,ejemplares)+ubicacionClase); %coordenadas en y
           else
                clasex = randn(1,ejemplares)+ubicacionClasex; %coordenadas en x
                clasey = (randn(1,ejemplares)+ubicacionClasey)*dispersionClasey; %coordenadas en y
                %clasex = round(randn(1,ejemplares)+ubicacionClase); %coordenadas en x
                %clasey = round((randn(1,ejemplares)+ubicacionClase)*dispersionClase); %coordenadas en y
           end
           
       vector = [clasex;clasey];%vector con los valores corespondientes para X & Y
       Matriz = [Matriz;vector]; %se agrega al vector original(Matriz) su valor actual y el nuevo vector
   end
end

