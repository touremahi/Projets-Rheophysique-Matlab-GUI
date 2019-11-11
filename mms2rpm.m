function [rpm]=mms2rpm(mms)
% mms2rpm
% 20 r => 77mm
mmm=mms*60;
rpm=20*mmm/77;
end