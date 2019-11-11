function [obj1]=connectForce(port)
% Find a serial port object.
po=['COM',num2str(port)];
% obj1 = instrfind('Type', 'serial', 'Port', 'COM3', 'Tag', '');
obj1 = instrfind('Type', 'serial', 'Port', po, 'Tag', '');

set(obj1, 'BaudRate', 230400);
% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = serial(po);
else
    fclose(obj1);
    delete(obj1);
    obj1 = serial(po);
    obj1 = obj1(1);
end
set(obj1, 'BaudRate', 230400);
% Configure instrument object, obj1.
fopen(obj1);
end