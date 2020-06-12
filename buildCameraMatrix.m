function C=buildCameraMatrix(f,sensor_dim,res,camera_pose)

W=sensor_dim(1);
H=sensor_dim(2);


rho=[W/res(1),H/res(2)];
pp = res/2;


    C = [   f/rho(1)     0           pp(1)   0
            0            f/rho(2)    pp(2)   0
            0            0           1         0
        ] * inv(camera_pose);


end