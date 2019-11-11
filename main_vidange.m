function varargout = main_vidange(varargin)
%MAIN_VIDANGE MATLAB code file for main_vidange.fig
%      MAIN_VIDANGE, by itself, creates a new MAIN_VIDANGE or raises the existing
%      singleton*.
%
%      H = MAIN_VIDANGE returns the handle to a new MAIN_VIDANGE or the handle to
%      the existing singleton*.
%
%      MAIN_VIDANGE('Property','Value',...) creates a new MAIN_VIDANGE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to main_vidange_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MAIN_VIDANGE('CALLBACK') and MAIN_VIDANGE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MAIN_VIDANGE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_vidange

% Last Modified by GUIDE v2.5 22-Nov-2017 16:53:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_vidange_OpeningFcn, ...
                   'gui_OutputFcn',  @main_vidange_OutputFcn, ...
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


% --- Executes just before main_vidange is made visible.
function main_vidange_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for main_vidange
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_vidange wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_vidange_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
