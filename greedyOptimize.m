function output_matrix=greedyOptimize(coverage_matrix,target_camera_count)


number_of_cameras=size(coverage_matrix,1); %Get number of cameras from matrix
number_of_triangles=size(coverage_matrix,2); %Get number of triangles from matrix



triangle_coverage_count=NaN(number_of_cameras,1);
triangle_coverage_avg_value=NaN(number_of_cameras,1);


coverage_matrix_no_nan=coverage_matrix;

coverage_matrix_no_nan(isnan(coverage_matrix_no_nan)) = 0;  %Replace NaNs from matrix by 0s
%coverage_matrix_no_nan(coverage_matrix_no_nan==0) = [];

for i=1:number_of_cameras
    
    
    triangle_coverage_count(i)=sum(any(coverage_matrix(i,:),1));
    triangle_coverage_avg_value(i)=mean(coverage_matrix_no_nan(i,:));
    
end



%sorted_camera_indices_by_max_covered_tri=sortIndicesDecending(triangle_coverage_count);
sorted_camera_indices_by_max_average_coverage=sortIndicesDecending(triangle_coverage_avg_value); %Get indices of sorted cameras by maximum average coverage

output_matrix=NaN(target_camera_count,number_of_triangles); %Create empty coverage matrix with th


for i=1:target_camera_count
    
    output_matrix(i,:)=coverage_matrix(sorted_camera_indices_by_max_average_coverage(i),:);
    
end

end