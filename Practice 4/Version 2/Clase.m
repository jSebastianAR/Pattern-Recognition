classdef Clase<handle
    properties
       ubicacionx
       ubicaciony
       dispersion
       ejex = []
       ejey = []
       matriz = [] %contains in matriz(1) = ejex and matriz(2) = ejey
       media %contains both means of ejex and ejey, media(1) = ejex and media(2) = ejey
       matrixSigma = []
       matrixSigmaI = []
    end
    
    methods
        function obj = Clase(ubicacionx,ubicaciony,dispersion,ejemplares) %constructor
            obj.ubicacionx=ubicacionx;
            obj.ubicaciony=ubicaciony;
            obj.dispersion=dispersion;
            if dispersion==0 %si la dispersion es cero entonces no se hace ninguna multiplicacion
                obj.ejex = randn(1,ejemplares)+ubicacionx; %coordenadas en x
                obj.ejey = randn(1,ejemplares)+ubicaciony; %coordenadas en y
           else
                obj.ejex = randn(1,ejemplares)+ubicacionx; %coordenadas en x
                obj.ejey = (randn(1,ejemplares)+ubicaciony)*dispersion; %coordenadas en y
           end
           obj.matriz = [obj.ejex;obj.ejey];
           obj.calculateMean(); %obtain the mean for future calculations
           obj.calculateSigma() %calculate the sigma matrix and its inverse for current class
        end
        
        function calculateMean(obj)
            meanx = mean(obj.ejex,2);
            meany = mean(obj.ejey,2);
            obj.media = [meanx meany]
        end
        
        function calculateSigma(obj)
            x_mean = obj.ejex-obj.media(1);% all values on "ejex" minus "meanx"
            y_mean = obj.ejex-obj.media(2);% all values on "ejey" minus "meany"
            prematrixE = [x_mean;y_mean]
            traspE = prematrixE.' 
            numElements = numel(x_mean)%gets the number of vectors in the class
            multMatrices = prematrixE*traspE
            obj.matrixSigma = (1/numElements)*multMatrices %finally calculate the sigma matrix
            obj.matrixSigmaI = inv(obj.matrixSigma)%calculate the inverse of sigma matrix
        end
        
        function calculateStatic(obj)
            obj.ejex = [0 1 1 1];%extrac all the values in all columns on the "numFila" row for x values
            obj.ejey = [0 0 1 0];%extrac all the values in all columns on the "numFila" row for y values
            obj.calculateMean()
            x_mean = obj.ejex-obj.media(1);% all values on "ejex" minus "meanx"
            y_mean = obj.ejey-obj.media(2);% all values on "ejey" minus "meany"
            prematrixE = [x_mean;y_mean]
            traspE = prematrixE.' 
            numElements = numel(x_mean)%gets the number of vectors in the class
            multMatrices = prematrixE*traspE
            obj.matrixSigma = (1/numElements)*multMatrices %finally calculate the sigma matrix
            obj.matrixSigmaI = inv(obj.matrixSigma)%calculate the inverse of sigma matrix
        end
    end
end
