function [occlusion_per_triangle,visible_triangles]=getMultiOcclusionCoverage_PPM(uvw,model,camera_pose)


triangle_count=size(model.faces,1);
%occlusion_per_triangle=NaN(triangle_count,1);
visible_triangles=NaN(triangle_count,3);

polyshape_list(1:triangle_count)=polyshape();

occlusion_per_triangle=NaN(triangle_count,1);

model.faces=backfaceCulling(model,camera_pose);

%waitbar_occlusion = waitbar(0,'Calculating Occlusion for Triangle # 1','Name','Please wait...');
note=helpdlg('Please wait, Occlusion Calculation in Progress...','Please Wait...');

for i=1:triangle_count
    
    %progress_index=i/triangle_count;
    
    %waitbar_string="Calculating Occlusion for Triangle #"+i;
    
    %waitbar(progress_index,waitbar_occlusion,waitbar_string);
    
    
    
    if isnan(model.faces(i,1))  %If current selected triangle is eliminated, skip it
        continue;
    end
    
    if occlusion_per_triangle(i)==1 % Exclude triangle from intersection check if it's 100% occluded
        continue;
    end
    
    
    intersected_triangles_bool=zeros(triangle_count,1);

    A=uvw((model.faces(i,1)),:);
    B=uvw((model.faces(i,2)),:);
    C=uvw((model.faces(i,3)),:);    %Select a triangle from list
    
    %centroid_u=(A(1)+B(1)+C(1))/3;
    %centroid_v=(A(2)+B(2)+C(2))/3;
    centroid_w=(A(3)+B(3)+C(3))/3;
    %centroid=[centroid_u,centroid_v,centroid_w];
    
%     figure(2)
%     line([A(1),B(1)], [A(2), B(2)], 'Color', 'r');
%     hold on;
%     line([B(1),C(1)], [B(2), C(2)], 'Color', 'r');
%     line([C(1),A(1)], [C(2), A(2)], 'Color', 'r');
    
    
    
    
    for j=1:triangle_count          %Select a triangle to compare

        
        if i==j || isnan(model.faces(j,1))
            continue;
        end
        
        E=uvw(model.faces(j,1),:);
        F=uvw(model.faces(j,2),:);
        G=uvw(model.faces(j,3),:);
        
        if isequal(A,E) || isequal(A,F) || isequal(A,G) || isequal(B,E) || isequal(B,F) || isequal(B,G) || isequal(C,E) || isequal(C,F) || isequal(C,G)
            continue; % Skip triangle if it shares any vertex with the tested one
        end
        
        if occlusion_per_triangle(j)==1 % Exclude triangle from intersection check if it's 100% occluded
            continue;
        end
        
        
%         if isequal(uvw(model.faces(i,1),:),uvw(model.faces(j,1),:)) || isequal(uvw(model.faces(i,1),:),uvw(model.faces(j,2),:)) || isequal(uvw(model.faces(i,1),:),uvw(model.faces(j,3),:)) ||...
%            isequal(uvw(model.faces(i,2),:),uvw(model.faces(j,1),:)) || isequal(uvw(model.faces(i,2),:),uvw(model.faces(j,2),:)) || isequal(uvw(model.faces(i,2),:),uvw(model.faces(j,3),:)) ||...
%            isequal(uvw(model.faces(i,3),:),uvw(model.faces(j,1),:)) || isequal(uvw(model.faces(i,3),:),uvw(model.faces(j,2),:)) || isequal(uvw(model.faces(i,3),:),uvw(model.faces(j,3),:))
%         
%         
%             continue; % Skip triangle if it shares any vertex with the tested one
%         end
        
        
        

        
        
        tri= [A,B;B,C;C,A];
        flag=0;
        for p=1:3
            
            
            if checkIntersection(tri(p,1:2),tri(p,4:5),E(1:2),F(1:2))
                intersected_triangles_bool(j)=1;
                flag=1;
                break
            elseif checkIntersection(tri(p,1:2),tri(p,4:5),F(1:2),G(1:2))
                intersected_triangles_bool(j)=1;
                flag=1;
                break
            elseif checkIntersection(tri(p,1:2),tri(p,4:5),G(1:2),E(1:2))
                intersected_triangles_bool(j)=1;
                flag=1;
                break
            end
            
        end
        
        
        

        if flag==0 %Check that Triangle is inside the other
            flag2=0;
            for k=1:3
                
                D=uvw(model.faces(j,k),:);
                
                
                w1=   (( (A(1)*(C(2)-A(2))) + (D(2)-A(2))*(C(1)-A(1)) - D(1)*(C(2)-A(2)) ) / (((B(2)-A(2))*(C(1)-A(1)))-((B(1)-A(1))*(C(2)-A(2)))));
                w2=   (D(2)-A(2)-w1*(B(2)-A(2))) / (C(2)-A(2));
                
                
                if (w1>0) && (w2>0) && (round(w1+w2,10)<1)
                    %intersected_triangles_bool(j)=1;
                    %intersected_triangles_indices=[intersected_triangles_indices j];
                    flag2=flag2+1;
                end
            end
            
            if flag2==3 %    Triangle is inside the other
                intersected_triangles_bool(j)=1;
            end
            
        end
        
        
    end
    
    
    
    
    
    intersected_triangles_number=sum(intersected_triangles_bool); %Count the number of intersected triangles by their flags
    
    if intersected_triangles_number==0
        occlusion_per_triangle(i)=0;
        %model.faces(i,:)=NaN;
        continue;
    end
    
    
    
    intersected_triangles_indices=zeros(intersected_triangles_number,2);    %Create intersection/centroid array with length of number of intersected flags
    pointer=1;
    for m=1:triangle_count
        
        if intersected_triangles_bool(m)==1           
            intersected_triangles_indices(pointer,1)=m; 
            E=uvw((model.faces(m,1)),:);
            F=uvw((model.faces(m,2)),:);
            G=uvw((model.faces(m,3)),:);
            centroid_d=(E(3)+F(3)+G(3))/3;
            intersected_triangles_indices(pointer,2)=centroid_d;
            pointer=pointer+1;                                      %Compile all intersected triangles indices and their respective centroid depth: [index centroid]
        end
    end
    intersected_triangles_indices=[intersected_triangles_indices;[i centroid_w]]; %Append the tested triangle into the intersection/centroid array
    
    %plotProjectedTriangles(uvw,intersected_triangles_indices,model,[1280,800]);
    
    [a_sorted, a_order] = sort(intersected_triangles_indices(:,2));
    N=intersected_triangles_indices(:,1);
    intersected_triangles_sorted = N(a_order(:));           %Sort triangle indices by distance of their centroid from the camera in ascending order
    
    front_triangle_index=intersected_triangles_sorted(1);   %First triangle is unoccluded
    occlusion_per_triangle(front_triangle_index)=0;
    visible_triangles(front_triangle_index,:)=(model.faces(front_triangle_index,:));
    
    A=uvw((model.faces(front_triangle_index,1)),:);
    B=uvw((model.faces(front_triangle_index,2)),:);
    C=uvw((model.faces(front_triangle_index,3)),:);
    triangle_front=polyshape([ A(1) B(1) C(1)],[A(2) B(2) C(2)]);
    
    for n=2:size(intersected_triangles_sorted,1)
        
        E=uvw((model.faces(intersected_triangles_sorted(n),1)),:);
        F=uvw((model.faces(intersected_triangles_sorted(n),2)),:);
        G=uvw((model.faces(intersected_triangles_sorted(n),3)),:);
        
        triangle_back=polyshape([ E(1) F(1) G(1)],[E(2) F(2) G(2)]);
        
        if isnan(occlusion_per_triangle(intersected_triangles_sorted(n)))   %If triangle coverage score is a NaN
            
            subtracted_triangle= subtract(triangle_back,triangle_front);
            subtracted_polyshape_area=area(subtracted_triangle);
            triangle_back_area=abs(  ( E(1)* ( F(2)-G(2) ) + F(1)* ( G(2)-E(2) )+ G(1)*( E(2)-F(2) ) ) /2);
%             if(subtracted_polyshape_area==0)
%                 
%                 intersected_polyshape=intersect(convhull(triangle_front),triangle_back);
%                 
%                 if isequal(intersected_polyshape,triangle_back)
%                     occlusion_per_triangle(intersected_triangles_sorted(n))=1;
%                     continue;
%                 end
%                 
%                 triangle_front=union(triangle_front,triangle_back);
%                 continue;
%             end
            temp_occlusion=1-(subtracted_polyshape_area/triangle_back_area);
            occlusion_per_triangle(intersected_triangles_sorted(n))=temp_occlusion; %Get partial occlusion score for the triangle
            polyshape_list(intersected_triangles_sorted(n))=subtracted_triangle;    %Save its polyshape object for later use
        
        elseif occlusion_per_triangle(intersected_triangles_sorted(n))==1   %If triangle is already occluded skip it
            triangle_front=union(triangle_front,triangle_back);
            continue
              
        else
            
            subtracted_triangle= subtract(polyshape_list(intersected_triangles_sorted(n)),triangle_front);   %If triangle has already occlusion score, subtract front triangle from the polyshape
            subtracted_polyshape_area=area(subtracted_triangle);
            triangle_back_area=abs(  ( E(1)* ( F(2)-G(2) ) + F(1)* ( G(2)-E(2) )+ G(1)*( E(2)-F(2) ) ) /2);
            
            if(subtracted_polyshape_area==0) || (subtracted_polyshape_area==triangle_back_area)
            
                %intersected_polyshape=intersect(convhull(triangle_front),triangle_back);
                union_polyshape=union(triangle_front,triangle_back);
                
                if round(area(union_polyshape),3)==round(area(triangle_front),3)
                    occlusion_per_triangle(intersected_triangles_sorted(n))=1;
                    continue
                end
                
%                 if isequal(union_polyshape,triangle_front)
%                     occlusion_per_triangle(intersected_triangles_sorted(n))=1;
%                     continue;
%                 end

                triangle_front=union(triangle_front,triangle_back);
                continue;
            end
            
            temp_occlusion=1-(subtracted_polyshape_area/triangle_back_area);
            
            occlusion_per_triangle(intersected_triangles_sorted(n))=round(temp_occlusion,3);
            polyshape_list(intersected_triangles_sorted(n))=subtracted_triangle; 
        end
        
%         intersected_triangle = intersect(triangle_front,triangle_back);
%         
%         
%         %intersected_triangle_area=abs(  ( intersected_triangle.Vertices(1,1)* ( intersected_triangle.Vertices(2,2)-intersected_triangle.Vertices(3,2) ) + intersected_triangle.Vertices(2,1)* ( intersected_triangle.Vertices(3,2)-intersected_triangle.Vertices(1,2) )+ intersected_triangle.Vertices(3,1)*( intersected_triangle.Vertices(1,2)-intersected_triangle.Vertices(2,2) ) ) /2);
%         intersected_polyshape_area=area(intersected_triangle);
%         subtracted_polyshape_area=area(subtracted_triangle);
%         
%         triangle_back_area=abs(  ( E(1)* ( F(2)-G(2) ) + F(1)* ( G(2)-E(2) )+ G(1)*( E(2)-F(2) ) ) /2);
%         
%         temp_occlusion=(intersected_polyshape_area/triangle_back_area);
%         
%         
%         
%         if isnan(occlusion_per_triangle(intersected_triangles_sorted(n)))
%             occlusion_per_triangle(intersected_triangles_sorted(n))=temp_occlusion;
%         else
%             occlusion_per_triangle(intersected_triangles_sorted(n))=occlusion_per_triangle(intersected_triangles_sorted(n))+temp_occlusion;
%         end
        
        
        triangle_front=union(triangle_front,triangle_back);
        
    end

end
    occlusion_per_triangle=round(occlusion_per_triangle,3);
    
    %close(waitbar_occlusion);
    close(note);
end
                  
