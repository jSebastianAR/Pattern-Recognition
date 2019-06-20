function [ PP ] = plottingPoints(RGB,GROUPS)
diferencia = 100;
PP = [];
[rgb rows columns] = size(RGB);
numGroups = length(GROUPS);
    for i=1:numGroups %for each group
        %fprintf('\nInicia GROUP %d\n',i)
            while ~(diferencia>=0 && diferencia<=5)
                randomRow = randi([50,rows-50]);
                randomCol = randi([50,columns-50]);
                rgbIm = RGB(:,randomRow,randomCol).';
                rgbIm = double(rgbIm);
                kmean = GROUPS(i).samplesKmeans(1,:);
                    %class(sample)
                diference = norm(rgbIm-kmean);
                if(diference>=0 && diference<=10)
                    %fprintf('\nI got a new position :)\n')
                    PP = [PP;randomCol randomRow];
                    break
                end
            end
        %fprintf('\nTermina GROUP %d\n',i)
    end
    %PP
    %PP = permute(PP,[2,1]);
end



%{
function [ PP ] = plottingPoints(RGB,GROUPS)

PP = [];
[rgb rows columns] = size(RGB);
numGroups = length(GROUPS);
    for i=1:numGroups %for each group
        fprintf('\nInicia GROUP %d\n',i)
            for j=1:10:rows %for each row of the image
                for k=1:10:columns %for each row of the image
                    fprintf('\nI am in [%d,%d]\n',j,k)
                    rgbIm = RGB(:,j,k).';
                    rgbIm = double(rgbIm);
                    %class(rgbIm)
                    kmean = GROUPS(i).samplesKmeans(1,:);
                    %class(sample)
                    diference = norm(rgbIm-kmean);
                    if(diference>=0 && diference<=10)
                        fprintf('\nI got a new position :)\n')
                        PP = [PP;i j];
                        break
                    end
                end
                if(diference>=0 && diference<=10)
                    break
                end
            end
        fprintf('\nTermina GROUP %d\n',i)
    end
    %PP
    %PP = permute(PP,[2,1]);
end
%}

%{
function [ PP ] = plottingPoints(RGB,GROUPS)

RGB = permute(a,[3,1,2]);

%RGB = im2double(RGB);
[rgb rows columns] = size(RGB);
RGB(:,1,1)
RGB(:,1,1).'
pause
    for i=1:km %for each group
        fprintf('\nInicia GROUP %d\n',i)
        [numSamples,~] = size(GROUPS(i).samplesKmeans);
        for z=1:numSamples
            for j=1:10:rows %for each row of the image
                for k=1:10:columns %for each row of the image
                    fprintf('\nI am in [%d,%d]\n',j,k)
                    rgbIm = RGB(:,j,k).';
                    rgbIm = double(rgbIm)
                    %class(rgbIm)
                    sample = GROUPS(i).samplesKmeans(z,:)
                    %class(sample)
                    diference = norm(rgbIm-sample);
                    if(diference>=0 && diference<=10)
                        fprintf('\nI got a new position :)\n')
                        PP = [PP;i j];
                        break
                    end
                    %pause
                end

                if(diference>=0 && diference<=10)
                    break
                end

            end
        end
        fprintf('\nTermina GROUP %d\n',i)
    end


end
%}


