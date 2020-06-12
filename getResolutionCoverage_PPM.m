function [pix_per_tri,pix_per_tri_nrmlized,pix_per_tri_nrmlized_2]=getResolutionCoverage_PPM(uvw,model,minimum_res)

triangle_count=size(model.faces,1);

pix_per_tri=zeros(triangle_count,1);
pix_per_tri_nrmlized=zeros(triangle_count,1);


for i=1:triangle_count
    
    
    A=uvw((model.faces(i,1)),:);
    B=uvw((model.faces(i,2)),:);
    C=uvw((model.faces(i,3)),:);
    
    pix_per_tri(i)=abs(  ( A(1)* ( B(2)-C(2) ) + B(1)* ( C(2)-A(2) )+ C(1)*( A(2)-B(2) ) ) /2);     
    pix_per_tri_nrmlized(i)=pix_per_tri(i)/minimum_res;
    
    
    
end


pix_per_tri_nrmlized_2=pix_per_tri_nrmlized/max(pix_per_tri_nrmlized);



end