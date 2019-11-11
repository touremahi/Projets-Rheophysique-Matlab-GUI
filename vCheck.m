vMax=139; 
vit=str2double(get(gco,'string'));
if ~((vit<vMax)&&(vit>0))
        errordlg(['Entrer une Vitesse entre 0 et ',num2str(vMax),' mm/s'],'Erreur ...');
end
