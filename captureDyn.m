function varargout = captureDyn(varargin)
% CAPTUREDYN MATLAB code for captureDyn.fig
%      CAPTUREDYN, by itself, creates a new CAPTUREDYN or raises the existing
%      singleton*.
%
%      H = CAPTUREDYN returns the handle to a new CAPTUREDYN or the handle to
%      the existing singleton*.
%
%      CAPTUREDYN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAPTUREDYN.M with the given input arguments.
%
%      CAPTUREDYN('Property','Value',...) creates a new CAPTUREDYN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before captureDyn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to captureDyn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help captureDyn

% Last Modified by GUIDE v2.5 21-Apr-2017 15:54:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @captureDyn_OpeningFcn, ...
                   'gui_OutputFcn',  @captureDyn_OutputFcn, ...
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


% --- Executes just before captureDyn is made visible.
function captureDyn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to captureDyn (see VARARGIN)

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
plot(0),grid


% Choose default command line output for captureDyn
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes captureDyn wait for user response (see UIRESUME)
% uiwait(handles.fStat);


% --- Outputs from this function are returned to the command line.
function varargout = captureDyn_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in stopSave.
function stopSave_Callback(hObject, eventdata, handles)
% hObject    handle to stopSave (see GCBO)
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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
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
