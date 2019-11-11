%vidFile
        set(findobj(gcf,'Tag','mapButton'),'enable','off');
        
    vid=[];
        vid = videoinput('dalsa', 2, 'T_FA-21-3HK3H_(Falcon)_8bit_off.ccf');
        src = getselectedsource(vid);
        vid.FramesPerTrigger = inf;
%         set(vid, 'FramesPerTrigger',inf);
        
        VidRes = get(vid,'VideoResolution');
        nBands = get(vid,'NumberOfBands');
        hImage = image(zeros(VidRes(2),VidRes(1),nBands));
%         preview(vid,hImage); 
j=1;
% % axes('axes1')
        while j
            I = getsnapshot(vid);
            imshow(I)
            pause(0.01)
        end
        
       