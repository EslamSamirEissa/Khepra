function [centroid_avg,normal_avg]=getRegionNormalAverage(mesh_segementation,normals,centroids)

triangle_count=size(mesh_segementation,1);  %Get triangle count in whole model
region_count=max(mesh_segementation);   %Get number of segments in the segmentation matrix

centroid_avg=zeros(region_count,3); %Create matrix to store avg center of each segment
normal_avg=zeros(region_count,3);   %Create matrix to store avg normal of each segment


for i=1:region_count    %For each segment, do

current_region_triangle_count=sum(mesh_segementation==i);   %Count triangles in current segment
c_avg_region=zeros(current_region_triangle_count,3);
n_avg_region=zeros(current_region_triangle_count,3);
pointer=1;
for j=1:triangle_count  %Loop through all triangles
    
    if mesh_segementation(j)==i %If triangle belongs to current segment
        c_avg_region(pointer,:)=centroids(j,:);
        n_avg_region(pointer,:)=normals(j,:)+c_avg_region(pointer,:);
        pointer=pointer+1;
    end
    
end

centroid_avg(i,:)=mean(c_avg_region);
normal_avg(i,:)=mean(n_avg_region);


end
end