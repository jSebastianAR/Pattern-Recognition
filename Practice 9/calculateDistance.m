function [distances,numGroup,dmin] = calculateDistance(GROUPS,sample)
import classGroup
%{
INPUTS
GROUPS = instances of classGroup wich contains the samples and the mean(Z) value
sample = current sample to classify

OUTPUTS
distances = array with all the distances between the current sample and all the means
numGroup = number of group wich the sample belongs
%}
    distances = [];
    numGroups = length(GROUPS);
    for i=1:numGroups
        distance = norm(GROUPS(i).Z-sample);
        distances = [distances distance];
    end
    
    dmin = min(distances);%find the group who belongs the sample
    Group = find(distances==dmin);
    numGroup = Group(1);
end