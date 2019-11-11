classdef MoteurVir < handle
    %MoteurVir Creating a virtual device object in simulation mode
    %   Detailed explanation goes here
    
    properties
        Vitesse
        Position
        Sens
        Etat
        RefPos
        Servo
        Mouv
        MouvTime
        %Connect
    end
    
    methods 
        function obj = MoteurVir
            obj.Vitesse = 0;
            obj.RefPos = int32(0);
            obj.Position = int32(0);   % Relative position
            obj.Servo = 1;      % Servo ON
            obj.Sens = 1;       % Montée
            obj.Etat = 0;       % Connetion
            obj.Mouv = [0 0];       % Mouvement en cours + vitesse
            obj.MouvTime = tic;   % Durée du mouvement
        end
        function obj = fopen(obj)
            obj.Etat = 1;
        end
        function WriteModBus(obj, registre, valeur)
            switch registre
                case 40100, % definition de sens
                    if valeur == hex2dec('041F')
                        obj.Sens = 1;
                        obj.Servo = 1; %#ok<MCHV2>
                    elseif valeur == hex2dec('041E')
                        obj.Servo = 0;
                        obj.Sens = 1;
                    elseif valeur == hex2dec('0C1F')
                        obj.Sens = 0;
                    end
                case 40101, % Regler la vitesse
                    obj.Vitesse = round(rpm2mms(rated2rpm(valeur)));
                    if obj.Servo && obj.Vitesse ~= 0
                            obj.Mouv = [1 obj.Vitesse];       % Mouvement en cours
                            obj.MouvTime = tic;   % Durée du mouvement                                       
                    elseif obj.Servo
                        tpar = toc(obj.MouvTime);
                        if obj.Sens
                            obj.Position = obj.Position + obj.Mouv(2)*tpar;
                        else
                            obj.Position = obj.Position - obj.Mouv(2)*tpar;
                        end
                        obj.Mouv = [0 0];
                        obj.MouvTime = uint64(0);
                    end
                otherwise
            end
        end
        function [motrHex] = ReadModBus(obj, registre, ~)
            switch registre
                case 40248, % zero Reference value
                    if obj.RefPos <= int32(0)
                        motrHex = '01';
                        if obj.Position == 15
                            %pause(1);
                            obj.RefPos = 1;
                        end
                        %obj.RefPos = int32(0)-1;
                    else
                        motrHex = '00';
                        %obj.RefPos = int32(0)+1;
                    end
                case 40352, % Actual position Value
                otherwise
            end
        end
        function [k2] = getPosition(obj)
            k2 = obj.Position;
        end
        
       function [pm,p] = getPosition2(obj,~)
            [pm] = obj.Position;
            p =0;
       end
       
    end
    
end

