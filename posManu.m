function varargout = posManu(varargin)
% POSMANU MATLAB code for posManu.fig
%      POSMANU, by itself, creates a new POSMANU or raises the existing
%      singleton*.
%
%      H = POSMANU returns the handle to a new POSMANU or the handle to
%      the existing singleton*.
%
%      POSMANU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POSMANU.M with the given input arguments.
%
%      POSMANU('Property','Value',...) creates a new POSMANU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before posManu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to posManu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help posManu

% Last Modified by GUIDE v2.5 25-Apr-2017 11:43:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @posManu_OpeningFcn, ...
                   'gui_OutputFcn',  @posManu_OutputFcn, ...
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


% --- Executes just before posManu is made visible.
function posManu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to posManu (see VARARGIN)
global s posAct prLim ipt 

    try
        s=serialstart(ipt);        % Conncetion du moteur
        fopen(s);
        posAct=getPosition2(s,prLim);
        WriteModBus(s, 40322, hex2dec('0000'));
        WriteModBus(s, 40323, hex2dec('0000'));
        WriteModBus(s, 40101, hex2dec('0000'));
        pause(0);
        WriteModBus(s, 40100, hex2dec('041E'));
        WriteModBus(s, 40100, hex2dec('041F'));
    catch mConnect 
        errordlg('Vérifier si votre moteur est bien connecté','Erreur ...');
%         break;
    end


% Choose default command line output for posManu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes posManu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = posManu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


