function varargout = calibVidange(varargin)
%CALIBVIDANGE MATLAB code file for calibVidange.fig
%      CALIBVIDANGE, by itself, creates a new CALIBVIDANGE or raises the existing
%      singleton*.
%
%      H = CALIBVIDANGE returns the handle to a new CALIBVIDANGE or the handle to
%      the existing singleton*.
%
%      CALIBVIDANGE('Property','Value',...) creates a new CALIBVIDANGE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to calibVidange_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CALIBVIDANGE('CALLBACK') and CALIBVIDANGE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CALIBVIDANGE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calibVidange

% Last Modified by GUIDE v2.5 07-Jul-2017 09:38:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calibVidange_OpeningFcn, ...
                   'gui_OutputFcn',  @calibVidange_OutputFcn, ...
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


% --- Executes just before calibVidange is made visible.
function calibVidange_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

global kt kVi at aVi bt bVi ;
myinterf=gcf;

if ~isnan(kVi)
           set(findobj(myinterf, 'Tag','startFirst'),'enable','off');
        set(findobj(myinterf, 'Tag','restCalib'),'enable','on');
        set(findobj(myinterf, 'Tag','masse'),'enable','on');
        set(findobj(myinterf, 'Tag','startMasse'),'enable','off');
        set(findobj(myinterf, 'Tag','massPlus'),'enable','on');
        set(findobj(myinterf, 'Tag','validQuit'),'enable','on'); 
        if kVi(end,:)==zeros(1,2)
            kVi(end,:)=[];
        end
        set(findobj(myinterf, 'Tag','masse'),'string',num2str(kVi(end,1)));
        kViValue=kVi(end,2)/kVi(end,1);
        set(findobj(myinterf, 'Tag','kValue'),'string',['kVi = ',num2str(kViValue)]);
%         plot(kVi(:,1),kVi(:,2)),grid;
        y2 = aVi*kVi(:,1)+bVi;
        plot(kVi(:,1),kVi(:,2),'*',kVi(:,1),y2,'--'),grid;
else
    cla;
    grid;
end
kt=kVi;
at=aVi;
bt=bVi;


% Choose default command line output for calibVidange
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calibVidange wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calibVidange_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
