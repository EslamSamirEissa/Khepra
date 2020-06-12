function [uvw]=getProjectedVertices (camera_matrix,camera_pose,model)

points=model.vertices';
points_h=e2h(points);
vertex_count=size(points,2);
projected_p=zeros(3,vertex_count);
%projected_p=zeros(vertex_count,1);


point_camera_coord =World2Camera_pose (model,camera_pose);



for i=1:vertex_count

    projected_p(:,i)=camera_matrix*points_h(:,i);
    depth(i)=point_camera_coord(i,3);
end

projected_p=h2e(projected_p);
uvw=[projected_p;depth]';

end