function [T] = trans_elo(eloN)
%TRANS_ELO returns the transformation matrix of a segment given its
%parameters

t = eloN(1);
a = eloN(2);
l = eloN(3);
d = eloN(4);

% Alternative way to calculate T
% Rz = [cos(t) -sin(t) 0 0;
%     sin(t) cos(t) 0 0;
%     0 0 1 0;
%     0 0 0 1];
% 
% Tx = [1 0 0 l;
%     0 1 0 0;
%     0 0 1 0;
%     0 0 0 1];
% 
% Tz = [1 0 0 0;
%     0 1 0 0;
%     0 0 1 d;
%     0 0 0 1];
% 
% Rx = [1 0 0 0;
%     0 cos(a) -sin(a) 0;
%     0 sin(a) cos(a) 0;
%     0 0 0 1];
% 
% T = Rz*Tx*Tz*Rx;

T = [cos(t) -sin(t)*cos(a) sin(t)*sin(a) l*cos(t);
    sin(t) cos(t)*cos(a) -cos(t)*sin(a) l*sin(t);
    0 sin(a) cos(a) d;
    0 0 0 1];

end

