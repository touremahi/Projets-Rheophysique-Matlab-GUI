% clc
% clear
ordre=1;
myinterf=gcf;
global a b aVi bVi por posAct
camCheck=get(findobj(gcf, 'Tag','camCheck'),'Value');
if camCheck
    forVid = get(findobj(myinterf, 'Tag','tifBtn'),'Value');
    %     delete vid;
    %     clear vid;
    prompt={'Vidéo'};
    name='Entrer le nom du fichier Video';
    numlines=1;
    defaultanswer={'VidangeCap2'};
    nnn=inputdlg(prompt,name,numlines,defaultanswer);
%     vidName=[nnn,'.avi'];
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
    com_vid = 0;
end
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
    set(findobj(myinterf, 'Tag','saveButton'),'enable','off');
    set(findobj(myinterf, 'Tag','quit'),'enable','off');
        BtnName = questdlg('Lancez le compte à rebours (10 secondes) pour enlever la plaque en fond de cuve', 'Avertissement', 'Oui','Non','Oui');
        if strcmp(BtnName,'Oui')
           compteurM(11); 
           pause(11)
        end
    %%
    fenetre=tmax+10;%300;%str2num(get(findobj(myinterf, 'Tag','fenetre'),'string'));
    ymax1=60;
    ymax2=60;
    ymin1=-10;
    ymin2=-10;
    %% Initialisation
    % nbPoint=100;                % Nombre de point de mesure
%     y=NaN(fenetre,1);           % Vecteur de données initial
%     t2=1:fenetre;
    x1=[];
    x2=[];
    obj1=connectForce(por(1));        % Connection du capteur de vidange
    obj2=connectForce(por(2));        % Connection du capteur de vidange
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
        flushinput(obj1);       % Vidange de la memoire cache
        flushinput(obj2);       % Vidange de la memoire cache
        
        c1=mesureForce(obj1);    % Mesures de la force
        c2=mesureForce(obj2);    % Mesures de la force

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
                ymax1=x1(end)+10;
            end
            if x1(end)<ymin1
                ymin1=x1(end)-10;
            end
            
            if x2(end)>ymax2
                ymax2=x2(end)+10;
            end
            if x2(end)<ymin2
                ymin2=x(end)-10;
            end
            cla
%             plot(t2,y), axis([0 fenetre ymin ymax])
            subplot('position',[0.3 0.45 0.5 0.2]), plot(t,x1), axis([0 fenetre ymin1 ymax1]),ylabel('Pâle (g)')
            grid
            subplot('position',[0.3 0.2 0.5 0.2]), plot(t,x2), axis([0 fenetre ymin2 ymax2]),xlabel('Temps (sec)'),ylabel('Vidange (g)')
            grid

            
            pause(0.001)%0.01 non fonctionnel :(
                if ~(t(end)<=tmax)
                    ordre=0;
                end
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

    data=[t,x1,x2,pos];

i=0;
end
set(findobj(myinterf, 'Tag','pState'),'String',' ');
% data=int8(data);
% filename=['Capture_' num2str(time(1)) '-' num2str(time(2)) '-' num2str(time(3)) '_' num2str(time(4)) ':' num2str(time(5)) '.txt'];
