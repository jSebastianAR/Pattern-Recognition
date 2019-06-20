function [GROUPS] = getAllPositions(GROUPS,plottedPoints)
numGroups = length(GROUPS);
min = 0;
max = 0;
    for i=1:numGroups
        [elements,~] = size(GROUPS(i).samplesKmeans);
        fprintf('\nGRUPO %d\n',i)
        for j=1:elements
            randomRow = randi([plottedPoints(i,1)-elements plottedPoints(i,1)+elements]);
            randomCol = randi([plottedPoints(i,2)-elements plottedPoints(i,2)+elements]);
            fprintf('\nplot in [%d,%d]\n',randomRow,randomCol)
            plotAllGroups(randomRow,randomCol,i)
            GROUPS(i).plotPoints = [GROUPS(i).plotPoints;randomRow,randomCol];
        end
        fprintf('\nGRUPO %d\n',i)
    end
    
    
    
end

function plotAllGroups(ejex,ejey,numGroup)
    if numGroup==1 %clase 1
        plot(ejex,ejey, 'y+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
        %grid on
        hold on
        %title('Grafica de datos en el espacio euclidiano')
    elseif numGroup==2 %clase 2
        plot(ejex,ejey, 'g+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==3 %clase 3
        plot(ejex,ejey, 'b+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==4 %clase 4
        plot(ejex,ejey, 'r+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==5 %clase 5
        plot(ejex,ejey, 'c+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==6 %clase 6
        plot(ejex,ejey, 'm+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==7 %clase 7
        plot(ejex,ejey, 'w+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    elseif numGroup==8 %clase 8
        plot(ejex,ejey, 'k+', 'MarkerSize', 10, 'LineWidth', 2);% (vector en x, vector en y, color, )
    end
end
