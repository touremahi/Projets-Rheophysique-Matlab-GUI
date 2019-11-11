function compteurM(secs,endMssg,varargin)
% Creates a figure to countdown remaining time (minutes/seconds only).
%
% SYNTAX:
%   COUNTDOWN(secs)
if isempty(secs)
    secs = 5;
end

if nargin < 2
    endMssg = 'Prêt';
end

countdownfig = figure('numbertitle','off','name','Compteur',...
    'color','w','menubar','none','toolbar','none',...
    'units','normalized','pos',[0.40 0.45 0.15 0.1]);


edtpos = [0.1 0.1 0.8 0.8];
edtbox = uicontrol('style','edit','string','Attention','units','normalized',...
    'position',edtpos,'fontsize',28,'foregroundcolor','r');
pause(1)
timerobj = timer('timerfcn',@updateDisplay,'period',1,'executionmode','fixedrate');
secsElapsed = 0;
start(timerobj);
    function updateDisplay(varargin)
        secsElapsed = secsElapsed + 1;
        if secsElapsed >= secs
            set(edtbox,'string',endMssg);
%             tmp = get(0,'screensize');
%             set(countdownfig,'pos',[1 40 tmp(3) tmp(4)-80]);
            set(edtbox,'foregroundcolor',1-get(edtbox,'foregroundcolor')); %,'backgroundcolor',1-get(edtbox,'backgroundcolor')
            set(edtbox,'fontsize',32);
            pause(1);
            stop(timerobj);
            delete(timerobj);
            fermeCompteur();
        else
            set(edtbox,'string',secs-secsElapsed);
        end
    end
    function fermeCompteur(varargin)
        close(countdownfig);
    end
end