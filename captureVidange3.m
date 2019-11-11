function varargout = captureVidange3(varargin)
% CAPTUREVIDANGE3 MATLAB code for captureVidange3.fig
%      CAPTUREVIDANGE3, by itself, creates a new CAPTUREVIDANGE3 or raises the existing
%      singleton*.
%
%      H = CAPTUREVIDANGE3 returns the handle to a new CAPTUREVIDANGE3 or the handle to
%      the existing singleton*.
%
%      CAPTUREVIDANGE3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAPTUREVIDANGE3.M with the given input arguments.
%
%      CAPTUREVIDANGE3('Property','Value',...) creates a new CAPTUREVIDANGE3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before captureVidange3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to captureVidange3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help captureVidange3

% Last Modified by GUIDE v2.5 17-Nov-2017 13:18:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @captureVidange3_OpeningFcn, ...
                   'gui_OutputFcn',  @captureVidange3_OutputFcn, ...
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


% --- Executes just before captureVidange3 is made visible.
function captureVidange3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to captureVidange3 (see VARARGIN)

global cfgAll;
if cfgAll(3)
        set(findobj(gcf, 'Tag','camCheck'),'enable','on');
end

            subplot('position',[0.3 0.45 0.5 0.2]), axis([0 60 -10 60]),ylabel('P�le (g)')
            grid
            subplot('position',[0.3 0.2 0.5 0.2]), axis([0 60 -10 60]),xlabel('Temps (sec)'),ylabel('Vidange (g)')
            grid
% 	set(findobj(gcf, 'Tag','startMeasure'),'enable','off');
%     set(findobj(gcf, 'Tag','stopMeasure'),'enable','off');
%     set(findobj(gcf, 'Tag','saveButton'),'enable','off');
%     set(findobj(gcf, 'Tag','quit'),'enable','off');
    
% Choose default command line output for captureVidange3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes captureVidange3 wait for user response (see UIRESUME)
% uiwait(handles.fStat);


% --- Outputs from this function are returned to the command line.
function varargout = captureVidange3_OutputFcn(hObject, eventdata, handles) 
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
