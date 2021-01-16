function [cx,cy,cz] = transfCylinder(T,cylinder)
%transfCylinder creates new cylinder given a cylinder and transformatin
%matrix
%   T - 3D transformation matrix
%   cylinder - 3D matrix with cylinder points
% ex: 
% [cx, cy, cz] = cylinder(2);
% cz = -cz* 8;
% cylinder = zeros(4, size(cx, 2), 2);
% cylinder(:,:,1) = [cx(1,:); cz(1,:); cy(1,:); ones(1,size(cx,2))];
% cylinder(:,:,2) = [cx(2,:); cz(2,:); cy(2,:); ones(1,size(cx,2))];

n_ring1 = T*cylinder(:,:,1);
n_ring2 = T*cylinder(:,:,2);

cx = [n_ring1(1,:); n_ring2(1,:)];
cy = [n_ring1(2,:); n_ring2(2,:)];
cz = [n_ring1(3,:); n_ring2(3,:)];
end

