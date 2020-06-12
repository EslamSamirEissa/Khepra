function [triangle_res,triangle_res_normalized]=get_resolution_Coverage (model, camera)

vertex_count= size(model.vertices,1);
triangle_count=size(model.faces,1);

f=camera.f*1000; %Get camera focal length in mm
max_rho=max(camera.rho*1000); %Get camera pixel dimensions in mm
optical_center=camera.centre();

model_normals=patchnormals(model);
theta=NaN(vertex_count,1);
Pci=NaN(vertex_count,1);
triangle_res=zeros(triangle_count,1);
%triangle_res_normalized=zeros(triangle_count,1);

   for i=1:size(model_normals,1)
       p1=model.vertices(i,:); p2=model.vertices(i,:)-4*model_normals(i,:);
       p3=optical_center';
       
       S1= p2-p1;
       S2= p3-p1;
       
       theta(i)=(atan2(norm(cross(S1, S2)), dot(S1, S2)));
   end


for i=1:vertex_count
    
    z_vertex_depth=norm(model.vertices(i,:)-optical_center);    % Get z-distance
    
    Pci(i)= (f*cos(theta(i))) / (z_vertex_depth*max_rho);    %Get resolution for each vertex

end


for i=1:triangle_count
    
    triangle_res(i)=mean( [ Pci(model.faces(i,1)) Pci(model.faces(i,2)) Pci(model.faces(i,3)) ]) ;

end

max_triangle_res=max(triangle_res);

triangle_res_normalized=triangle_res/max_triangle_res;

end