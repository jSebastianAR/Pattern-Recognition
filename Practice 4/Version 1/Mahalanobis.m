function [ distances ] = Mahalanobis(CLASES,vectorUsuario)
    distances = [];
    numClases = numel(CLASES);
    for i=1:numClases %goes through all classes
        resta = restaVectores(vectorUsuario,CLASES(i).media);%calls local function
        m = (resta)*(CLASES(i).matrixSigmaI);
        distancia = sqrt(m*resta');%formula de las distancias
        distances = [distances distancia]; %returns all the distances 
    end
end

%Local function
function [ subtracVectors ] = restaVectores(minuendo,sustraendo)%minuendo = vector al que se resta, sustraendo = vector que resta
subtracVectors = minuendo - sustraendo;
end
