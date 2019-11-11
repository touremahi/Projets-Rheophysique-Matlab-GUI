function varargout = mapVid(varargin)
% MAPVID MATLAB code for mapVid.fig
%      MAPVID, by itself, creates a new MAPVID or raises the existing
%      singleton*.
%
%      H = MAPVID returns the handle to a new MAPVID or the handle to
%      the existing singleton*.
%
%      MAPVID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAPVID.M with the given input arguments.
%
%      MAPVID('Property','Value',...) creates a new MAPVID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mapVid_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mapVid_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mapVid

% Last Modified by GUIDE v2.5 25-Apr-2017 12:05:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mapVid_OpeningFcn, ...
                   'gui_OutputFcn',  @mapVid_OutputFcn, ...
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


% --- Executes just before mapVid is made visible.
function mapVid_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mapVid (see VARARGIN)
  
vid=[];
try
    vid = videoinput('dalsa', 1, 'D_FA-20-01M1H_08_08.ccf');
    src = getselectedsource(vid);
    vid.FramesPerTrigger = 1;
    
    VidRes = get(vid,'VideoResolution');
    nBands = get(vid,'NumberOfBands');
    hImage = image(zeros(VidRes(2),VidRes(1),nBands));
    preview(vid,hImage);
        % Create a customized GUI
%         figure('Name', 'Diffusion Vidéo Temps Réel');

catch
        set(findobj(gcf,'Tag','validQuit'),'enable','off');
        set(findobj(gcf,'Tag','err'),'visible','on');
        set(findobj(gcf,'Tag','axes1'),'visible','off');
end

% Choose default command line output for mapVid
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mapVid wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mapVid_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        % Create a customized GUI
%         figure('Name', 'Diffusion Vidéo Temps Réel');


% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


