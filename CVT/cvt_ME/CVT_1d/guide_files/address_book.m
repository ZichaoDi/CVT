function varargout = address_book(varargin)
if nargin <= 1  % LAUNCH GUI
  fig = openfig(mfilename,'reuse');
  % Use system color scheme for figure:
  set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));
  % Generate a structure of handles to pass to callbacks, and store it. 
  handles = guihandles(fig); 
  % Save handles structure
  guidata(fig, handles);
  if nargin == 0
	  % Load the default address book
	  Check_And_Load([],handles);
  elseif exist(varargin{1},'file')
	  Check_And_Load(varargin{1},handles);
  else
	  errordlg('File Not Found','File Load Error')
	  set(handles.Contact_Name,'String','')
	  set(handles.Contact_Phone,'String','')
  end	  
  % If there is an output argument assigned,
  % the first one is the figure handle
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
% Check to see if the MAT-file has the require fields - if so
% load it and display the first entry.
% ------------------------------------------------------------
function pass = Check_And_Load(file,handles)

% Initialize the variable "pass" to determine if this is a valid file.
pass = 0;

% If called without any file then set file to the default file name.
% Otherwise if the file exists then load it.
if isempty(file)
	file = 'addrbook.mat';
	handles.LastFile = file;
	guidata(handles.Address_Book,handles)
end

if exist(file) == 2
	data = load(file);
end

% Validate the MAT-file
% The file is valid if the variable is called "Addresses" and it has 
% fields called "Name" and "Phone"
flds = fieldnames(data);
if (length(flds) == 1) & (strcmp(flds{1},'Addresses'))
	fields = fieldnames(data.Addresses);
	if (length(fields) == 2) &(strcmp(fields{1},'Name')) & (strcmp(fields{2},'Phone'))
		pass = 1;
	end
end

% If the file is valid, display it
if pass
	% Add Addresses to the handles structure
	handles.Addresses = data.Addresses;
	% Display the first entry
	set(handles.Contact_Name,'String',data.Addresses(1).Name)
	set(handles.Contact_Phone,'String',data.Addresses(1).Phone)
	% Set the index pointer to 1
	handles.Index = 1;
	% Save the modified handles structure
	guidata(handles.Address_Book,handles)
else
	errordlg('Not a valid Address Book','Address Book Error')
end

% ------------------------------------------------------------
% Callback for Open menu - displays an open dialog
% ------------------------------------------------------------
function varargout = Open_Callback(h, eventdata, handles, varargin)
% Use UIGETFILE to allow for the selection of a custom address book.
[filename, pathname] = uigetfile( ...
	{'*.mat', 'All MAT-Files (*.mat)'; ...
		'*.*','All Files (*.*)'}, ...
	'Select Address Book');
% If "Cancel" is selected then return
if isequal([filename,pathname],[0,0])
	return
% Otherwise construct the fullfilename and Check and load the file.
else
	File = fullfile(pathname,filename);
	% if the MAT-file is not valid, do not save the name
	if Check_And_Load(File,handles)
		handles.LastFIle = File;
		guidata(h,handles)
	end
end


% ------------------------------------------------------------
% Callback for the Contact Name text box
% ------------------------------------------------------------
function varargout = Contact_Name_Callback(h, eventdata, handles, varargin)
% Get the strings in the Contact Name and Phone text box
Current_Name = get(handles.Contact_Name,'string');
Current_Phone = get(handles.Contact_Phone,'string');

% If empty then return
if isempty(Current_Name)
	return
end
% Get the current list of addresses from the handles structure
Addresses = handles.Addresses;
% Go through the list of contacts
% Determine if the current name matches an existing name
for i = 1:length(Addresses)
	if strcmp(Addresses(i).Name,Current_Name)
		set(handles.Contact_Name,'string',Addresses(i).Name)
		set(handles.Contact_Phone,'string',Addresses(i).Phone)
		handles.Index = i;
		guidata(h,handles)
		return
	end
end
% If it's a new name, ask to create a new entry
Answer=questdlg('Do you want to create a new entry?', ...
	'Create New Entry', ...
	'Yes','Cancel','Yes');			
switch Answer
case 'Yes'
	Addresses(end+1).Name = Current_Name; % Grow array by 1
	Addresses(end).Phone = Current_Phone; 
	index = length(Addresses);
	handles.Addresses = Addresses;
	handles.Index = index;
	guidata(h,handles)
	return			
case 'Cancel'
	% Revert back to the original number
	set(handles.Contact_Name,'string',Addresses(handles.Index).Name)
	set(handles.Contact_Phone,'String',Addresses(handles.Index).Phone)
	return
end			

% ------------------------------------------------------------
% Callback for the Contact Phone # text box
% ------------------------------------------------------------
function varargout = Contact_Phone_Callback(h, eventdata, handles, varargin)
Current_Phone = get(handles.Contact_Phone,'string');
% If either one is empty then return
if isempty(Current_Phone)
	return
end
% Get the current list of addresses from the handles structure
Addresses = handles.Addresses;
Answer=questdlg('Do you want to change the phone number?', ...
	'Change Phone Number', ...
	'Yes','Cancel','Yes');			
switch Answer
case 'Yes'
	% If no name match was found create a new contact
	Addresses(handles.Index).Phone = Current_Phone; 
	handles.Addresses = Addresses;
	guidata(h,handles)
	return			
case 'Cancel'
	% Revert back to the original number
	set(handles.Contact_Phone,'String',Addresses(handles.Index).Phone)
	return
end			

% ------------------------------------------------------------
% Callback for the Prev and Next buttons
% ------------------------------------------------------------
function varargout = Prev_Next_Callback(h, eventdata, handles, varargin)
% Get the string of the object selected
str = get(h,'string');
% Get the index pointer and the addresses
index = handles.Index;
Addresses = handles.Addresses;
% Depending on whether Prev or Next was clicked change the display
switch str
case 'Prev'
	% Decrease the index by one
	i = index - 1;	
	% If the index is less then one then set it equal to the index of the 
	% last element in the Addresses array
	if i < 1
		i = length(Addresses);
	end
case 'Next'
	% Increase the index by one
	i = index + 1;
	
	% If the index is greater than the size of the array then point
	% to the first item in the Addresses array
	if i > length(Addresses)
		i = 1;
	end	
end

% Get the appropriate data for the index in selected
Current_Name = Addresses(i).Name;
Current_Phone = Addresses(i).Phone;
set(handles.Contact_Name,'string',Current_Name)
set(handles.Contact_Phone,'string',Current_Phone)

% Update the index pointer to reflect the new index
handles.Index = i;
guidata(h,handles)

% ------------------------------------------------------------
% Callback for Save and Save As menus 
% ------------------------------------------------------------
function varargout = Save_Callback(h, eventdata, handles, varargin)
% Get the Tag of the menu selected
Tag = get(h,'Tag');
% Get the address array
Addresses = handles.Addresses;
% Based on the item selected, take the appropriate action
switch Tag
case 'Save'
	% Save to the default addrbook file
	File = handles.LastFile;
	save(File,'Addresses')
case 'Save_As'
	% Allow the user to select the file name to save to
	[filename, pathname] = uiputfile( ...
		{'*.mat';'*.*'}, ...
		'Save as');	
	% If 'Cancel' was selected then return
	if isequal([filename,pathname],[0,0])
		return
	else
		% Construct the full path and save
		File = fullfile(pathname,filename);
		save(File,'Addresses')
		handles.LastFile = File;
		guidata(h,handles)
	end
end
% ------------------------------------------------------------
% Callback for the Contact --> Create New menu
% ------------------------------------------------------------
function varargout = New_Callback(h, eventdata, handles, varargin)
set(handles.Contact_Name,'String','')
set(handles.Contact_Phone,'String','')

% ------------------------------------------------------------
% Callback for the GUI figure ResizeFcn property.
% ------------------------------------------------------------
function varargout = ResizeFcn(h, eventdata, handles, varargin)
% Get the figure size and position
Figure_Size = get(h,'Position');
% Set the figure's original size in character units
Original_Size = [ 0 0 94 19.230769230769234];
% If the resized figure is smaller than the original figure size then compensate
if (Figure_Size(3) < Original_Size(3)) | (Figure_Size(4) ~= Original_Size(4))
	if Figure_Size(3) < Original_Size(3)
		% If the width is too small then reset to origianl width
		set(h,'Position',[Figure_Size(1) Figure_Size(2) Original_Size(3) Original_Size(4)])
		Figure_Size = get(h,'Position');
	end
	
	if Figure_Size(4) ~= Original_Size(4)
		% Do not allow the height to change 
		set(h,'Position',[Figure_Size(1) Figure_Size(2)+Figure_Size(4)-Original_Size(4) Figure_Size(3) Original_Size(4)])
	end
end
% Set the units of the Contact Name field to 'Normalized'
set(handles.Contact_Name,'units','normalized')
% Get its Position
C_N_pos = get(handles.Contact_Name,'Position');
% Reset it so that it's width remains normalized relative to figure
set(handles.Contact_Name,'Position',[C_N_pos(1) C_N_pos(2)  0.789 C_N_pos(4)])
% Return the units to 'Characters'
set(handles.Contact_Name,'units','characters')
% Reposition GUI on screen
movegui(h,'onscreen')
