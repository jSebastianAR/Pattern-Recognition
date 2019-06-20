classdef classGroup<handle
    
    properties
        noGroup; %the number(index) of the group
        samples; %array with all the indices of all the samples who gonna be contained in the group
        
        %FOR KMEANS
        samplesKmeans;
        Z;
        plotPoints;
        
        
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
            [numSamplesKmeans,~] = size(obj.samplesKmeans);
            if numSamplesKmeans>1
                allSamples = [obj.samplesKmeans];
                obj.Z = mean(allSamples);
            end
            
        end
        
        function resetSamplesK(obj)
            obj.samplesKmeans = [];
        end
    end
    
end

