myinterf=gcf;
i=0;
global pDynamsVi prLim vLim check;
pMax=prLim(2);%50;%mm
vMax=vLim;%138;%mm/s
while i==0
   
pDebut=str2double(get(findobj(myinterf, 'Tag','pDebut'),'string'));
pTot=str2double(get(findobj(myinterf, 'Tag','pTot'),'string'));

if pTot+pDebut>pMax
    errordlg('Valeur Maximale atteinte','Erreur ...');
    break;  
else if ~(pTot>0)
            errordlg('Vérifier les valeurs des positions','Erreur ...');
    break;
    end
end
pDebut;
pTot;
    check=1;
    vit = str2double(get(findobj(myinterf, 'Tag','vFixe'),'string')); %rpm
    if ~((vit<vMax)&&(vit>0))
        errordlg(['Entrer une Vitesse entre 0 et ',num2str(vMax),' mm/s'],'Erreur ...');
        break;  
    end
    vitRpm=mms2rpm(vit);
    vitRated=rpm2rated(vitRpm);
    pDynamsVi=[pDebut;pTot;vit;0;0];
close(myinterf);
captureVidange3;
i=1;
end