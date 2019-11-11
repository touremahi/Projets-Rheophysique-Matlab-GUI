function [s] = serialstart(ipt)
global simu
if simu
    s = MoteurVir;
else
    % instrreset;
    port=502;
    if nargin == 0
        ipt = '162.38.135.150';
    end
    % Find a serial port object.
    % echotcpip('on', port);
    s = tcpip(ipt,port);

    % otherwise use the object that was found.
    if isempty(s)
        s = tcpip(ipt,port);
    else
        fclose(s);
        delete(s);
        s = tcpip(ipt,port);
    %     obj1 = obj1(1);
    end
    % Create the serial port object if it does not exist
    % otherwise use the object that was found.
    set(s, 'Terminator', {'CR/LF','CR/LF'});
    set(s,'Timeout',(1/115200));
end