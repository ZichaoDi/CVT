function varargout = samplegui(varargin)
% SAMPLEGUI M-file for samplegui.fig
%      SAMPLEGUI, by itself, creates a new SAMPLEGUI or raises the existing
%      singleton*.
%
%      H = SAMPLEGUI returns the handle to a new SAMPLEGUI or the handle to
%      the existing singleton*.
%
%      SAMPLEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAMPLEGUI.M with the given input arguments.
%
%      SAMPLEGUI('Property','Value',...) creates a new SAMPLEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before samplegui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to samplegui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help samplegui

% Last Modified by GUIDE v2.5 04-Sep-2002 10:38:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @samplegui_OpeningFcn, ...
                   'gui_OutputFcn',  @samplegui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before samplegui is made visible.
function samplegui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to samplegui (see VARARGIN)

% Choose default command line output for samplegui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes samplegui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Handle no structure being passed to GUI
if nargin<4 | ~isstruct(varargin{1})
    set(handles.StaticText,'String','Default String')
else
    set(handles.StaticText,'String',varargin{1}.String)
end


% --- Outputs from this function are returned to the command line.
function varargout = samplegui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ExitButton.
function ExitButton_Callback(hObject, eventdata, handles)
% hObject    handle to ExitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.figure1)