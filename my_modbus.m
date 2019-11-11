% clc
% close all
% clear
% instrreset
% 
s=serialstart;
% 
% % Open serial connection
fopen(s);
% % Servo On
WriteModBus(s, 40100, hex2dec('041E'));
WriteModBus(s, 40100, hex2dec('041F'));
WriteModBus(s, 40100, hex2dec('0C1F'));

% WriteModBus(s, 40100, hex2dec('0C1F'));
% Speed setpoint 50 % = hex[2000]
% WriteModBus(s, 40101, hex2dec('1000'));
WriteModBus(s, 40101, rpm2rated(mms2rpm(5)));
pause(10)
% WriteModBus(s, 40101, hex2dec('2000'));
% pause(5)
% WriteModBus(s, 40101, hex2dec('4000'));
% pause(5)
% % Change Rotation direction CCW
% WriteModBus(s, 40100, hex2dec('0C1F'));
% pause(5)
WriteModBus(s, 40101, hex2dec('0000'));
% WriteModBus(s, 40100, hex2dec('041F'));
% Servo Off
% WriteModBus(s, 40100, hex2dec('041F'));
% WriteModBus(s, 40100, hex2dec('041E'));

% % fclose(s);
% servo_off(s);
% pause(0.1)
% [pm,p]=getPosition2(s,[0 530])
% % ReadModBus(s, 40248, 1)
% fmon=int32(1073741324);
% fmin=int32(1073197421);
% fma = p + fmon-fmin
% % int32(1352670)
