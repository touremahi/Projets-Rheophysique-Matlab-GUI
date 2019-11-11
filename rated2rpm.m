function [rpm]=rated2rpm(rpmRated)
% mms2rpm
% 20 r => 77mm
vrap=hex2dec('4000')/3000;
rpm=rpmRated/vrap;
%rpm=round(rpm);
end