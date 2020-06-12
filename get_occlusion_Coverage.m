function [covered_triangles_bool,pass1_triangles,pass2_triangles]=get_occlusion_Coverage(model,camera)

vertex_count= size(model.vertices,1);
covered_vertices_bool=zeros(vertex_count,1);

triangle_count=size(model.faces,1);
covered_triangles_bool=zeros(triangle_count,1);
covered_triangles=NaN(triangle_count,3);

theta=NaN(vertex_count,1);

modelNormals=patchnormals(model);
note=helpdlg('Please wait, Zhang Occlusion Calculation in Progress...','Please Wait...');
   for i=1:size(modelNormals,1)
       p1=model.vertices(i,:); 
       p2=model.vertices(i,:)-4*modelNormals(i,:);
       p3=camera.centre()';
       
       S1= p2-p1;
       S2= p3-p1;
       
       theta(i) = rad2deg(atan2(norm(cross(S1, S2)), dot(S1, S2)));
       
       if theta(i)<90
           
           covered_vertices_bool(i)=1;
           
       end   
       
       
   end
   
   
   for i=1:size(model.faces,1)  %Loop through triangle list and get covered triangles from covered vertices

        v_index_1=model.faces(i,1);
        v_index_2=model.faces(i,2);
        v_index_3=model.faces(i,3);

        if (covered_vertices_bool(v_index_1)==1) && (covered_vertices_bool(v_index_2)==1) && (covered_vertices_bool(v_index_3)==1)
            
            covered_triangles_bool(i)=1;
            covered_triangles(i,:)=model.faces(i,:);
            
        end
    
    end

   pass1_triangles=covered_triangles;   % Visible triangles after Backface culling
   
   
   % Get occluded vertices
   tic
   optical_center=camera.centre();
   
   for i=1:size(covered_triangles,1)  %From the visible triangle list, pick a triangle
           if isnan(covered_triangles(i,1))  %If current selected triangle is eliminated, skip it
               continue;
           end
       
       for k=1:3    %Loop through vertices of the picked triangle
           if isnan(covered_triangles(i,1)) %If current selected triangle is eliminated, skip  checking its other vertices
               break;
           end
           
           for m=1:size(covered_triangles,1)  %Loop through visible triangle list
               
               if i==m || isnan(covered_triangles(m,1))    
                   continue;        % Discard currently selected triangle from comparison  
               end 
               
               %try

               tested_vertex=model.vertices( covered_triangles(i,k),:);
               
               %catch
                   %display("i= "+i+" k= "+k+" m= "+m);
                   
               %end
               
               v1=model.vertices( covered_triangles(m,1),:);
               try
               v2=model.vertices( covered_triangles(m,2),:);
               catch
                   display("i= "+i+" k= "+k+" m= "+m);
               end
                   
               v3=model.vertices( covered_triangles(m,3),:);
               
               test_triangle_centroid= [ ((v1(1)+v2(1)+v3(3)))/3 ((v1(2)+v2(2)+v3(2)))/3 ((v1(3)+v2(3)+v3(3)))/3 ];
               
               if norm(tested_vertex-optical_center) <= norm(test_triangle_centroid-optical_center)
                   continue;        % Discard currently selected triangle from comparison if its behind the tested vertex  
               end                  
               
               
               if ( (isequal(tested_vertex,v1)) || (isequal(tested_vertex,v2)) || (isequal(tested_vertex,v3)) )
                   continue;        % Discard currently selected triangle from comparison if it contain the tested vertex  
               end 

               origin = optical_center';
               direction=(origin-tested_vertex);
                
                i_flag = rayTriangleIntersection(origin, direction, v1, v2, v3);

               if i_flag==1     %If vertex is occluded by another triangle
                   condemned_vertex= model.vertices( covered_triangles(i,k),:);
                   covered_triangles(i,:)=NaN;   %Eliminate Whole triangle with the vertex
                   
                   covered_triangles_bool(i)=0;
                   
                   %[covered_triangles,covered_triangles_bool]=removeTrianglebyVertex(condemned_vertex,covered_triangles_bool,covered_triangles,model); %Eliminate Whole triangle with the vertex Eliminate any other triangles that has that vertex to avoid rechecking the same vertex again
                   break;   % If vertex was found to be occluded by a triangle, skip checking other triangles as there's no need
                   
               end
           end
       end
   end
   
    %covered_triangles(isnan(covered_triangles)) = [];  %Remove Eliminated Triangles from the Triangle list
    pass2_triangles=covered_triangles;
    close(note);
   end
   
   
   


function [triangles_bool,triangles]=removeTrianglebyVertex(vertex,triangles_bool,triangleList,model)

triangles=triangleList;

    for i=1:size(triangles,1)  %From the visible triangle list, pick a triangle
        
        if isnan(triangles(i,1)) % Skip selected triangle if it was already eliminated
            continue;
        end
        
        for k=1:3
            if model.vertices( triangleList(i,k),:)== vertex  
                triangles(i,:)=NaN;
                triangles_bool(i)=0;
                break;
            end
        end
        
    end
end





