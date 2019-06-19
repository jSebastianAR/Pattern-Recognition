
clc
clear all
close all
warning off all

ejex = [0 1 1 1];%extrac all the values in all columns on the "numFila" row for x values
ejey = [0 0 1 0];%extrac all the values in all columns on the "numFila" row for y values
%ejez = [0 0 0 1];

%MEDIAS only has one column thats why we need to put a "1" in the second parameter
%media = [3/4 1/4 1/4]; %extrac the value of the mean in the specific position that we need
media = [3/4 1/4];

resta_onX = ejex - media(1); %does the subtraction on x
resta_onY = ejey -media(2); %does the subtraction on y
%resta_onZ = ejez -media(3) %does the subtraction on z

%stores all the results on the final matrix for E, the first row contains the elements for x and the second row the elements for y
%matrizE = [resta_onX;resta_onY;resta_onZ]
matrizE = [resta_onX;resta_onY]
traspE = matrizE.' %does the inverse matrix of E 
multMatrices = matrizE*traspE
preFinalE = (1/4)*multMatrices

fprintf('Estatico')
inverseMatrixE = inv(preFinalE)
%{
fprintf('==================================================================')
fprintf('Estatico con for')
CLASES = [ejex;ejey;ejex;ejey;ejex;ejey];
mediax = mean(ejex,2);
mediay = mean(ejey,2);
MEDIAS = [mediax;mediay;mediax;mediay;mediax;mediay;];
tam = size(CLASES);
numFilas = tam(1);
numElements = tam(2);

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

        inverseMatrixE = inv(preFinalE)
        %matricesE = [matricesE;inverseMatrixE]
end
%}
