function [espaco_juntas] = cinematicaInversa_RR(end_factor, dim_elos, redundancias)

LA = dim_elos(1);
LB = dim_elos(2);

x=end_factor(1);
y=end_factor(2);
% z=end_factor(3);

theta2 = redundancias*acos((x^2+y^2-LA^2-LB^2)/(2*LA*LB));
s = y*(LA+LB*cos(theta2))-x*(LB*sin(theta2));
c = x*(LA+LB*cos(theta2))+y*(LB*sin(theta2));
theta1 = atan2(s, c);

espaco_juntas = [
    rad2deg(theta1);
    rad2deg(theta2);
    ];

for i=1:size(espaco_juntas,1)
    if espaco_juntas(i)>180
        espaco_juntas(i) = espaco_juntas(i)-360;
    elseif espaco_juntas(i)<-180
        espaco_juntas(i) = espaco_juntas(i)+360;
    end
end
end

