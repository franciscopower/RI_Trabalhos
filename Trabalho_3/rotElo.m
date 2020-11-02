function [MA2, MB2, MC2] = rotElo(n_elo, eixo, angulo, MA1, MB1, MC1)
%ROTELO calculates rotation matrices for a 3 joint robot arm
%Args:
%   n_elo: number of joint to rotate (1,2,3)
%   eixo: axis to rotate around ("x","y","z")
%   angulo: angle of rotation
%   MA1,MB1,MC1: transformation matrices of previous transformations for 
%       joints 1, 2 and 3
%Returns:
%   MA2, MB2, MB3: new transformation matrices

if n_elo == 1
    MA2 = rot3("z",angulo)*MA1;
    MB2 = MA2*MA1^-1*MB1;
    MC2 = MB2*MB1^-1*MC1;
elseif n_elo == 2
    MA2 = MA1;
    MB2 = MB1*rot3("z",angulo);
    MC2 = MB2*MB1^-1*MC1;
elseif n_elo == 3
    MA2 = MA1;
    MB2 = MB1;
    MC2 = MC1*rot3("z",angulo);
end
end

