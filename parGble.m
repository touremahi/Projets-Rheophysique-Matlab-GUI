function varargout = parGble(varargin)
%PARGBLE MATLAB code file for parGble.fig
%      PARGBLE, by itself, creates a new PARGBLE or raises the existing
%      singleton*.
%
%      H = PARGBLE returns the handle to a new PARGBLE or the handle to
%      the existing singleton*.
%
%      PARGBLE('Property','Value',...) creates a new PARGBLE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to parGble_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PARGBLE('CALLBACK') and PARGBLE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PARGBLE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help parGble

% Last Modified by GUIDE v2.5 27-Oct-2019 13:20:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @parGble_OpeningFcn, ...
                   'gui_OutputFcn',  @parGble_OutputFcn, ...
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


% --- Executes just before parGble is made visible.
function parGble_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
myinterf=gcf;

global vLim prLim por ipt simu

set(findobj(myinterf, 'Tag','vLim'),'String',num2str(vLim));
set(findobj(myinterf, 'Tag','prLim'),'String',num2str(prLim(2)));
set(findobj(myinterf, 'Tag','portCom'),'value',(por(1)-2));
set(findobj(myinterf, 'Tag','portComvi'),'value',(por(2)-2));
set(findobj(myinterf, 'Tag','ipt'),'String',ipt);
set(findobj(myinterf, 'Tag','simuMode'),'value',simu);


% Choose default command line output for parGble
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes parGble wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = parGble_OutputFcn(hObject, eventdata, handles)
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




% --- Executes on button press in backF.
function backF_Callback(hObject, eventdata, handles)
% hObject    handle to backF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function vLim_Callback(hObject, eventdata, handles)
% hObject    handle to vLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vLim as text
%        str2double(get(hObject,'String')) returns contents of vLim as a double


% --- Executes during object creation, after setting all properties.
function vLim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prLim_Callback(hObject, eventdata, handles)
% hObject    handle to prLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prLim as text
%        str2double(get(hObject,'String')) returns contents of prLim as a double


% --- Executes during object creation, after setting all properties.
function prLim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in portCom.
function portCom_Callback(hObject, eventdata, handles)
% hObject    handle to portCom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns portCom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from portCom


% --- Executes during object creation, after setting all properties.
function portCom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to portCom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in portComvi.
function portComvi_Callback(hObject, eventdata, handles)
% hObject    handle to portComvi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns portComvi contents as cell array
%        contents{get(hObject,'Value')} returns selected item from portComvi


% --- Executes during object creation, after setting all properties.
function portComvi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to portComvi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ipt_Callback(hObject, eventdata, handles)
% hObject    handle to ipt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ipt as text
%        str2double(get(hObject,'String')) returns contents of ipt as a double


% --- Executes during object creation, after setting all properties.
function ipt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ipt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simuMode.
function simuMode_Callback(hObject, eventdata, handles)
% hObject    handle to simuMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of simuMode
