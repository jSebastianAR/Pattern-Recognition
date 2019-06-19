%Programa que obtiene la matriz "E"
function [inverseMatrixE] = calculaE(CLASES,MEDIAS,numFila,numElements)
%{
In general, you can generate N random numbers in the interval (a,b) with the formula r = a + (b-a).*rand(N,1).
Example: 
r = -5 + (5+5)*rand(10,1) gives us random numbers between -5 to 5
%}
ejex = CLASES(numFila,:);%extrac all the values in all columns on the "numFila" row for x values
ejey = CLASES(numFila+1,:);%extrac all the values in all columns on the "numFila" row for y values

%MEDIAS only has one column thats why we need to put a "1" in the second parameter
mediax = MEDIAS(numFila,1); %extrac the value of the mean in the specific position that we need
mediay = MEDIAS(numFila+1,1);

resta_onX = ejex-mediax; %does the subtraction on x
resta_onY = ejey-mediay; %does the subtraction on y

%stores all the results on the final matrix for E, the first row contains the elements for x and the second row the elements for y
matrizE = [resta_onX;resta_onY]
traspE = matrizE.' %does the inverse matrix of E 
multMatrices = matrizE*traspE;
preFinalE = (1/numElements)*multMatrices

inverseMatrixE = inv(preFinalE)

end




