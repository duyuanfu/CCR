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

% Last Modified by GUIDE v2.5 19-Dec-2020 20:05:52

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
[filename pathname] = uigetfile({'*.jpg; *.bmp'}, '打开图片', '..\image\ori_img');
imagePath = [pathname filename];
set(handles.text1, 'String', imagePath);
image = imread(imagePath);
axes(handles.axes1);
imshow(image);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_bin.
function pushbutton_bin_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagePath = get(handles.text1,'String');
imagePath = Binaryzation(imagePath);
set(handles.text1, 'String', imagePath);
image = imread(imagePath);
axes(handles.axes1);
imshow(image);


% --- Executes on button press in pushbutton_elm.
function pushbutton_elm_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_elm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagePath = get(handles.text1,'String');
imagePath = EliminatNoise(imagePath);
set(handles.text1, 'String', imagePath);
image = imread(imagePath);
axes(handles.axes1);
imshow(image);


% --- Executes on button press in pushbutton_seg.
function pushbutton_seg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_seg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagePath = get(handles.text1,'String');

[imagePath, rowCount, chineseCount]= Segmentation(imagePath);
set(handles.text1, 'String', imagePath);
imageNull = logical(1 * ones(48, 48));
imageBack = uint8(255 * ones(300, 500));
imshow(imageBack);

axes(handles.axes1);
hold on
for i = 1 : 10
    for j = 1 : 6
        if (10 * (j - 1) + i)  <= chineseCount       
            image = imread([imagePath, num2str(10 * (j - 1) + i), '.bmp']);
%             image = imageNull1;
        else
            image = imageNull;
        end
        imshow(image, 'Parent', handles.axes1,...
            'XData',[1 + 50 * (i - 1), 50 * i - 1],...
            'YData',[1 + 50 * (j - 1), 50 * j - 1]);
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
imagePath = get(handles.text1,'String');
chineseCount = 14;

% 将结果写入文件
folder='../image/res_img/';
if ~exist(folder,'dir')
	mkdir(folder)
end
outputPath = [folder, '1.bmp'];

for i = 1 : chineseCount
    resultImage  = logical(Recognition([imagePath, num2str(i), '.bmp']));
    imwrite(resultImage, [folder, num2str(i), '.bmp']);
end
set(handles.text1, 'String', folder); 

% 初始化axes背景
imageBack = uint8(255 * ones(300, 500));
imshow(imageBack);

imageNull = logical(1 * ones(48, 48));
% 绘图
axes(handles.axes1);
hold on
for i = 1 : 10
    for j = 1 : 6
        if (10 * (j - 1) + i)  <= chineseCount       
            image = imread([folder, num2str(10 * (j - 1) + i), '.bmp']);
        else
            image = imageNull;
        end
        imshow(image, 'Parent', handles.axes1,...
            'XData',[1 + 50 * (i - 1), 50 * i - 1],...
            'YData',[1 + 50 * (j - 1), 50 * j - 1]);
    end
end
hold off
handles.axes1.XLim = [0, 500];
handles.axes1.YLim = [0, 300];


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XColor',get(gca,'Color')) ;% 这两行代码功能：将坐标轴和坐标刻度转为白色
set(gca,'YColor',get(gca,'Color'));
 
set(gca,'XTickLabel',[]); % 这两行代码功能：去除坐标刻度
set(gca,'YTickLabel',[]);

% Hint: place code in OpeningFcn to populate axes1
