function [segementation,segment_output]=mergeCheck(alpha,model_triangulated,segment,normals,centroids,segementation,nseg_flag)

global segement_pointer;
triangle_count=size(model_triangulated.ConnectivityList,1); %Get triangle count of the model




if nseg_flag==1
    segement_pointer=getSegmentPointer(segementation);
    nseg_flag==0;
end






if size(segment,1)==1  %Check if examined segment is made of one triangle only
    
    seed_triangle=segment;  %Assign first triangle given as seed triangle
    
    segementation(seed_triangle)=segement_pointer;  %Assign seed triangle to first segment
    
    adjacent_triangles=getAdjacentTrianglesSegment(model_triangulated,segment,segementation);     %Get segment's adjacent triangles
    
    adjacent_triangles(isnan(adjacent_triangles)) = []; %Force remove NaNs from adjacent triangles
    
    adjacent_triangles_count=size(adjacent_triangles,2);    %Get adjacent triangles count
    
    segment_temp=NaN(adjacent_triangles_count,1);   %Create temp vector for accepted triangles
    rejected_temp=NaN(adjacent_triangles_count,1);  %Create temp vector for rejected triangles
    
    for i=1:adjacent_triangles_count        %Check each adjacent triangle for merge condition
        
        angle=getNormalAngleDiff(adjacent_triangles(i),segment,normals,centroids);     %Get angle between selected adjacent and the seed triangle
        
        if angle<= alpha
            
            segementation(adjacent_triangles(i))=segement_pointer;
            
            segment_temp(i)=adjacent_triangles(i);
        else
            rejected_temp(i)=adjacent_triangles(i);
        end
        
    end
    
    segment_temp(isnan(segment_temp)) = [];  %Remove NaNs from accepted vector
    segment_output=[segment;segment_temp]; %Append the input segment and the accepted segment
    
    rejected_temp(isnan(rejected_temp)) = [];  %Remove NaNs from rejected vector
    rejected_segment=rejected_temp;
    
    if isempty(segment_temp)
        try
        seed_triangle=getSeedTriangle(segementation);   %If current segment has finished processing, get new seed triangle
        catch
            segementation
        end
        segment_output=seed_triangle;
        nseg_flag=1;
    else
        nseg_flag=0;
    end
    
    if all(~isnan(segementation))
        return;
    end
    
    [segementation,segment_output]=mergeCheck(alpha,model_triangulated,segment_output,normals,centroids,segementation,nseg_flag);
    
else
    
    adjacent_triangles=getAdjacentTrianglesSegment(model_triangulated,segment,segementation);     %Get segment's adjacent triangles
    
    adjacent_triangles(isnan(adjacent_triangles)) = []; %Force remove NaNs from adjacent triangles
    
    adjacent_triangles_count=size(adjacent_triangles,1);    %Get adjacent triangles count
    
    segment_temp=NaN(adjacent_triangles_count,1);   %Create temp vector for accepted triangles
    rejected_temp=NaN(adjacent_triangles_count,1);  %Create temp vector for rejected triangles
    
    segment_count=size(segment,1);
    angles_A=zeros(segment_count,1);
    
    
    
    for i=1:adjacent_triangles_count    %Check each adjacent triangle for merge condition
        
        for j=1:segment_count    %Find angles between the selected adjacent triangle and each triangle in segment
            
            angles_A(j)=getNormalAngleDiff(adjacent_triangles(i),segment(j),normals,centroids);  %Store angle in vector
            
        end
        
        max_angle=max(angles_A);    % Get maximum of all angles between the adjacent triangle and the segment triangles
        
        if max_angle<=alpha
            
            segment_pointer=segementation(segment(1));  %Find segment ID of the current examined segment
            
            segementation(adjacent_triangles(i))=segement_pointer;
            
            segment_temp(i)=adjacent_triangles(i);
        else
            rejected_temp(i)=adjacent_triangles(i);
        end
        
        
    end
    
    
    segment_temp(isnan(segment_temp)) = [];  %Remove NaNs from accepted vector
    segment_output=[segment;segment_temp]; %Append the input segment and the accepted segment
    
    rejected_temp(isnan(rejected_temp)) = [];  %Remove NaNs from rejected vector
    rejected_segment=rejected_temp;
    
    if all(~isnan(segementation))
        return;
    end
    
    if isempty(segment_temp)
        seed_triangle=getSeedTriangle(segementation);   %If current segment has finished processing, get new seed triangle
        segment_output=seed_triangle;
        nseg_flag=1;
    else
        nseg_flag=0;
    end
    
    

    
    
 
    [segementation,segment_output]=mergeCheck(alpha,model_triangulated,segment_output,normals,centroids,segementation,nseg_flag);
  
      
  
end
end