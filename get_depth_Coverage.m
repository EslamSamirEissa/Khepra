function [covered_triangles_bool]=get_depth_Coverage (z_min,z_max,model, camera)


vertex_count= size(model.vertices,1);
covered_vertices_bool=zeros(vertex_count,1);

triangle_count=size(model.faces,1);
covered_triangles_bool=zeros(triangle_count,1);
covered_triangles=NaN(triangle_count,3);


vertices= World2Camera(model,camera)';



alpha=NaN(vertex_count,1);

for i=1:vertex_count
    
       p1=[0 0 0];
       p2=vertices(i,:);
       p3=p1+ [0 0 z_max];
       
       S1= p2-p1;
       S2= p3-p1;
       
       alpha(i)=(atan2(norm(cross(S1, S2)), dot(S1, S2))); %Get the angle alpha between the vertex and the optical axis
       
       vertex_depth=norm(vertices(i,:)-[0 0 0]);
       z_max_dash=z_max/cos(alpha(i));
       z_min_dash=z_min/cos(alpha(i));
       
       if (vertex_depth >= z_min_dash) && (z_max_dash >= vertex_depth)
           
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

    

end