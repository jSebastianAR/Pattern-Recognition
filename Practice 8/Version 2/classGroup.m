classdef classGroup<handle
    
    properties
        noGroup; %the number(index) of the group
        samples; %array with all the indices of all the samples who gonna be contained in the group
        
        samplesKmeans; %number of samples to classify
        Z; %the centroid of a class
        plotPoints; %the position(x,y) of all samples for plot them
    end
    
    methods
        function obj = classGroup(numGroup)
            obj.noGroup = numGroup; %number of group
            obj.samples = []; %array that contains the number of sample who belong to the group
            obj.samplesKmeans = []; %matrix with all the samples 
            obj.plotPoints = [];
        end
        
        function addSample(obj,no_Sample)
            obj.samples = [obj.samples no_Sample];%adds the number of sample contained in the group
        end
        
        
        function updateMean(obj)
            %{
            This function updates the centroid(Z) of the class
            %}
            [numSamplesKmeans,~] = size(obj.samplesKmeans);%gets the number of samples in the class
            if numSamplesKmeans>1%if its biggest than one
                allSamples = [obj.samplesKmeans];
                obj.Z = mean(allSamples);
            end
            
        end
        
        
        function resetSamplesK(obj)
            %This function deletes all the samples in a class
            obj.samplesKmeans = [];
        end
    end
    
end

