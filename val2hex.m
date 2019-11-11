function [hex]=val2hex(val)
    val=dec2hex(val);
    k=size(val);

% hexf=[];
%     for i=1:k(1)
        switch k(2)
            case 1
                hex=['00';'0' val];
            case 2
                hex=['00';val];
            otherwise
                if k(2)>2
                    if mod(k(2),2)==0
                        hex=reshape(val,2,k(2)/2)';
                    else
                        val=['0' val ];
                        hex=reshape(val,2,(k(2)+1)/2)';
                    end
                end
        end
%         hexf=[hexf;hex];
%     end
end
