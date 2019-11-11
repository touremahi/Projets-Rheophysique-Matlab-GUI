global z0
if GPstatus
    z0=0;
   cfgAll(5)=1; 
   set(findobj(gcf, 'Tag','cGP'),'enable','off','visible','off');
   set(findobj(gcf, 'Tag','cGPStop'),'enable','on','visible','on');
   colo=[0.231 0.443 0.337];
        set(findobj(gcf, 'Tag','cPale'),'enable','off');    
        set(findobj(gcf, 'Tag','cStat'),'enable','on');
        set(findobj(gcf, 'Tag','cDyn'),'enable','on'); 
   te='Prêt pour fonctionner';
else
    cfgAll(5)=0;
   set(findobj(gcf, 'Tag','cGPStop'),'enable','off','visible','off');
   set(findobj(gcf, 'Tag','cGP'),'enable','on','visible','on');
   colo=[1 0 0];
        set(findobj(gcf, 'Tag','cPale'),'enable','on');    
        set(findobj(gcf, 'Tag','cStat'),'enable','off');
        set(findobj(gcf, 'Tag','cDyn'),'enable','off'); 
   te='Effectuer le positionnement du zero gramme';
end
set(findobj(gcf, 'Tag','comm'),'ForegroundColor',colo);
set(findobj(gcf, 'Tag','comm'),'string',te);