function [group] = createGroup(noGroup,references)
    import classGroup
    %{
    INPUTS
    noGroup = the number(index) of the group
    references = array with all the indices of all the samples who gonna be contained in the group
    %}
    group = classGroup(noGroup); %create an instance of classGroup 
    numElements = length(references); %gets the total elements that will be added to the new group
    for i=1:numElements
        group.addSample(references(i)) %adds the reference of sample
    end
end

