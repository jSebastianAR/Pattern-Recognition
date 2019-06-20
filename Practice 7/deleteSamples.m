function [ newMatrix ] = deleteSamples(Matrix,numSamples)
    maxSample = max(numSamples);
    minSample = min(numSamples);
    %
    Matrix(maxSample,:)=[];
    Matrix(:,maxSample)=[];
    Matrix(minSample,:)=[];
    Matrix(:,minSample)=[];
    newMatrix = Matrix;
end
