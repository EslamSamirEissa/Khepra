function varargout = Coverage_Evaluation_Tool_v03(varargin)
% COVERAGE_EVALUATION_TOOL_V03 MATLAB code for Coverage_Evaluation_Tool_v03.fig
%      COVERAGE_EVALUATION_TOOL_V03, by itself, creates a new COVERAGE_EVALUATION_TOOL_V03 or raises the existing
%      singleton*.
%
%      H = COVERAGE_EVALUATION_TOOL_V03 returns the handle to a new COVERAGE_EVALUATION_TOOL_V03 or the handle to
%      the existing singleton*.
%
%      COVERAGE_EVALUATION_TOOL_V03('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COVERAGE_EVALUATION_TOOL_V03.M with the given input arguments.
%
%      COVERAGE_EVALUATION_TOOL_V03('Property','Value',...) creates a new COVERAGE_EVALUATION_TOOL_V03 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Coverage_Evaluation_Tool_v03_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Coverage_Evaluation_Tool_v03_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Coverage_Evaluation_Tool_v03

% Last Modified by GUIDE v2.5 29-May-2020 22:28:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Coverage_Evaluation_Tool_v03_OpeningFcn, ...
    'gui_OutputFcn',  @Coverage_Evaluation_Tool_v03_OutputFcn, ...
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


% --- Executes just before Coverage_Evaluation_Tool_v03 is made visible.
function Coverage_Evaluation_Tool_v03_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Coverage_Evaluation_Tool_v03 (see VARARGIN)

% Choose default command line output for Coverage_Evaluation_Tool_v03
handles.output = hObject;

axes(handles.axes1);
matlabImage = imread('Uni_logo_small.png');
image(matlabImage);
axis off;
axis image;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Coverage_Evaluation_Tool_v03 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Coverage_Evaluation_Tool_v03_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in draw_object_pushbutton.
function draw_object_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to draw_object_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

file_name=get(handles.stl_string_input,'string');

fv = stlread(file_name);
fv=normalizeScale(fv,1);


triangle_count=size(fv.faces,1);
vertex_count=size(fv.vertices,1);
set(handles.triangle_count_output,'string',triangle_count);
set(handles.vertex_count_output,'string',vertex_count);


figure;

patch(fv,'FaceColor',       [0.8 0.8 1], ...
    'EdgeColor',       'none',        ...
    'FaceLighting',    'gouraud',     ...
    'AmbientStrength', 0.15);

camlight('headlight');
material('dull');

axis('image');
view([-135 35]);








% --- Executes on button press in draw_segmentation_pushbutton.
function draw_segmentation_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to draw_segmentation_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global seg_matrix;
global fv;

figure;
hold on;
axis('image');
view([-135 35]);
for j=1:max(seg_matrix)
    
    current_seg_color=rand(1,3);
    
    for i=1:size(seg_matrix,1)
        if seg_matrix(i)==j
            patch('Faces',fv.faces((i),:),'Vertices',fv.vertices,'FaceColor',       current_seg_color, ...
                'EdgeColor',       'k',        ...
                'FaceLighting',    'gouraud',     ...
                'AmbientStrength', 0.15 );
        end
    end
    
    
    
end










% --- Executes on button press in no_optimzation_radio.
function no_optimzation_radio_Callback(hObject, eventdata, handles)
% hObject    handle to no_optimzation_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no_optimzation_radio


% --- Executes on button press in greedy_radio.
function greedy_radio_Callback(hObject, eventdata, handles)
% hObject    handle to greedy_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of greedy_radio



function target_camera_count_input_Callback(hObject, eventdata, handles)
% hObject    handle to target_camera_count_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of target_camera_count_input as text
%        str2double(get(hObject,'String')) returns contents of target_camera_count_input as a double


% --- Executes during object creation, after setting all properties.
function target_camera_count_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to target_camera_count_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stl_string_input_Callback(hObject, eventdata, handles)
% hObject    handle to stl_string_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stl_string_input as text
%        str2double(get(hObject,'String')) returns contents of stl_string_input as a double


% --- Executes during object creation, after setting all properties.
function stl_string_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stl_string_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha_input_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha_input as text
%        str2double(get(hObject,'String')) returns contents of alpha_input as a double


% --- Executes during object creation, after setting all properties.
function alpha_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beta_input_Callback(hObject, eventdata, handles)
% hObject    handle to beta_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta_input as text
%        str2double(get(hObject,'String')) returns contents of beta_input as a double


% --- Executes during object creation, after setting all properties.
function beta_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function focal_length_input_Callback(hObject, eventdata, handles)
% hObject    handle to focal_length_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of focal_length_input as text
%        str2double(get(hObject,'String')) returns contents of focal_length_input as a double


% --- Executes during object creation, after setting all properties.
function focal_length_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to focal_length_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sensor_dim_input_Callback(hObject, eventdata, handles)
% hObject    handle to sensor_dim_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sensor_dim_input as text
%        str2double(get(hObject,'String')) returns contents of sensor_dim_input as a double


% --- Executes during object creation, after setting all properties.
function sensor_dim_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensor_dim_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function res_input_Callback(hObject, eventdata, handles)
% hObject    handle to res_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of res_input as text
%        str2double(get(hObject,'String')) returns contents of res_input as a double


% --- Executes during object creation, after setting all properties.
function res_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to res_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function focus_dim_input_Callback(hObject, eventdata, handles)
% hObject    handle to focus_dim_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of focus_dim_input as text
%        str2double(get(hObject,'String')) returns contents of focus_dim_input as a double


% --- Executes during object creation, after setting all properties.
function focus_dim_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to focus_dim_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in segmentation_pushbutton.
function segmentation_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to segmentation_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global seg_matrix;
global poses;
global fv;
global segementation_matrix;


file_name=get(handles.stl_string_input,'string');

fv = stlread(file_name);
fv=normalizeScale(fv,1);
[fv.faces,fv.vertices] = unifyVertex(fv.faces,fv.vertices);
triang_fv=triangulation(fv.faces,fv.vertices);
P = incenter(triang_fv);
F=faceNormal(triang_fv);
triangle_count=size(fv.faces,1);
vertex_count=size(fv.vertices,1);

set(handles.triangle_count_output,'string',triangle_count);
set(handles.vertex_count_output,'string',vertex_count);



segementation_matrix=NaN(triangle_count,1);  %Create segmentation vector

alpha=str2double(get(handles.alpha_input,'string'));

[seg_matrix,accepted_seg]=mergeCheck(alpha,triang_fv,1,F,P,segementation_matrix,1);


beta=str2double(get(handles.beta_input,'string'));
segmentation_matrix=SegmentRegions(beta,seg_matrix,F,P);

segment_count=max(segmentation_matrix);

set(handles.number_of_segments_output,'string',segment_count);

seg_matrix=segmentation_matrix;


focal_length=str2double(get(handles.focal_length_input,'string'));
sensor_dim=str2num(get(handles.sensor_dim_input,'string'));
res=str2num(get(handles.res_input,'string'));

rho=sensor_dim./res;
fov = rad2deg(2*atan(res/2.*rho / focal_length));




poses=getCameraPlacement(seg_matrix,triang_fv,F,P,fov(1));




% --- Executes on button press in calc_coverage_pushbutton.
function calc_coverage_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calc_coverage_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global poses;
global fv;

optmization_button=get(handles.no_optimzation_radio,'value');
focal_length=str2double(get(handles.focal_length_input,'string'));
sensor_dim=str2num(get(handles.sensor_dim_input,'string'));
res=str2num(get(handles.res_input,'string'));
focus_dim=str2num(get(handles.focus_dim_input,'string'));
Ra=str2double(get(handles.Ra_input,'string'));
tic
coverage_matrix=getCoverageMatrix(focal_length,sensor_dim,res,focus_dim,Ra,fv,poses);
time_cost=toc;

set(handles.network_time_cost_output,'string',time_cost);

if optmization_button==1
    
    
    [non_coverage_percentage,mean_coverage_per_triangle_per_camera]=getCoverageReport_A(coverage_matrix,fv);
    segment_count=size(coverage_matrix,1);
    
    set(handles.number_of_segments_output,'string',segment_count);
    
    set(handles.non_covered_percentage_output,'string',non_coverage_percentage);
    
    set(handles.average_overall_coverage,'string',mean_coverage_per_triangle_per_camera);
    
    
    
else
    camera_count=str2double(get(handles.target_camera_count_input,'string'));
    
    output_matrix=greedyOptimize(coverage_matrix,camera_count);
    [non_coverage_percentage,mean_coverage_per_triangle_per_camera]=getCoverageReport_A(output_matrix,fv);
    segment_count=size(output_matrix,1);
    set(handles.number_of_segments_output,'string',segment_count);
    set(handles.non_covered_percentage_output,'string',non_coverage_percentage);
    set(handles.average_overall_coverage,'string',mean_coverage_per_triangle_per_camera);
    
end



function Ra_input_Callback(hObject, eventdata, handles)
% hObject    handle to Ra_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ra_input as text
%        str2double(get(hObject,'String')) returns contents of Ra_input as a double


% --- Executes during object creation, after setting all properties.
function Ra_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ra_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in draw_cams_pushbutton.
function draw_cams_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to draw_cams_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global seg_matrix;
global fv;
global poses;

focal_length=str2double(get(handles.focal_length_input,'string'));
sensor_dim=str2num(get(handles.sensor_dim_input,'string'));
res=str2num(get(handles.res_input,'string'));
segment_count=max(seg_matrix);



figure;
hold on;
axis('image');
view([-135 35]);
for j=1:max(seg_matrix)
    
    current_seg_color=rand(1,3);
    
    for i=1:size(seg_matrix,1)
        if seg_matrix(i)==j
            patch('Faces',fv.faces((i),:),'Vertices',fv.vertices,'FaceColor',       current_seg_color, ...
                'EdgeColor',       'k',        ...
                'FaceLighting',    'gouraud',     ...
                'AmbientStrength', 0.15 );
        end
    end
    
    
    
end








for j=1:segment_count
    
    T=reshape(poses(j,:,:),[4,4]);
    
    draw_frustum(focal_length,res,sensor_dim,T)
    
    
    
end


% --- Executes on button press in specify_camera_pose_radio.
function specify_camera_pose_radio_Callback(hObject, eventdata, handles)
% hObject    handle to specify_camera_pose_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of specify_camera_pose_radio



function camera_transl_input_Callback(hObject, eventdata, handles)
% hObject    handle to camera_transl_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of camera_transl_input as text
%        str2double(get(hObject,'String')) returns contents of camera_transl_input as a double


% --- Executes during object creation, after setting all properties.
function camera_transl_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to camera_transl_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function camera_rotation_input_Callback(hObject, eventdata, handles)
% hObject    handle to camera_rotation_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of camera_rotation_input as text
%        str2double(get(hObject,'String')) returns contents of camera_rotation_input as a double


% --- Executes during object creation, after setting all properties.
function camera_rotation_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to camera_rotation_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in use_segmented_pose_radio.
function use_segmented_pose_radio_Callback(hObject, eventdata, handles)
% hObject    handle to use_segmented_pose_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of use_segmented_pose_radio



function camera_from_segment_input_Callback(hObject, eventdata, handles)
% hObject    handle to camera_from_segment_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of camera_from_segment_input as text
%        str2double(get(hObject,'String')) returns contents of camera_from_segment_input as a double


% --- Executes during object creation, after setting all properties.
function camera_from_segment_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to camera_from_segment_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in evaluate_single_coverage_button.
function evaluate_single_coverage_button_Callback(hObject, eventdata, handles)
% hObject    handle to evaluate_single_coverage_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global single_camera_coverage;
global fv;

file_name=get(handles.stl_string_input,'string');

fv = stlread(file_name);
fv=normalizeScale(fv,1);

selected_model=get(handles.image_space_model_radio,'value');

focal_length=str2double(get(handles.focal_length_input,'string'));
sensor_dim=str2num(get(handles.sensor_dim_input,'string'));
res=str2num(get(handles.res_input,'string'));
focus_dim=str2num(get(handles.focus_dim_input,'string'));
Ra=str2double(get(handles.Ra_input,'string'));

camera_translation=(get(handles.camera_transl_input,'string'));

camera_translation=eval(camera_translation);

camera_rotation=(get(handles.camera_rotation_input,'string'));
camera_rotation=eval(camera_rotation);

camera_pose=camera_translation*camera_rotation;

camera_matrix=buildCameraMatrix(focal_length,sensor_dim,res,camera_pose);

if selected_model==1
    
    coverage_type=(get(handles.coverage_type_menu,'Value'));
    
    switch (coverage_type)
        case 1
            tic
            single_camera_coverage=getOverallCoverage_PPM(camera_matrix,camera_pose,fv,Ra,res,focus_dim);
            time_cost=toc;
            
        case 2
            tic
            uvw=getProjectedVertices (camera_matrix,camera_pose,fv);
            single_camera_coverage=getFOVCoverage_PPM(uvw,fv,res);
            time_cost=toc;
            
        case 3
            tic
            uvw=getProjectedVertices (camera_matrix,camera_pose,fv);
            [pix_per_tri,single_camera_coverage,pix_per_tri_nrmlized_2]=getResolutionCoverage_PPM(uvw,fv,Ra);
            time_cost=toc;
            
        case 4
            tic
            uvw=getProjectedVertices (camera_matrix,camera_pose,fv);
            [single_camera_coverage,focus_visible_triangles]=getFocusCoverage_PPM(uvw,fv,focus_dim);
            time_cost=toc;
            
        case 5
            tic
            uvw=getProjectedVertices (camera_matrix,camera_pose,fv);
            [occlusion_triangles_bool,occlusion_triangles]=getMultiOcclusionCoverage_PPM(uvw,fv,camera_pose);
            single_camera_coverage=1-occlusion_triangles_bool;
            time_cost=toc;
            
    end
    
    
else
    cam1=CentralCamera('Name','Camera1','focal',focal_length, 'resolution',res,'sensor',sensor_dim,'pose',camera_pose);
    coverage_type=(get(handles.coverage_type_menu,'Value'));
    
    switch (coverage_type)
        case 1
            tic
            
            single_camera_coverage=get_overall_Coverage (focus_dim(1),focus_dim(2),fv, cam1);
            time_cost=toc;
            
        case 2
            tic
            
            [covered_vertices_bool_FOV,single_camera_coverage,covered_triangles_FOV]=get_FOV_Coverage (fv, cam1);
            
            time_cost=toc;
            
        case 3
            tic
            [single_camera_coverage,triangle_res_normalized]=get_resolution_Coverage (fv, cam1);
            time_cost=toc;
            
        case 4
            tic
            
            [single_camera_coverage]=get_depth_Coverage (focus_dim(1),focus_dim(2),fv, cam1);
            time_cost=toc;
            
        case 5
            tic
            
            [single_camera_coverage,pass1,pass2]=get_occlusion_Coverage (fv,cam1);
           % [single_camera_coverage,pass1_triangles,pass2_triangles_CPU]=get_occlusion_Coverage_GPU (fv,cam1)
            time_cost=toc;
            %single_camera_coverage=gather(single_camera_coverage);
    end
end

set(handles.text51,'string',time_cost);

number_of_covered=sum(any(single_camera_coverage,2));
number_of_triagles=size(fv.faces,1);

number_of_non_covered=number_of_triagles-number_of_covered; %Find overall number of non-covered triangles

non_coverage_percentage=(number_of_non_covered/number_of_triagles)*100; %Percentage of Uncovered Triangles

set(handles.text49,'string',non_coverage_percentage);


mean_coverage_per_triangle=mean(single_camera_coverage,'omitnan');
set(handles.text48,'string',mean_coverage_per_triangle);



% --- Executes on button press in draw_single_coverage_button.
function draw_single_coverage_button_Callback(hObject, eventdata, handles)
% hObject    handle to draw_single_coverage_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global single_camera_coverage;

camera_translation=(get(handles.camera_transl_input,'string'));
camera_translation=eval(camera_translation);

camera_rotation=(get(handles.camera_rotation_input,'string'));
camera_rotation=eval(camera_rotation);

camera_pose=camera_translation*camera_rotation;


focal_length=str2double(get(handles.focal_length_input,'string'));
sensor_dim=str2num(get(handles.sensor_dim_input,'string'));
res=str2num(get(handles.res_input,'string'));



file_name=get(handles.stl_string_input,'string');

fv = stlread(file_name);
fv=normalizeScale(fv,1);




single_camera_coverage_normalized=single_camera_coverage/max(single_camera_coverage);


figure;
draw_frustum(focal_length,res,sensor_dim,camera_pose);
hold on;
axis('image');
view([-135 35]);
for i=1:size(single_camera_coverage_normalized,1)
    
    if isnan(single_camera_coverage_normalized(i))
        patch('Faces',fv.faces(i,:),'Vertices',fv.vertices,'FaceColor',       [ 0 0 0 ], ...
            'EdgeColor',       'k',        ...
            'FaceLighting',    'gouraud',     ...
            'AmbientStrength', 0.15);
    else
        
        patch('Faces',fv.faces(i,:),'Vertices',fv.vertices,'FaceColor',       [ single_camera_coverage_normalized(i) single_camera_coverage_normalized(i) single_camera_coverage_normalized(i) ], ...
            'EdgeColor',       'k',        ...
            'FaceLighting',    'gouraud',     ...
            'AmbientStrength', 0.15);
    end
end




% --- Executes on button press in image_space_model_radio.
function image_space_model_radio_Callback(hObject, eventdata, handles)
% hObject    handle to image_space_model_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of image_space_model_radio


% --- Executes on button press in zhang_model_radio.
function zhang_model_radio_Callback(hObject, eventdata, handles)
% hObject    handle to zhang_model_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zhang_model_radio


% --- Executes on button press in draw_object_pushbutton.
function plot_object_button_Callback(hObject, eventdata, handles)
% hObject    handle to draw_object_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in draw_segmentation_pushbutton.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to draw_segmentation_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in draw_cams_pushbutton.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to draw_cams_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in segmentation_pushbutton.
function segment_shape_button_Callback(hObject, eventdata, handles)
% hObject    handle to segmentation_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in calc_coverage_pushbutton.
function calculate_network_coverage_button_Callback(hObject, eventdata, handles)
% hObject    handle to calc_coverage_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in show_camera_pose_pushbutton.
function show_camera_pose_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to show_camera_pose_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




camera_translation=(get(handles.camera_transl_input,'string'));
camera_translation=eval(camera_translation);

camera_rotation=(get(handles.camera_rotation_input,'string'));
camera_rotation=eval(camera_rotation);

camera_pose=camera_translation*camera_rotation;

focal_length=str2double(get(handles.focal_length_input,'string'));
sensor_dim=str2num(get(handles.sensor_dim_input,'string'));
res=str2num(get(handles.res_input,'string'));



file_name=get(handles.stl_string_input,'string');

fv = stlread(file_name);
fv=normalizeScale(fv,1);

triangle_count=size(fv.faces,1);
vertex_count=size(fv.vertices,1);
set(handles.triangle_count_output,'string',triangle_count);
set(handles.vertex_count_output,'string',vertex_count);


figure;

patch(fv,'FaceColor',       [0.8 0.8 1], ...
    'EdgeColor',       'k',        ...
    'FaceLighting',    'gouraud',     ...
    'AmbientStrength', 0.15);


axis('image');
view([-135 35]);


draw_frustum(focal_length,res,sensor_dim,camera_pose);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in plot_single_camera_image_plane_pushbutton.
function plot_single_camera_image_plane_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plot_single_camera_image_plane_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

file_name=get(handles.stl_string_input,'string');

fv = stlread(file_name);
fv=normalizeScale(fv,1);

focal_length=str2double(get(handles.focal_length_input,'string'));
sensor_dim=str2num(get(handles.sensor_dim_input,'string'));
res=str2num(get(handles.res_input,'string'));
focus_dim=str2num(get(handles.focus_dim_input,'string'));
Ra=str2double(get(handles.Ra_input,'string'));


camera_translation=(get(handles.camera_transl_input,'string'));
camera_translation=eval(camera_translation);

camera_rotation=(get(handles.camera_rotation_input,'string'));
camera_rotation=eval(camera_rotation);

camera_pose=camera_translation*camera_rotation;

camera_matrix=buildCameraMatrix(focal_length,sensor_dim,res,camera_pose);

uvw=getProjectedVertices (camera_matrix,camera_pose,fv);

plotProjectedTriangles_whole_model(uvw,fv,res,'k','r');


% --- Executes on selection change in coverage_type_menu.
function coverage_type_menu_Callback(hObject, eventdata, handles)
% hObject    handle to coverage_type_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns coverage_type_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from coverage_type_menu


% --- Executes during object creation, after setting all properties.
function coverage_type_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coverage_type_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
