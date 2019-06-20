function [ matrixDistances ] = calculateDistances(GROUPS,SAMPLES,indexForGroup,allGROUPS)
    numGroups = length(GROUPS); %takes the number of groups added in the matrix "GROUPS"
    matrixDistances = zeros(numGroups); %reserve space for the distances
    size(matrixDistances);
    for i=1:numGroups %for each group
        %fprintf('\n====================Grupo %d====================\n',i)
        numSamples_iGroup = length(GROUPS(i).samples); %gets all the number of samples contained in the i-group
        for j=1:numGroups %calculate the distance between the i-group and all the j-groups
            %fprintf('\n====================Grupo %d====================\n',j)
            numSamples_jGroup = length(GROUPS(j).samples); %gets all the number of samples contained in the j-group
            matrixSamples = zeros(numSamples_iGroup,numSamples_jGroup);
            if i~=j %if it is not the same group
                GROUPS(i).samples;
                GROUPS(j).samples;
                isamples = getRealSamples(GROUPS(i).samples,indexForGroup,allGROUPS);
                jsamples = getRealSamples(GROUPS(j).samples,indexForGroup,allGROUPS);
                numSamples_iGroup = length(isamples);
                numSamples_jGroup = length(jsamples);
                for k=1:numSamples_iGroup %for each sample in i-group
                    for l=1:numSamples_jGroup %for each sample in j-group
                        kSample = SAMPLES(isamples(k),:); %takes the i-sample
                        lSample = SAMPLES(jsamples(l),:); %takes the j-sample
                        %fprintf('\nisample = %d %d %d vs jsample=%d %d %d\n',kSample(1),kSample(2),kSample(3),lSample(1),lSample(2),lSample(3))
                        distance = distanceVectors(kSample,lSample); %gets the distance between both vectors
                        matrixSamples(k,l) = distance; %stores the distance in the position i,j which says that is the distance between the i-sample and the j-sample
                    end
                end
                %matrixSamples;
                %pause
                %minvalue=min(matrixSamples(matrixSamples>0))%gets the min distance of all the calculated distances between the samples of i-group and the samples of  j-group    
                %minvalue=min(matrixSamples)%gets the min distance of all the calculated distances between the samples of i-group and the samples of  j-group    
                [rows,cols] = size(matrixSamples);
                if rows==1 && cols==1
                    minvalue = matrixSamples(1,1);
                else
                    [minvalue,~] = findMin(matrixSamples);
                end
                
                matrixDistances;
                matrixDistances(i,j) = minvalue; %stores the distance in the position i,j which says that is the distance between the i-sample and the j-sample
            else
                matrixDistances;
                matrixDistances(i,j) = 0; %stores a distance o zero because is the same group
            end    
            %[rows cols] = find(abs(distancesMatrix-minvalue)<0.001)
            %fprintf('\n====================Grupo %d====================\n',j)
        end
        %fprintf('\n====================Grupo %d====================\n',i)
    end
end
    
function [distance] = distanceVectors(vector1,vector2)
    distance = norm(vector1-vector2);
end

function [samples] = getRealSamples(samples1,IndexOriginalsamples,GROUPS)
    samples = [];
    IndexOriginalsamples;
    for sample = samples1
        sample;
        repeat = numel(find(IndexOriginalsamples==sample)); %found if sample is content in Originalsamples
        if repeat>0
            samples = [samples,sample];
        else
            samples = [samples,getRealSamples(GROUPS(sample).samples,IndexOriginalsamples,GROUPS)];
        end
    end
    samples;
end

%{
function [ matrixDistances ] = calculateDistances(GROUPS,SAMPLES)
    numGroups = length(GROUPS); %takes the number of groups added in the matrix "GROUPS"
    matrixDistances = zeros(numGroups); %reserve space for the distances
    size(matrixDistances);
    for i=1:numGroups %for each group
        %fprintf('\n====================Grupo %d====================\n',i)
        numSamples_iGroup = length(GROUPS(i).samples); %gets all the number of samples contained in the i-group
        for j=1:numGroups %calculate the distance between the i-group and all the j-groups
            %fprintf('\n====================Grupo %d====================\n',j)
            numSamples_jGroup = length(GROUPS(j).samples); %gets all the number of samples contained in the j-group
            matrixSamples = zeros(numSamples_iGroup,numSamples_jGroup);
            if i~=j %if it is not the same group
                for k=1:numSamples_iGroup %for each sample in i-group
                    for l=1:numSamples_jGroup %for each sample in j-group
                        kSample = SAMPLES(GROUPS(i).samples(k),:); %takes the i-sample
                        lSample = SAMPLES(GROUPS(j).samples(l),:); %takes the j-sample
                        fprintf('\nisample = %d %d %d vs jsample=%d %d %d\n',kSample(1),kSample(2),kSample(3),lSample(1),lSample(2),lSample(3))
                        distance = distanceVectors(kSample,lSample); %gets the distance between both vectors
                        matrixSamples(k,l) = distance; %stores the distance in the position i,j which says that is the distance between the i-sample and the j-sample
                    end
                end
                %matrixSamples;
                %pause
                %minvalue=min(matrixSamples(matrixSamples>0))%gets the min distance of all the calculated distances between the samples of i-group and the samples of  j-group    
                %minvalue=min(matrixSamples)%gets the min distance of all the calculated distances between the samples of i-group and the samples of  j-group    
                [rows,cols] = size(matrixSamples);
                if rows==1 && cols==1
                    minvalue = matrixSamples(1,1);
                else
                    [minvalue,~] = findMin(matrixSamples);
                end
                
                matrixDistances;
                matrixDistances(i,j) = minvalue; %stores the distance in the position i,j which says that is the distance between the i-sample and the j-sample
            else
                matrixDistances;
                matrixDistances(i,j) = 0; %stores a distance o zero because is the same group
            end    
            %[rows cols] = find(abs(distancesMatrix-minvalue)<0.001)
            %fprintf('\n====================Grupo %d====================\n',j)
        end
        %fprintf('\n====================Grupo %d====================\n',i)
    end
end
%}
