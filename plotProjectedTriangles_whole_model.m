function plotProjectedTriangles_whole_model(uvw,model,image_dim,edge_color,face_color)


note=helpdlg('Please wait, Plotting in Progress...','Please Wait...');
figure;
hold on;

for i=1:size(model.faces,1)
    

    %progress_index=i/triangle_count;
    
    %waitbar_string="Plotting Projected Triangle #"+i;
    
    %waitbar(progress_index,waitbar_draw_image_plane,waitbar_string);
    
    
    A=uvw((model.faces(i,1)),:);
    B=uvw((model.faces(i,2)),:);
    C=uvw((model.faces(i,3)),:);
    
    line([A(1),B(1)], [A(2), B(2)], 'Color', edge_color);
    hold on;
    line([B(1),C(1)], [B(2), C(2)], 'Color', edge_color);
    line([C(1),A(1)], [C(2), A(2)], 'Color', edge_color);
    
    plot(A(1,1),A(1,2),'Color','r','Marker','square','MarkerFaceColor',face_color,'MarkerSize',A(1,3));
    plot(B(1,1),B(1,2),'Color','r','Marker','square','MarkerFaceColor',face_color,'MarkerSize',B(1,3));
    plot(C(1,1),C(1,2),'Color','r','Marker','square','MarkerFaceColor',face_color,'MarkerSize',C(1,3));
    
end

close(note);

title('Image Plane')
xlabel('u (pixels)');
ylabel('v (pixels)');
xlim([0 image_dim(1)]);
ylim([0 image_dim(2)]);
pbaspect([image_dim(1) image_dim(2) image_dim(2)]);
grid on;
grid minor;
ax = gca;
ax.YDir = 'reverse';



% figure(1);
% 
% patch(model,'FaceColor',       'k', ...
%     'EdgeColor',       'none',        ...
%     'FaceLighting',    'gouraud',     ...
%     'AmbientStrength', 0.15);
% 
% for i=1:size(triangle_indices,1)
%     patch('Faces',(model.faces(triangle_indices(i),:)) ,'Vertices',model.vertices,'FaceColor',       'red', ...
%         'EdgeColor',       'k',        ...
%         'FaceLighting',    'gouraud',     ...
%         'AmbientStrength', 0.15);
% end
% axis('image');
% view([-135 35]);
end