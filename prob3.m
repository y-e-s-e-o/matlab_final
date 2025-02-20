function varargout = prob3(varargin)
% PROB3 MATLAB code for prob3.fig
%      PROB3, by itself, creates a new PROB3 or raises the existing
%      singleton*.
%
%      H = PROB3 returns the handle to a new PROB3 or the handle to
%      the existing singleton*.
%
%      PROB3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROB3.M with the given input arguments.
%
%      PROB3('Property','Value',...) creates a new PROB3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prob3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prob3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prob3

% Last Modified by GUIDE v2.5 12-Dec-2024 20:36:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @prob3_OpeningFcn, ...
                   'gui_OutputFcn',  @prob3_OutputFcn, ...
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


% --- Executes just before prob3 is made visible.
function prob3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prob3 (see VARARGIN)

% Choose default command line output for prob3
handles.output = hObject;

set(handles.slider_m, 'Value', 5);
set(handles.edit_m, 'String', 5);

open_system('prob3_msd')
set_param('prob3_msd/A','Gain','1');
set_param('prob3_msd/m','Gain',num2str(1/5));

out = sim('prob3_msd.slx');

axes(handles.axes2); 
plot(out.tout, out.simout);
ylabel('displacement(m)'); 

axes(handles.axes1);
plot(out.tout, out.simout_force);
ylabel('force(N)'); ylim([-10 10]);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prob3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prob3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_m_Callback(hObject, eventdata, handles)
% hObject    handle to slider_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

m = get(hObject, 'Value');

set(handles.edit_m, 'String', num2str(m));
set_param('prob3_msd/m', 'Gain', num2str(1/m));

out = sim('prob3_msd.slx');

axes(handles.axes2); 
plot(out.tout, out.simout);
ylabel('displacement(m)'); 

axes(handles.axes1);
plot(out.tout, out.simout_force); 
ylabel('force(N)'); ylim([-10 10]);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_m_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m as text
%        str2double(get(hObject,'String')) returns contents of edit_m as a double

m = get(hObject, 'String');

set(handles.slider_m, 'Value', str2num(m));
set_param('prob3_msd/m', 'Gain', num2str(1/str2num(m)));

out = sim('prob3_msd.slx');

axes(handles.axes2); 
plot(out.tout, out.simout);
ylabel('displacement(m)'); 

axes(handles.axes1);
plot(out.tout, out.simout_force); 
ylabel('force(N)'); ylim([-10 10]);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_A.
function popupmenu_A_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_A contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_A

contents = cellstr(get(hObject, 'String'));
A = str2num(contents{get(hObject, 'Value')});

set_param('prob3_msd/A', 'Gain', num2str(A));

out = sim('prob3_msd.slx');

axes(handles.axes2); 
plot(out.tout, out.simout);
ylabel('displacement(m)'); 

axes(handles.axes1);
plot(out.tout, out.simout_force); 
ylabel('force(N)'); ylim([-10 10]);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
