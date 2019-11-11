function [rpmRated]=rpm2rated(rpm)
% mms2rpm
% 20 r => 77mm
vrap=hex2dec('4000')/3000;
rpmRated=rpm*vrap;
rpmRated=round(rpmRated);
end