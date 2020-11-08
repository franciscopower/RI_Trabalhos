function [MA2, MB2, MC2, Mt2] = rotJoint(n_elo, axis, angle, MA1, MB1, MC1, Mt1)
%ROTELO calculates rotation matrices for a 3 joint robot arm
%Args:
%   n_elo: number of joint to rotate (1,2,3)
%   axis: axis to rotate around ("x","y","z")
%   angle: angle of rotation
%   MA1,MB1,MC1: transformation matrices of previous transformations for 
%       joints 1, 2 and 3
%Returns:
%   MA2, MB2, MB3: new transformation matrices

if n_elo == 1
    MA2 = rot3(axis,angle)*MA1;
    MB2 = MA2*MA1^-1*MB1;
    MC2 = MB2*MB1^-1*MC1;
    Mt2 = MC2*MC1^-1*Mt1;
elseif n_elo == 2
    MA2 = MA1;
    MB2 = MB1*rot3(axis,angle);
    MC2 = MB2*MB1^-1*MC1;
    Mt2 = MC2*MC1^-1*Mt1;
elseif n_elo == 3
    MA2 = MA1;
    MB2 = MB1;
    MC2 = MC1*rot3(axis,angle);
    Mt2 = MC2*MC1^-1*Mt1;
end
end

