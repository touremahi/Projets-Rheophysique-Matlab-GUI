%reconnect_moteur
clc
ipt = '162.38.135.150';
instrreset;
s=serialstart(ipt);
fopen(s);