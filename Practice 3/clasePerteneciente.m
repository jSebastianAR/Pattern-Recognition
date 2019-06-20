%Funcion que define la clase a la que pertenece el vector a clasificar

function [numClase] = clasePerteneciente(distanciasM,opcion) %Recibe el arreglo que guarda todas las distancias de las medias de las clases y el vector dado por el usuario
     if opcion==1 || opcion==2
        distanciaMinima = min(distanciasM);%encuentra la distancia más corta
        numClase = find(distanciasM==distanciaMinima); %encuentra la posicion donde se ubica la distancia minima en el arreglo de distancias 
     elseif opcion==3
        distanciaMinima = max(distanciasM);%encuentra la probabilidad mas grande
        numClase = find(distanciasM==distanciaMinima); %encuentra la posicion donde se ubica la distancia minima en el arreglo de distancias 
     end
end

