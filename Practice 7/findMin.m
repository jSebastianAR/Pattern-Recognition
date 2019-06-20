function [globalMin,globalPosition] = findMin(matrix)
    matrix;
    [rows,cols] = size(matrix);
    numCeros = numel(find(matrix==0));
    
    if rows==1 || cols==1 %if array is in one dimension
        if numCeros==0
           globalMin = min(matrix(matrix>0));
           [rows,cols] = find(abs(matrix-globalMin)<0.001);
           globalPosition = [rows(1) cols(1)];
        else
           globalMin = min(matrix); 
           [rows,cols] = find(matrix==globalMin);
           globalPosition = [rows(1) cols(1)];
        end 
    else
        if numCeros==0 || numCeros==rows
           globalMin = min(matrix(matrix>0));
           [rows,cols] = find(abs(matrix-globalMin)<0.001);
           globalPosition = [rows(1) cols(1)];
        else
            for i=1:rows
                for j=1:cols
                    value = matrix(i,j);
                    if(value==0 && i~=j)
                        globalMin = value;
                        globalPosition = [i,j];
                        return
                    end
                end
           end
        end
    end
    maxVal = max(globalPosition);
    minVal = min(globalPosition);
    globalPosition = [minVal maxVal];
end

%{
function [globalMin,globalPosition] = findMin(matrix)
    matrix
    [rows,cols] = size(matrix);
    start = 2; %the position of start is static
    PositionMins = [];
    Mins = [];
    lim = rows;
    fprintf('\nEntre a for\n')
    for i=1:lim %goes through all the rows
        if i~=lim
            minimoRow = min(matrix(i,start:end));
            positionCol = find(matrix(i,start:end) == minimoRow)+i
            currentPosition = [i positionCol(1)]
            PositionMins = cat(1,PositionMins,currentPosition);
            Mins = [Mins minimoRow];
            start = start+1;
        end
        
    end
    fprintf('\nSali a for\n')
    %FIND THE MIN OF THE MIN VALUES
    Mins
    PositionMins
    globalMin = min(Mins)
    arrayPosition = find(Mins==globalMin);
    globalPosition = PositionMins(arrayPosition,:)
    
end

%}




