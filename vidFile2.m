clc
clear
close all;
%vidFile
        
% vid=[];
        vidName='test2';
com_vid =0;
    vid = videoinput('winvideo');
    % vid = videoinput('dalsa', 2, 'XceleraCLPX4_DALSA_FA-20-01M1H_08Bit_1400x1024.ccf');
    set(vid, 'FramesPerTrigger',inf);
    % vid.FrameRate=100;

    % vid.FrameGrabInterval = 1;
    start(vid)

    aviObject = VideoWriter(vidName,'MPEG-4');
%     set(aviObject, 'FrameRate',50);
set(aviObject, 'FrameRate',100);
open(aviObject);
      t1=tic;  
    for vi=1:160
        com_vid =  com_vid + 1;
        I = getsnapshot(vid);
        %     F=im2frame(I);
        writeVideo(aviObject,I);
%         pause(0.01)
        disp(vi)
        %                 kvid(:,:,vi) = I;
    end
    t2=toc(t1);
    close(aviObject);
    stop(vid);
%     fr_vid = com_vid/t(end);
    delete(aviObject);
%     disp(com_vid)
imaqreset