function [ P,PN ] = Bayesiano(CLASES,distancesMahal)
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
    numClases = numel(CLASES);
    for i=1:numClases %go through all rows with step of two to get only one matrix per iteration
        distance = distancesMahal(i)%gets the distance for the matrix E evaluated
        prob = probability(CLASES(i).matrixSigma,distance);
        P = [P prob]; %stores the value p at last position of the P vector
    end
    
    sumP = sum(P)%sum all values in P
    for i=1:numel(P)
       pn = (P(i)/sumP)*100; %normalize all values in P 
       PN = [PN pn];%stores the value pn at last position of the PN vector
    end
end

function [p] = probability(matrix,distanceM)
% p = probability for "matrix"
% matrix = it's a specific matrix E 
% distanceM = distance Mahal of the matrix
n = 2;
detM = sqrt(det(matrix));
%detM = det(matrix)
f = 2*pi;
%m1 = f*detM
c = f*detM;
a = 1/c

m = (-1/2)*distanceM;
b = exp(m)

p = b/a
%p = round(p)%round to two decimals
end