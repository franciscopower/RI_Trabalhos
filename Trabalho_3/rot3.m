function [R] = rot3(axis, theta)
%rot3 Creates 3D rotation matrix

if axis == "x"
    R = [1 0 0 0;
        0 cos(theta) -sin(theta) 0;
        0 sin(theta) cos(theta) 0;
        0 0 0 1];
elseif axis == "y"
    R = [cos(theta) 0 sin(theta) 0;
        0 1 0 0;
        -sin(theta) 0 cos(theta) 0;
        0 0 0 1];
elseif axis == "z"
    R = [cos(theta) -sin(theta) 0 0;
        sin(theta) cos(theta) 0 0;
        0 0 1 0;  
        0 0 0 1];
end

