% save param globales

myinterf=gcf;

global por vLim prLim ipt simu cfgAll
comPrin=get(findobj(myinterf, 'Tag','portCom'),'value')+2;
comVida=get(findobj(myinterf, 'Tag','portComvi'),'value')+2;

vLim=str2double(get(findobj(myinterf, 'Tag','vLim'),'String'));
prLim(2)=str2double(get(findobj(myinterf, 'Tag','prLim'),'String'));

por=[comPrin;comVida];

simuA = get(findobj(myinterf, 'Tag','simuMode'),'value');
if simu ~= simuA
    simu = simuA;
    cfgAll(4) = 0;
end
ipt = get(findobj(myinterf, 'Tag','ipt'),'String');

%filnam=[ctfroot '\configfil.mat'];
filnam=['\configfil.mat'];

save(filnam,'por','pDynams','prLim','vLim','ipt','simu')

set(findobj(myinterf, 'Tag','pState'),'String','Paramètres mis à jour !');