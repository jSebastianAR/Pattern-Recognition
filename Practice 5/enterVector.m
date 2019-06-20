function [vectorUsuario] = enterVector( vector )
    %{
    INPUTS
    vector: this is the old vector plotted, in case that its the first
    time to plot this vector will be equal to []

    OUTPUTS
    vectorUsuario: returns the current vector to be plotted
    %}
    elementosVector = numel(vector);
    vectorUsuario = [];
    if elementosVector~=0 %if there is an old vector plotted
        plot(vector(1),vector(2),'vw','MarkerFaceColor','w','MarkerSize',10)%borra el punto
    end
    %Ingresando vector del usuario y plotteando
    vectorx = input('Ingresa el valor de la coordenada en x ');
    vectory = input('Ingresa el valor de la coordenada en y ');
    vectorUsuario = [vectorx vectory];
    plot(vectorUsuario(1),vectorUsuario(2),'vm','MarkerFaceColor','m','MarkerSize',10)
    %Ingresando vector del usuario y plotteando
end

