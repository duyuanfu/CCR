function varargout = GUI(varargin)
% CCR_GUI MATLAB code for CCR_GUI.fig
%      CCR_GUI, by itself, creates a new CCR_GUI or raises the existing
%      singleton*.
%
%      H = CCR_GUI returns the handle to a new CCR_GUI or the handle to
%      the existing singleton*.
%
%      CCR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CCR_GUI.M with the given input arguments.
%
%      CCR_GUI('Property','Value',...) creates a new CCR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CCR_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CCR_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CCR_GUI

% Last Modified by GUIDE v2.5 20-Dec-2020 22:23:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CCR_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CCR_GUI_OutputFcn, ...
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


% --- Executes just before CCR_GUI is made visible.
function CCR_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CCR_GUI (see VARARGIN)

% Choose default command line output for CCR_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CCR_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global chineseCount; % �ָ�����?
chineseCount = 0;
global inputPath; % ���Ƭ�ĵ��
inputPath = '';
global binPath; % ��ֵ�����ͼƬ�ĵ��
binPath = '';
global eliPath; % �����ͼƬ�ĵ��
eliPath = '';
global segPath; % �ָ��Ƭ�ĵ��
segPath = '';
global resPath; % ��ͼƬ�ĵ��?
resPath = '';

% --- Outputs from this function are returned to the command line.
function varargout = CCR_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_open.
function pushbutton_open_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg; *.bmp'}, '����?', '..\image\ori_img');
global inputPath;
inputPath = [pathname, filename];
set(handles.edit1, 'String', inputPath);
image = imread(inputPath);
axes(handles.axes1);
imshow(image);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_bin.
function pushbutton_bin_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagePath = get(handles.edit1,'String');
global inputPath;
global binPath;

binPath = Binaryzation(inputPath);
set(handles.edit1, 'String', binPath);
image = imread(binPath);
axes(handles.axes1);
imshow(image);


% --- Executes on button press in pushbutton_elm.
function pushbutton_elm_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_elm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagePath = get(handles.edit1,'String');
global binPath;
global eliPath;
eliPath = EliminatNoise(binPath);
set(handles.edit1, 'String', eliPath);
image = imread(eliPath);
axes(handles.axes1);
imshow(image);


% --- Executes on button press in pushbutton_seg.
function pushbutton_seg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagePath = get(handles.edit1,'String');
global chineseCount;
global eliPath;
global segPath;
[segPath, rowCount, chineseCount] = Segmentation(eliPath);
set(handles.edit1, 'String', segPath);
pageNum = ceil(chineseCount / 60);
set(handles.slider,'Min', 0, 'Max', pageNum, 'Value', pageNum);
draw(segPath, chineseCount, handles, 1);


function draw(imagePath, chineseCount, handles, pageNum)
imageNull = logical(1 * ones(48, 48));
imageBack = logical(1 * ones(300, 500));

axes(handles.axes1);
% ���������?
imshow(imageBack);

hold on

for i = 1 : 10
    for j = 1 : 6
        if (10 * (j - 1) + i + (pageNum - 1) * 60)  <= chineseCount       
            image = imread([imagePath, num2str(10 * (j - 1) + i + (pageNum - 1) * 60), '.bmp']);
        else
            image = imageNull;
        end
        imshow(image, 'Parent', handles.axes1,...
            'XData',[5 + 50 * (i - 1), 50 * i - 5],...
            'YData',[5 + 50 * (j - 1), 50 * j - 5]);     
    end
end

hold off
handles.axes1.XLim = [0, 500];
handles.axes1.YLim = [0, 300];




% --- Executes on button press in pushbutton_reg.
function pushbutton_reg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagePath = get(handles.edit1,'String');

global chineseCount;
global segPath;
global resPath;
% ����д����
resPath='../image/res_img/';
if ~exist(resPath, 'dir')
	mkdir(resPath);
end

str ='';
for i = 1 : chineseCount
    [resultImage, resultChar] = Recognition([segPath, num2str(i), '.bmp']);
    resultImage  = logical(resultImage);
    imwrite(resultImage, [resPath, num2str(i), '.bmp']);
    set(handles.edit4, 'String', [str, resultChar]); 
    str = get(handles.edit4, 'String'); 
end
set(handles.edit1, 'String', resPath); 
draw(resPath, chineseCount, handles, 1);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XColor',get(gca,'Color')) ;% �����빦���������������Ϊ���
set(gca,'YColor',get(gca,'Color'));
 
set(gca,'XTickLabel',[]); % �����빦���ȥ����̶�set(gca,'YTickLabel',[]);

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(hObject, 'value'); %ͨ��et���������ĵ�ǰֵ
val = floor(val);
val = get(hObject, 'Max') - val;
global chineseCount;
imagePath = get(handles.edit1,'String');
draw(imagePath, chineseCount, handles, val);


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
