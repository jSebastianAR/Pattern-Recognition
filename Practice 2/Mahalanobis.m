function [ distances ] = Mahalanobis(matricesE,MEDIAS,vectorUsuario,numFilas)
    distances = [];
    for i=1:2:numFilas %for from one to "numFilas" with step of two
        matrixE_X = matricesE(i,:);
        matrixE_Y = matricesE(i+1,:);
        matrixE = [matrixE_X;matrixE_Y];
        meanX = MEDIAS(i,1);
        meanY = MEDIAS(i+1,1);
        vectorMean = [meanX meanY];
        vectUser_vectorMean = restaVectores(vectorUsuario,vectorMean);%calls local function
        cDistance = sqrt((vectUser_vectorMean*matrixE)*vectUser_vectorMean.');%formula de las distancias
        distances = [distances cDistance]; %returns all the distances 
    end
end

%Local function
function [ subtracVectors ] = restaVectores(minuendo,sustraendo)%minuendo = vector al que se resta, sustraendo = vector que resta
subtracVectors = minuendo - sustraendo;
end
