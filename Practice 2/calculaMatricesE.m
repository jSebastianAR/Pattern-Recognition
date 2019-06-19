function [ matricesE,inverseE ] = calculaMatricesE(CLASES,MEDIAS,numFilas,numElements)
    matricesE = [];
    inverseE = [];
    for i=1:2:numFilas
        ejex = CLASES(i,:);%extrac all the values in all columns on the "numFila" row for x values
        ejey = CLASES(i+1,:);%extrac all the values in all columns on the "numFila" row for y values

        %MEDIAS only has one column thats why we need to put a "1" in the second parameter
        mediax = MEDIAS(i,1); %extrac the value of the mean in the specific position that we need
        mediay = MEDIAS(i+1,1);

        resta_onX = ejex-mediax; %does the subtraction on x
        resta_onY = ejey-mediay; %does the subtraction on y

        %stores all the results on the final matrix for E, the first row contains the elements for x and the second row the elements for y
        matrizE = [resta_onX;resta_onY];
        traspE = matrizE.'; %does the inverse matrix of E 
        multMatrices = matrizE*traspE;
        preFinalE = (1/numElements)*multMatrices;
        matricesE = [matricesE;preFinalE]; %gets the normal E matrix 
        inverseMatrixE = inv(preFinalE);%gets the inverse E matrix
        inverseE = [inverseE;inverseMatrixE];
    end
    
    matricesE;
    inverseE;

end

