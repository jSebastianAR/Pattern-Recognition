function graficaClases(CLASES,numClases)%Recibe la matriz que contiene todos los puntos de las clases
    
    for i=1:numClases
        clasex = CLASES(i).ejex(1,:); %obtains only the ejex values 
        clasey = CLASES(i).ejey(1,:); %obtains only the ejey values
        if i==1 %clase 1
            plot(clasex(1,:),clasey(1,:),'ob','MarkerFaceColor','b','MarkerSize',15,'DisplayName','clase1')% (vector en x, vector en y, color, )
            grid on 
            hold on
            title('Grafica de datos en el espacio euclidiano')
        elseif i==2 %clase 2
            plot(clasex(1,:),clasey(1,:),'ok','MarkerFaceColor','k','MarkerSize',15,'DisplayName','clase2')% (vector en x, vector en y, color, )
        elseif i==3 %clase 3
            plot(clasex(1,:),clasey(1,:),'or','MarkerFaceColor','r','MarkerSize',15,'DisplayName','clase3')% (vector en x, vector en y, color, )
        elseif i==4 %clase 4
            plot(clasex(1,:),clasey(1,:),'og','MarkerFaceColor','g','MarkerSize',15,'DisplayName','clase4')% (vector en x, vector en y, color, )
        elseif i==5 %clase 5
            plot(clasex(1,:),clasey(1,:),'oy','MarkerFaceColor','y','MarkerSize',15,'DisplayName','clase5')% (vector en x, vector en y, color, )
        elseif i==6 %clase 6
            plot(clasex(1,:),clasey(1,:),'oc','MarkerFaceColor','c','MarkerSize',15,'DisplayName','clase6')% (vector en x, vector en y, color, )
        elseif i==7 %clase 7
            plot(clasex(1,:),clasey(1,:),'om','MarkerFaceColor','m','MarkerSize',15,'DisplayName','clase7')% (vector en x, vector en y, color, )
        elseif i==8 %clase 8
            plot(clasex(1,:),clasey(1,:),'ow','MarkerFaceColor','w','MarkerSize',15,'DisplayName','clase8')% (vector en x, vector en y, color, )
        end  
    end
end