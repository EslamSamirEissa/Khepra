function seedTriangle=getSeedTriangle(segmentation_matrix)

triangle_count=size(segmentation_matrix,1);

for i=1:triangle_count
    
    if isnan(segmentation_matrix(i))
        seedTriangle=i;
        return;
    end
end
end