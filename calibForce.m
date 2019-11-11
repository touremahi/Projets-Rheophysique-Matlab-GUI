function varargout = calibForce(varargin)
%CALIBFORCE MATLAB code file for calibForce.fig
%      CALIBFORCE, by itself, creates a new CALIBFORCE or raises the existing
%      singleton*.
%
%      H = CALIBFORCE returns the handle to a new CALIBFORCE or the handle to
%      the existing singleton*.
%
%      CALIBFORCE('Property','Value',...) creates a new CALIBFORCE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to calibForce_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CALIBFORCE('CALLBACK') and CALIBFORCE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CALIBFORCE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calibForce

% Last Modified by GUIDE v2.5 21-Apr-2017 14:58:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calibForce_OpeningFcn, ...
                   'gui_OutputFcn',  @calibForce_OutputFcn, ...
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


% --- Executes just before calibForce is made visible.
function calibForce_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

global kt k a at b bt cfgAll;
myinterf=gcf;

if ~cfgAll(4)
    set(findobj(myinterf, 'Tag','posManCal'),'enable','off');
end
if ~isnan(k)
           set(findobj(myinterf, 'Tag','startFirst'),'enable','off');
        set(findobj(myinterf, 'Tag','restCalib'),'enable','on');
        set(findobj(myinterf, 'Tag','masse'),'enable','on');
        set(findobj(myinterf, 'Tag','startMasse'),'enable','off');
        set(findobj(myinterf, 'Tag','massPlus'),'enable','on');
        set(findobj(myinterf, 'Tag','validQuit'),'enable','on'); 
        if k(end,:)==zeros(1,2)
            k(end,:)=[];
        end
        set(findobj(myinterf, 'Tag','masse'),'string',num2str(k(end,1)));
        kValue=k(end,2)/k(end,1);
        set(findobj(myinterf, 'Tag','kValue'),'string',['k = ',num2str(kValue)]);
%         plot(k(:,1),k(:,2)),grid;
        y2 = a*k(:,1)+b;
        plot(k(:,1),k(:,2),'*',k(:,1),y2,'--'),grid;
else
    cla;
    grid;
end
kt=k;
at=a;
bt=b;


% Choose default command line output for calibForce
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calibForce wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calibForce_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
