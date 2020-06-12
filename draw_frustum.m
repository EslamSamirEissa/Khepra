function  draw_frustum(focal_length,res,sensor_dim,Tcam)
%Get Camera object FOV
% focal_length=0.00193;
% sensor_dim=[3.6e-3 2.01e-3];
% res=[1280,800];

rho=sensor_dim./res;
fov = rad2deg(2*atan(res/2.*rho / focal_length));


HFOV=fov(1);
VFOV=fov(2);

Nc=0.2;
Fc=0.4;
%Compute frustum vertices A,B for Near Clipping Plane 'Nc'
A=((Nc*sin(HFOV/2))/sin(180-(HFOV/2)));
B=((Nc*sin(VFOV/2))/sin(180-(VFOV/2)));

%Compute frustum vertices C,D for Far Clipping Plane 'Fc'
C=((Fc*sin(HFOV/2))/sin(180-(HFOV/2)));
D=((Fc*sin(VFOV/2))/sin(180-(VFOV/2)));

vertices=[0 0 0;-A B Nc;A B Nc;A -B Nc;-A -B Nc;C D Fc;-C D Fc;-C -D Fc;C -D Fc];

vertices_2 =Camera2World_pose_vertex (vertices,Tcam);


facesNear=[1 2 3;1 3 4;1 4 5;1 2 5];
facesFar=[2 3 6 7;2 5 8 7;4 5 8 9;3 4 9 6];
patch('Faces',facesNear,'Vertices',vertices_2,'EdgeColor','cyan','FaceColor','none','LineWidth',1);
patch('Faces',facesFar,'Vertices',vertices_2,'EdgeColor','g','FaceColor','none','LineWidth',1);



end
