function varargout = main_fig2(varargin)
% MAIN_FIG2 MATLAB code for main_fig2.fig
%      MAIN_FIG2, by itself, creates a new MAIN_FIG2 or raises the existing
%      singleton*.
%
%      H = MAIN_FIG2 returns the handle to a new MAIN_FIG2 or the handle to
%      the existing singleton*.
%
%      MAIN_FIG2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_FIG2.M with the given input arguments.
%
%      MAIN_FIG2('Property','Value',...) creates a new MAIN_FIG2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_fig2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_fig2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_fig2

% Last Modified by GUIDE v2.5 20-Apr-2017 11:59:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_fig2_OpeningFcn, ...
                   'gui_OutputFcn',  @main_fig2_OutputFcn, ...
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


% --- Executes just before main_fig2 is made visible.
function main_fig2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_fig2 (see VARARGIN)

global cfgAll cfgVi;
colo=[1 0 0];
if cfgAll(4)
    if (~cfgAll(1))
        set(findobj(gcf, 'Tag','cPale'),'enable','off');   
        set(findobj(gcf, 'Tag','cGP'),'enable','off');   
        set(findobj(gcf, 'Tag','cStat'),'enable','off');
        set(findobj(gcf, 'Tag','cDyn'),'enable','off');    
        te='Effectuer le calibrage du capteur de Force';
    elseif (~(cfgAll(1))||(~cfgAll(2)))
        set(findobj(gcf, 'Tag','cPale'),'visible','on');    
        set(findobj(gcf, 'Tag','cStat'),'enable','off');
        set(findobj(gcf, 'Tag','cDyn'),'enable','off');    
        te='Effectuer le positionnement du zero gramme';
    else
        colo=[0.231 0.443 0.337];
        te='Prêt pour fonctionner';
    end
else
        set(findobj(gcf, 'Tag','posManButton'),'enable','off');
        set(findobj(gcf, 'Tag','cPale'),'visible','off');    
        set(findobj(gcf, 'Tag','cStat'),'enable','off');
        set(findobj(gcf, 'Tag','cDyn'),'enable','off');
        set(findobj(gcf, 'Tag','refButton'),'enable','on');
        te='Effectuer le référencement du moteur pour pouvoir effectuer toutes les fonctions de ce programme';
end
if (cfgAll(5))
   set(findobj(gcf, 'Tag','cGP'),'enable','off','visible','off');
   set(findobj(gcf, 'Tag','cGPStop'),'enable','on','visible','on');
   colo=[0.231 0.443 0.337];
        set(findobj(gcf, 'Tag','cPale'),'enable','off');    
        set(findobj(gcf, 'Tag','cStat'),'enable','on');
        set(findobj(gcf, 'Tag','cDyn'),'enable','off'); 
   te='Prêt pour fonctionner';
end
set(findobj(gcf, 'Tag','comm'),'string',te);
set(findobj(gcf, 'Tag','comm'),'ForegroundColor',colo);

if ~cfgVi(1)
    set(findobj(gcf, 'Tag','cVidange'),'enable','off');
end
% xandd=ctfroot;
% set(findobj(gcf, 'Tag','text5'),'String',xandd);
% Choose default command line output for main_fig2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_fig2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_fig2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cStat.
function cStat_Callback(hObject, eventdata, handles)
% hObject    handle to cStat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cal.
function cal_Callback(hObject, eventdata, handles)
% hObject    handle to cal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in etal.
function etal_Callback(hObject, eventdata, handles)
% hObject    handle to etal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mes.
function mes_Callback(hObject, eventdata, handles)
% hObject    handle to mes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
