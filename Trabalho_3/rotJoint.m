function [oTa2, oTb2, oTc2, oTt2] = rotJoint(n_elo, axis, angle, oTa1, oTb1, oTc1, oTt1)
%ROTELO calculates rotation matrices for a 3 joint robot arm
%Args:
%   n_elo: number of joint to rotate (1,2,3)
%   axis: axis to rotate around ("x","y","z")
%   angle: angle of rotation
%   oTa1,oTb1,oTc1,oTt1: transformation matrices of previous transformations for 
%       joints 1, 2 and 3
%Returns:
%   oTa2, oTb2, oTc2, oTt2: new transformation matrices

if n_elo == 1
    oTa2 = rot3(axis,angle)*oTa1;
    oTb2 = oTa2*oTa1^-1*oTb1;
    oTc2 = oTb2*oTb1^-1*oTc1;
    oTt2 = oTc2*oTc1^-1*oTt1;
elseif n_elo == 2
    oTa2 = oTa1;
    oTb2 = oTb1*rot3(axis,angle);
    oTc2 = oTb2*oTb1^-1*oTc1;
    oTt2 = oTc2*oTc1^-1*oTt1;
elseif n_elo == 3
    oTa2 = oTa1;
    oTb2 = oTb1;
    oTc2 = oTc1*rot3(axis,angle);
    oTt2 = oTc2*oTc1^-1*oTt1;
elseif n_elo == 4
    oTa2 = oTa1;
    oTb2 = oTb1;
    oTc2 = oTc1;
    oTt2 = oTt1*rot3(axis,angle);
end
end

