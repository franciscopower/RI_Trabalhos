function [Q] = ji_dr(Q,t,dr,n_iter,dim_elos)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


LA = dim_elos(1);
LB = dim_elos(2);
LC = dim_elos(3);
LD = dim_elos(4);
LE = dim_elos(5);
LF = dim_elos(6);

dr

for i=1:n_iter
   
%     dr = [0;sentido_rot*R*sin(t(i))*(2*pi/n_iter);
%         R*cos(t(i))*(2*pi/n_iter)];
    ti = t(i);

    theta1 = Q(1,end);
    theta2 = Q(2,end);
    theta3 = Q(3,end);
    theta4 = Q(4,end);
    theta5 = Q(5,end);
    theta6 = Q(6,end);
    
    jacob = [LD*cos(theta2)*sin(theta1)*sin(theta3) - LC*sin(theta1)*sin(theta2) - LE*cos(theta2)*cos(theta3)*sin(theta1) - LB*sin(theta1) - LD*cos(theta3)*sin(theta1)*sin(theta2) - LF*cos(theta1)*sin(theta4)*sin(theta5) - LE*sin(theta1)*sin(theta2)*sin(theta3) - LF*cos(theta2)*cos(theta3)*cos(theta5)*sin(theta1) - LF*cos(theta5)*sin(theta1)*sin(theta2)*sin(theta3) + LF*cos(theta2)*cos(theta4)*sin(theta1)*sin(theta3)*sin(theta5) - LF*cos(theta3)*cos(theta4)*sin(theta1)*sin(theta2)*sin(theta5), LC*cos(theta1)*cos(theta2) + LD*cos(theta1)*cos(theta2)*cos(theta3) + LE*cos(theta1)*cos(theta2)*sin(theta3) - LE*cos(theta1)*cos(theta3)*sin(theta2) + LD*cos(theta1)*sin(theta2)*sin(theta3) + LF*cos(theta1)*cos(theta2)*cos(theta5)*sin(theta3) - LF*cos(theta1)*cos(theta3)*cos(theta5)*sin(theta2) + LF*cos(theta1)*cos(theta4)*sin(theta2)*sin(theta3)*sin(theta5) + LF*cos(theta1)*cos(theta2)*cos(theta3)*cos(theta4)*sin(theta5), LE*cos(theta1)*cos(theta3)*sin(theta2) - LE*cos(theta1)*cos(theta2)*sin(theta3) - LD*cos(theta1)*cos(theta2)*cos(theta3) - LD*cos(theta1)*sin(theta2)*sin(theta3) - LF*cos(theta1)*cos(theta2)*cos(theta5)*sin(theta3) + LF*cos(theta1)*cos(theta3)*cos(theta5)*sin(theta2) - LF*cos(theta1)*cos(theta4)*sin(theta2)*sin(theta3)*sin(theta5) - LF*cos(theta1)*cos(theta2)*cos(theta3)*cos(theta4)*sin(theta5), LF*cos(theta1)*cos(theta2)*sin(theta3)*sin(theta4)*sin(theta5) - LF*cos(theta4)*sin(theta1)*sin(theta5) - LF*cos(theta1)*cos(theta3)*sin(theta2)*sin(theta4)*sin(theta5), LF*cos(theta1)*cos(theta3)*cos(theta4)*cos(theta5)*sin(theta2) - LF*cos(theta1)*cos(theta2)*cos(theta3)*sin(theta5) - LF*cos(theta1)*sin(theta2)*sin(theta3)*sin(theta5) - LF*cos(theta1)*cos(theta2)*cos(theta4)*cos(theta5)*sin(theta3) - LF*cos(theta5)*sin(theta1)*sin(theta4), 0;
            LB*cos(theta1) + LC*cos(theta1)*sin(theta2) + LE*cos(theta1)*cos(theta2)*cos(theta3) - LD*cos(theta1)*cos(theta2)*sin(theta3) + LD*cos(theta1)*cos(theta3)*sin(theta2) + LE*cos(theta1)*sin(theta2)*sin(theta3) - LF*sin(theta1)*sin(theta4)*sin(theta5) + LF*cos(theta1)*cos(theta2)*cos(theta3)*cos(theta5) + LF*cos(theta1)*cos(theta5)*sin(theta2)*sin(theta3) - LF*cos(theta1)*cos(theta2)*cos(theta4)*sin(theta3)*sin(theta5) + LF*cos(theta1)*cos(theta3)*cos(theta4)*sin(theta2)*sin(theta5), LC*cos(theta2)*sin(theta1) + LD*cos(theta2)*cos(theta3)*sin(theta1) + LE*cos(theta2)*sin(theta1)*sin(theta3) - LE*cos(theta3)*sin(theta1)*sin(theta2) + LD*sin(theta1)*sin(theta2)*sin(theta3) + LF*cos(theta2)*cos(theta5)*sin(theta1)*sin(theta3) - LF*cos(theta3)*cos(theta5)*sin(theta1)*sin(theta2) + LF*cos(theta2)*cos(theta3)*cos(theta4)*sin(theta1)*sin(theta5) + LF*cos(theta4)*sin(theta1)*sin(theta2)*sin(theta3)*sin(theta5), LE*cos(theta3)*sin(theta1)*sin(theta2) - LE*cos(theta2)*sin(theta1)*sin(theta3) - LD*cos(theta2)*cos(theta3)*sin(theta1) - LD*sin(theta1)*sin(theta2)*sin(theta3) - LF*cos(theta2)*cos(theta5)*sin(theta1)*sin(theta3) + LF*cos(theta3)*cos(theta5)*sin(theta1)*sin(theta2) - LF*cos(theta2)*cos(theta3)*cos(theta4)*sin(theta1)*sin(theta5) - LF*cos(theta4)*sin(theta1)*sin(theta2)*sin(theta3)*sin(theta5), LF*cos(theta1)*cos(theta4)*sin(theta5) + LF*cos(theta2)*sin(theta1)*sin(theta3)*sin(theta4)*sin(theta5) - LF*cos(theta3)*sin(theta1)*sin(theta2)*sin(theta4)*sin(theta5), LF*cos(theta1)*cos(theta5)*sin(theta4) - LF*cos(theta2)*cos(theta3)*sin(theta1)*sin(theta5) - LF*sin(theta1)*sin(theta2)*sin(theta3)*sin(theta5) - LF*cos(theta2)*cos(theta4)*cos(theta5)*sin(theta1)*sin(theta3) + LF*cos(theta3)*cos(theta4)*cos(theta5)*sin(theta1)*sin(theta2), 0;
             0,                                                                                                             LD*cos(theta2)*sin(theta3) - LE*cos(theta2)*cos(theta3) - LC*sin(theta2) - LD*cos(theta3)*sin(theta2) - LE*sin(theta2)*sin(theta3) - LF*cos(theta2)*cos(theta3)*cos(theta5) - LF*cos(theta5)*sin(theta2)*sin(theta3) + LF*cos(theta2)*cos(theta4)*sin(theta3)*sin(theta5) - LF*cos(theta3)*cos(theta4)*sin(theta2)*sin(theta5),                                                                                                 LE*cos(theta2)*cos(theta3) - LD*cos(theta2)*sin(theta3) + LD*cos(theta3)*sin(theta2) + LE*sin(theta2)*sin(theta3) + LF*cos(theta2)*cos(theta3)*cos(theta5) + LF*cos(theta5)*sin(theta2)*sin(theta3) - LF*cos(theta2)*cos(theta4)*sin(theta3)*sin(theta5) + LF*cos(theta3)*cos(theta4)*sin(theta2)*sin(theta5),                                                                - LF*cos(theta2)*cos(theta3)*sin(theta4)*sin(theta5) - LF*sin(theta2)*sin(theta3)*sin(theta4)*sin(theta5),                                                                                          LF*cos(theta3)*sin(theta2)*sin(theta5) - LF*cos(theta2)*sin(theta3)*sin(theta5) + LF*cos(theta2)*cos(theta3)*cos(theta4)*cos(theta5) + LF*cos(theta4)*cos(theta5)*sin(theta2)*sin(theta3), 0];

   
    jacob_inv = pinv(jacob);
    dq = jacob_inv * dr;
    
    q = [theta1; theta2; theta3; theta4; theta5; theta6];
    Q = [Q q+dq];
    
end
end

