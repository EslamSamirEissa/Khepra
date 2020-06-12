function segmentation_matrix=SegmentRegions(beta,mesh_segementation,normals,centroids)


region_count=max(mesh_segementation);   %Get number of segments in the segmentation matrix
region_process_flag=NaN(region_count,1);


[centroid_avg,normal_avg]=getRegionNormalAverage(mesh_segementation,normals,centroids);



for i=1:region_count
    
    if region_process_flag(i)==1
        continue
    end
    
    selected_centroid=centroid_avg(i,:);
    selected_normal=normal_avg(i,:);
    
    for j=1:region_count
        if i==j
            continue;
        end
        
        
        
        iterated_centroid=centroid_avg(j,:);
        iterated_normal=normal_avg(j,:);
        
        s1=selected_normal-selected_centroid;
        s2=iterated_normal-iterated_centroid;
        angle = rad2deg(atan2(norm(cross(s1, s2)), dot(s1, s2)));
        
        angle=round(angle,4);
        
        
        if angle<= beta
           
            mesh_segementation(mesh_segementation==j) = i;
            region_process_flag(j)=1;
            
        end
   
    end
    
end

temp_segment_array=unique(mesh_segementation);
temp_segment_array_length=size(temp_segment_array,1);

for i=1:temp_segment_array_length
    
    for j=1:size(mesh_segementation,1)
        
        if mesh_segementation(j)==temp_segment_array(i)
            mesh_segementation(j)=i;
        end
    
    end
    
end


segmentation_matrix=mesh_segementation;
end