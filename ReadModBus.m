function [motrHex,mothex]=ReadModBus(s, registre, nombre_registre)

% s=serialstart;
% 
% % Check Open serial connection
% s.Status

entete=['00';'00';'00';'00';'00';'06'];
% entete=[];


s_add='01';                     % Adresse esclave

FC='03';                        % Function de code 03 (lecture) 1 octet
% FC='06';                       % Function de code 06 (écriture) 1 octet

reg_add=reg2hex(registre);         % Registre de début 2 octets

req=val2hex(nombre_registre);

% req=['E0';'20'];                % Valeur du régistre

mothex=[entete;s_add;FC;reg_add;req];  % Mot de code modbus

motdec=uint8(hex2dec(mothex));      % conversion en decimale

% Open serial connection
% fopen(s);
flushinput(s);
%     ret=tic;
fwrite(s, motdec');     % écriture octect par octet

% pause(0.032)
motrec1=fread(s);
%     toc(ret)
% fclose(s);
motrHex=dec2hex(motrec1);
motrHex=motrHex(7:end,:);
end