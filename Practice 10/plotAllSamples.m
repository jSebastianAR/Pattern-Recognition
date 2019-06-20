function [GROUPS] = plotAllSamples(GROUPS,RGB)%,imagen)
%[rows,cols,~] = size(imagen)
%pause
numGroups = length(GROUPS);
[~,rows,columns] = size(RGB);
diferencia = 100;
    for i=1:numGroups
        [elements,~] = size(GROUPS(i).samplesKmeans);
        %fprintf('\nGRUPO %d\n',i)
        for j=1:elements
            while ~(diferencia>=0 && diferencia<=10) %while diferencia does not be between 0 and 10
                ejex = randi([1,columns]);
                ejey = randi([1,rows]);
                rgbIm = RGB(:,ejey,ejex).'; %gets the vector in random position
                rgbIm = double(rgbIm);%cast to double
                kmean = GROUPS(i).samplesKmeans(j,:); %gets the sample
                diference = norm(rgbIm-kmean); %does the distance
                if(diference>=0 && diference<=10)
                    %fprintf('\nplot in [%d,%d]\n',ejex,ejey)
                    plotAllGroups(ejex,ejey,i)
                    GROUPS(i).plotPoints = [GROUPS(i).plotPoints;ejex,ejey];
                    break
                end
            end
            
        end
        %fprintf('\nGRUPO %d\n',i)
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
