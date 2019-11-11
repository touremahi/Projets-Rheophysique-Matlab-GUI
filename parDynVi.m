function varargout = parDynVi(varargin)
%PARDYNVI MATLAB code file for parDynVi.fig
%      PARDYNVI, by itself, creates a new PARDYNVI or raises the existing
%      singleton*.
%
%      H = PARDYNVI returns the handle to a new PARDYNVI or the handle to
%      the existing singleton*.
%
%      PARDYNVI('Property','Value',...) creates a new PARDYNVI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to parDynVi_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PARDYNVI('CALLBACK') and PARDYNVI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PARDYNVI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help parDynVi

% Last Modified by GUIDE v2.5 22-Nov-2017 17:04:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @parDynVi_OpeningFcn, ...
                   'gui_OutputFcn',  @parDynVi_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before parDynVi is made visible.
function parDynVi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
global s posAct prLim ipt
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

    set(findobj(gcf, 'Tag','pDebut'),'string',num2str(posAct));
% 	set(findobj(gcf, 'Tag','nextF'),'enable','on');
%     set(findobj(gcf, 'Tag','backF'),'enable','off');
%     set(findobj(gcf, 'Tag','pTot'),'enable','off');
    
    % Choose default command line output for parDynVi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes parDynVi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = parDynVi_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in nextF.
function nextF_Callback(hObject, eventdata, handles)
% hObject    handle to nextF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function pDebut_Callback(hObject, eventdata, handles)
% hObject    handle to pDebut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pDebut as text
%        str2double(get(hObject,'String')) returns contents of pDebut as a double


% --- Executes during object creation, after setting all properties.
function pDebut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pDebut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pTot_Callback(hObject, eventdata, handles)
% hObject    handle to pTot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pTot as text
%        str2double(get(hObject,'String')) returns contents of pTot as a double


% --- Executes during object creation, after setting all properties.
function pTot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pTot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in backF.
function backF_Callback(hObject, eventdata, handles)
% hObject    handle to backF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    



function vFixe_Callback(hObject, eventdata, handles)
% hObject    handle to vFixe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vFixe as text
%        str2double(get(hObject,'String')) returns contents of vFixe as a double


% --- Executes during object creation, after setting all properties.
function vFixe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vFixe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vDebut_Callback(hObject, eventdata, handles)
% hObject    handle to vDebut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vDebut as text
%        str2double(get(hObject,'String')) returns contents of vDebut as a double


% --- Executes during object creation, after setting all properties.
function vDebut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vDebut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vFin_Callback(hObject, eventdata, handles)
% hObject    handle to vFin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vFin as text
%        str2double(get(hObject,'String')) returns contents of vFin as a double


% --- Executes during object creation, after setting all properties.
function vFin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vFin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to pTot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pTot as text
%        str2double(get(hObject,'String')) returns contents of pTot as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pTot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
