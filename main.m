function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 24-May-2018 02:50:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PB_train.
function PB_train_Callback(hObject, eventdata, handles)
% hObject    handle to PB_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global deepnet;

deepnet = train();

% --- Executes on button press in PB_arsitek.
function PB_arsitek_Callback(hObject, eventdata, handles)
% hObject    handle to PB_arsitek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PB_showimg.
function PB_showimg_Callback(hObject, eventdata, handles)
% hObject    handle to PB_showimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(c, 'Visible', 'on');




% --- Executes on button press in PB_import.
function PB_import_Callback(hObject, eventdata, handles)
% hObject    handle to PB_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global citra

[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png';},'Pilih Gambar');

if ~isequal(filename,0)
    citra = imread(fullfile(pathname, filename));
    
    guidata(hObject,handles);
    axes(handles.G1);
    imshow(citra);
    title('Citra Asli');
    disp('Open Gambar: ');
else
    return;
end


% --- Executes on button press in PB_preprocessing.
function PB_preprocessing_Callback(hObject, eventdata, handles)
% hObject    handle to PB_preprocessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global citra
global citra_preprocessing
global det_fig

[prep, detail] = preprocessing(citra);
    
guidata(hObject,handles);
axes(handles.G2);
imshow(prep);

citra_preprocessing = prep;
det_fig = detail;

% --- Executes on button press in PB_segmentasi.
function PB_segmentasi_Callback(hObject, eventdata, handles)
% hObject    handle to PB_segmentasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global citra_preprocessing

chars = segmentasi(citra_preprocessing);
char = regionprops(chars,'BoundingBox', 'Area', 'Eccentricity','Centroid');

guidata(hObject,handles);
axes(handles.G3);
imshow(chars);

for i=1:size(char,1)
    tes(i) = char(i).Eccentricity;
    if (char(i).Area>=235)&&(char(i).Eccentricity>=0.800)&&(char(i).Eccentricity<=0.990)
        cfix{i} = char(i).BoundingBox;
        rectangle('Position', char(i).BoundingBox,'edgecolor','blue');
    end
end

% --- Executes on button press in PB_recog.
function PB_recog_Callback(hObject, eventdata, handles)
% hObject    handle to PB_recog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global deepnet;

[result, sample] = recognize(deepnet);
set(handles.T_plat, 'String', result);

prompt = sprintf('Nomor polisi kendaraan adalah: %s , apakah pengenalan yang diberikan tepat? y/n [y]', result);
str = input(prompt, 's');

if isempty(str)
    str = 'y';
end

if str == 'y' || str == 'Y'
    return;
else
    prompt = sprintf('Mohon masukkan nomor yang seharusnya: ');
    str = input(prompt, 's');
    
    move_to_train(0, result, str, sample);
    deepnet = train();
    return;
end
