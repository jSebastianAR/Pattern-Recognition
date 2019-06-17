%Funcion que calcula las medias de un grupo de clases

%function [ Medias ] = calculaMedias( numFilas, numClases, CLASES )
function [ Medias ] = calculaMedias( numFilas, CLASES)
    Medias=[];
    %{
    for i=1:2:numFilas%
        clasex = CLASES(i:2*numClases:end)%obtiene los valores de una fila de ejes en x
        clasey = CLASES(i+1:2*numClases:end)%obtiene valores de una fila de ejes en y
        mediax = mean(clasex,2)%media para valores en x
        mediay = mean(clasey,2)%media para valores en y
        vectMedia = [mediax;mediay]%crea el vector media
        Medias = [Medias;vectMedia]%se guardan todos las coordenadas de las medias en vectores
    end
    %}
    dimension = size(CLASES)
    numColumnas = dimension(2)
    clasex = []
    clasey = []
    CLASES
    for i=1:2:numFilas%recorre filas de dos en dos
        for j=1:numColumnas%recorre todas las columnas 
            clasex = [clasex CLASES(i,j)];
            clasey = [clasey CLASES(i+1,j)];
        end
        mediax = mean(clasex,2);
        mediay = mean(clasey,2);
        vectMedia = [mediax;mediay];
        Medias = [Medias;vectMedia];
        clasex = [];
        clasey = [];
    end
    
end

