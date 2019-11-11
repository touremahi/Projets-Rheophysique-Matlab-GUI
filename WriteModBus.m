% function [mothexCRC]=WriteModBus(s, registre, valeur)
function [mothex]=WriteModBus(s, registre, valeur)
% s=serialstart;
% 
% % Check Open serial connection
% s.Status

entete=['00';'00';'00';'00';'00';'06'];

s_add='01';                     % Adresse esclave

% FC='03';                        % Function de code 03 (lecture) 1 octet
FC='06';                       % Function de code 06 (écriture) 1 octet

reg_add=reg2hex(registre);         % Registre de début 2 octets

req=val2hex(valeur);

% req=['E0';'20'];                % Valeur du régistre

mothex=[entete;s_add;FC;reg_add;req];  % Mot de code modbus

% mothexCRC=append_crc(mothex);   % ajout du CRC

motdec=hex2dec(mothex);      % conversion en decimale

% Open serial connection
% fopen(s);
fwrite(s, motdec,'uint8');      % écriture octect par octet
% Close serial connection
% fclose(s);
% pause(0.032)

end