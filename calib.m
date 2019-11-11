% function []=action(ordre)
% This function is for the force calibration interface
clc
myinterf=gcf;
%% Initialisation
global kt at bt por;
i=0;

while i==0
try
obj1=connectForce(por(1));        % Checking connection of force sensor
catch me 
    errordlg('Vérifier que votre capteur de force est connecté','Erreur ...');
    break;
end
%%
if isnan(kt)
        flushinput(obj1);       % Flushing the data 
        c=mesureForce(obj1);    % Meausring data
%         Correcting errors
        if ~isnan(c)            
            c=mesureForce(obj1);
        else
            c=mesureForce(obj1);
        end
        
        kt=[0,-c];
%         k=[k;0,0];
        plot(kt(:,1),kt(:,2),'*'),grid;
        set(findobj(myinterf, 'Tag','startFirst'),'enable','off');
        set(findobj(myinterf, 'Tag','restCalib'),'enable','on');
        set(findobj(myinterf, 'Tag','masse'),'enable','on');
%         set(findobj(myinterf, 'Tag','startMasse'),'enable','on');
        set(findobj(myinterf, 'Tag','massPlus'),'enable','on');
        set(findobj(myinterf, 'Tag','validQuit'),'enable','on');
kValue=-c;
else
%%    
        mas=str2double(get(findobj(myinterf, 'Tag','masse'),'string'));
        
        flushinput(obj1);       % Flushing the data 
        c=mesureForce(obj1);    % Meausring data
        % Correcting errors
        if ~isnan(c)            
            c=mesureForce(obj1);
        else
            c=mesureForce(obj1);
        end
        
        kt(end,:)=[mas,-c];
        [y2,at,bt]=methCarr(kt(:,1),kt(:,2));
%         plot(k(:,1),k(:,2),'*-'),grid;
        plot(kt(:,1),kt(:,2),'*',kt(:,1),y2,'--'),grid;
        
        set(findobj(myinterf, 'Tag','startMasse'),'enable','off');
        set(findobj(myinterf, 'Tag','massPlus'),'enable','on');
kValue=at;
end
set(findobj(myinterf, 'Tag','kValue'),'string',['k = ',num2str(kValue)]);
i=1;
end

clear c i kValue mas % Freeing the memory