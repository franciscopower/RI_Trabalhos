function [M] = rot_2D(M_in,theta)
%rot_2d rotates a 2 x n matrix by theta radians.

R = [cos(theta) -sin(theta);
    sin(theta) cos(theta)];
M = R * M_in;

end
