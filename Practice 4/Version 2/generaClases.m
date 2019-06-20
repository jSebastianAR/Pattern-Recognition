%Funcion que genera aleatoriamente elementos de las clases deseadas
function [MatrizClases] = generaClases(numClases,ejemplares)
   import Clase
   
   MatrizClases = [];
   for i=1:numClases
       ubicacionClasex = input('ubicacion de clase en x:' );
       ubicacionClasey = input('ubicacion de clase en y:' );
       dispersion = input('dispercion de clase:' );
       clase = Clase(ubicacionClasex,ubicacionClasey,dispersion,ejemplares); %creates a new object of clase
       MatrizClases = [MatrizClases clase];%stores the new clase in MatrizClases
   end
end

