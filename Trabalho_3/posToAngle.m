function [a1z,a1x,a2x,a3x] = posToAngle(pos,Lj,Lt)
%POSTOANGLE Summary of this function goes here
%   Detailed explanation goes here

[azimuth,elevation,r] = cart2sph(pos(1),pos(2),pos(3));

a1z = rad2deg(azimuth);
t1 = acos((r-Lj)/(2*Lj));
t2 = acos((cos(t1)*Lj)/(Lj+Lt));

a1x = rad2deg(elevation + t1);
a2x = rad2deg(-t1);
a3x = rad2deg(-t2);

end

