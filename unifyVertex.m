function [f,v,vd] = unifyVertex(faces,vertices)
%unifyVertex unifies the duplicated vertices of a triangular meshed object
% INPUT:
%   faces - input facet triangulation 
%   vertices - input vertex coordinates
% OUTPUT:
%   f - unified facet triangulation
%   v - unified vertex coordinates
%   vd - indices of duplicated vertices
%
%   Author: Di Zhu 2016-05-02
   
cri = sum(vertices,2); % sum as criterion for duplication
 
if (length(unique(cri)) == length(unique(vertices,'rows')))
    vd = dupV ( cri );
else
    cri = cri + vertices(:,1);
    vd = dupV ( cri );
end
%----------------------------------------rewrite vertex info
v = zeros(length(vd),3);
for i = 1 : length(vd)
    v(i,:) = vertices(vd(i,1),:);
end
%-----------------------------------------rewrite facet info
nf = size(faces,1);
f = zeros(nf,3);
for i = 1 : nf
    for j = 1 : 3
        [row,~] = find(vd == faces(i,j));
        f(i,j) = row;
    end
end
end % end of function sub_unify
function [ vd ] = dupV ( cri )
nv = size(cri,1);
vd = []; % index of duplicated vertex
n = 0;
for i = 1 : nv
    if cri(i) == cri(1)
        n = n + 1;
        vd(1,n) = i; %duplicated vertices with V1
    else
    end
end
%-----------removing vertices above from original match list
match = ones(nv,1);
for i = 1 : length(vd)
    match(vd(i)) = 0;
end
%----complete detecting all vertices for duplicated elements
r = 1; % indicating row index
for i = 2 : nv % start scanning all points from v2
    c = 0; % indicating colomn index
    if match(i) ~= 0;  % has Vi been removed from original list already?
        r = r + 1;    % r++ when new vertex detected
        for m = i : nv % start scanning from Vi
            if cri(i) == cri(m);
                c = c + 1; % c++ when another vertex found equal to Vi
                vd(r,c) = m; % add index for duplicated element to "duplicated vertices"
                match(m) = 0; % remove Vi from original list
            end
        end
    else
    end
end
end % end of sub-function dupV