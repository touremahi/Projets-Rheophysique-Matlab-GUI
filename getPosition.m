function [k2,k]=getPosition(s)

warning off all
% fopen(s);
% rep1=ReadModBus(s, 40104, 2);   % MDI Position setpoint
% rep1=ReadModBus(s, 40935, 1);
% rep1=ReadModBus(s, 40350, 2);   % Position setpoint
rep1=ReadModBus(s, 40352, 2);   % actual Position value
% rep1=ReadModBus(s, 40112, 2);   % actual Position value

k=rep1(4:end,:);

if k(1,1)=='F'
    t=size(k);
    k1=k;
    for i=1:t(1)
        for j=1:t(2)
            k1(i,j)=dec2hex(15-hex2dec(k1(i,j)));
        end
    end
    k2=-1-(int32(hex2dec(reshape(k1',1,numel(k1)))));%/vrap;
else
    k2=(int32(hex2dec(reshape(k',1,numel(k)))));%/vrap;
end


