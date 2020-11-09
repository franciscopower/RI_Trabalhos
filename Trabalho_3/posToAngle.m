function [a1z,a1x,a2x,a3x,atx] = posToAngle(pos,Lj,Lt)
%POSTOANGLE Summary of this function goes here
%   Detailed explanation goes here

[azimuth,elevation,r] = cart2sph(pos(1),pos(2),pos(3));

a1z = azimuth+pi/2;
t1 = - acos((r-Lt-Lj)/(2*Lj));

a1x = pi/2 - elevation + t1;
a2x = -t1;
a3x = -t1;
atx = t1;

end

