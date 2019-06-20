function [ P,PN ] = Bayesiano(matricesE,distancesMahal,numFilas)
%{
Output args: 
P = Matrix with all probability values, 
PN = Matrix with all normalized probability values

Input args:
matricesE = All matrices E
distancesMahal = This argument contains all the distances that we got in   
mahal function
%}
    P = [];
    PN = [];
    numClase = 1;
    for i=1:2:numFilas %go through all rows with step of two to get only one matrix per iteration
        ejex = matricesE(i,:); %gets all columns values in the i row 
        ejey = matricesE(i+1,:); %gets all columns values in the i+1 row 
        matrixE = [ejex;ejey]%makes the matrix with the axis obtained 
        distance = distancesMahal(numClase)%gets the distance for the matrix E evaluated
        prob = probability(matrixE,distance);
        P = [P prob]; %stores the value p at last position of the P vector
        numClase = numClase+1;%adds
    end
    
    sumP = sum(P);%sum all values in P
    for i=1:numel(P)
       pn = (P(i)/sumP)*100; %normalize all values in P 
       PN = [PN pn];%stores the value pn at last position of the PN vector
    end
    P;
    PN;
end

function [p] = probability(matrix,distanceM)
% p = probability for "matrix"
% matrix = it's a specific matrix E 
% distanceM = distance Mahal of the matrix
n = 2;
detM = sqrt(det(matrix))
f = 2*pi
a = detM/f

m = (-1/2)*distanceM
b = exp(m);

p = b/a;
%p = round(p)%round to two decimals
end