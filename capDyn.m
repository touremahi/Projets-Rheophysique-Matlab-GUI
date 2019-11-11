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
    pAct = posAct;
%%
myinterf=gcf;

if cfgAll(5) % Condition grande pale
    set(findobj(myinterf, 'Tag','coulomb'),'Visible','on');
    set(findobj(myinterf, 'Tag','coulomb'),'Value',0);
    tt=[];
end
        %% camera
        camCheck=get(findobj(gcf, 'Tag','camCheck'),'Value');
        if camCheck
            forVid = get(findobj(myinterf, 'Tag','tifBtn'),'Value');

            prompt={'Vidéo'};
            name='Entrer le nom du fichier Video';
            numlines=1;
            defaultanswer={'dynamicVideo'};
            nnn=inputdlg(prompt,name,numlines,defaultanswer);
            
            vid = videoinput('dalsa', 1, 'D_FA-20-01M1H_08_08.ccf');
            set(vid, 'FramesPerTrigger',inf);
            
            if forVid
                mkdir(char(nnn))
                vidName=[char(nnn) '\' char(nnn)];
            else
                vidName=[char(nnn),'.avi'];
                aviObject = VideoWriter(vidName,'Uncompressed AVI');
                %     aviObject = VideoWriter(vidName,'MPEG-4');
                set(aviObject, 'FrameRate',20);         %%% FrameRate??
                open(aviObject);
            end
            com_vid = 0; % compteur trames
        end
%%
set(findobj(myinterf, 'Tag','startMeasure'),'Visible','off');
set(findobj(myinterf, 'Tag','stopSave'),'Visible','on');
set(findobj(myinterf, 'Tag','saveButton'),'enable','off');
set(findobj(myinterf, 'Tag','quit'),'enable','off');
while (val==1)
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
    fenetre=10;%300;%str2num(get(findobj(myinterf, 'Tag','fenetre'),'string'));
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
    WriteModBus(s, 40100, hex2dec('0C1F'));
end
    if camCheck
        start(vid);
    end
        WriteModBus(s, 40101, vitSet);
    %     pause(ti);
    %     WriteModBus(s, 40101, 0);
    t1=tic;
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
%                 for vi=1:2
                    com_vid = com_vid+1;
                    I = getsnapshot(vid);
                %     F=im2frame(I);
                    if forVid
                        imwrite(I, [vidName,num2str(t(end),'%08.3f'),'.tif'],'Compression','none');
                    else
                        writeVideo(aviObject,I);
                    end
%                     x=[x;c];
%                     t=[t;toc(t1)];
%                     x(end)=(-x(end)-b)./a;
%                 end
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
            
            if t(end)>fenetre
                fenetre = fenetre +1;
            end
            cla
%             plot(t2,y), axis([0 fenetre ymin ymax])
            plot(t,x), axis([0 fenetre ymin ymax])
            grid
            if cfgAll(5)
                valCoulomb = get(findobj(myinterf, 'Tag','coulomb'),'Value');
                if valCoulomb
                    WriteModBus(s, 40101, 0);
                    tt=length(t);
                    %         WriteModBus(s, 40322, hex2dec('0000'));
                    WriteModBus(s, 40323, hex2dec('0000'));
                    set(findobj(myinterf, 'Tag','coulomb'),'Visible','off');
                end
            end
    
            pause(0.001)%0.01 non fonctionnel :(
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
        stop(vid);
        delete(vid);
        if ~forVid
            close(aviObject);            
            delete(aviObject);
        end
    end
    
set(findobj(myinterf, 'Tag','startMeasure'),'Visible','on');
set(findobj(myinterf, 'Tag','startMeasure'),'Enable','off');
set(findobj(myinterf, 'Tag','stopSave'),'Visible','off');
set(findobj(myinterf, 'Tag','saveButton'),'enable','on');
set(findobj(myinterf, 'Tag','quit'),'enable','on');
set(findobj(myinterf, 'Tag','pState'),'String',' ');
if cfgAll(5)
    pos=[t(1:tt).*vit;t(tt).*vit.*ones(size(t(tt+1:end)))];
else
    pos=t*vit;
end
data=[t,x,pos+double(pAct)];
