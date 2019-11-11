myinterf=gcf;
i=0;
global pDynams prLim vLim check;
pMax=prLim(2);%50;%mm
vMax=vLim;%30;%mm/s
while i==0
   
pDebut=str2double(get(findobj(myinterf, 'Tag','pDebut'),'string'));
pTot=str2double(get(findobj(myinterf, 'Tag','pTot'),'string'));

if pTot+pDebut>pMax
    errordlg('Valeur Maximale atteinte','Erreur ...');
    break;  
else if ~((pDebut>=0)&&(pTot>0))
            errordlg('Vérifier les valeurs des positions','Erreur ...');
    break;
    end
end
pDebut;
pTot;

l=get(findobj(myinterf, 'Tag','vN'),'Value');

if l
    check=1;
    vit = str2double(get(findobj(myinterf, 'Tag','vFixe'),'string')); %rpm
    if ~((vit<vMax)&&(vit>0))
        errordlg(['Entrer une Vitesse entre 0 et ',num2str(vMax),' mm/s'],'Erreur ...');
        break;  
    end
    vitRpm=mms2rpm(vit);
    vitRated=rpm2rated(vitRpm);
    pDynams=[pDebut;pTot;vit;0;0];
else
    check=0;
    dis = pTot;%mm
    vDebut = str2double(get(findobj(myinterf, 'Tag','vDebut'),'string'));
    vFin = str2double(get(findobj(myinterf, 'Tag','vFin'),'string'));
        if ~(((vDebut<vMax)||(vFin<vMax))&&((vDebut>0)||(vFin>0)))
            errordlg(['Entrer une Vitesse entre 0 et ',num2str(vMax),' mm/s'],'Erreur ...');
        break;  
        end
    rUp=rUpCal(vDebut,vFin,dis);
    pDynams=[pDebut;pTot;0;vDebut;vFin];
end
close(myinterf);
captureDyn;
i=1;
end