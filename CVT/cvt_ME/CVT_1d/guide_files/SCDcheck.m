function varargout = SCDcheck(varargin)
% SCDCHECK M-file for SCDcheck.fig
%      SCDCHECK, by itself, creates a new SCDCHECK or raises the existing
%      singleton*.
%
%      H = SCDCHECK returns the handle to a new SCDCHECK or the handle to
%      the existing singleton*.
%
%      SCDCHECK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCDCHECK.M with the given input arguments.
%
%      SCDCHECK('Property','Value',...) creates a new SCDCHECK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SCDcheck_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SCDcheck_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SCDcheck

% Last Modified by GUIDE v2.5 13-Nov-2003 17:43:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SCDcheck_OpeningFcn, ...
                   'gui_OutputFcn',  @SCDcheck_OutputFcn, ...
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


% --- Executes just before SCDcheck is made visible.
function SCDcheck_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SCDcheck (see VARARGIN)

% Choose default command line output for SCDcheck
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SCDcheck wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SCDcheck_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in checkalignment.
function checkalignment_Callback(hObject, eventdata, handles)
% hObject    handle to checkalignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(gcbf, 'SCDcheckdata');
inputdata=data.inputdata;
P1 = data.P1;
P2 = data.P2;

% Select what data file to open. If using SCDtemp2.mat, just get FRAC.
% otherwise, get all variables because there isn't any way to get just
% one of the variables with the load() command which is needed for
% string input.
if eq(length(inputdata),length('SCDtemp2.mat'))==0;
    load(inputdata);
elseif eq(inputdata,'SCDtemp2.mat')==1;
    load SCDtemp2 FRAC Q
else
    load(inputdata)
end;

for i=1:size(FRAC,3); 
    x(i)=FRAC(P1,P2,i); 
end; 

% Send position data to the plot window.
% figure; % enable this line to plot cross-check plot to a new figure window.
plot(x);
title ('Alignment vs. Decorrelation Point (DC)');
xlabel('Profile 2 Stretching (Indexed)');
ylabel('Rim-to-Core Fractional DC Position');

Quality = Q(P1,P2);
data.Quality = Quality;
set(handles.edit5, 'String', Quality);


% --- Executes during object creation, after setting all properties.
function inputdata1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputdata1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

inputdata = (get(hObject, 'String'));
data = getappdata(gcbf, 'SCDcheckdata');
data.inputdata = inputdata;
setappdata(gcbf, 'SCDcheckdata', data);

function inputdata1_Callback(hObject, eventdata, handles)
% hObject    handle to inputdata1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputdata = (get(hObject, 'String'));
data = getappdata(gcbf, 'SCDcheckdata');
data.inputdata = inputdata;
setappdata(gcbf, 'SCDcheckdata', data);


% --- Executes during object creation, after setting all properties.
function profile1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to profile1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

P1 = str2double(get(hObject, 'String'));
data = getappdata(gcbf, 'SCDcheckdata');
data.P1 = P1;
setappdata(gcbf, 'SCDcheckdata', data);

function profile1_Callback(hObject, eventdata, handles)
% hObject    handle to profile1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
P1 = str2double(get(hObject, 'String'));
data = getappdata(gcbf, 'SCDcheckdata');
data.P1 = P1;
setappdata(gcbf, 'SCDcheckdata', data);

% --- Executes during object creation, after setting all properties.
function profile2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to profile2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

P2 = str2double(get(hObject, 'String'));
data = getappdata(gcbf, 'SCDcheckdata');
data.P2 = P2;
setappdata(gcbf, 'SCDcheckdata', data);


function profile2_Callback(hObject, eventdata, handles)
% hObject    handle to profile2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
P2 = str2double(get(hObject, 'String'));
data = getappdata(gcbf, 'SCDcheckdata');
data.P2 = P2;
setappdata(gcbf, 'SCDcheckdata', data);


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
