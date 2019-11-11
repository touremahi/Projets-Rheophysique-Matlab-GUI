% =capDyn
% clc
%clear
%% initialisation
global pDynams check s posAct a b por;
ordre=1;val=1;
%% %%
    % Position X
        prompt={'X (entre 1 et 4)'};
        name='Entrer la position en X';
        numlines=1;
        defaultanswer={'1'};
        xPos=str2double(inputdlg(prompt,name,numlines,defaultanswer));
        
    % Type de pâle
        prompt={'Pâle (en mm)'};
        name='Entrer la la largeur de la pâle';
        numlines=1;
        defaultanswer={'10'};
        typePale=str2double(inputdlg(prompt,name,numlines,defaultanswer));
    
    ent=entete(xPos,posAct,pDynams(2),typePale);
%%
myinterf=gcf;
if cfgAll(5) % Condition grande pale
    set(findobj(myinterf, 'Tag','coulomb'),'Visible','on');    
    set(findobj(myinterf, 'Tag','coulomb'),'Value',0);
end
        %% camera
        camCheck=get(findobj(gcf, 'Tag','camCheck'),'Value');
        if camCheck
        %     delete vid;
        %     clear vid;
        prompt={'Vidéo'};
        name='Entrer le nom du fichier Video';
        numlines=1;
        defaultanswer={'myVideo'};
        nnn=inputdlg(prompt,name,numlines,defaultanswer);
        vidName=[nnn,'.avi'];
        
            %vid = videoinput('dalsa', 1, 'XceleraCLPX4_DALSA_FA-20-01M1H_08Bit_1400x1024.ccf');
            vid = videoinput('dalsa', 1, 'D_FA-20-01M1H_08_08.ccf');
            set(vid, 'FramesPerTrigger',inf);
            % vid.FrameRate=100;

            % vid.FrameGrabInterval = 1;
            start(vid)
            aviObject = VideoWriter(vidName,'Uncompressed AVI');
            set(aviObject, 'FrameRate',100);
            open(aviObject);
        end
%%
set(findobj(myinterf, 'Tag','startMeasure'),'Visible','off');
set(findobj(myinterf, 'Tag','stopSave'),'Visible','on');
set(findobj(myinterf, 'Tag','saveButton'),'enable','off');
set(findobj(myinterf, 'Tag','quit'),'enable','off');

while (val==1)
k=1;
%% Position initiale
    if check
        vit=pDynams(3);
        pTot=pDynams(2);
        vitSet=rpm2rated(mms2rpm(vit));
        ti=pTot/vit;
    else
        vit=pDynams(5);
        %         WriteModBus(s, 40323, hex2dec('0000'));
        vitSet=rpm2rated(mms2rpm(vit));
        ti=pDynams(6);% Rup
        WriteModBus(s, 40322, round(100*ti));
        servo_off(s);
    end
    %%
    fenetre=ti+10;%300;%str2num(get(findobj(myinterf, 'Tag','fenetre'),'string'));
    ymax=60;%str2num(get(findobj(myinterf, 'Tag','ymax'),'string'));
    ymin=-10;
    %% Initialisation
    % nbPoint=100;                % Nombre de point de mesure
    % fenetre=40;
%     y=NaN(fenetre,1);           % Vecteur de données initial
%     t2=1:fenetre;
    x=[];
    obj1=connectForce(por(1,:));        % Conncetion du capteur
    % t=1:fenetre;
    t=[];

    %% Boucle principale de mesure
    % choix de la vitesse
% if ~check
    servo_on(s);
% end
if cfgAll(5)%Condition grande pale
        WriteModBus(s, 40101, 0);
        WriteModBus(s, 40100, hex2dec('0C1F'));
else
    WriteModBus(s, 40101, vitSet);
end
    %     pause(ti);
    %     WriteModBus(s, 40101, 0);
    t1=tic;
    if cfgAll(5)
        tc = t1;
    end
    temps=0;
    set(findobj(myinterf, 'Tag','pState'),'String','Mesure en cours...');
    b1=0;
    while (ordre==1)
    %         tstart=tic;
        flushinput(obj1);       % Vidange de la memoire cache
        c=mesureForce(obj1);    % Mesures de la force

            % Correction en cas d'erreur de mesures
            if ~isnan(c)            
                c=mesureForce(obj1);
                x=[x;c];
            else
                c=mesureForce(obj1);
                x=[x;c];
            end
            %% application du facteur k
        x(end)=(-x(end)-b)./a;
    %% Prise de la vidéo
            if camCheck
                for vi=1:3
                    I = getsnapshot(vid);
                %     F=im2frame(I);
                    writeVideo(aviObject,I);
                    x=[x;c];
                    t=[t;toc(t1)];
                    x(end)=(-x(end)-b)./a;
                end
            end

    %% prise de temps
            t=[t;toc(t1)];
%             if t(end) <= fenetre
%                 y(1:length(x))=x;
%                 t2(1:length(t))=t;
%             else
%                 y=x(end-fenetre+1:end);
%                 t2=t(end-fenetre+1:end);
%             end
            
            if x(end)>ymax
                ymax=x(end)+10;
            end
            if x(end)<ymin
                ymin=x(end)-10;
            end
            
            cla
%             plot(t2,y), axis([0 fenetre ymin ymax])
            plot(t,x), axis([0 fenetre ymin ymax])
            grid

    
            pause(0.001)%0.01 non fonctionnel :(
            if cfgAll(5)
                valCoulomb = get(findobj(myinterf, 'Tag','coulomb'),'Value');
                if valCoulomb && k
                    WriteModBus(s, 40101, vitSet);
                    tplus=toc(tc);
                    ti=ti+tplus;
                    fenetre = fenetre + tplus;
                    k=0;
                else
                    WriteModBus(s, 40101, 0);
                    tc=tic;
                    k=1;
                end
            end
            
            if (t(end)>=ti)
                ordre=0;
            end
            set(findobj(myinterf, 'Tag','mText'),'String',[num2str(x(end)),' g']);
    end

val=0;
end
%%
        WriteModBus(s, 40101, 0);
%         WriteModBus(s, 40322, hex2dec('0000'));
        WriteModBus(s, 40323, hex2dec('0000'));
        
    if camCheck
        close(aviObject);
        stop(vid);
        delete(aviObject);
    end
    
set(findobj(myinterf, 'Tag','startMeasure'),'Visible','on');
set(findobj(myinterf, 'Tag','startMeasure'),'Enable','off');
set(findobj(myinterf, 'Tag','stopSave'),'Visible','off');
set(findobj(myinterf, 'Tag','saveButton'),'enable','on');
set(findobj(myinterf, 'Tag','quit'),'enable','on');
set(findobj(myinterf, 'Tag','pState'),'String',' ');
% if check
    pos=t*vit;
% else
%     pos=t*vit;
% end
data=[t,x,pos];
