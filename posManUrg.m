% La pâle descend jusqu'au contact de en définissant la position Z0
myinterf=gcf;

global vLim s 
i=0;
while i==0
    
    set(findobj(myinterf, 'Tag','posHaut'),'enable','off');
    set(findobj(myinterf, 'Tag','validQuit'),'enable','off');
    set(findobj(myinterf, 'Tag','posBas'),'enable','off');
    
    %% Initialisation Connect "Force & Moteur" gestion des erreurs
%     try
%     s=serialstart;        % Conncetion du moteur
%     fopen(s);
%     catch mConnect 
%         errordlg('Vérifier si votre moteur est bien connecté','Erreur ...');
%         break;
%     end
    
    %% Valeur du pas et correction
    pas=str2double(get(findobj(myinterf, 'Tag','pas'),'string'));
    vitPas=str2double(get(findobj(myinterf, 'Tag','vitPas'),'string'));
    if (pas<=0)
            errordlg('Vérifier la valeur du pas','Erreur ...');
            break;
    end

    if ~((0<vitPas)&&(vitPas<vLim))
            errordlg(['Vitesse de déplacement invalide (0 < Vitesse < ',num2str(vLim),' mm/s)...'],'Erreur ...');
            break;
    end
    %%
% 	posAct=getPosition2(s,prLim);
%     ppasse=posAct;
    ti=pas/vitPas;
    vitMot=rpm2rated(mms2rpm(vitPas));
    %% Positionnement initial
        % deplacer au minimum
%         fopen(s);
     if dir
%             if (posAct-pas<prLim(1))||(posAct-pas>prLim(2))
%                 errordlg('Déplacement Hors de la plage...','Erreur ...');
%                 break;
%             end
        WriteModBus(s, 40100, hex2dec('0C1F'));
%         msgbox('deplacement vers le bas ')
        WriteModBus(s, 40101, vitMot);
        pause(ti);
        WriteModBus(s, 40101, 0);
        pause(0.5)
%         posAct=getPosition2(s,prLim);
%         if ~(posAct+pas==ppasse)
%                 ti=1;
%                 vitMot=rpm2rated(mms2rpm(1));
%             WriteModBus(s, 40100, hex2dec('0C1F'));
%             WriteModBus(s, 40101, vitMot);
%             pause(ti);
%             WriteModBus(s, 40101, 0);
%             pause(0.5)
%             posAct=getPosition2(s,prLim);
%         end
%         set(findobj(myinterf, 'Tag','posValue'),'String',['Position : ',num2str(posAct), ' mm']);
     else
%             if pas+posAct>(prLim(2)-30)
%                 errordlg('Déplacement Hors de la plage...','Erreur ...');
%                 break;
%             end
        WriteModBus(s, 40100, hex2dec('041F'));
%         msgbox('deplacement vers le haut ')
        WriteModBus(s, 40101, vitMot);
        pause(ti);
        WriteModBus(s, 40101, 0);
        pause(0.5)
%         posAct=getPosition2(s,prLim);
%         if ~(posAct-pas==ppasse)
%                 ti=1;
%                 vitMot=rpm2rated(mms2rpm(1));
%             WriteModBus(s, 40100, hex2dec('041F'));
%             WriteModBus(s, 40101, vitMot);
%             pause(ti);
%             WriteModBus(s, 40101, 0);
%             pause(0.5)
%             posAct=getPosition2(s,prLim);
%         end
%         set(findobj(myinterf, 'Tag','posValue'),'String',['Position : ',num2str(posAct), ' mm']);
     end
    
    
    %% 
    

i=1;
end

% if (posAct>prLim(2))
%         vitPas=1;
%         pas=1;
%         ti=pas/vitPas;
%         vitMot=rpm2rated(mms2rpm(vitPas));    
%         WriteModBus(s, 40100, hex2dec('041F'));
%     %         msgbox('deplacement vers le haut ')
%         WriteModBus(s, 40101, vitMot);
%         pause(ti);
%         WriteModBus(s, 40101, 0);
%         pause(0.5)
%         posAct=getPosition2(s,prLim);
%         set(findobj(myinterf, 'Tag','posValue'),'String',['Position : ',num2str(posAct), ' mm']);
% end
        %% Activation des boutons
        set(findobj(myinterf, 'Tag','posHaut'),'enable','on');
        set(findobj(myinterf, 'Tag','validQuit'),'enable','on');
        set(findobj(myinterf, 'Tag','posBas'),'enable','on');
    

% pause(5);% function while
        