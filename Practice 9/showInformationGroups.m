function showInformationGroups(GROUPS,umbral)
numGroups = length(GROUPS);

    fprintf('\nSe obtuvieron %d grupos con un umbral de %d\n',numGroups,umbral)
    for i=1:numGroups
        [elements,~] = size(GROUPS(i).samplesKmeans);
        fprintf('\nGrupo %d contiene %d muestras y un centroide de [%f %f %f]\n\n',i,elements,GROUPS(i).Z)
    end
    
end

