function setVFixe(s, vFixe)

% Open serial connection
fopen(s);

WriteModBus(s, 40101, vFixe); % set

WriteModBus(s, 40322, 100*0); %ramp Up


% Servo On
WriteModBus(s, 40100, hex2dec('041E'));
WriteModBus(s, 40100, hex2dec('041F'));

% WriteModBus(s, 40322, 100*rUp); %ramp Up
% WriteModBus(s, 40101, vF);
