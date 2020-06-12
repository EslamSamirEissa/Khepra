function segment_pointer=getSegmentPointer(segmentation_matrix)

if all(isnan(segmentation_matrix))
    segment_pointer=1;
    return;


else 
    
    segment_pointer=1+max(segmentation_matrix);
    return;
end

end