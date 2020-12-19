function [elo] = createCylinder(r,h,plane)
%CREATECYLINDER Summary of this function goes here
%   Detailed explanation goes here
[cx, cy, cz] = cylinder(r);
cz = cz * h;
elo = zeros(4, size(cx, 2), 2);

if plane=="xy" || plane=="yx"
    elo(:,:,1) = [cx(1,:); cy(1,:); cz(1,:); ones(1,size(cx,2))];
    elo(:,:,2) = [cx(2,:); cy(2,:); cz(2,:); ones(1,size(cx,2))];
elseif plane=="xz" || plane=="zx"
    elo(:,:,1) = [cx(1,:); cz(1,:); cy(1,:); ones(1,size(cx,2))];
    elo(:,:,2) = [cx(2,:); cz(2,:); cy(2,:); ones(1,size(cx,2))];
else
    elo(:,:,1) = [cz(1,:); cy(1,:); cx(1,:); ones(1,size(cx,2))];
    elo(:,:,2) = [cz(2,:); cy(2,:); cx(2,:); ones(1,size(cx,2))];
end

end

