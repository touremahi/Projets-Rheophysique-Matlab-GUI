% function []=action(ordre)
% This function is for the force calibration interface
clc
myinterf=gcf;
%% Initialisation
global kt at bt por;
i=0;

while i==0
try
obj2=connectForce(por(2));        % Checking connection of force sensor
catch me 
    errordlg('Vérifier que votre capteur de force est connecté','Erreur ...');
    break;
end
%%
if isnan(kt)
        flushinput(obj2);       % Flushing the data 
        c=mesureForce(obj2);    % Meausring data
        % Correcting errors
        if ~isnan(c)            
            c=mesureForce(obj2);
        else
            c=mesureForce(obj2);
        end
        
        kt=[0,-c];
%         kVi=[kVi;0,0];
        plot(kt(:,1),kt(:,2),'*'),grid;
        set(findobj(myinterf, 'Tag','startFirst'),'enable','off');
        set(findobj(myinterf, 'Tag','restCalib'),'enable','on');
        set(findobj(myinterf, 'Tag','masse'),'enable','on');
%         set(findobj(myinterf, 'Tag','startMasse'),'enable','on');
        set(findobj(myinterf, 'Tag','massPlus'),'enable','on');
        set(findobj(myinterf, 'Tag','validQuit'),'enable','on');
kViValue=-c;
else
%%    
        mas=str2double(get(findobj(myinterf, 'Tag','masse'),'string'));
        
        flushinput(obj2);       % Flushing the data 
        c=mesureForce(obj2);    % Meausring data
        % Correcting errors
        if ~isnan(c)            
            c=mesureForce(obj2);
        else
            c=mesureForce(obj2);
        end
        
        kt(end,:)=[mas,-c];
        [y2,at,bt]=methCarr(kt(:,1),kt(:,2));
%         plot(kVi(:,1),kVi(:,2),'*-'),grid;
        plot(kt(:,1),kt(:,2),'*',kt(:,1),y2,'--'),grid;
        
        set(findobj(myinterf, 'Tag','startMasse'),'enable','off');
        set(findobj(myinterf, 'Tag','massPlus'),'enable','on');
kViValue=at;
end
if isnan(kt)
    set(findobj(myinterf, 'Tag','kViValue'),'string','Erreur Réessayer SVP !' );
else
    set(findobj(myinterf, 'Tag','kViValue'),'string',['kVi = ',num2str(kViValue)]);
end
i=1;
end

clear c i kViValue mas % Freeing the memory