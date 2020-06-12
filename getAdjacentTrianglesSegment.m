function adjacent_triangles=getAdjacentTrianglesSegment(model_triangulated,segement_indices,segmentation_matrix)

triangle_count=size(segement_indices,1);

if triangle_count==1
    adjacent_triangles = neighbors(model_triangulated,segement_indices);
    return;
end

temp_triangles_A = neighbors(model_triangulated,segement_indices);

temp_triangles_B=temp_triangles_A(:);
temp_triangles_B=unique(temp_triangles_B);
temp_triangles_B(isnan(temp_triangles_B)) = [];

%temp_triangles_B(isnan(temp_triangles_B)) = []; %Remove NaN from neighbour function ouput to handle non airtight 3d models


%[ii,jj,kk]=unique(temp_triangles_B);
%elimnated_triangles=ii(histc(kk,1:numel(ii))>1);
elimnated_triangles=segement_indices;

for i=1:size(elimnated_triangles,1)
    
    temp_triangles_B = temp_triangles_B(temp_triangles_B~=elimnated_triangles(i));
    
end

for i=1:size(temp_triangles_B,1)
    
    if ~isnan(segmentation_matrix(temp_triangles_B(i))) %If adjacent triangle has a segment value, remove it
        temp_triangles_B(i)=NaN; 
    end
    
end

temp_triangles_B(isnan(temp_triangles_B)) = [];

adjacent_triangles=temp_triangles_B;






    
    
    
    
end

