clc
clear all
close all
warning off all
import classGroup

option = 100;
optionIm = 100;
firstTime=true;
imagen = 100;
while option~=0 && optionIm~=0

        if firstTime==true
            [imagen,optionIm] = SelectImage();
            firstTime=false;
        end
    
        if optionIm~=0
            option = input('1-Seleccionar Imagen 2-Nuevas muestras 3-Usar las anteriores 4-Random Samples ')
            switch option
                case 1
                    [imagen,optionIm] = SelectImage();
                case 2
                    close all hidden
                    samples=impixel(imagen)
                    oldsamples = samples;
                    imshow(imagen)
                    hold on 
                case 3
                    close all hidden
                    samples = oldsamples
                    imshow(imagen)
                    hold on
                case 4
                    close all hidden
                    numSamples = input('Ingresa el número de muestras que deseas de la imagen ')
                    samples = GetRandomSamples(imagen,numSamples);
                    samples = double(samples);
                    oldsamples = samples;
                    imshow(imagen)
                    hold on
                otherwise
            end
            if option~=0 && option~=1
                umbral = input('Ingresa el umbral ')

                GROUPS = [];
                %Gets the first mean
                newGroup = createGroup(1,[]); %creates a new group
                newGroup.Z = samples(1,:) %adds the first sample from all matrix of samples for the first group
                newGroup.samplesKmeans = [newGroup.samplesKmeans;samples(1,:)]; %stores the current sample into the chosen group        
                GROUPS = [GROUPS newGroup]; %stores the group in GROUPS
                numSamples = length(samples);  
                start = 2;%STARTS from the second sample
                %classify all the samples
                    for i=start:numSamples
                        fprintf('\n\n===================Comienza iteracion %d===================\n\n',i)
                        currentSample = samples(i,:);%takes the i sample
                        [~,numGroup,dmin] = calculateDistance(GROUPS,currentSample);
                        if dmin<umbral %if minimun distance is shorter than umbral
                            GROUPS(numGroup).samplesKmeans = [GROUPS(numGroup).samplesKmeans;currentSample]; %stores the current sample into the chosen group        
                            GROUPS(numGroup).updateMean(); %updates the mean
                        else %else creates another group
                            numberGroup = length(GROUPS)+1;%gets the index for the new group
                            newGroup = createGroup(numberGroup,[]); %creates a new group
                            newGroup.samplesKmeans = [newGroup.samplesKmeans;currentSample]; %stores the current sample into the chosen group        
                            newGroup.Z = samples(i,:); %stores the i-sample into the new group
                            GROUPS = [GROUPS newGroup]; %stores the group in GROUPS
                        end
                        fprintf('\n\n===================Finaliza iteracion %d===================\n\n',i)
                    end

                RGB = permute(imagen,[3,1,2]);%change the position for the image
                plotAllSamples(GROUPS,RGB);
                showInformationGroups(GROUPS,umbral)
            end
        end
    
end
