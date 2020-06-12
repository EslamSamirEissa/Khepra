function coverage_matrix=getCoverageMatrix(focal_length,sensor_dim,res,focus_dim,Ra,model,poses)

% focal_length=0.00193;
% sensor_dim=[3.6e-3 2.01e-3];
% res=[1280,800];
% focus_dim=[0.1,5];
% Ra=10;

camera_count=size(poses,1);

triangle_count=size(model.faces,1);

coverage_matrix=NaN(camera_count,triangle_count);


waitbar_camera_matrix = waitbar(0,'Calculating Coverage for Camera # 1','Name','Please wait...');
for i=1:camera_count
    
    progress_index=i/camera_count;
    
    waitbar_string="Calculating Coverage for Camera # #"+i;
    
    waitbar(progress_index,waitbar_camera_matrix,waitbar_string);
    
    current_camera_pose=reshape(poses(i,:,:),[4,4]);
    
    camera_matrix=buildCameraMatrix(focal_length,sensor_dim,res,current_camera_pose);
    
    
    coverage_matrix(i,:)=getOverallCoverage_PPM(camera_matrix,current_camera_pose,model,Ra,res,focus_dim);
    
    
end

close(waitbar_camera_matrix);



end