function output_triangles=backfaceCulling(model,camera_pose)


vertex_count= size(model.vertices,1);
covered_vertices_bool=zeros(vertex_count,1);

triangle_count=size(model.faces,1);
covered_triangles_bool=zeros(triangle_count,1);
covered_triangles=NaN(triangle_count,3);

theta=NaN(vertex_count,1);

modelNormals=patchnormals(model);

for i=1:size(modelNormals,1)
    p1=model.vertices(i,:);
    p2=model.vertices(i,:)-4*modelNormals(i,:);
    p3= transl(camera_pose)';
    
    S1= p2-p1;
    S2= p3-p1;
    
    theta(i) = rad2deg(atan2(norm(cross(S1, S2)), dot(S1, S2)));
    
    if theta(i)<90
        
        covered_vertices_bool(i)=1;
        
    end
    
    
end


for i=1:size(model.faces,1)  %Loop through triangle list and get covered triangles from covered vertices
    
    v_index_1=model.faces(i,1);
    v_index_2=model.faces(i,2);
    v_index_3=model.faces(i,3);
    
    if (covered_vertices_bool(v_index_1)==1) && (covered_vertices_bool(v_index_2)==1) && (covered_vertices_bool(v_index_3)==1)
        
        covered_triangles_bool(i)=1;
        covered_triangles(i,:)=model.faces(i,:);
        
    end
    
end

output_triangles=covered_triangles;   % Visible triangles after Backface culling


end