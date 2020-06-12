function [covered_vertices_bool,covered_triangles_bool,covered_triangles]=get_FOV_Coverage (model, camera)


vertex_count= size(model.vertices,1);
triangle_count=size(model.faces,1);

vertices= World2Camera(model,camera);
covered_vertices_bool= zeros(1,vertex_count);
FOV= camera.fov;

covered_triangles_bool= zeros(1,triangle_count);
covered_triangles=NaN(triangle_count,3);


Ah= (FOV(1))/2;
Av= (FOV(2))/2;

for i=1:vertex_count
    
middle_term_h= vertices(1,i)/vertices(3,i);
middle_term_v= vertices(2,i)/vertices(3,i);   


    
    if (-tan(Ah) <= middle_term_h) && (middle_term_h <= tan(Ah)) && (-tan(Av) <= middle_term_v) && (middle_term_v <= tan(Av))

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
covered_triangles_bool=covered_triangles_bool';

end










