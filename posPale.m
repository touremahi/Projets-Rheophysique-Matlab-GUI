function varargout = posPale(varargin)
%POSPALE MATLAB code file for posPale.fig
%      POSPALE, by itself, creates a new POSPALE or raises the existing
%      singleton*.
%
%      H = POSPALE returns the handle to a new POSPALE or the handle to
%      the existing singleton*.
%
%      POSPALE('Property','Value',...) creates a new POSPALE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to posPale_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      POSPALE('CALLBACK') and POSPALE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in POSPALE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help posPale

% Last Modified by GUIDE v2.5 21-Apr-2017 15:01:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @posPale_OpeningFcn, ...
                   'gui_OutputFcn',  @posPale_OutputFcn, ...
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


% --- Executes just before posPale is made visible.
function posPale_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

global s posAct;
    try
        s=serialstart;        % Conncetion du moteur
        fopen(s);
        WriteModBus(s, 40322, hex2dec('0000'));
        WriteModBus(s, 40323, hex2dec('0000'));
        
        WriteModBus(s, 40101, hex2dec('0000'));
        pause(0);
        WriteModBus(s, 40100, hex2dec('041E'));
        WriteModBus(s, 40100, hex2dec('041F'));
        pause(1);
        posAct=getPosition2(s,[0,500]);
        set(findobj(gcf, 'Tag','pPale'),'string',num2str(posAct));
    catch mConnect 
        errordlg('Vérifier si votre moteur est bien connecté','Erreur ...');
%         break;
    end

% Choose default command line output for posPale
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes posPale wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = posPale_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
