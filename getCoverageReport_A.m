function [Non_Coverage_percentage,mean_coverage_per_triangle_per_camera]=getCoverageReport_A(coverage_matrix,model)



max_for_each_triangle=max(coverage_matrix); %For each triangle, its maximum achieved coverge value

number_of_covered=sum(any(max_for_each_triangle,1)); %Find overall number of covered triangles

number_of_triagles=size(model.faces,1); %Get total number of triangles

number_of_non_covered=number_of_triagles-number_of_covered; %Find overall number of non-covered triangles

Non_Coverage_percentage=(number_of_non_covered/number_of_triagles)*100; %Percentage of Uncovered Triangles


number_of_cameras=size(coverage_matrix,1);  %From matrix get total number of cameras

triangle_coverage_count=NaN(number_of_cameras,1);   %Create
triangle_coverage_avg_value=NaN(number_of_cameras,1); %Create


coverage_matrix_no_nan=coverage_matrix;

coverage_matrix_no_nan(isnan(coverage_matrix_no_nan)) = 0; %Replace NaNs in matrix with zeros
%coverage_matrix_no_nan(coverage_matrix_no_nan==0) = [];

for i=1:number_of_cameras
    
    
    triangle_coverage_count(i)=sum(any(coverage_matrix(i,:),1));    %Get total number of triangles covered by each camera
    triangle_coverage_avg_value(i)=mean(coverage_matrix_no_nan(i,:)); %Get average value of triangle coverage by each camera
    
end

mean_coverage_per_triangle_per_camera=mean(triangle_coverage_avg_value);  %Get average value of triangle coverage for the whole camera network  



end