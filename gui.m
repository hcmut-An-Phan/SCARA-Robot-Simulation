function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 11-Dec-2023 13:37:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)
global show_work_space;
global alpha;
global frames_on;
show_work_space = 0;
alpha = 1;
frames_on = [0 0 0 0 0];

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

theta1_pre = 0;
theta2_pre = 90;
theta3_pre = 0;
theta4_pre = 0;

init_theta = [theta1_pre theta2_pre theta3_pre theta4_pre];

global prev_x;
global prev_y;
global prev_z;
global prev_t;

prev_x = 300;
prev_y = 300;
prev_z = 13.5;
prev_t = 90;

global v_max;
global a_max;
global end_x;
global end_y;
global end_z;
global end_yaw;

v_max = 400;
a_max = 800;
end_x = 400;
end_y = -200;
end_z = 100;
end_yaw = 90;

global v1_max;
global v2_max;
global v3_max;
global v4_max;
global time_max;

v1_max = 50;
v2_max = 5;
v3_max = 60;
v4_max = 60;
time_max = 2;

set(handles.theta1_textBox, 'string', num2str(0));
set(handles.theta2_textBox, 'string', num2str(90));
set(handles.theta3_textBox, 'string', num2str(0));
set(handles.theta4_textBox, 'string', num2str(0));

set(handles.x, 'string', num2str(300));
set(handles.y, 'string', num2str(300));
set(handles.z, 'string', num2str(13.5));
set(handles.yaw, 'string', num2str(90));

set(handles.theta1_slider, 'value', 0);
set(handles.theta2_slider, 'value', 90);
set(handles.theta3_slider, 'value', 0);
set(handles.theta4_slider, 'value', 0);

set(handles.opacity_slider, 'value', 1);

% set(handles.v_max, 'value', 0.4);
% set(handles.a_max, 'value', 0.8);

set(handles.end_x, 'value', 300);
set(handles.end_y, 'value', -300);
set(handles.end_z, 'value', 13.5);
set(handles.end_x, 'value', 90);

grid(handles.axes_p,'on')
grid(handles.axes_v,'on')
grid(handles.axes_a,'on')

grid(handles.axes_q1,'on')
grid(handles.axes_q2,'on')
grid(handles.axes_q3,'on')
grid(handles.axes_q4,'on')

grid(handles.axes_v1,'on')
grid(handles.axes_v2,'on')
grid(handles.axes_v3,'on')
grid(handles.axes_v4,'on')

grid(handles.axes_a1,'on')
grid(handles.axes_a2,'on')
grid(handles.axes_a3,'on')
grid(handles.axes_a4,'on')

view_ = [41 32];
draw_robot(handles,init_theta,alpha,frames_on,show_work_space,view_)
% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in forward_button.
function forward_button_Callback(hObject, eventdata, handles)
% hObject    handle to forward_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

global prev_x;
global prev_y;
global prev_z;
global prev_t;

theta1 = str2double(handles.theta1_textBox.String);
theta2 = str2double(handles.theta2_textBox.String);
theta3 = str2double(handles.theta3_textBox.String);
theta4 = str2double(handles.theta4_textBox.String);

q = zeros(4,20);
q(1,:) = linspace(theta1_pre,theta1,size(q,2));
q(2,:) = linspace(theta2_pre,theta2,size(q,2));
q(3,:) = linspace(theta3_pre,theta3,size(q,2));
q(4,:) = linspace(theta4_pre,theta4,size(q,2));

p = zeros(4,20);

[x,y,z,t] = fkine(theta1,theta2,theta3,theta4);

p(1,:) = linspace(prev_x,x,size(p,2));
p(2,:) = linspace(prev_y,y,size(p,2));
p(3,:) = linspace(prev_z,z,size(p,2));
p(4,:) = linspace(prev_t,t,size(p,2));


for i = 1:size(q,2)
    draw_robot(handles,q(:,i),alpha,frames_on,show_work_space,[caz,cel])
    pause(0.001)
    if abs(p(1,i)) < 1e-6
        p(1,i) = 0;
    end
    if abs(p(2,i)) < 1e-6
        p(2,i) = 0;
    end
    if abs(p(4,i)) < 1e-6
        p(4,i) = 0;
    end
    set(handles.x,'string',num2str(p(1,i)));
    set(handles.y,'string',num2str(p(2,i)));
    set(handles.z,'string',num2str(p(3,i)));
    set(handles.yaw,'string',num2str(p(4,i)));
end    

theta1_pre=theta1;
theta2_pre=theta2;
theta3_pre=theta3;
theta4_pre=theta4;

prev_x = x;
prev_y = y;
prev_z = z;
prev_t = t;

% --- Executes on button press in home_button.
function home_button_Callback(hObject, eventdata, handles)
% hObject    handle to home_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

global prev_x;
global prev_y;
global prev_z;
global prev_t;

cla(handles.axes_p)
cla(handles.axes_v)
cla(handles.axes_a)
cla(handles.axes_q1)
cla(handles.axes_q2)
cla(handles.axes_q3)
cla(handles.axes_q4)
cla(handles.axes_v1)
cla(handles.axes_v2)
cla(handles.axes_v3)
cla(handles.axes_v4)
cla(handles.axes_a1)
cla(handles.axes_a2)
cla(handles.axes_a3)
cla(handles.axes_a4)

[caz,cel] = view(handles.axes1);

q = zeros(4,2);
q(1,:) = linspace(theta1_pre,0,size(q,2));
q(2,:) = linspace(theta2_pre,90,size(q,2));
q(3,:) = linspace(theta3_pre,0,size(q,2));
q(4,:) = linspace(theta4_pre,0,size(q,2));

p = zeros(4,2);

p(1,:) = linspace(prev_x,300,size(p,2));
p(2,:) = linspace(prev_y,300,size(p,2));
p(3,:) = linspace(prev_z,13.5,size(p,2));
p(4,:) = linspace(prev_t,90,size(p,2));

for i = 1:size(q,2)
    draw_robot(handles,q(:,i),alpha,frames_on,show_work_space,[caz,cel])
    pause(0.001)
    set(handles.x,'string',num2str(p(1,i)));
    set(handles.y,'string',num2str(p(2,i)));
    set(handles.z,'string',num2str(p(3,i)));
    set(handles.yaw,'string',num2str(p(4,i)));

    set(handles.theta1_textBox,'string',num2str(q(1,i)));
    set(handles.theta2_textBox,'string',num2str(q(2,i)));
    set(handles.theta3_textBox,'string',num2str(q(3,i)));
    set(handles.theta4_textBox,'string',num2str(q(4,i)));
end

set(handles.theta1_slider, 'value', 0);
set(handles.theta2_slider, 'value', 90);
set(handles.theta3_slider, 'value', 0);
set(handles.theta4_slider, 'value', 0);

theta1_pre=0;
theta2_pre=90;
theta3_pre=0;
theta4_pre=0;

prev_x = 300;
prev_y = 300;
prev_z = 13.5;
prev_t = 90;

function theta1_textBox_Callback(hObject, eventdata, handles)
% hObject    handle to theta1_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    stncture with handles and user data (see GUIDATA)
theta1 = str2double(handles.theta1_textBox.String);
if (theta1 <= 125.0) && (theta1 >= -125.0)
   set(handles.theta1_slider, 'value', theta1);
else
   errordlg('Theta1 must in range -125 to 125','Out of workspace');
end
% Hints: get(hObject,'String') returns contents of theta1_textBox as text
%        str2double(get(hObject,'String')) returns contents of theta1_textBox as a double


% --- Executes during object creation, after setting all properties.
function theta1_textBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function theta1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to theta1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1 = get(handles.theta1_slider,'value');
set(handles.theta1_textBox,'string',num2str(theta1));

global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

global prev_x;
global prev_y;
global prev_z;
global prev_t;
if (abs(theta1 - theta1_pre) < 5)
    q = zeros(4,3);
else
    q = zeros(4,10);
end
q(1,:) = linspace(theta1_pre,theta1,size(q,2));
q(2,:) = linspace(theta2_pre,theta2_pre,size(q,2));
q(3,:) = linspace(theta3_pre,theta3_pre,size(q,2));
q(4,:) = linspace(theta4_pre,theta4_pre,size(q,2));

p = zeros(4,size(q,2));

[x,y,z,t] = fkine(theta1,theta2_pre,theta3_pre,theta4_pre);

p(1,:) = linspace(prev_x,x,size(p,2));
p(2,:) = linspace(prev_y,y,size(p,2));
p(3,:) = linspace(prev_z,z,size(p,2));
p(4,:) = linspace(prev_t,t,size(p,2));

for i = 1:size(q,2)
    draw_robot(handles,q(:,i),alpha,frames_on,show_work_space,[caz,cel])
    pause(0.001)
    if abs(p(1,i)) < 1e-6
        p(1,i) = 0;
    end
    if abs(p(2,i)) < 1e-6
        p(2,i) = 0;
    end
    if abs(p(4,i)) < 1e-6
        p(4,i) = 0;
    end
    set(handles.x,'string',num2str(p(1,i)));
    set(handles.y,'string',num2str(p(2,i)));
    set(handles.z,'string',num2str(p(3,i)));
    set(handles.yaw,'string',num2str(p(4,i)));
end

theta1_pre=theta1;

prev_x = x;
prev_y = y;
prev_z = z;
prev_t = t;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function theta1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function theta2_textBox_Callback(hObject, eventdatWorkspacea, handles)
% hObject    handle to theta2_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta2 = str2double(handles.theta2_textBox.String);
if (theta2 <= 145.0) && (theta2 >= -145.0)
   set(handles.theta2_slider, 'value', theta2);
else
   errordlg('Theta2 must in range -145 to 145','Out of workspace');
end
% Hints: get(hObject,'String') returns contents of theta2_textBox as text
%        str2double(get(hObject,'String')) returns contents of theta2_textBox as a double


% --- Executes during object creation, after setting all properties.
function theta2_textBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function theta2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to theta2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta2 = get(handles.theta2_slider,'value');
set(handles.theta2_textBox,'string',num2str(theta2));

global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

global prev_x;
global prev_y;
global prev_z;
global prev_t;

if (abs(theta2 - theta2_pre) < 5)
    q = zeros(4,3);
else
    q = zeros(4,10);
end
q(1,:) = linspace(theta1_pre,theta1_pre,size(q,2));
q(2,:) = linspace(theta2_pre,theta2,size(q,2));
q(3,:) = linspace(theta3_pre,theta3_pre,size(q,2));
q(4,:) = linspace(theta4_pre,theta4_pre,size(q,2));

p = zeros(4,size(q,2));

[x,y,z,t] = fkine(theta1_pre,theta2,theta3_pre,theta4_pre);

p(1,:) = linspace(prev_x,x,size(p,2));
p(2,:) = linspace(prev_y,y,size(p,2));
p(3,:) = linspace(prev_z,z,size(p,2));
p(4,:) = linspace(prev_t,t,size(p,2));

for i = 1:size(q,2)
    draw_robot(handles,q(:,i),alpha,frames_on,show_work_space,[caz,cel])
    pause(0.001)
    if abs(p(1,i)) < 1e-6
        p(1,i) = 0;
    end
    if abs(p(2,i)) < 1e-6
        p(2,i) = 0;
    end
    if abs(p(4,i)) < 1e-6
        p(4,i) = 0;
    end
    set(handles.x,'string',num2str(p(1,i)));
    set(handles.y,'string',num2str(p(2,i)));
    set(handles.z,'string',num2str(p(3,i)));
    set(handles.yaw,'string',num2str(p(4,i)));
end

theta2_pre=theta2;

prev_x = x;
prev_y = y;
prev_z = z;
prev_t = t;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function theta2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function theta3_textBox_Callback(hObject, eventdata, handles)
% hObject    handle to theta3_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta3 = str2double(handles.theta3_textBox.String);
if (theta3 <= 150.0) && (theta3 >= 0)
   set(handles.theta3_slider, 'value', theta3);
else
   errordlg('Theta3 must in range 0 to 150','Out of workspace');
end
% Hints: get(hObject,'String') returns contents of theta3_textBox as text
%        str2double(get(hObject,'String')) returns contents of theta3_textBox as a double


% --- Executes during object creation, after setting all properties.
function theta3_textBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta3_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function theta3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to theta3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta3 = get(handles.theta3_slider,'value');
set(handles.theta3_textBox,'string',num2str(theta3));

global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

global prev_x;
global prev_y;
global prev_z;
global prev_t;

if (abs(theta3 - theta3_pre) < 5)
    q = zeros(4,3);
else
    q = zeros(4,10);
end
q(1,:) = linspace(theta1_pre,theta1_pre,size(q,2));
q(2,:) = linspace(theta2_pre,theta2_pre,size(q,2));
q(3,:) = linspace(theta3_pre,theta3,size(q,2));
q(4,:) = linspace(theta4_pre,theta4_pre,size(q,2));

p = zeros(4,size(q,2));

[x,y,z,t] = fkine(theta1_pre,theta2_pre,theta3,theta4_pre);

p(1,:) = linspace(prev_x,x,size(p,2));
p(2,:) = linspace(prev_y,y,size(p,2));
p(3,:) = linspace(prev_z,z,size(p,2));
p(4,:) = linspace(prev_t,t,size(p,2));

for i = 1:size(q,2)
    draw_robot(handles,q(:,i),alpha,frames_on,show_work_space,[caz,cel])
    pause(0.001)
    if abs(p(1,i)) < 1e-6
        p(1,i) = 0;
    end
    if abs(p(2,i)) < 1e-6
        p(2,i) = 0;
    end
    if abs(p(4,i)) < 1e-6
        p(4,i) = 0;
    end
    set(handles.x,'string',num2str(p(1,i)));
    set(handles.y,'string',num2str(p(2,i)));
    set(handles.z,'string',num2str(p(3,i)));
    set(handles.yaw,'string',num2str(p(4,i)));
end

theta3_pre=theta3;

prev_x = x;
prev_y = y;
prev_z = z;
prev_t = t;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function theta3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function theta4_textBox_Callback(hObject, eventdata, handles)
% hObject    handle to theta4_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta4 = str2double(handles.theta4_textBox.String);
if (theta4 <= 360) && (theta4 >= -360)
   set(handles.theta4_slider, 'value', theta4);
else
   errordlg('Theta4 must in range -360 to 360','Out of workspace');
end
% Hints: get(hObject,'String') returns contents of theta4_textBox as text
%        str2double(get(hObject,'String')) returns contents of theta4_textBox as a double


% --- Executes during object creation, after setting all properties.
function theta4_textBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta4_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function theta4_slider_Callback(hObject, eventdata, handles)
% hObject    handle to theta4_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta4 = get(handles.theta4_slider,'value');
set(handles.theta4_textBox,'string',num2str(theta4));

theta3 = get(handles.theta3_slider,'value');
set(handles.theta3_textBox,'string',num2str(theta3));

global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

global prev_x;
global prev_y;
global prev_z;
global prev_t;

if (abs(theta4 - theta4_pre) < 5)
    q = zeros(4,3);
else
    q = zeros(4,10);
end
q(1,:) = linspace(theta1_pre,theta1_pre,size(q,2));
q(2,:) = linspace(theta2_pre,theta2_pre,size(q,2));
q(3,:) = linspace(theta3_pre,theta3_pre,size(q,2));
q(4,:) = linspace(theta4_pre,theta4,size(q,2));

p = zeros(4,size(q,2));

[x,y,z,t] = fkine(theta1_pre,theta2_pre,theta3_pre,theta4);

p(1,:) = linspace(prev_x,x,size(p,2));
p(2,:) = linspace(prev_y,y,size(p,2));
p(3,:) = linspace(prev_z,z,size(p,2));
p(4,:) = linspace(prev_t,t,size(p,2));

for i = 1:size(q,2)
    draw_robot(handles,q(:,i),alpha,frames_on,show_work_space,[caz,cel])
    pause(0.001)
    if abs(p(1,i)) < 1e-6
        p(1,i) = 0;
    end
    if abs(p(2,i)) < 1e-6
        p(2,i) = 0;
    end
    if abs(p(4,i)) < 1e-6
        p(4,i) = 0;
    end
    set(handles.x,'string',num2str(p(1,i)));
    set(handles.y,'string',num2str(p(2,i)));
    set(handles.z,'string',num2str(p(3,i)));
    set(handles.yaw,'string',num2str(p(4,i)));
end

theta4_pre=theta4;

prev_x = x;
prev_y = y;
prev_z = z;
prev_t = t;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function theta4_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta4_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function x_Callback(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x as text
%        str2double(get(hObject,'String')) returns contents of x as a double


% --- Executes during object creation, after setting all properties.
function x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_Callback(hObject, eventdata, handles)
% hObject    handle to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y as text
%        str2double(get(hObject,'String')) returns contents of y as a double


% --- Executes during object creation, after setting all properties.
function y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_Callback(hObject, eventdata, handles)
% hObject    handle to z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z as text
%        str2double(get(hObject,'String')) returns contents of z as a double


% --- Executes during object creation, after setting all properties.
function z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaw_Callback(hObject, eventdata, handles)
% hObject    handle to yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaw as text
%        str2double(get(hObject,'String')) returns contents of yaw as a double


% --- Executes during object creation, after setting all properties.
function yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function opacity_box_Callback(hObject, eventdata, handles)
% hObject    handle to opacity_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;
a = str2double(handles.opacity_box.String);
if (a <= 1) && (a >= 0)
   alpha = a;
   set(handles.opacity_slider, 'value', alpha);
   draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
       alpha,frames_on,show_work_space,[caz,cel])
else
   errordlg('Opacity must in range 0 to 1','Out of range');
end

% Hints: get(hObject,'String') returns contents of opacity_box as text
%        str2double(get(hObject,'String')) returns contents of opacity_box as a double


% --- Executes during object creation, after setting all properties.
function opacity_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to opacity_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function opacity_slider_Callback(hObject, eventdata, handles)
% hObject    handle to opacity_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

alpha = get(handles.opacity_slider,'value');
set(handles.opacity_box,'string',num2str(alpha));

draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
    alpha,frames_on,show_work_space,[caz,cel])
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function opacity_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to opacity_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in frame0.
function frame0_Callback(hObject, eventdata, handles)
% hObject    handle to frame0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

if get(handles.frame0,'Value')==1
    frames_on(1) = 1;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
else
    frames_on(1) = 0;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
end
% Hint: get(hObject,'Value') returns toggle state of frame0


% --- Executes on button press in frame1.
function frame1_Callback(hObject, eventdata, handles)
% hObject    handle to frame1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

if get(handles.frame1,'Value')==1
    frames_on(2) = 1;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
else
    frames_on(2) = 0;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
end
% Hint: get(hObject,'Value') returns toggle state of frame1


% --- Executes on button press in frame2.
function frame2_Callback(hObject, eventdata, handles)
% hObject    handle to frame2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

if get(handles.frame2,'Value')==1
    frames_on(3) = 1;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
else
    frames_on(3) = 0;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
end
% Hint: get(hObject,'Value') returns toggle state of frame2


% --- Executes on button press in frame3.
function frame3_Callback(hObject, eventdata, handles)
% hObject    handle to frame3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

if get(handles.frame3,'Value')==1
    frames_on(4) = 1;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
else
    frames_on(4) = 0;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
end
% Hint: get(hObject,'Value') returns toggle state of frame3


% --- Executes on button press in frame4.
function frame4_Callback(hObject, eventdata, handles)
% hObject    handle to frame4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

if get(handles.frame4,'Value')==1
    frames_on(5) = 1;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
else
    frames_on(5) = 0;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
end
% Hint: get(hObject,'Value') returns toggle state of frame4


% --- Executes on button press in work_space.
function work_space_Callback(hObject, eventdata, handles)
% hObject    handle to work_space (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

if get(handles.work_space,'Value')==1
    show_work_space = 1;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
else
    show_work_space = 0;
    draw_robot(handles,[theta1_pre theta2_pre theta3_pre theta4_pre], ...
        alpha,frames_on,show_work_space,[caz,cel])
end
% Hint: get(hObject,'Value') returns toggle state of work_space


% --- Executes on button press in goto_button.
function goto_button_Callback(hObject, eventdata, handles)
% hObject    handle to goto_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

global prev_x;
global prev_y;
global prev_z;
global prev_t;

x = str2double(handles.x.String);
y = str2double(handles.y.String);
z = str2double(handles.z.String);
yaw = str2double(handles.yaw.String);

theta = ikine(x,y,z,yaw);

if isempty(theta)
    return;
end


q = zeros(4,20);
q(1,:) = linspace(theta1_pre,theta(1),size(q,2));
q(2,:) = linspace(theta2_pre,theta(2),size(q,2));
q(3,:) = linspace(theta3_pre,theta(3),size(q,2));
q(4,:) = linspace(theta4_pre,theta(4),size(q,2));

for i = 1:size(q,2)
    draw_robot(handles,q(:,i),alpha,frames_on,show_work_space,[caz,cel])
    pause(0.001)

    set(handles.theta1_textBox,'string',num2str(q(1,i)));
    set(handles.theta2_textBox,'string',num2str(q(2,i)));
    set(handles.theta3_textBox,'string',num2str(q(3,i)));
    set(handles.theta4_textBox,'string',num2str(q(4,i)));
end

theta1_pre=theta(1,1);
theta2_pre=theta(1,2);
theta3_pre=theta(1,3);
theta4_pre=theta(1,4);

set(handles.theta1_slider, 'value', theta(1,1));
set(handles.theta2_slider, 'value', theta(1,2));
set(handles.theta3_slider, 'value', theta(1,3));
set(handles.theta4_slider, 'value', theta(1,4));

prev_x = x;
prev_y = y;
prev_z = z;
prev_t = yaw;


% % --- Executes on button press in run_button.
% function run_button_Callback(hObject, eventdata, handles)
% % hObject    handle to run_button (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global show_work_space;
% global alpha;
% global frames_on;
% 
% [caz,cel] = view(handles.axes1);
% 
% global theta1_pre;
% global theta2_pre;
% global theta3_pre;
% global theta4_pre;
% 
% global prev_x;
% global prev_y;
% global prev_z;
% global prev_t;
% 
% global end_x;
% global end_y;
% global end_z;
% global end_yaw;
% 
% global v_max;
% global a_max;
% 
% cla(handles.axes_p)
% cla(handles.axes_v)
% cla(handles.axes_a)
% cla(handles.axes_q1)
% cla(handles.axes_q2)
% cla(handles.axes_q3)
% cla(handles.axes_q4)
% cla(handles.axes_v1)
% cla(handles.axes_v2)
% cla(handles.axes_v3)
% cla(handles.axes_v4)
% 
% start_point = [prev_x  prev_y prev_z];
% end_point = [end_x end_y end_z];
% 
% time_segment = 50;
% 
% [position_t, velocity_t, accelaeration_t, path_length, toltal_time, time] = Trajectory(start_point,end_point,v_max,a_max,time_segment);
% 
% position_graph = animatedline(handles.axes_p,'Color','blue','LineWidth',2);
% axis(handles.axes_p,[0 toltal_time 0 path_length+path_length/10]), grid(handles.axes_p,'on'), legend(handles.axes_p,'p(t)')
% 
% velocity_graph = animatedline(handles.axes_v,'Color','blue','LineWidth',2);
% axis(handles.axes_v,[0 toltal_time 0 v_max+v_max/10]), grid(handles.axes_v,'on'), legend(handles.axes_v,'v(t)')
% 
% acceleration_graph = animatedline(handles.axes_a,'Color','blue','LineWidth',2);
% axis(handles.axes_a,[0 toltal_time  -a_max-a_max/10 a_max+a_max/10]),grid(handles.axes_a,'on'), legend(handles.axes_a,'a(t)')
% 
% x_path = end_effector_trajectory(prev_x,end_x,v_max,toltal_time,time_segment);
% y_path = end_effector_trajectory(prev_y,end_y,v_max,toltal_time,time_segment);
% z_path = end_effector_trajectory(prev_z,end_z,v_max,toltal_time,time_segment);
% yaw_path = end_effector_trajectory(prev_t,end_yaw,v_max,toltal_time,time_segment);
% 
% path_x = x_path/1000;
% path_y = y_path/1000;
% path_z = z_path/1000;
% 
% path = [path_x; path_y; path_z];
% 
% q1_graph = animatedline(handles.axes_q1,'Color','blue','LineWidth',2);
% axis(handles.axes_q1,[0 toltal_time -125 125]), grid(handles.axes_q1,'on'), legend(handles.axes_q1,'theta1(t)')
% q2_graph = animatedline(handles.axes_q2,'Color','blue','LineWidth',2);
% axis(handles.axes_q2,[0 toltal_time -145 145]), grid(handles.axes_q2,'on'), legend(handles.axes_q2,'theta2(t)')
% q3_graph = animatedline(handles.axes_q3,'Color','blue','LineWidth',2);
% axis(handles.axes_q3,[0 toltal_time 0 150]), grid(handles.axes_q3,'on'), legend(handles.axes_q3,'theta3(t)')
% q4_graph = animatedline(handles.axes_q4,'Color','blue','LineWidth',2);
% axis(handles.axes_q4,[0 toltal_time -360 360]), grid(handles.axes_q4,'on'), legend(handles.axes_q4,'theta4(t)')
% 
% v1_graph = animatedline(handles.axes_v1,'Color','blue','LineWidth',2);
% axis(handles.axes_v1,[0 toltal_time -125 125]), grid(handles.axes_v1,'on'), legend(handles.axes_v1,'v1(t)')
% v2_graph = animatedline(handles.axes_v2,'Color','blue','LineWidth',2);
% axis(handles.axes_v2,[0 toltal_time -145 145]), grid(handles.axes_v2,'on'), legend(handles.axes_v2,'v2(t)')
% v3_graph = animatedline(handles.axes_v3,'Color','blue','LineWidth',2);
% axis(handles.axes_v3,[0 toltal_time 0 150]), grid(handles.axes_v3,'on'), legend(handles.axes_v3,'v3(t)')
% v4_graph = animatedline(handles.axes_v4,'Color','blue','LineWidth',2);
% axis(handles.axes_v4,[0 toltal_time -360 360]), grid(handles.axes_v4,'on'), legend(handles.axes_v4,'v4(t)')
% 
% a1_graph = animatedline(handles.axes_a1,'Color','blue','LineWidth',2);
% axis(handles.axes_a1,[0 toltal_time -200 170]), grid(handles.axes_a1,'on'), legend(handles.axes_a1,'a1(t)')
% a2_graph = animatedline(handles.axes_a2,'Color','blue','LineWidth',2);
% axis(handles.axes_a2,[0 toltal_time -145 145]), grid(handles.axes_a2,'on'), legend(handles.axes_a2,'a2(t)')
% a3_graph = animatedline(handles.axes_a3,'Color','blue','LineWidth',2);
% axis(handles.axes_a3,[0 toltal_time -150 150]), grid(handles.axes_a3,'on'), legend(handles.axes_a3,'a3(t)')
% a4_graph = animatedline(handles.axes_a4,'Color','blue','LineWidth',2);
% axis(handles.axes_a4,[0 toltal_time -360 360]), grid(handles.axes_a4,'on'), legend(handles.axes_a4,'a4(t)')
% 
% theta = zeros(time_segment,4);
% theta_dot = zeros(time_segment,4);
% theta_dot_dot = zeros(time_segment,4);
% 
% for i = 1:time_segment
%     theta(i,:) = ikine(x_path(i),y_path(i),z_path(i),yaw_path(i));
% end
% 
% for j = 2:time_segment
%     for l = 1:4
%         theta_dot(j,l) = (theta(j,l)-theta(j-1,l))/(toltal_time/time_segment);
%     end
% end
% 
% for m = 3:time_segment
%     for n = 1:4
%         theta_dot_dot(m,n) = (theta_dot(m,n)-theta_dot(m-1,n))/(toltal_time/time_segment);
%     end
% end
% 
% for k = 1:time_segment
%     %theta = ikine(x_path(k),y_path(k),z_path(k),yaw_path(k));
%     draw_robot_path(handles,theta(k,:),alpha,frames_on,show_work_space,[caz,cel],path,k)
%     set(handles.theta1_textBox,'string',num2str(theta(1)));
%     set(handles.theta2_textBox,'string',num2str(theta(2)));
%     set(handles.theta3_textBox,'string',num2str(theta(3)));
%     set(handles.theta4_textBox,'string',num2str(theta(4)));
% 
%     set(handles.x,'string',num2str(x_path(k)));
%     set(handles.y,'string',num2str(y_path(k)));
%     set(handles.z,'string',num2str(z_path(k)));
%     set(handles.yaw,'string',num2str(yaw_path(k)));
% 
%     addpoints(position_graph,time(k),position_t(k));
%     addpoints(velocity_graph,time(k),velocity_t(k));
%     addpoints(acceleration_graph,time(k),accelaeration_t(k));
%     
%     addpoints(q1_graph,time(k),theta(k,1))
%     addpoints(q2_graph,time(k),theta(k,2))
%     addpoints(q3_graph,time(k),theta(k,3))
%     addpoints(q4_graph,time(k),theta(k,4))
% 
%     addpoints(v1_graph,time(k),theta_dot(k,1))
%     addpoints(v2_graph,time(k),theta_dot(k,2))
%     addpoints(v3_graph,time(k),theta_dot(k,3))
%     addpoints(v4_graph,time(k),theta_dot(k,4))
% 
%     addpoints(a1_graph,time(k),theta_dot_dot(k,1))
%     addpoints(a2_graph,time(k),theta_dot_dot(k,2))
%     addpoints(a3_graph,time(k),theta_dot_dot(k,3))
%     addpoints(a4_graph,time(k),theta_dot_dot(k,4))
% 
%     drawnow 
%     pause(0.01)
% end
% 
% % update 
% theta = ikine(end_x,end_y,end_z,end_yaw);
% theta1_pre = theta(1);
% theta2_pre = theta(2);
% theta3_pre = theta(3);
% theta4_pre = theta(4);
% 
% set(handles.theta1_slider, 'value', theta(1));
% set(handles.theta2_slider, 'value', theta(2));
% set(handles.theta3_slider, 'value', theta(3));
% set(handles.theta4_slider, 'value', theta(4));
% 
% prev_x = end_x;
% prev_y = end_y;
% prev_z = end_z;
% prev_t = end_yaw;



% --- Executes on button press in joint_traj.
function joint_traj_Callback(hObject, eventdata, handles)
% hObject    handle to joint_traj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

global prev_x;
global prev_y;
global prev_z;
global prev_t;

global end_x;
global end_y;
global end_z;
global end_yaw;

global v1_max;
global v2_max;
global v3_max;
global v4_max;

global time_max;

cla(handles.axes_p)
cla(handles.axes_v)
cla(handles.axes_a)
cla(handles.axes_q1)
cla(handles.axes_q2)
cla(handles.axes_q3)
cla(handles.axes_q4)
cla(handles.axes_v1)
cla(handles.axes_v2)
cla(handles.axes_v3)
cla(handles.axes_v4)
cla(handles.axes_a1)
cla(handles.axes_a2)
cla(handles.axes_a3)
cla(handles.axes_a4)

time_segment = 50;

theta = ikine(end_x, end_y, end_z, end_yaw);

[joint1_position_t, joint1_velocity_t, joint1_accelaeration_t, v1, a1, time] =  joint_trajectory(theta1_pre,theta(1),v1_max,time_max,time_segment,1);
[joint2_position_t, joint2_velocity_t, joint2_accelaeration_t, v2, a2, time] =  joint_trajectory(theta2_pre,theta(2),v2_max,time_max,time_segment,2);
[joint3_position_t, joint3_velocity_t, joint3_accelaeration_t, v3, a3, time] =  joint_trajectory(theta3_pre,theta(3),v3_max,time_max,time_segment,3);
[joint4_position_t, joint4_velocity_t, joint4_accelaeration_t, v4, a4, time] =  joint_trajectory(theta4_pre,theta(4),v4_max,time_max,time_segment,4);

joint_position_t = [joint1_position_t;joint2_position_t;joint3_position_t;joint4_position_t];

q1_graph = animatedline(handles.axes_q1,'Color','blue','LineWidth',2);
if (theta1_pre < theta(1))
    axis(handles.axes_q1,[0 time_max theta1_pre theta(1)]), grid(handles.axes_q1,'on'), legend(handles.axes_q1,'theta1(t)')
elseif (theta1_pre == theta(1))
    axis(handles.axes_q1,[0 time_max theta1_pre-10 theta1_pre+10]), grid(handles.axes_q1,'on'), legend(handles.axes_q1,'theta1(t)')
else
    axis(handles.axes_q1,[0 time_max theta(1) theta1_pre]), grid(handles.axes_q1,'on'), legend(handles.axes_q1,'theta1(t)')
end

q2_graph = animatedline(handles.axes_q2,'Color','blue','LineWidth',2);
if (theta2_pre < theta(2))
    axis(handles.axes_q2,[0 time_max theta2_pre theta(2)]), grid(handles.axes_q2,'on'), legend(handles.axes_q2,'theta2(t)')
elseif (theta2_pre == theta(2))
    axis(handles.axes_q2,[0 time_max theta2_pre-10 theta2_pre+10]), grid(handles.axes_q2,'on'), legend(handles.axes_q2,'theta2(t)')
else
    axis(handles.axes_q2,[0 time_max theta(2) theta2_pre]), grid(handles.axes_q2,'on'), legend(handles.axes_q2,'theta2(t)')
end

q3_graph = animatedline(handles.axes_q3,'Color','blue','LineWidth',2);
if (theta3_pre < theta(3))

    axis(handles.axes_q3,[0 time_max theta3_pre theta(3)]), grid(handles.axes_q3,'on'), legend(handles.axes_q3,'theta3(t)')
elseif (theta3_pre == theta(3))
    axis(handles.axes_q3,[0 time_max theta3_pre-10 theta3_pre+10]), grid(handles.axes_q3,'on'), legend(handles.axes_q3,'theta1(t)')
else
    axis(handles.axes_q3,[0 time_max theta(3) theta3_pre]), grid(handles.axes_q3,'on'), legend(handles.axes_q3,'theta3(t)')
end

q4_graph = animatedline(handles.axes_q4,'Color','blue','LineWidth',2);
if (theta4_pre < theta(4))
    axis(handles.axes_q4,[0 time_max theta4_pre theta(4)]), grid(handles.axes_q4,'on'), legend(handles.axes_q4,'theta4(t)')
elseif (theta4_pre == theta(4))
    axis(handles.axes_q4,[0 time_max theta3_pre-10 theta3_pre+10]), grid(handles.axes_q4,'on'), legend(handles.axes_q4,'theta4(t)')
else
    axis(handles.axes_q4,[0 time_max theta(4) theta4_pre]), grid(handles.axes_q4,'on'), legend(handles.axes_q4,'theta4(t)')
end

v1_graph = animatedline(handles.axes_v1,'Color','blue','LineWidth',2);
if (v1 > 0)
    axis(handles.axes_v1,[0 time_max 0 v1]), grid(handles.axes_v1,'on'), legend(handles.axes_v1,'v1(t)')
elseif (v1 == 0)
    axis(handles.axes_v1,[0 time_max -10 10]), grid(handles.axes_v1,'on'), legend(handles.axes_v1,'v1(t)')    
else
    axis(handles.axes_v1,[0 time_max v1 0]), grid(handles.axes_v1,'on'), legend(handles.axes_v1,'v1(t)')
end

v2_graph = animatedline(handles.axes_v2,'Color','blue','LineWidth',2);
if (v2 > 0)
    axis(handles.axes_v2,[0 time_max 0 v2]), grid(handles.axes_v2,'on'), legend(handles.axes_v2,'v2(t)')
elseif (v2 == 0)
     axis(handles.axes_v2,[0 time_max -10 10]), grid(handles.axes_v2,'on'), legend(handles.axes_v2,'v2(t)')   
else 
    axis(handles.axes_v2,[0 time_max v2 0]), grid(handles.axes_v2,'on'), legend(handles.axes_v2,'v2(t)')   
end

v3_graph = animatedline(handles.axes_v3,'Color','blue','LineWidth',2);
if (v3 > 0)
    axis(handles.axes_v3,[0 time_max 0 v3]), grid(handles.axes_v3,'on'), legend(handles.axes_v3,'v3(t)')
elseif (v3 == 0)
     axis(handles.axes_v3,[0 time_max -10 10]), grid(handles.axes_v3,'on'), legend(handles.axes_v3,'v3(t)')   
else
    axis(handles.axes_v3,[0 time_max v3 0]), grid(handles.axes_v3,'on'), legend(handles.axes_v3,'v3(t)')    
end

v4_graph = animatedline(handles.axes_v4,'Color','blue','LineWidth',2);
if (v4 > 0)
    axis(handles.axes_v4,[0 time_max 0 v4]), grid(handles.axes_v4,'on'), legend(handles.axes_v4,'v4(t)')
elseif (v4 == 0)
    axis(handles.axes_v4,[0 time_max -10 10]), grid(handles.axes_v4,'on'), legend(handles.axes_v4,'v4(t)')    
else
    axis(handles.axes_v4,[0 time_max v4 0]), grid(handles.axes_v4,'on'), legend(handles.axes_v4,'v4(t)')
end

%%
a1_graph = animatedline(handles.axes_a1,'Color','blue','LineWidth',2);
if (a1 == 0)
    axis(handles.axes_a1,[0 time_max -10 10]), grid(handles.axes_a1,'on'), legend(handles.axes_a1,'a1(t)')    
else
    axis(handles.axes_a1,[0 time_max -abs(a1) abs(a1)]), grid(handles.axes_a1,'on'), legend(handles.axes_a1,'a1(t)')    
end

a2_graph = animatedline(handles.axes_a2,'Color','blue','LineWidth',2);
if (a2 == 0)
    axis(handles.axes_a2,[0 time_max -10 10]), grid(handles.axes_a2,'on'), legend(handles.axes_a2,'a2(t)')    
else
    axis(handles.axes_a2,[0 time_max -abs(a2) abs(a2)]), grid(handles.axes_a2,'on'), legend(handles.axes_a2,'a2(t)')    
end

a3_graph = animatedline(handles.axes_a3,'Color','blue','LineWidth',2);
if (a3 == 0)
    axis(handles.axes_a3,[0 time_max -10 10]), grid(handles.axes_a3,'on'), legend(handles.axes_a3,'a3(t)')    
else
    axis(handles.axes_a3,[0 time_max -abs(a3) abs(a3)]), grid(handles.axes_a3,'on'), legend(handles.axes_a3,'a3(t)')    
end

a4_graph = animatedline(handles.axes_a4,'Color','blue','LineWidth',2);
if (a4 == 0)
    axis(handles.axes_a4,[0 time_max -10 10]), grid(handles.axes_a4,'on'), legend(handles.axes_a4,'a4(t)')    
else
    axis(handles.axes_a4,[0 time_max -abs(a4) abs(a4)]), grid(handles.axes_a4,'on'), legend(handles.axes_a4,'a4(t)')    
end
%%

x_path = zeros(1,time_segment);
y_path = zeros(1,time_segment);
z_path = zeros(1,time_segment);
t_path = zeros(1,time_segment);

for i = 1:time_segment
    [x_path(i),y_path(i),z_path(i),t_path(i)] = fkine(joint_position_t(1,i),joint_position_t(2,i),joint_position_t(3,i),joint_position_t(4,i));
end
path_x = x_path/1000;
path_y = y_path/1000;
path_z = z_path/1000;

path = [path_x; path_y; path_z];

x_graph = animatedline(handles.axes_p,'Color','blue','LineWidth',2);
axis(handles.axes_p,[0 time_max -700 700]), grid(handles.axes_p,'on'), legend(handles.axes_p,'x(t)')


y_graph = animatedline(handles.axes_v,'Color','blue','LineWidth',2);
axis(handles.axes_v,[0 time_max -700 700]), grid(handles.axes_v,'on'), legend(handles.axes_v,'y(t)')


z_graph = animatedline(handles.axes_a,'Color','blue','LineWidth',2);
axis(handles.axes_a,[0 time_max 0 700]), grid(handles.axes_a,'on'), legend(handles.axes_a,'z(t)')

for k = 1:time_segment
    draw_robot_path(handles,joint_position_t(:,k),alpha,frames_on,show_work_space,[caz,cel],path,k)
    set(handles.theta1_textBox,'string',num2str(joint_position_t(1,k)));
    set(handles.theta2_textBox,'string',num2str(joint_position_t(2,k)));
    set(handles.theta3_textBox,'string',num2str(joint_position_t(3,k)));
    set(handles.theta4_textBox,'string',num2str(joint_position_t(4,k)));

    set(handles.x,'string',num2str(x_path(k)));
    set(handles.y,'string',num2str(y_path(k)));
    set(handles.z,'string',num2str(z_path(k)));
    set(handles.yaw,'string',num2str(t_path(k)));

    addpoints(x_graph,time(k),x_path(k));
    addpoints(y_graph,time(k),y_path(k));
    addpoints(z_graph,time(k),z_path(k));
    
    addpoints(q1_graph,time(k),joint1_position_t(k))
    addpoints(q2_graph,time(k),joint2_position_t(k))
    addpoints(q3_graph,time(k),joint3_position_t(k))
    addpoints(q4_graph,time(k),joint4_position_t(k))

    addpoints(v1_graph,time(k),joint1_velocity_t(k))
    addpoints(v2_graph,time(k),joint2_velocity_t(k))
    addpoints(v3_graph,time(k),joint3_velocity_t(k))
    addpoints(v4_graph,time(k),joint4_velocity_t(k))

    addpoints(a1_graph,time(k),joint1_accelaeration_t(k))
    addpoints(a2_graph,time(k),joint2_accelaeration_t(k))
    addpoints(a3_graph,time(k),joint3_accelaeration_t(k))
    addpoints(a4_graph,time(k),joint4_accelaeration_t(k))

    drawnow 
    pause(0.01)
end

% update 
theta1_pre = theta(1);
theta2_pre = theta(2);
theta3_pre = theta(3);
theta4_pre = theta(4);

set(handles.theta1_slider, 'value', theta(1));
set(handles.theta2_slider, 'value', theta(2));
set(handles.theta3_slider, 'value', theta(3));
set(handles.theta4_slider, 'value', theta(4));

prev_x = end_x;
prev_y = end_y;
prev_z = end_z;
prev_t = end_yaw;

% --- Executes on button press in scurve.
function scurve_Callback(hObject, eventdata, handles)
% hObject    handle to scurve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global show_work_space;
global alpha;
global frames_on;

[caz,cel] = view(handles.axes1);

global theta1_pre;
global theta2_pre;
global theta3_pre;
global theta4_pre;

global prev_x;
global prev_y;
global prev_z;
global prev_t;

global end_x;
global end_y;
global end_z;
global end_yaw;

global v1_max;
global v2_max;
global v3_max;
global v4_max;

global time_max;

cla(handles.axes_p)
cla(handles.axes_v)
cla(handles.axes_a)
cla(handles.axes_q1)
cla(handles.axes_q2)
cla(handles.axes_q3)
cla(handles.axes_q4)
cla(handles.axes_v1)
cla(handles.axes_v2)
cla(handles.axes_v3)
cla(handles.axes_v4)
cla(handles.axes_a1)
cla(handles.axes_a2)
cla(handles.axes_a3)
cla(handles.axes_a4)

time_segment = 50;

theta = ikine(end_x, end_y, end_z, end_yaw);

[joint1_position_t, joint1_velocity_t,joint1_accelaeration_t, v1, a1, time] =  scurve_joint_trajectory(theta1_pre,theta(1),v1_max,time_max,time_segment,1);
[joint2_position_t, joint2_velocity_t,joint2_accelaeration_t, v2, a2, time] =  scurve_joint_trajectory(theta2_pre,theta(2),v2_max,time_max,time_segment,2);
[joint3_position_t, joint3_velocity_t,joint3_accelaeration_t, v3, a3, time] =  scurve_joint_trajectory(theta3_pre,theta(3),v3_max,time_max,time_segment,3);
[joint4_position_t, joint4_velocity_t,joint4_accelaeration_t, v4, a4, time] =  scurve_joint_trajectory(theta4_pre,theta(4),v4_max,time_max,time_segment,4);

joint_position_t = [joint1_position_t;joint2_position_t;joint3_position_t;joint4_position_t];

q1_graph = animatedline(handles.axes_q1,'Color','blue','LineWidth',2);
if (theta1_pre < theta(1))
    axis(handles.axes_q1,[0 time_max theta1_pre theta(1)]), grid(handles.axes_q1,'on'), legend(handles.axes_q1,'theta1(t)')
elseif (theta1_pre == theta(1))
    axis(handles.axes_q1,[0 time_max theta1_pre-10 theta1_pre+10]), grid(handles.axes_q1,'on'), legend(handles.axes_q1,'theta1(t)')
else
    axis(handles.axes_q1,[0 time_max theta(1) theta1_pre]), grid(handles.axes_q1,'on'), legend(handles.axes_q1,'theta1(t)')
end

q2_graph = animatedline(handles.axes_q2,'Color','blue','LineWidth',2);
if (theta2_pre < theta(2))
    axis(handles.axes_q2,[0 time_max theta2_pre theta(2)]), grid(handles.axes_q2,'on'), legend(handles.axes_q2,'theta2(t)')
elseif (theta2_pre == theta(2))
    axis(handles.axes_q2,[0 time_max theta2_pre-10 theta2_pre+10]), grid(handles.axes_q2,'on'), legend(handles.axes_q2,'theta2(t)')
else
    axis(handles.axes_q2,[0 time_max theta(2) theta2_pre]), grid(handles.axes_q2,'on'), legend(handles.axes_q2,'theta2(t)')
end

q3_graph = animatedline(handles.axes_q3,'Color','blue','LineWidth',2);
if (theta3_pre < theta(3))

    axis(handles.axes_q3,[0 time_max theta3_pre theta(3)]), grid(handles.axes_q3,'on'), legend(handles.axes_q3,'theta3(t)')
elseif (theta3_pre == theta(3))
    axis(handles.axes_q3,[0 time_max theta3_pre-10 theta3_pre+10]), grid(handles.axes_q3,'on'), legend(handles.axes_q3,'theta1(t)')
else
    axis(handles.axes_q3,[0 time_max theta(3) theta3_pre]), grid(handles.axes_q3,'on'), legend(handles.axes_q3,'theta3(t)')
end

q4_graph = animatedline(handles.axes_q4,'Color','blue','LineWidth',2);
if (theta4_pre < theta(4))
    axis(handles.axes_q4,[0 time_max theta4_pre theta(4)]), grid(handles.axes_q4,'on'), legend(handles.axes_q4,'theta4(t)')
elseif (theta4_pre == theta(4))
    axis(handles.axes_q4,[0 time_max theta3_pre-10 theta3_pre+10]), grid(handles.axes_q4,'on'), legend(handles.axes_q4,'theta4(t)')
else
    axis(handles.axes_q4,[0 time_max theta(4) theta4_pre]), grid(handles.axes_q4,'on'), legend(handles.axes_q4,'theta4(t)')
end

v1_graph = animatedline(handles.axes_v1,'Color','blue','LineWidth',2);
if (v1 > 0)
    axis(handles.axes_v1,[0 time_max 0 v1]), grid(handles.axes_v1,'on'), legend(handles.axes_v1,'v1(t)')
elseif (v1 == 0)
    axis(handles.axes_v1,[0 time_max -10 10]), grid(handles.axes_v1,'on'), legend(handles.axes_v1,'v1(t)')    
else
    axis(handles.axes_v1,[0 time_max v1 0]), grid(handles.axes_v1,'on'), legend(handles.axes_v1,'v1(t)')
end

v2_graph = animatedline(handles.axes_v2,'Color','blue','LineWidth',2);
if (v2 > 0)
    axis(handles.axes_v2,[0 time_max 0 v2]), grid(handles.axes_v2,'on'), legend(handles.axes_v2,'v2(t)')
elseif (v2 == 0)
     axis(handles.axes_v2,[0 time_max -10 10]), grid(handles.axes_v2,'on'), legend(handles.axes_v2,'v2(t)')   
else 
    axis(handles.axes_v2,[0 time_max v2 0]), grid(handles.axes_v2,'on'), legend(handles.axes_v2,'v2(t)')   
end

v3_graph = animatedline(handles.axes_v3,'Color','blue','LineWidth',2);
if (v3 > 0)
    axis(handles.axes_v3,[0 time_max 0 v3]), grid(handles.axes_v3,'on'), legend(handles.axes_v3,'v3(t)')
elseif (v3 == 0)
     axis(handles.axes_v3,[0 time_max -10 10]), grid(handles.axes_v3,'on'), legend(handles.axes_v3,'v3(t)')   
else
    axis(handles.axes_v3,[0 time_max v3 0]), grid(handles.axes_v3,'on'), legend(handles.axes_v3,'v3(t)')    
end

v4_graph = animatedline(handles.axes_v4,'Color','blue','LineWidth',2);
if (v4 > 0)
    axis(handles.axes_v4,[0 time_max 0 v4]), grid(handles.axes_v4,'on'), legend(handles.axes_v4,'v4(t)')
elseif (v4 == 0)
    axis(handles.axes_v4,[0 time_max -10 10]), grid(handles.axes_v4,'on'), legend(handles.axes_v4,'v4(t)')    
else
    axis(handles.axes_v4,[0 time_max v4 0]), grid(handles.axes_v4,'on'), legend(handles.axes_v4,'v4(t)')
end

%%
a1_graph = animatedline(handles.axes_a1,'Color','blue','LineWidth',2);
if (a1 == 0)
    axis(handles.axes_a1,[0 time_max -10 10]), grid(handles.axes_a1,'on'), legend(handles.axes_a1,'a1(t)')    
else
    axis(handles.axes_a1,[0 time_max -abs(a1) abs(a1)]), grid(handles.axes_a1,'on'), legend(handles.axes_a1,'a1(t)')    
end

a2_graph = animatedline(handles.axes_a2,'Color','blue','LineWidth',2);
if (a2 == 0)
    axis(handles.axes_a2,[0 time_max -10 10]), grid(handles.axes_a2,'on'), legend(handles.axes_a2,'a2(t)')    
else
    axis(handles.axes_a2,[0 time_max -abs(a2) abs(a2)]), grid(handles.axes_a2,'on'), legend(handles.axes_a2,'a2(t)')    
end

a3_graph = animatedline(handles.axes_a3,'Color','blue','LineWidth',2);
if (a3 == 0)
    axis(handles.axes_a3,[0 time_max -10 10]), grid(handles.axes_a3,'on'), legend(handles.axes_a3,'a3(t)')    
else
    axis(handles.axes_a3,[0 time_max -abs(a3) abs(a3)]), grid(handles.axes_a3,'on'), legend(handles.axes_a3,'a3(t)')    
end

a4_graph = animatedline(handles.axes_a4,'Color','blue','LineWidth',2);
if (a4 == 0)
    axis(handles.axes_a4,[0 time_max -10 10]), grid(handles.axes_a4,'on'), legend(handles.axes_a4,'a4(t)')    
else
    axis(handles.axes_a4,[0 time_max -abs(a4) abs(a4)]), grid(handles.axes_a4,'on'), legend(handles.axes_a4,'a4(t)')    
end

%%

x_path = zeros(1,time_segment);
y_path = zeros(1,time_segment);
z_path = zeros(1,time_segment);
t_path = zeros(1,time_segment);

for i = 1:time_segment
    [x_path(i),y_path(i),z_path(i),t_path(i)] = fkine(joint_position_t(1,i),joint_position_t(2,i),joint_position_t(3,i),joint_position_t(4,i));
end
path_x = x_path/1000;
path_y = y_path/1000;
path_z = z_path/1000;

path = [path_x; path_y; path_z];

x_graph = animatedline(handles.axes_p,'Color','blue','LineWidth',2);
axis(handles.axes_p,[0 time_max -700 700]), grid(handles.axes_p,'on'), legend(handles.axes_p,'x(t)')


y_graph = animatedline(handles.axes_v,'Color','blue','LineWidth',2);
axis(handles.axes_v,[0 time_max -700 700]), grid(handles.axes_v,'on'), legend(handles.axes_v,'y(t)')


z_graph = animatedline(handles.axes_a,'Color','blue','LineWidth',2);
axis(handles.axes_a,[0 time_max 0 700]), grid(handles.axes_a,'on'), legend(handles.axes_a,'z(t)')

for k = 1:time_segment
    draw_robot_path(handles,joint_position_t(:,k),alpha,frames_on,show_work_space,[caz,cel],path,k)
    set(handles.theta1_textBox,'string',num2str(joint_position_t(1,k)));
    set(handles.theta2_textBox,'string',num2str(joint_position_t(2,k)));
    set(handles.theta3_textBox,'string',num2str(joint_position_t(3,k)));
    set(handles.theta4_textBox,'string',num2str(joint_position_t(4,k)));

    set(handles.x,'string',num2str(x_path(k)));
    set(handles.y,'string',num2str(y_path(k)));
    set(handles.z,'string',num2str(z_path(k)));
    set(handles.yaw,'string',num2str(t_path(k)));

    addpoints(x_graph,time(k),x_path(k));
    addpoints(y_graph,time(k),y_path(k));
    addpoints(z_graph,time(k),z_path(k));
    
    addpoints(q1_graph,time(k),joint1_position_t(k))
    addpoints(q2_graph,time(k),joint2_position_t(k))
    addpoints(q3_graph,time(k),joint3_position_t(k))
    addpoints(q4_graph,time(k),joint4_position_t(k))

    addpoints(v1_graph,time(k),joint1_velocity_t(k))
    addpoints(v2_graph,time(k),joint2_velocity_t(k))
    addpoints(v3_graph,time(k),joint3_velocity_t(k))
    addpoints(v4_graph,time(k),joint4_velocity_t(k))

    addpoints(a1_graph,time(k),joint1_accelaeration_t(k))
    addpoints(a2_graph,time(k),joint2_accelaeration_t(k))
    addpoints(a3_graph,time(k),joint3_accelaeration_t(k))
    addpoints(a4_graph,time(k),joint4_accelaeration_t(k))

    drawnow 
    pause(0.01)
end

% update 
theta1_pre = theta(1);
theta2_pre = theta(2);
theta3_pre = theta(3);
theta4_pre = theta(4);

set(handles.theta1_slider, 'value', theta(1));
set(handles.theta2_slider, 'value', theta(2));
set(handles.theta3_slider, 'value', theta(3));
set(handles.theta4_slider, 'value', theta(4));

prev_x = end_x;
prev_y = end_y;
prev_z = end_z;
prev_t = end_yaw;


function end_x_Callback(hObject, eventdata, handles)
% hObject    handle to end_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global end_x;
end_x = str2double(handles.end_x.String);
% Hints: get(hObject,'String') returns contents of end_x as text
%        str2double(get(hObject,'String')) returns contents of end_x as a double


% --- Executes during object creation, after setting all properties.
function end_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end_y_Callback(hObject, eventdata, handles)
% hObject    handle to end_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global end_y;
end_y = str2double(handles.end_y.String);
% Hints: get(hObject,'String') returns contents of end_y as text
%        str2double(get(hObject,'String')) returns contents of end_y as a double


% --- Executes during object creation, after setting all properties.
function end_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end_z_Callback(hObject, eventdata, handles)
% hObject    handle to end_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global end_z;
end_z = str2double(handles.end_z.String);
% Hints: get(hObject,'String') returns contents of end_z as text
%        str2double(get(hObject,'String')) returns contents of end_z as a double


% --- Executes during object creation, after setting all properties.
function end_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end_yaw_Callback(hObject, eventdata, handles)
% hObject    handle to end_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global end_yaw;
end_yaw = str2double(handles.end_yaw.String);
% Hints: get(hObject,'String') returns contents of end_yaw as text
%        str2double(get(hObject,'String')) returns contents of end_yaw as a double


% --- Executes during object creation, after setting all properties.
function end_yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% function v_max_Callback(hObject, eventdata, handles)
% % hObject    handle to v_max (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% global v_max;
% v_max = str2double(handles.v_max.String);
% 
% % Hints: get(hObject,'String') returns contents of v_max as text
% %        str2double(get(hObject,'String')) returns contents of v_max as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function v_max_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to v_max (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function a_max_Callback(hObject, eventdata, handles)
% % hObject    handle to a_max (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global a_max;
% a_max = str2double(handles.a_max.String);
% % Hints: get(hObject,'String') returns contents of a_max as text
% %        str2double(get(hObject,'String')) returns contents of a_max as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function a_max_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to a_max (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function time_max_Callback(hObject, eventdata, handles)
% hObject    handle to time_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global time_max;
time_max = str2double(handles.time_max.String);

% Hints: get(hObject,'String') returns contents of time_max as text
%        str2double(get(hObject,'String')) returns contents of time_max as a double


% --- Executes during object creation, after setting all properties.
function time_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v1_max_Callback(hObject, eventdata, handles)
% hObject    handle to v1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global v1_max;
v1_max = str2double(handles.v1_max.String);

% Hints: get(hObject,'String') returns contents of v1_max as text
%        str2double(get(hObject,'String')) returns contents of v1_max as a double


% --- Executes during object creation, after setting all properties.
function v1_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v2_max_Callback(hObject, eventdata, handles)
% hObject    handle to v2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global v2_max;
v2_max = str2double(handles.v2_max.String);

% Hints: get(hObject,'String') returns contents of v2_max as text
%        str2double(get(hObject,'String')) returns contents of v2_max as a double


% --- Executes during object creation, after setting all properties.
function v2_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v3_max_Callback(hObject, eventdata, handles)
% hObject    handle to v3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global v3_max;
v3_max = str2double(handles.v3_max.String);

% Hints: get(hObject,'String') returns contents of v3_max as text
%        str2double(get(hObject,'String')) returns contents of v3_max as a double


% --- Executes during object creation, after setting all properties.
function v3_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v4_max_Callback(hObject, eventdata, handles)
% hObject    handle to v4_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global v4_max;
v4_max = str2double(handles.v4_max.String);

% Hints: get(hObject,'String') returns contents of v4_max as text
%        str2double(get(hObject,'String')) returns contents of v4_max as a double


% --- Executes during object creation, after setting all properties.
function v4_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v4_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
