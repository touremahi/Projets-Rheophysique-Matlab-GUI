% function [hex]=reg2hex(registre)
%     
%     reg=registre;%-40001;
%     reg=dec2hex(reg);
%     switch length(reg)
%         case 1
%             hex=['00';'0' reg];
%         case 2
%             hex=['00';reg];
%         case 3
%             hex=['0' reg(1);reg(2:end)];
%         case 4
%             hex=[reg(1:2);reg(3:end)];
%         otherwise
%             hex='01';
%     end
%     
% 
% end

function [hex]=reg2hex(registre)
    
    reg=registre-40001;
    reg=dec2hex(reg);
    switch length(reg)
        case 1
            hex=['00';'0' reg];
        case 2
            hex=['00';reg];
        case 3
            hex=['0' reg(1);reg(2:end)];
        otherwise
            hex='01';
    end
    

end
