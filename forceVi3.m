% =capDyn
% clc
%clear
%% initialisation
global pDynamsVi s posAct aVi bVi  a b por;
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
            
    ent=entete(xPos,posAct,pDynamsVi(2),typePale);
%%
myinterf=gcf;
        %% camera
        camCheck=get(findobj(gcf, 'Tag','camCheck'),'Value');
        if camCheck
            forVid = get(findobj(myinterf, 'Tag','tifBtn'),'Value');
            %     delete vid;
            %     clear vid;
            prompt={'Vidéo'};
            name='Entrer le nom du fichier Video';
            numlines=1;
            defaultanswer={'VidangeCaph'};
            nnn=inputdlg(prompt,name,numlines,defaultanswer);
%             vidName=[nnn,'.avi'];
            
            vid = videoinput('dalsa', 1, 'D_FA-20-01M1H_08_08.ccf');
            set(vid, 'FramesPerTrigger',inf);
            % vid.FrameRate=100;
            
            % vid.FrameGrabInterval = 1;
            
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
            com_vid = 0;
        end
%%
set(findobj(myinterf, 'Tag','startMeasure'),'Visible','off');
set(findobj(myinterf, 'Tag','stopMeasure'),'Visible','on');
set(findobj(myinterf, 'Tag','saveButton'),'enable','off');
set(findobj(myinterf, 'Tag','quit'),'enable','off');
BtnName = questdlg('Lancez le compte à rebours (10 secondes) pour enlever la plaque en fond de cuve', 'Avertissement', 'Oui','Non','Oui');
if strcmp(BtnName,'Oui')
       compteurM(11); 
       pause(11)
end
while (val==1)
    %% Position initiale
        vit=pDynamsVi(3);
        pTot=pDynamsVi(2);
        vitSet=rpm2rated(mms2rpm(vit));
        ti=pTot/vit;

    %%
    fenetre=ti+10;%300;%str2num(get(findobj(myinterf, 'Tag','fenetre'),'string'));
    ymax1=60;
    ymax2=60;
    ymin1=-10;
    ymin2=-10;
    %% Initialisation
    % nbPoint=100;                % Nombre de point de mesure
    % fenetre=40;
%     y=NaN(fenetre,1);           % Vecteur de données initial
%     t2=1:fenetre;
    x1=[];
    x2=[];
    obj1=connectForce(por(1));        % Conncetion du capteur
    obj2=connectForce(por(2));        % Conncetion du capteur
    % t=1:fenetre;
    t=[];

    %% Boucle principale de mesure
    servo_on(s);
    if camCheck
        start(vid);
    end
        WriteModBus(s, 40101, vitSet);
    t1=tic;
    temps=0;
    set(findobj(myinterf, 'Tag','pState'),'String','Mesure en cours...');
    b1=0;
    while (ordre==1)
    %         tstart=tic;
        flushinput(obj1);       % Vidange de la memoire cache
        flushinput(obj2);       % Vidange de la memoire cache
            % Correction en cas d'erreur de mesures
                c1=mesureForce(obj1);
                c2=mesureForce(obj2);

                            % Correction en cas d'erreur de mesures
            if (~isnan(c1))||(~isnan(c2))            
                c1=mesureForce(obj1);    % Mesures de la force
                c2=mesureForce(obj2);    % Mesures de la force
                x1=[x1;c1];
                x2=[x2;c2];
            else
                c1=mesureForce(obj1);    % Mesures de la force
                c2=mesureForce(obj2);    % Mesures de la force
                x1=[x1;c1];
                x2=[x2;c2];
            end
            %% application du facteur k
x1(end)=(-x1(end)-b)./a;
x2(end)=(-x2(end)-bVi)./aVi;
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
%                     x1=[x1;c1];
%                     x2=[x2;c2];
%                     t=[t;toc(t1)];
%                     x1(end)=(-x1(end)-b)./a;
%                     x2(end)=(-x2(end)-bVi)./aVi;
%                 end
            end

    %% prise de temps
            t=[t;toc(t1)];

            if x1(end)>ymax1
                ymax1=x1(end);
            end
            if x1(end)<ymin1
                ymin1=x1(end);
            end
            
            if x2(end)>ymax2
                ymax2=x2(end);
            end
            if x2(end)<ymin2
                ymin2=x(end);
            end
            cla
%             plot(t2,y), axis([0 fenetre ymin ymax])
            subplot('position',[0.3 0.45 0.5 0.2]), plot(t,x1), axis([0 fenetre ymin1 ymax1]),ylabel('Pâle (g)')
            grid
            subplot('position',[0.3 0.2 0.5 0.2]), plot(t,x2), axis([0 fenetre ymin2 ymax2]),xlabel('Temps (sec)'),ylabel('Vidange (g)')
            grid

    
            pause(0.001)%0.01 non fonctionnel :(
                if (t(end)>=ti)
                    ordre=0;
                end
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
set(findobj(myinterf, 'Tag','stopMeasure'),'Visible','off');
set(findobj(myinterf, 'Tag','saveButton'),'enable','on');
set(findobj(myinterf, 'Tag','quit'),'enable','on');
set(findobj(myinterf, 'Tag','pState'),'String',' ');
    pos=t*vit;
data=[t,x1,x2,pos];
