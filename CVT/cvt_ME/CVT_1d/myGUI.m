function varargout = myGUI(varargin)
% myGUI M-file for myGUI.fig
%      myGUI, by itself, creates a new myGUI or raises the existing
%      singleton*.
%
%      H = myGUI returns the handle to a new myGUI or the handle to
%      the existing singleton*.
%
%      myGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in myGUI.M with the given input arguments.
%
%      myGUI('Property','Value',...) creates a new myGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the myGUI before myGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to myGUI_OpeningFcn via varargin.
%
%      *See myGUI Options on GUIDE's Tools menu.  Choose "myGUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help myGUI

% Last Modified by GUIDE v2.5 19-May-2004 18:47:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @myGUI_OutputFcn, ...
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

% --- Executes just before myGUI is made visible.
function myGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to myGUI (see VARARGIN)

% Choose default command line output for myGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

data.mu1 = 1;
data.mu2 = 1;
data.mu0 = 0;

setappdata(hObject, 'relaxdata', data);

if strcmp(get(hObject,'Visible'),'off')
    initialize_mygui(hObject, handles);
end

N = num2str(get(handles.Ngen,'Value'));
NGridSteps = num2str(get(handles.NGridSteps,'Value'));
Ncycles = num2str(get(handles.MaxCycles,'Value'));
mu1 = num2str(data.mu1);
mu2 = num2str(data.mu2);
mu0 = num2str(data.mu0);
eps = num2str(get(handles.Epsilon,'Value'));
name = ['ConstResults/',N,'pts',NGridSteps,'gds',Ncycles,'cyc','_',mu1,'_',mu2,'_',mu0];
set(handles.editOutput,'String',name);

initial_dir = pwd;

% Populate the listbox
load_listboxInput(initial_dir,handles)


% UIWAIT makes myGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = myGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

initialize_mygui(gcbf, handles);
guidata(hObject, handles); % Save the updated structure


function initialize_mygui(fig_handle, handles)

set(handles.Ngen,'Value',3);
set(handles.NGridSteps,'Value',2);
set(handles.Epsilon,'Value',1e-16);
set(handles.MaxCycles,'Value', 50);
set(handles.IterNumber,'String','n/a');
set(handles.CurError,'String','n/a');
set(handles.CurRho,'String','n/a');

%set(handles.listboxInput,'String','.');
%set(handles.listboxOutput,'String', '.');




% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

N = get(handles.Ngen,'Value');
eps = get(handles.Epsilon,'Value');
NGridStep = get(handles.NGridSteps,'Value');
Ncycles = get(handles.MaxCycles,'Value');
fileIN = get(handles.listboxInput,'String');
fileOUT = get(handles.editOutput,'String');

data = getappdata(gcbf, 'relaxdata');
mu1 = data.mu1;
mu2 = data.mu2;
mu0 = data.mu0;

voronSeidelComplete(N,eps,NGridStep,Ncycles,mu1,mu2,mu0,fileIN,fileOUT,handles,hObject)

% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = getappdata(gcbf, 'relaxdata');
mu1 = data.mu1;
mu2 = data.mu2;
mu0 = data.mu0;
sN = num2str(get(handles.Ngen,'Value'));
sNGridSteps = num2str(get(handles.NGridSteps,'Value'));
sNcycles = num2str(get(handles.MaxCycles,'Value'));
smu1 = num2str(data.mu1);
smu2 = num2str(data.mu2);
smu0 = num2str(data.mu0);
name = ['ConstResults/',sN,'pts',sNGridSteps,'gds',sNcycles,'cyc','_',smu1,'_',smu2,'_',smu0];
set(handles.editOutput,'String',name);

% --- Executes during object creation, after setting all properties.
function Ngen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ngen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Ngen_Callback(hObject, eventdata, handles)
% hObject    handle to Ngen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ngen as text
%        str2double(get(hObject,'String')) returns contents of Ngen as a double

N = str2double(get(hObject,'String'))
if isnan(N)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

set(handles.Ngen,'Value',N);
guidata(hObject, handles); % Save the updated structure


% --- Executes during object creation, after setting all properties.
function NGridSteps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NGridSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function NGridSteps_Callback(hObject, eventdata, handles)
% hObject    handle to NGridSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NGridSteps as text
%        str2double(get(hObject,'String')) returns contents of NGridSteps as a double

NGridSteps = str2double(get(hObject,'String'))
if isnan(NGridSteps)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

set(handles.NGridSteps,'Value', NGridSteps);
guidata(hObject, handles); % Save the updated structure



% --- Executes during object creation, after setting all properties.
function Epsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Epsilon_Callback(hObject, eventdata, handles)
% hObject    handle to Epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Epsilon as text
%        str2double(get(hObject,'String')) returns contents of Epsilon as a double

eps = str2double(get(hObject,'String'))
if isnan(eps)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

set(handles.Epsilon,'Value',eps);
guidata(hObject, handles); % Save the updated structure



% --- Executes during object creation, after setting all properties.
function MaxCycles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxCycles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function MaxCycles_Callback(hObject, eventdata, handles)
% hObject    handle to MaxCycles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxCycles as text
%        str2double(get(hObject,'String')) returns contents of MaxCycles as a double

Ncycles = str2double(get(hObject,'String'))
if isnan(Ncycles)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

set(handles.MaxCycles,'Value',Ncycles);
guidata(hObject, handles); % Save the updated structure



% --- Executes during object creation, after setting all properties.
function CycleType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CycleType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in CycleType.
function CycleType_Callback(hObject, eventdata, handles)
% hObject    handle to CycleType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns CycleType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CycleType
 
data = getappdata(gcbf, 'relaxdata');

contents = get(hObject,'String');        
type = contents{get(hObject,'Value')}
switch type
    case 'V(1,1)'
        data.mu1 = 1;
        data.mu2 = 1;
        data.mu0 = 0;
    case 'V(0,1)'
        data.mu1 = 0;
        data.mu2 = 1;
        data.mu0 = 0;

    case 'V(1,0)'
        data.mu1 = 1;
        data.mu2 = 0;
        data.mu0 = 0;
    case 'V(2,2)'
        data.mu1 = 2;
        data.mu2 = 2;
        data.mu0 = 0;
    case 'V(0,2)'
        data.mu1 = 0;
        data.mu2 = 2;
        data.mu0 = 0;

    case 'V(2,0)'
        data.mu1 = 2;
        data.mu2 = 0;
        data.mu0 = 0;   
        
    case 'W(1,1,1)'
        data.mu1 = 1;
        data.mu2 = 1;
        data.mu0 = 1;
       
    case 'W(1,0,1)'
        data.mu1 = 1;
        data.mu2 = 0;
        data.mu0 = 1;
   
    case 'W(0,1,1)'
        data.mu1 = 0;
        data.mu2 = 1;
        data.mu0 = 1;
                
end

setappdata(gcbf, 'relaxdata', data);
guidata(hObject, handles); % Save the updated structure



% --- Executes during object creation, after setting all properties.
function IterNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IterNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



% --- Executes during object creation, after setting all properties.
function CurError_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes during object creation, after setting all properties.
function CurRho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurRho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in listboxInput.
function listboxInput_Callback(hObject, eventdata, handles)
% hObject    handle to listboxInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listboxInput contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxInput

if strcmp(get(handles.figure1,'SelectionType'),'open') % If double click
    index_selected = get(handles.listboxInput,'Value');
    file_list = get(handles.listboxInput,'String');
    filename = file_list{index_selected} % Item selected in list box
    if  handles.is_dir(handles.sorted_index(index_selected)) % If directory
        cd (filename)
        load_listboxInput(pwd,handles) % Load list box with new directory
    else

        set(handles.listboxInput,'String', filename,'Value',1);
        guidata(hObject, handles); % Save the updated structure

%         [path,name,ext,ver] = fileparts(filename);
%         switch ext
%         case '.fig' 
%             guide (filename) % Open FIG-file with guide command
%         otherwise 
%             try
%                  open(filename) % Use open for other file types
%             catch
%                  errordlg(lasterr,'File Type Error','modal')
%             end
%         end
    end
end

function load_listboxInput(dir_path, handles)
cd (dir_path)
dir_struct = dir(dir_path);
[sorted_names,sorted_index] = sortrows({dir_struct.name}');
handles.file_names = sorted_names;
handles.is_dir = [dir_struct.isdir];
handles.sorted_index = [sorted_index];
guidata(handles.figure1,handles)
set(handles.listboxInput,'String',handles.file_names,'Value',1)
%set(handles.text1,'String',pwd)


% --- Executes during object creation, after setting all properties.
function editOutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editOutput_Callback(hObject, eventdata, handles)
% hObject    handle to editOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOutput as text
%        str2double(get(hObject,'String')) returns contents of editOutput as a double


