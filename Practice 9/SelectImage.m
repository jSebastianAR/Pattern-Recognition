function [imagen,numImagen] = SelectImage()
    
    numImagen = input('Imagen deseada 0-Salir 1-italia 2-alemania 3-francia 4.-Argentina 5.-Inglaterra')
    switch numImagen   
    case 1
        imagen=imread('italia.jpg');
    case 2
        imagen=imread('alemania.jpg');
    case 3
        imagen=imread('francia.png');
    case 4
        imagen=imread('argentina.png');
    case 5
        imagen=imread('inglaterra.png');
    otherwise
        fprintf('\nSaliendo\n')
        imagen=0;
    end

    
end

