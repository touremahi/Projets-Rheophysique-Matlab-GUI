function massPlus2
% global k kVi cfgVi
global kt
% if cfgVi(2)
%     kVi=[kVi;0,0];
% else
%     k=[k;0,0];
% end
    kt=[kt;0,0];
        set(findobj(gcf, 'Tag','startMasse'),'enable','on');
        set(findobj(gcf, 'Tag','massPlus'),'enable','off');
end