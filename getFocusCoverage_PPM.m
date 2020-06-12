function [visible_triangles_bool,visible_triangles]=getFocusCoverage_PPM(uvw,model,focus_dim)

triangle_count=size(model.faces,1);
visible_triangles_bool=zeros(triangle_count,1);
visible_triangles=NaN(triangle_count,3);
focus_min=focus_dim(1);
focus_max=focus_dim(2);

for i=1:triangle_count
    
    
    A=uvw((model.faces(i,1)),3);
    B=uvw((model.faces(i,2)),3);
    C=uvw((model.faces(i,3)),3);
    

    
    
    if (    (A>=focus_min && A<=focus_max) && (B>=focus_min && B<=focus_max) && (C>=focus_min && C<=focus_max)   )
       
        visible_triangles_bool(i)=1;
        visible_triangles(i,:)=model.faces(i,:);
        
    end

end

end