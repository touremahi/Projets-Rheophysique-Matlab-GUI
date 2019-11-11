% clc
% clear
ordre=1;
myinterf=gcf;
global aVi bVi por
camCheck=get(findobj(gcf, 'Tag','camCheck'),'Value');
if camCheck
    forVid = get(findobj(myinterf, 'Tag','tifBtn'),'Value');
    prompt={'Vidéo'};
    name='Entrer le nom du fichier Video';
    numlines=1;
    defaultanswer={'VidangeCap1'};
    nnn=inputdlg(prompt,name,numlines,defaultanswer);
%     vidName=[nnn,'.avi'];
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
    com_vid = 0; % compteur trames
end
%%
% % Position X
%     prompt={'X (entre 1 et 4)'};
%     name='Entrer la position en X';
%     numlines=1;
%     defaultanswer={'1'};
%     xPos=str2double(inputdlg(prompt,name,numlines,defaultanswer));
% % Type de pâle
%     prompt={'Zmax (en mm, max 500)'};
%     name='Entrer la position en X';
%     numlines=1;
%     defaultanswer={'500'};
%     typePale=str2double(inputdlg(prompt,name,numlines,defaultanswer));
        %% Temps de mesure
        prompt={'Entrer la durée de la capture (en secondes):'};
        name='Temps max de capture';
        numlines=1;
        defaultanswer={'60'};
 
        tmax=str2double(inputdlg(prompt,name,numlines,defaultanswer));
        tmax=tmax(1);
        if isempty(tmax)
            tmax=60;
        end
        
        %%
% ent=entete(xPos,posAct,0,typePale);
dat=clock;
dat=dat(1:5);
date=[num2str(dat(3)),'-',num2str(dat(2)),'-',...
    num2str(dat(1)),' à ',num2str(dat(4)),' h ',num2str(dat(5)),' mn'];
ent=['Mesure de la vidange réalisée le ',date,'\r\n'];

%%
i=1;
while i
    set(findobj(myinterf, 'Tag','startMeasure'),'Visible','off');
    set(findobj(myinterf, 'Tag','stopMeasure'),'Visible','on');
    set(findobj(myinterf, 'Tag','stopMeasure'),'enable','on');
    set(findobj(myinterf, 'Tag','saveButton'),'enable','off');
    set(findobj(myinterf, 'Tag','quit'),'enable','off');
        BtnName = questdlg('Lancez le compte à rebours (10 secondes) pour enlever la plaque en fond de cuve', 'Avertissement', 'Oui','Non','Oui');
        if strcmp(BtnName,'Oui')
           compteurM(11); 
           pause(11)
        end
    %%
    fenetre=tmax+10;%str2num(get(findobj(myinterf, 'Tag','fenetre'),'string'));
    ymax=60;%str2num(get(findobj(myinterf, 'Tag','ymax'),'string'));
    ymin=-40;
    %% enclachement du moteur pour positionnement initiale

%     WriteModBus(s, 40100, 0);
%         posAct=getPosition2(s,[0,500]);
%         set(findobj(myinterf, 'Tag','pPale'),'string',num2str(posAct));
%         set(findobj(myinterf, 'Tag','pState'),'String','Positionnement en cours...');
%         pPale=str2double(get(findobj(myinterf, 'Tag','pPale'),'string'));
    
%         WriteModBus(s, 40101, 0);
    %% Initialisation
    % nbPoint=100;                % Nombre de point de mesure
%     y=NaN(fenetre,1);           % Vecteur de données initial
%     t2=1:fenetre;
    x=[];
    obj2=connectForce(por(2));        % Connection du capteur
    % t=1:fenetre;
    t=[];
    set(findobj(myinterf, 'Tag','pState'),'String','Mesure en cours...');

    if camCheck
        start(vid);
    end
    t1=tic;
    % b1=0;bVi=0;
    %% Boucle principale de mesure
    while (ordre==1)
    %         tstart=tic;
    %% Mesure Force
        flushinput(obj2);       % Vidange de la memoire cache
        c=mesureForce(obj2);    % Mesures de la force

            % Correction en cas d'erreur de mesures
            if ~isnan(c)            
                c=mesureForce(obj2);
                x=[x;c];
            else
                c=mesureForce(obj2);
                x=[x;c];
            end
            
            %% application du facteur k
x(end)=(-x(end)-bVi)./aVi;
    %% Prise Vidéo
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
%                     x(end)=(-x(end)-bVi)./aVi;
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
            cla
%             plot(t2,y), axis([0 fenetre ymin ymax])
            plot(t,x), axis([0 fenetre ymin ymax])
            grid

            
            pause(0.001)%0.01 non fonctionnel :(
                if ~(t(end)<=tmax)
                    ordre=0;
                end
                set(findobj(myinterf, 'Tag','mText'),'String',[num2str(x(end)),' g']);
    end
    %     hold on;
    if camCheck
        stop(vid);
        delete(vid);
        if ~forVid
            close(aviObject);            
            delete(aviObject);
        end
    end
    % end
    set(findobj(myinterf, 'Tag','startMeasure'),'Visible','on');
    set(findobj(myinterf, 'Tag','stopMeasure'),'Visible','off');
    set(findobj(myinterf, 'Tag','saveButton'),'enable','on');
    set(findobj(myinterf, 'Tag','quit'),'enable','on');
    
%     pos=double(posAct).*ones(size(t));

    data=[t,x];%,pos];

i=0;
end
set(findobj(myinterf, 'Tag','pState'),'String',' ');
% data=int8(data);
% filename=['Capture_' num2str(time(1)) '-' num2str(time(2)) '-' num2str(time(3)) '_' num2str(time(4)) ':' num2str(time(5)) '.txt'];
