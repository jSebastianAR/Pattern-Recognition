clc
clear all
close all
warning off all
import classPerceptron

W = [1 1 1] %we propose the initial weights 
perceptron = classPerceptron(W,1);%instantiate the perceptron

flagW = 0; %this flag increase its value if there was a change in any weight of the perceptron
Continue = true; %boolean that indicates if we can keep going with the loop of iterations
noIteracion = 1; %does not have relevance for the funcionality of the perceptron

while Continue==true %while we can do the loop
    fprintf('\n==============================Iteracion %d==============================',noIteracion)
    flagW = 0;%initialize the flagW in zero
    for i=1:4
        currentInput = perceptron.inputs(i,:)%takes the i row and all the columns
        perceptron.weights
        result = (currentInput)*(perceptron.weights)'; %multiplies the input's array per the current transposed weight matrix
        class = currentInput(1) & currentInput(2); %does the AND operation between the two inputs x1 and x2
        %class = currentInput(1) | currentInput(2)
        if class == 0 %choose the class for the input
           noClass = 1;
        else
           noClass = 2;
        end
        flagW = perceptron.changeWeights(currentInput,flagW,result,noClass); %calls the function to modify the weights
    end
    
    if flagW == 0 %after iteration there no were changes we can finish the training
        Continue=false; %put the boolena in false
    end
    fprintf('\n==============================Iteracion %d==============================',noIteracion)
    noIteracion = noIteracion+1;
end

fprintf('\n\n\nLos pesos finales son para x1=%d x2=%d x0=%d',perceptron.weights(1),perceptron.weights(2),perceptron.weights(3))
perceptron.weights
perceptron.plotClass()
%a = 3*x+2*y-4
%solve(a,y)
%y = 2 - (3*x/2)
%ezplot(y)
%grid on


