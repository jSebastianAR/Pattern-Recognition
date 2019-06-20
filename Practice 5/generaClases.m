%Funcion que genera aleatoriamente elementos de las clases deseadas
function [MatrizClases] = generaClases(numClases,ejemplares)
   import classClase
   
   MatrizClases = [];
   for i=1:numClases
       fprintf('\n\nDatos de la clase %d\n',i)
       ubicacionClasex = input('ubicacion de clase en x: ');
       ubicacionClasey = input('ubicacion de clase en y: ');
       dispersion = input('dispersion de clase: ');
       clase = classClase(ubicacionClasex,ubicacionClasey,dispersion,ejemplares); %creates a new object of clase
       MatrizClases = [MatrizClases clase];%stores the new clase in MatrizClases
   end
end

