function [R] = rot(angle)
%Rotate: returns the rotation matrix given the angle in radians

 R=[cos(angle), -sin(angle) 0;
        sin(angle), cos(angle) 0;
        0 0 1];

end

