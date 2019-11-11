function varargout = captureStatique(varargin)
% CAPTURESTATIQUE MATLAB code for captureStatique.fig
%      CAPTURESTATIQUE, by itself, creates a new CAPTURESTATIQUE or raises the existing
%      singleton*.
%
%      H = CAPTURESTATIQUE returns the handle to a new CAPTURESTATIQUE or the handle to
%      the existing singleton*.
%
%      CAPTURESTATIQUE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAPTURESTATIQUE.M with the given input arguments.
%
%      CAPTURESTATIQUE('Property','Value',...) creates a new CAPTURESTATIQUE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before captureStatique_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to captureStatique_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help captureStatique

% Last Modified by GUIDE v2.5 11-Jun-2019 12:50:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @captureStatique_OpeningFcn, ...
                   'gui_OutputFcn',  @captureStatique_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before captureStatique is made visible.
function captureStatique_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to captureStatique (see VARARGIN)

global cfgAll s posAct prLim ipt;
if cfgAll(3)
        set(findobj(gcf, 'Tag','camCheck'),'enable','on');
end

    try
        s=serialstart(ipt);        % Conncetion du moteur
        fopen(s);
        WriteModBus(s, 40322, hex2dec('0000'));
        WriteModBus(s, 40323, hex2dec('0000'));
        
        WriteModBus(s, 40101, hex2dec('0000'));
        pause(0);
        WriteModBus(s, 40100, hex2dec('041E'));
        WriteModBus(s, 40100, hex2dec('041F'));
        pause(1);
        posAct=getPosition2(s,prLim);
        set(findobj(gcf, 'Tag','pPale'),'string',num2str(posAct));
    catch mConnect 
        errordlg('Vérifier si votre moteur est bien connecté','Erreur ...');
%         break;
    end
    
    	set(findobj(gcf, 'Tag','startMeasure'),'enable','off');
    set(findobj(gcf, 'Tag','stopMeasure'),'enable','off');
    set(findobj(gcf, 'Tag','saveButton'),'enable','off');
    set(findobj(gcf, 'Tag','quit'),'enable','off');
    
if (cfgAll(5))
   set(findobj(gcf, 'Tag','descBtn'),'enable','on','visible','on');
   set(findobj(gcf, 'Tag','text16'),'enable','on','visible','on');
   set(findobj(gcf, 'Tag','text17'),'enable','on','visible','on');
   set(findobj(gcf, 'Tag','vitDescente'),'enable','on','visible','on');
   set(findobj(gcf, 'Tag','pasDescente'),'enable','on','visible','on');
end
    
% Choose default command line output for captureStatique
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes captureStatique wait for user response (see UIRESUME)
% uiwait(handles.fStat);


% --- Outputs from this function are returned to the command line.
function varargout = captureStatique_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startMeasure.
function startMeasure_Callback(hObject, eventdata, handles)
% hObject    handle to startMeasure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stopMeasure.
function stopMeasure_Callback(hObject, eventdata, handles)
% hObject    handle to stopMeasure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function state_Callback(hObject, eventdata, handles)
% hObject    handle to state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of state as text
%        str2double(get(hObject,'String')) returns contents of state as a double


% --- Executes during object creation, after setting all properties.
function state_CreateFcn(hObject, eventdata, handles)
% hObject    handle to state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function pPale_Callback(hObject, eventdata, handles)
% hObject    handle to pPale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pPale as text
%        str2double(get(hObject,'String')) returns contents of pPale as a double


% --- Executes during object creation, after setting all properties.
function pPale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pPale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in camCheck.
function camCheck_Callback(hObject, eventdata, handles)
% hObject    handle to camCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(findobj(gcf, 'Tag','forVidePan'),'Visible','on');

% Hint: get(hObject,'Value') returns toggle state of camCheck


% --- Executes on button press in ValidPos.
function ValidPos_Callback(hObject, eventdata, handles)
% hObject    handle to ValidPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	set(findobj(gcf, 'Tag','startMeasure'),'enable','off');
    set(findobj(gcf, 'Tag','stopMeasure'),'Visible','off');
    set(findobj(gcf, 'Tag','saveButton'),'enable','off');
    set(findobj(gcf, 'Tag','quit'),'enable','on');
global posAct prLim s
    BtnName = questdlg('Assurez vous que vous avez vidé la cuve avant le le positionnement et placez la porte métallique du fond de cuve, puis cliquez sur OK', 'Avertissement', 'OK','Annuler','OK');
      if strcmp(BtnName,'OK')
        posAct=getPosition2(s,prLim);
        set(findobj(gcf, 'Tag','pState'),'String','Positionnement en cours...');
        pPale=str2double(get(findobj(gcf, 'Tag','pPale'),'string'));
        while abs(posAct-pPale)>0
            dev=posAct-pPale;
            ti=abs(dev)/5;
            vitMot=rpm2rated(mms2rpm(5));
            if dev<0
                if dev+posAct>prLim(2)-30
                        errordlg('Déplacement Hors de la plage...','Erreur ...');
                        break;
                end
                WriteModBus(s, 40100, hex2dec('041F'));
                WriteModBus(s, 40101, vitMot);
                pause(ti)
                WriteModBus(s, 40101, 0);
            elseif dev>0
                    if posAct-dev<prLim(1)
                            errordlg('Déplacement Hors de la plage...','Erreur ...');
                            break;
                    end
                    WriteModBus(s, 40100, hex2dec('0C1F'));
                    WriteModBus(s, 40101, vitMot);
                    pause(ti)
                    WriteModBus(s, 40101, 0);
            end
            pause(1);
            posAct=getPosition2(s,prLim);
%             pause(0.1);
        end
      end
    
        
	set(findobj(gcf, 'Tag','startMeasure'),'enable','on');
    set(findobj(gcf, 'Tag','stopMeasure'),'Visible','off');
%     set(findobj(gcf, 'Tag','saveButton'),'enable','on');
    set(findobj(gcf, 'Tag','quit'),'enable','on');

    set(findobj(gcf, 'Tag','pState'),'String',' ');



function vitDescente_Callback(hObject, eventdata, handles)
% hObject    handle to vitDescente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vitDescente as text
%        str2double(get(hObject,'String')) returns contents of vitDescente as a double


% --- Executes during object creation, after setting all properties.
function vitDescente_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vitDescente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pasDescente_Callback(hObject, eventdata, handles)
% hObject    handle to pasDescente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pasDescente as text
%        str2double(get(hObject,'String')) returns contents of pasDescente as a double


% --- Executes during object creation, after setting all properties.
function pasDescente_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pasDescente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
