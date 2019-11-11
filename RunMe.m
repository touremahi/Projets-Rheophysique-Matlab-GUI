clc
clear
instrreset
close all
% RunMe
global cfgAll k kt kVi pDynams prLim vLim cfgVi por z0 ipt simu;
z0=0;
k=NaN;
kt=NaN;
kVi=NaN;
cfgAll=[0,0,0,0,0];% configuration g�n�rales (calibration, positionnement, video et r�f�rencement, grande p�le)
cfgVi=[0,0];
% defAdress = {'162.38.135.150'};
% ipt=inputdlg('Confirmer l''adresse IP du servo', 'IP Config', 1, defAdress);
filnam=[ctfroot '\configfil.mat'];
try
    load(filnam)
catch
    por=[4;5];
    % pDynams=zeros(6,1);
    pDynams=[10;30;13;10;9;0];
    % % pLim=double(int32([882034,1073325350])/1000);
    prLim=[0,530]; % Course totale du moteur
    vLim=30;%mm/s
    ipt = '162.38.135.150';
    simu=1;
end
if simu
    ButtonSimu = questdlg('Vous �tes en mode simulation du moteur! \n Voulez vous continuer dans ce mode ?', ...
                         'Mode Simulation', ...
                         'Oui', 'Non', 'Oui');
                     if ~strcmp(ButtonSimu, 'Oui')
                         simu = 0;
                     end
end
inititPos;

% main_fig2;
