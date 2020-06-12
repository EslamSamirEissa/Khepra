function overall_coverage=getOverallCoverage_PPM(camera_matrix,camera_pose,model,Ra,image_dim,focus_dim)





triangle_count=size(model.faces,1);

uvw=getProjectedVertices (camera_matrix,camera_pose,model);

overall_coverage=NaN(triangle_count,1);


[pix_per_tri,pix_per_tri_nrmlized,pix_per_tri_nrmlized_2]=getResolutionCoverage_PPM(uvw,model,Ra);


[fov_visible_triangles_bool,fov_visible_triangles]=getFOVCoverage_PPM(uvw,model,image_dim);

[focus_visible_triangles_bool,focus_visible_triangles]=getFocusCoverage_PPM(uvw,model,focus_dim);

[occlusion_triangles_bool,occlusion_triangles]=getMultiOcclusionCoverage_PPM(uvw,model,camera_pose);


visibility_triangles_bool=1-occlusion_triangles_bool;

overall_coverage=pix_per_tri_nrmlized.*fov_visible_triangles_bool.*focus_visible_triangles_bool.*visibility_triangles_bool;

end