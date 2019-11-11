function [mms]=rpm2mms(rpm)
% mms2rpm
% 20 r => 77mm
mmm=rpm*77/20;
mms=mmm/60;
end