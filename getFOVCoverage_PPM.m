function [visible_triangles_bool,visible_triangles]=getFOVCoverage_PPM(uvw,model,image_dim)

triangle_count=size(model.faces,1);
visible_triangles_bool=zeros(triangle_count,1);
visible_triangles=NaN(triangle_count,3);

for i=1:triangle_count
    
    
    A=uvw((model.faces(i,1)),:);
    B=uvw((model.faces(i,2)),:);
    C=uvw((model.faces(i,3)),:);
    

    
    
    if (    A(1)>=0 && A(1)<=image_dim(1) && A(2)>=0 && A(2)<=image_dim(2)) && (B(1)>=0 && B(1)<=image_dim(1) && B(2)>=0 && B(2)<=image_dim(2)) && (C(1)>=0 && C(1)<=image_dim(1) && C(2)>=0 && C(2)<=image_dim(2)  )
       
        visible_triangles_bool(i)=1;
        visible_triangles(i,:)=model.faces(i,:);
        
    end

end

end