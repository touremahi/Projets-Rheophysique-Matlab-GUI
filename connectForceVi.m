function [obj2]=connectForceVi()
% Find a serial port object.
obj2 = instrfind('Type', 'serial', 'Port', 'COM6', 'Tag', '');

set(obj2, 'BaudRate', 230400);
% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(obj2)
    obj2 = serial('COM6');
else
    fclose(obj2);
    delete(obj2);
    obj2 = serial('COM6');
    obj2 = obj2(1);
end
set(obj2, 'BaudRate', 230400);
% Configure instrument object, obj2.
fopen(obj2);
end