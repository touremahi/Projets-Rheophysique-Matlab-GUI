global kt
myinterf=gcf;
cla;
kt=NaN;

        set(findobj(myinterf, 'Tag','startFirst'),'enable','on');
        set(findobj(myinterf, 'Tag','restCalib'),'enable','off');
        set(findobj(myinterf, 'Tag','masse'),'enable','off');
        set(findobj(myinterf, 'Tag','startMasse'),'enable','off');
        set(findobj(myinterf, 'Tag','massPlus'),'enable','off');
        set(findobj(myinterf, 'Tag','validQuit'),'enable','off');