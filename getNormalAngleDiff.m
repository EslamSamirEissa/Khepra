function angle=getNormalAngleDiff(triangle1,triangle2,normals,centroid)

p1=centroid(triangle1,:);
p2=normals(triangle1,:)+p1;

p3=centroid(triangle2,:);
p4=normals(triangle2,:)+p3;



s1=p2-p1;
s2=p4-p3;
  
%angle=rad2deg(acos(dot(s1,s2)/(norm(s1)*norm(s2))));

angle = rad2deg(atan2(norm(cross(s1, s2)), dot(s1, s2)));

angle=round(angle,4);

end