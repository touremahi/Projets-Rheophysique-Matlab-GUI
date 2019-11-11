function [c2]=mesureForce(obj)
% Programme pour la m�sure de V1 (pour u-log)
    
    %% Collecte de la donn�e et traitement
    datBit=fgetl(obj);     % Ecoute de la r�ponse du module
    
    % Remplacer les ',' par les '.' num�riques
    for t=1:length(datBit)  
        if datBit(t)==','
            datBit(t)='.';
        end
    end
    
    % Recherche du delimiteur pour V1
    j=NaN;
    for m=1:length(datBit)
        if datBit(m)=='\'
            j=m;
            break;
        end
    end
    
    % Selection des donn�es en chaines de caract�es et conversion en double
    if ~isnan(j(1))
        c1=datBit(1:j(1)-1);
        c2=str2double(c1);
        if c2>=500
            c2=NaN;
        end
    else
        c2=NaN;
    end

end