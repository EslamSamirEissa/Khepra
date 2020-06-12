function lookatPose=getLookatPose(eye,at)

up=[0,0,1];
zaxis=normalizeVector(at - eye);
xaxis=normalizeVector(cross(up,zaxis));
yaxis = cross(zaxis, xaxis);


lookatPose = [
     xaxis(1)           yaxis(1)           zaxis(1)          eye(1)
     xaxis(2)           yaxis(2)           zaxis(2)          eye(2)
     xaxis(3)           yaxis(3)           zaxis(3)          eye(3)
     0           0           0           1   
    ];


end
