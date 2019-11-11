% clc
%clear
%IUNITIALIS§Atuiobn
ordre=1;
myinterf=gcf;
global s posAct a b por
camCheck=get(findobj(myinterf, 'Tag','camCheck'),'Value');
if camCheck
    forVid = get(findobj(myinterf, 'Tag','tifBtn'),'Value');
    %     delete vid;
    %     clear vid;
    prompt={'Vidéo'};
    name='Entrer le nom du fichier Video';
    numlines=1;
    defaultanswer={'StaticVid'};
    nnn=inputdlg(prompt,name,numlines,defaultanswer);
    vid = videoinput('dalsa', 2, 'D_FA-20-01M1H_08_08.ccf');
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
% Position X
    prompt={'X (entre 1 et 4)'};
    name='Entrer la position latérale de la pâle (X=1 centre)';
    numlines=1;
    defaultanswer={'1'};
    xPos=str2double(inputdlg(prompt,name,numlines,defaultanswer));
% Type de pâle
    prompt={'Pâle (en mm)'};
    name='Entrer la largeur de la pâle';
    numlines=1;
    defaultanswer={'10'};
    typePale=str2double(inputdlg(prompt,name,numlines,defaultanswer));
        %% Temps de mesure
        prompt={'Entrer la durée d''enrégistrement (sec):'};
        name='Temps max de capture';
        numlines=1;
        defaultanswer={'60'};
 
        tmax=str2double(inputdlg(prompt,name,numlines,defaultanswer));
        tmax=tmax(1);
        if isempty(tmax)
            tmax=60;
        end
        %%
ent=entete(xPos,posAct,0,typePale);
i=1;
while i
    set(findobj(myinterf, 'Tag','startMeasure'),'Visible','off');
    set(findobj(myinterf, 'Tag','stopMeasure'),'Visible','on');
    set(findobj(myinterf, 'Tag','stopMeasure'),'enable','on');
    set(findobj(myinterf, 'Tag','saveButton'),'enable','off');
    set(findobj(myinterf, 'Tag','quit'),'enable','off');
    %%
    fenetre=tmax+10;%300;
    ymax=60;%str2num(get(findobj(myinterf, 'Tag','ymax'),'string'));
    ymin=-5;
    %% enclachement du moteur pour positionnement initiale

%     WriteModBus(s, 40100, 0);
%         posAct=getPosition2(s,[0,500]);
%         set(findobj(myinterf, 'Tag','pPale'),'string',num2str(posAct));
        set(findobj(myinterf, 'Tag','pState'),'String','Positionnement en cours...');
        pPale=str2double(get(findobj(myinterf, 'Tag','pPale'),'string'));
    
        WriteModBus(s, 40101, 0);
    %% Initialisation
    % nbPoint=100;                % Nombre de point de mesure
%     y=NaN(fenetre,1);           % Vecteur de données initial
%     t2=1:fenetre;
    x=[];
    obj1=connectForce(por(1));        % Connection du capteur
    % t=1:fenetre;
    t=[];
    set(findobj(myinterf, 'Tag','pState'),'String','Mesure en cours...');

    if camCheck
        start(vid);
    end
    t1=tic;
    % b1=0;b=0;
    %% Boucle principale de mesure
    while (ordre==1)
    %         tstart=tic;
    %% Mesure Force
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
    %% Prise Vidéo
            if camCheck
%                 for vi=1:2
                    com_vid = com_vid+1;
                    I = getsnapshot(vid);
                    %     F=im2frame(I);
                    if forVid
%                         imwrite(I, [vidName,num2str(t(end)),'.tif'], 'WriteMode', 'append','Compression','none');
                        imwrite(I, [vidName,num2str(t(end),'%08.3f'),'.tif'],'Compression','none');
                    else
                        writeVideo(aviObject,I);
                    end
%                     x=[x;c];                    %%% A voir!!
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
% %                 tend=ceil(t(end));
%                 y=x(end-fenetre+1:end);
%                 t2=t(end-fenetre+1:end);
%             end       

            if x(end)>ymax
                ymax=x(end)+10;
            end
            if x(end)<ymin
                ymin=x(end)-10;
            end
            
%             if fenetre>floor(t(end))
%                 fenetre=ceil(t(end));
%                 y=[y;0];
%                 t2=[t2,ceil(t(end))];
%             end
            
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
    
    pos=double(posAct).*ones(size(t));

    data=[t,x,pos];

i=0;
end
% disp(com_vid/t(end))
set(findobj(myinterf, 'Tag','pState'),'String',' ');
% data=int8(data);
% filename=['Capture_' num2str(time(1)) '-' num2str(time(2)) '-' num2str(time(3)) '_' num2str(time(4)) ':' num2str(time(5)) '.txt'];
