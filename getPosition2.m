function [pmm,px1]=getPosition2(s,p)
global fmi fma z0 cfgAll
% fmin=int32(1073612829);
fmon=int32(1073741324);
fmin=fmi;%a
fmax=fma;%b
if fmin < int32(1072000000)
    tm=fmax-fmin;
else
    tm=(fmon-fmin)+fmax;
end

px1=getPosition(s);
if px1>=fmin
    px=px1-fmin;
elseif fmin < int32(1072000000)
    px=px1;
else
    px=px1+tm-fmax;
end
    pmm=round(px*(p(2)-p(1))/tm);
    
if cfgAll(2)
    pmm= pmm - z0;
end