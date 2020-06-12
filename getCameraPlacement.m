function poses=getCameraPlacement(seg_matrix,triang_fv,normals,centroids,HFOV)

triangle_count=size(seg_matrix,1);  %Get triangle count in whole model
region_count=max(seg_matrix);   %Get number of segments in the segmentation matrix
region_triangle_count=sum(seg_matrix==1)*3;
poses=NaN(region_count,4,4);    %Create camera poses matrix

for k=1:region_count
    
    
    
    region_vertex=NaN(region_triangle_count,3);
    pointer=1;
    
    region_triangle_count=sum(seg_matrix==1)*3;
    
    current_region_vertex_count=sum(seg_matrix==k)*3;
    region_vertex=NaN(current_region_vertex_count,3);
    
    
    for i=1:triangle_count
        if seg_matrix(i)==k
            region_vertex(pointer,:)=triang_fv.Points(triang_fv.ConnectivityList(i,1),:);
            pointer=pointer+1;
            region_vertex(pointer,:)=triang_fv.Points(triang_fv.ConnectivityList(i,2),:);
            pointer=pointer+1;
            region_vertex(pointer,:)=triang_fv.Points(triang_fv.ConnectivityList(i,3),:);
            pointer=pointer+1;
            
        end
        
    end
    
    region_vertex(isnan(region_vertex)) = [];
    
    %region_origin=mean(region_vertex);
    
    boundry_x_max=max(region_vertex(:,1));
    boundry_x_min=min(region_vertex(:,1));
    x_side=boundry_x_max-boundry_x_min;
    
    
    boundry_y_max=max(region_vertex(:,2));
    boundry_y_min=min(region_vertex(:,2));
    y_side=boundry_y_max-boundry_y_min;
    
    boundry_z_max=max(region_vertex(:,3));
    boundry_z_min=min(region_vertex(:,3));
    z_side=boundry_z_max-boundry_z_min;
    
    
    width=max([x_side y_side z_side]);
    
    
    Z_min=(width*sin(deg2rad(90-(HFOV/2)))/2*sin(deg2rad(HFOV/2)));
    %Z_min=Z_min*0.75;
    [centroid_avg,normal_avg]=getRegionNormalAverage(seg_matrix,normals,centroids);
    
    current_normal=normal_avg(k,:);
    current_centroid=centroid_avg(k,:);
    
    vector=current_normal-current_centroid;
    vector_norm=norm(vector);
    u=vector/vector_norm;
    
    
    eye=current_normal+(Z_min*u);
    at=current_centroid;
    
    poses(k,:,:)=getLookatPose(eye,at);
    
    

end




end