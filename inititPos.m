%positionning initiale
% % clc
% % clear
% instrreset
global fmi fma cfgAll prLim ipt
i=1;
     BtnName = questdlg('Assurez-vous d''avoir mis le système sous tension, que vous avez vidé la cuve, enlevé la porte métallique (ou en verre) du fond de cuve, enlevé la tige, avant le référencement puis cliquez sur OK', 'Référencement', 'OK','Annuler','OK');
     if ~strcmp(BtnName,'OK')
         i=0;
     end

%      
while i
    %compteurM2(30);
    %pause(30);
        try
            s=serialstart(ipt);
            fopen(s);
        catch mConnect
            errordlg('Vérifiez que le moteur est bien connecté','Erreur ...');
            break;
        end
        to=300;
        ti=tic;
        % q=questdlf
        % global pLim
        h = waitbar(0,'Référencement en cours...');
        pos1 = getPosition(s);
        %%
        WriteModBus(s, 40322, 0);
        WriteModBus(s, 40323, 0);
        servo_on(s);
         waitbar(toc(ti)/to,h)
                WriteModBus(s, 40100, hex2dec('041F'));
                WriteModBus(s, 40101, hex2dec('0100'));
                pause(4)
                WriteModBus(s, 40101, hex2dec('0000'));
        waitbar(1/5,h)

        r=ReadModBus(s, 40248, 1);
        if r(end)=='1'
            WriteModBus(s, 40101, hex2dec('0100'));
            pause(1)
            WriteModBus(s, 40101, hex2dec('0000'));
            r(end)='0';
        end
        waitbar(2/5,h)
        %%
        WriteModBus(s, 40100, hex2dec('0C1F'));
        WriteModBus(s, 40101, hex2dec('0100'));
        while r(end)=='0'
            r=ReadModBus(s, 40248, 1);
        %     pause(1)
        end
        WriteModBus(s, 40101, 0);
        waitbar(3/5,h)
        %%
            WriteModBus(s, 40100, hex2dec('0C1F'));
            WriteModBus(s, 40101, hex2dec('0010'));
        while r(end)=='1'
            r=ReadModBus(s, 40248, 1);
        %     pause(1)
        end
        WriteModBus(s, 40101, 0);
        waitbar(toc(ti)/to,h)
        servo_off(s);
        pause(0.1);
        pos2 = getPosition(s);
        % to=toc(ti); % 5mn

        waitbar(4/5,h)

        fmon=int32(1073741324);
        fmi = pos2;
        if pos2 < int32(1072000000)
            fma = fmi + int32(1383574);
        else
            fma = pos2 + int32(1383574) - fmon;%1383574 before
        end
        waitbar(4/5,h)
        [pm,p]=getPosition2(s,prLim);
        pause(0.2)
        waitbar(1,h)
        close(h)
        
        cfgAll(4)=1;

i=0;
end
        close(gcf);
        main_fig2;