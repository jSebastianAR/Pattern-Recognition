classdef classPerceptron<handle
    
    
    properties
        inputs %all the inputs wich are gonna be evaluated
        weights %weights of each input
        classes %number of each class for the perceptron
        learningRate %this indicates how fast the perceptron learns
    end
    
    methods
        function obj = classPerceptron(W,LR)
            obj.inputs = [0 0 1;0 1 1;1 0 1;1 1 1] %static inputs, first value for x1, second value for x2 and the third value for x0(bias)
            obj.weights = W %weights proposed for the user
            obj.classes = [1 2] %the number of classes to assing to the inputs
            obj.learningRate = LR %the learning rate given for the user
        end
        
        function BC_class1(obj,input,W) %Function for bad classification in class 1
            A = (obj.learningRate*input);
            obj.weights = W-A;
        end
        
        function BC_class2(obj,input,W) %Function for bad classification in class 2
            A = (obj.learningRate*input);
            obj.weights = W+A;
        end
        
        function flagW = changeWeights(obj,currentInput,flag,R,numClass)
            %{
            Inputs:
            currentInput = the current input of the inputs array
            flag = the numeric value that indicates if the weights were
            changed
            R = the result of the multiplication between the current input
            and the current weights
            
            numClass = the class who belongs the current input
            %}
            
            flagW = flag;
            switch numClass
                case 1
                    if R>=0
                        obj.BC_class1(currentInput,obj.weights);
                        flagW = flagW+1
                    end
                case 2
                    if R<=0
                        obj.BC_class2(currentInput,obj.weights);
                        flagW = flagW+1
                    end
            end
            
            %flagW = flag;
            
        end
        
        function plotClass(obj)
           fig = figure('Name','Perceptron','NumberTitle','off') 
           if obj.weights(1)<0  
            stringX = strcat(int2str(obj.weights(1)),'*x')
           else
            stringX = strcat('+',int2str(obj.weights(1)),'*x')   
           end
           
           if obj.weights(2)<0  
            stringY = strcat(int2str(obj.weights(2)),'*y')
           else
            stringY = strcat('+',int2str(obj.weights(2)),'*y')   
           end
           
           if obj.weights(1)<0  
            ind = int2str(obj.weights(3))
           else
            ind = strcat('+',int2str(obj.weights(3)))   
           end
           
           equation = strcat(stringX,stringY,ind)
           result = solve(equation,'y')
           ezplot(result)
           grid on
           hold on
           %Plot all points
           class1 = [];
           class2 = [];
           for i=1:4
               and = obj.inputs(i,1) & obj.inputs(i,2);
               switch and
                   case 0
                       class1 = [class1;obj.inputs(i,1) obj.inputs(i,2)];
                       
                   case 1
                       class2 = [class2;obj.inputs(i,1) obj.inputs(i,2)];
                       
               end
           end
           plot(class1(:,1),class1(:,2),'.b','MarkerFaceColor','b','MarkerSize',15,'DisplayName','clase 1')
           plot(class2(:,1),class2(:,2),'.r','MarkerFaceColor','r','MarkerSize',15,'DisplayName','clase 2')
           legend show
        end
        
        
    end
    
end


