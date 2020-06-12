function [coverage_triangles]=get_overall_Coverage (z_min,z_max,model, camera)

[covered_vertices_bool_FOV,covered_triangles_bool_FOV,covered_triangles_FOV]=get_FOV_Coverage (model, camera);

[covered_triangles_bool_depth]=get_depth_Coverage (z_min,z_max,model, camera);

[covered_triangles_bool_occlusion,pass1,pass2]=get_occlusion_Coverage (model,camera);

[triangle_res,triangle_res_normalized]=get_resolution_Coverage (model, camera);

coverage_triangles=covered_triangles_bool_FOV.*covered_triangles_bool_depth.*covered_triangles_bool_occlusion.*triangle_res_normalized;

end