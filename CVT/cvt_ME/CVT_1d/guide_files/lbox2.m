function varargout = lbox2(varargin)

if nargin <= 1   % LAUNCH GUI
	if nargin == 0 
		initial_dir = pwd;
	elseif nargin == 1 & exist(varargin{1},'dir')  
		initial_dir = varargin{1};
	else
		errordlg('Input argument must be a valid directory','Input Argument Error!')
		return
	end
	% Open FIG-file
	fig = openfig(mfilename,'reuse');	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);
	% Populate the listbox
	load_listbox(initial_dir,handles)
	% Return figure handle as first output argument
	if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

  try
    [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
  catch
    disp(lasterr);
  end

end
% ------------------------------------------------------------
% Callback for list box - open .fig with guide, otherwise use open
% ------------------------------------------------------------
function varargout = listbox1_Callback(h, eventdata, handles, varargin)
if strcmp(get(handles.figure1,'SelectionType'),'open')
	index_selected = get(handles.listbox1,'Value');
	file_list = get(handles.listbox1,'String');	
	filename = file_list{index_selected};
	if  handles.is_dir(handles.sorted_index(index_selected))
		cd (filename)
		load_listbox(pwd,handles)
	else
	   [path,name,ext,ver] = fileparts(filename);
	   switch ext
	   case '.fig'
		   guide (filename)
	   otherwise 
		try
	    	open(filename)
		catch
			errordlg(lasterr,'File Type Error','modal')
		end
	   end	
   end
end
% ------------------------------------------------------------
% Read the current directory and sort the names
% ------------------------------------------------------------
function load_listbox(dir_path,handles)
cd (dir_path)
dir_struct = dir(dir_path);
[sorted_names,sorted_index] = sortrows({dir_struct.name}');
handles.file_names = sorted_names;
handles.is_dir = [dir_struct.isdir];
handles.sorted_index = [sorted_index];
guidata(handles.figure1,handles)
set(handles.listbox1,'String',handles.file_names,...
	'Value',1)
set(handles.text1,'String',pwd)