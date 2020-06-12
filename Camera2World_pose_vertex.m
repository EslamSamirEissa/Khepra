function p =Camera2World_pose_vertex (vertices,pose)

%R= camera.T(1:3,1:3);   %Get rotation matrix from camera pose method T
%Cw= camera.centre();    %Get translation matrix from camera centre method

ksi= (pose);      %Get W2C transformation matrix ksi


h_vertices =e2h(vertices');   %convert vertices into homogenous coordinate system

vertex_count=size(h_vertices,2);    %Get the number of vertices

c_vertices=zeros(4,vertex_count);

for i=1:vertex_count
    
    c_vertices(:,i)=ksi*h_vertices(:,i);
     
end

p=c_vertices(1:3,:)';

end