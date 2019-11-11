% La pâle descend jusqu'au contact de en définissant la position Z0
myinterf=gcf;

global s posAct prLim a b por z0 cfgAll
cfgAll(2)=0;
i=0;
x=0;
m=0;
consigne=10;
v=0;
while i==0

    set(findobj(myinterf, 'Tag','startPos'),'enable','off');
    set(findobj(myinterf, 'Tag','validQuit'),'enable','off');
    set(findobj(myinterf, 'Tag','annul'),'enable','off');
    set(findobj(myinterf, 'Tag','posManu'),'enable','off');
    
    %% Initialisation Connect "Force & Moteur" gestion des erreurs
    try
    obj1=connectForce(por(1));        % Conncetion du capteur
    catch fConnect 
        errordlg('Vérifier que votre capteur de force est connecté','Erreur ...');
        set(findobj(myinterf, 'Tag','startPos'),'enable','on');
        set(findobj(myinterf, 'Tag','annul'),'enable','on');
        break;
    end
    
    %% Positionnement initial
        posAct=getPosition2(s,prLim);
        set(findobj(myinterf, 'Tag','pState'),'String','Positionnement en cours...');
        pPale=10;
        while abs(posAct-pPale)>0
            dev=posAct-pPale;
            ti=abs(dev)/5;
            vitMot=rpm2rated(mms2rpm(5));
            if dev<0
                if dev+posAct>prLim(2)-30
                        errordlg(['Déplacement Hors de la plage...',num2str(posAct)],'Erreur ...');
                        break;
                end
                v=1;
                WriteModBus(s, 40100, hex2dec('041F'));
                WriteModBus(s, 40101, vitMot);
                pause(ti)
                WriteModBus(s, 40101, 0);
            elseif dev>0
                    if (posAct-dev<prLim(1))
                            errordlg('Déplacement Hors de la plage...',num2str(posAct),'Erreur ...');
                            break;
                    end
                    v=1;
                    WriteModBus(s, 40100, hex2dec('0C1F'));
                    WriteModBus(s, 40101, vitMot);
                    pause(ti)
                    WriteModBus(s, 40101, 0);
            end
            pause(1);
            posAct=getPosition2(s,prLim);
        end
        WriteModBus(s, 40100, hex2dec('041F'));
        if posAct==pPale
            v=1;
        end
    %% 
    while (abs(x(end))<consigne)&&(v==1)
                    dev=0.5;
                    pas=dev;
                    ti=abs(dev)/1;
                    vitMot=rpm2rated(mms2rpm(1));
                    if (posAct-pas<prLim(1))||(posAct-pas>prLim(2))
                        break;
                    end
                    WriteModBus(s, 40100, hex2dec('0C1F'));
                    WriteModBus(s, 40101, vitMot);
                    pause(ti)
                    WriteModBus(s, 40101, 0);
                    pause(1);
                    posAct=getPosition2(s,prLim);
                    
                    m=1;

        flushinput(obj1);       % Vidange de la memoire cache
        c=mesureForce(obj1);    % Mesures de la force
        if ~isnan(c)            
            c=mesureForce(obj1);
            x=[x;c];
        else
            c=mesureForce(obj1);
            x=[x;c];
        end
        x(end)=(-x(end)-b)./a;
                    
                    set(findobj(myinterf, 'Tag','massDis'),'String',[num2str(abs(x(end))) ' g']);
    end
    
    %% revenir à 0 gramme
    while (abs(x(end))>0)&&(m==1)&&(v==1)
%                     dev=posAct-1;
%                     ti=abs(dev)/1;
                    dev=1;
                    pas=dev;
                    ti=abs(dev)/1;
                    vitMot=rpm2rated(mms2rpm(1));
                    if dev+posAct>prLim(2)-30
                        break;
                    end
                    WriteModBus(s, 40100, hex2dec('041F'));
                    WriteModBus(s, 40101, vitMot);
                    pause(ti)
                    WriteModBus(s, 40101, 0);
                    pause(1);
                    posAct=getPosition2(s,prLim);
                    m=2;
                            flushinput(obj1);       % Vidange de la memoire cache
                            c=mesureForce(obj1);    % Mesures de la force
                            if ~isnan(c)            
                                c=mesureForce(obj1);
                                x=[x;c];
                            else
                                c=mesureForce(obj1);
                                x=[x;c];
                            end
                            x(end)=(-x(end)-b)./a;
                    set(findobj(myinterf, 'Tag','massDis'),'String',[num2str(abs(x(end))) ' g']);
    end
z0=getPosition2(s,prLim);

i=1;
end
    %% Activation des boutons
set(findobj(myinterf, 'Tag','startPos'),'enable','on');
set(findobj(myinterf, 'Tag','validQuit'),'enable','on');
set(findobj(myinterf, 'Tag','annul'),'enable','on');    
set(findobj(myinterf, 'Tag','pState'),'String',' ');
set(findobj(myinterf, 'Tag','massDis'),'String',[num2str(abs(x(end))) ' g']);

% pause(5);% function while
        
