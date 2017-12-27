function varargout = firstGUI(varargin)
% FIRSTGUI MATLAB code for firstGUI.fig
%      FIRSTGUI, by itself, creates a new FIRSTGUI or raises the existing
%      singleton*.
%
%      H = FIRSTGUI returns the handle to a new FIRSTGUI or the handle to
%      the existing singleton*.
%
%      FIRSTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRSTGUI.M with the given input arguments.
%
%      FIRSTGUI('Property','Value',...) creates a new FIRSTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before firstGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to firstGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help firstGUI

% Last Modified by GUIDE v2.5 25-Mar-2017 18:13:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @firstGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @firstGUI_OutputFcn, ...
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


% --- Executes just before firstGUI is made visible.
function firstGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to firstGUI (see VARARGIN)

% Choose default command line output for firstGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global originalImageNxM;
global encryptedImage;
global decryptedImage;
global rows;
global columns;
global secretKey;
global s;
global q;
global N;

clear global originalImageNxM;
clear global encryptedImage;
clear global decryptedImage;
clear global s;
clear global q;
clear global rows;
clear global columns;

%originalImageNxM = imread('cameraman.jpg');
%imshow(originalImageNxM, 'Parent', handles.axes1);

%originalImageNxM = imread('C:\Users\Akshay Khushu\Documents\MATLAB\cameraman.jpg');



% UIWAIT makes firstGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = firstGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImageNxM;
global encryptedImage;
global decryptedImage;
global secretKey;
global rows;
global columns;
global s;
global q;
global N;
[encryptedImage, s, q] = Encryption(originalImageNxM, secretKey);
imshow(encryptedImage, 'Parent', handles.axes2);
histogram(encryptedImage, 'Parent', handles.axes4);
pixels = rows*columns;
set(handles.edit3, 'string', num2str(pixels));
k=1;
for i=50:49+N
    xencrypted(k) = encryptedImage(110,i);
    k=k+1;
end
k=1;
for i=51:50+N
    yencrypted(k) = encryptedImage(110,i);
    k=k+1;
end
correlationEncrypted = correlationCoefficient(xencrypted,yencrypted,N);
set(handles.edit6, 'string', num2str(correlationEncrypted));

k=1;
for i=50:49+N
    xencrypted(k) = encryptedImage(i,110);
    k=k+1;
end
k=1;
for i=51:50+N
    yencrypted(k) = encryptedImage(i,110);
    k=k+1;
end
correlationEncrypted = correlationCoefficient(xencrypted,yencrypted,N);
set(handles.edit9, 'string', num2str(correlationEncrypted));
    


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global encryptedImage;
clear global decryptedImage;
clear global rows;
clear global columns;

global originalImageNxM;
global encryptedImage;
global secretKey;
global rows;
global columns;
global decryptedImage;
global s;
global q;
global N;

[FileName, PathName] = uigetfile('*.jpg', ' Select the Image to be encrypted','C:\Users\Akshay Khushu\Documents\MATLAB\cameraman.jpg');
originalImageNxM = imread(FileName);
N=100;

%Delete all values on screen
axesHandlesToChildObjects = findobj(handles.axes2, 'Type', 'image');
if ~isempty(axesHandlesToChildObjects)
	delete(axesHandlesToChildObjects);
end
axesHandlesToChildObjects = findobj(handles.axes4, 'Type', 'histogram');
if ~isempty(axesHandlesToChildObjects)
	delete(axesHandlesToChildObjects);
end
axesHandlesToChildObjects = findobj(handles.axes5, 'Type', 'image');
if ~isempty(axesHandlesToChildObjects)
	delete(axesHandlesToChildObjects);
end
axesHandlesToChildObjects = findobj(handles.axes6, 'Type', 'histogram');
if ~isempty(axesHandlesToChildObjects)
	delete(axesHandlesToChildObjects);
end
axesHandlesToChildObjects = findobj(handles.axes1, 'Type', 'image');
if ~isempty(axesHandlesToChildObjects)
	delete(axesHandlesToChildObjects);
end
axesHandlesToChildObjects = findobj(handles.axes3, 'Type', 'histogram');
if ~isempty(axesHandlesToChildObjects)
	delete(axesHandlesToChildObjects);
end
set(handles.edit2, 'string', num2str(0));
set(handles.edit3, 'string', num2str(0));
set(handles.edit4, 'string', num2str(0));
set(handles.edit5, 'string', num2str(0));
set(handles.edit6, 'string', num2str(0));
set(handles.edit7, 'string', num2str(0));
set(handles.edit8, 'string', num2str(0));
set(handles.edit9, 'string', num2str(0));
set(handles.edit10, 'string', num2str(0));

[rows,columns,depth] = size(originalImageNxM);
if rows<columns
        columns = rows;
    else
        rows = columns; 
end

r1S = get(handles.editR1, 'string');
r1 = str2double(r1S);

r2S = get(handles.editR2, 'string');
r2 = str2double(r2S);

X01S = get(handles.editX01, 'string');
X01 = str2double(X01S);

X02S = get(handles.editX02, 'string');
X02 = str2double(X02S);

m1S = get(handles.editM1, 'string');
m1 = str2double(m1S);

m2S = get(handles.editM2, 'string');
m2 = str2double(m2S);

ivS = get(handles.editIV, 'string');
iv = str2double(ivS);

secretKey = [r1 r2 X01 X02 m1 m2 iv];
for i=1:rows
    for j=1:columns
        originalImageNxMg(i,j) = originalImageNxM(i,j,1);
    end
end
pixels = rows*columns;
set(handles.edit2, 'string', num2str(pixels));

imshow(originalImageNxMg, 'Parent', handles.axes1);
histogram(originalImageNxMg, 'Parent', handles.axes3);
k=1;
for i=50:49+N
    xoriginalImage(k) = originalImageNxMg(110,i);
    k=k+1;
end
k=1;
for i=51:50+N
    yoriginalImage(k) = originalImageNxMg(110,i);
    k=k+1;
end
correlationOriginal = correlationCoefficient(xoriginalImage,yoriginalImage,N);
set(handles.edit5, 'string', num2str(correlationOriginal));
k=1;
for i=50:49+N
    xoriginalImage(k) = originalImageNxMg(i,110);
    k=k+1;
end
k=1;
for i=51:50+N
    yoriginalImage(k) = originalImageNxMg(i,110);
    k=k+1;
end
correlationOriginal = correlationCoefficient(xoriginalImage,yoriginalImage,N);
set(handles.edit8, 'string', num2str(correlationOriginal));

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImageNxM;
global encryptedImage;
global decryptedImage;
global rows;
global columns;
global secretKey;
global s;
global N;
global q;

decryptedImage = Decryption(originalImageNxM, encryptedImage, secretKey, q);
imshow(decryptedImage, 'Parent', handles.axes5);
histogram(decryptedImage, 'Parent', handles.axes6);
pixels = rows*columns;
set(handles.edit4, 'string', num2str(pixels));
k=1;
for i=50:49+N
    xdecrypted(k) = decryptedImage(110,i);
    k=k+1;
end
k=1;
for i=51:50+N
    ydecrypted(k) = decryptedImage(110,i);
    k=k+1;
end
correlationDecrypted = correlationCoefficient(xdecrypted,ydecrypted,N);
set(handles.edit7, 'string', num2str(correlationDecrypted));
k=1;
for i=50:49+N
    xdecrypted(k) = decryptedImage(i,110);
    k=k+1;
end
k=1;
for i=51:50+N
    ydecrypted(k) = decryptedImage(i,110);
    k=k+1;
end
correlationDecrypted = correlationCoefficient(xdecrypted,ydecrypted,N);
set(handles.edit10, 'string', num2str(correlationDecrypted));


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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editR1_Callback(hObject, eventdata, handles)
% hObject    handle to editR1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editR1 as text
%        str2double(get(hObject,'String')) returns contents of editR1 as a double


% --- Executes during object creation, after setting all properties.
function editR1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editR1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editR2_Callback(hObject, eventdata, handles)
% hObject    handle to editR2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editR2 as text
%        str2double(get(hObject,'String')) returns contents of editR2 as a double


% --- Executes during object creation, after setting all properties.
function editR2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editR2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editX01_Callback(hObject, eventdata, handles)
% hObject    handle to editX01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editX01 as text
%        str2double(get(hObject,'String')) returns contents of editX01 as a double


% --- Executes during object creation, after setting all properties.
function editX01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editX01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editX02_Callback(hObject, eventdata, handles)
% hObject    handle to editX02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editX02 as text
%        str2double(get(hObject,'String')) returns contents of editX02 as a double


% --- Executes during object creation, after setting all properties.
function editX02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editX02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editM1_Callback(hObject, eventdata, handles)
% hObject    handle to editM1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editM1 as text
%        str2double(get(hObject,'String')) returns contents of editM1 as a double


% --- Executes during object creation, after setting all properties.
function editM1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editM1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editM2_Callback(hObject, eventdata, handles)
% hObject    handle to editM2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editM2 as text
%        str2double(get(hObject,'String')) returns contents of editM2 as a double


% --- Executes during object creation, after setting all properties.
function editM2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editM2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editIV_Callback(hObject, eventdata, handles)
% hObject    handle to editIV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIV as text
%        str2double(get(hObject,'String')) returns contents of editIV as a double


% --- Executes during object creation, after setting all properties.
function editIV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global secretKey;
secretKey = [5 5 0.6325 0.3325 150 150 4];
set(handles.editR1, 'string', num2str(secretKey(1)));
set(handles.editR2, 'string', num2str(secretKey(2)));
set(handles.editX01, 'string', num2str(secretKey(3)));
set(handles.editX02, 'string', num2str(secretKey(4)));
set(handles.editM1, 'string', num2str(secretKey(5)));
set(handles.editM2, 'string', num2str(secretKey(6)));
set(handles.editIV, 'string', num2str(secretKey(7)));


% --- Executes on button press in pushbuttonSubmit.
function pushbuttonSubmit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSubmit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global secretKey;

r1S = get(handles.editR1, 'string');
r1 = str2double(r1S);

r2S = get(handles.editR2, 'string');
r2 = str2double(r2S);

X01S = get(handles.editX01, 'string');
X01 = str2double(X01S);

X02S = get(handles.editX02, 'string');
X02 = str2double(X02S);

m1S = get(handles.editM1, 'string');
m1 = str2double(m1S);

m2S = get(handles.editM2, 'string');
m2 = str2double(m2S);

ivS = get(handles.editIV, 'string');
iv = str2double(ivS);

secretKey = [r1 r2 X01 X02 m1 m2 iv];
global rows;
