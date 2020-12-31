function [espaco_juntas] = cinematicaInversa(end_factor, dim_elos)

LA = dim_elos(1);
LB = dim_elos(2);
LC = dim_elos(3);
LD = dim_elos(4);
LE = dim_elos(5);
LF = dim_elos(6);

x=end_factor(1);
y=end_factor(2);
z=end_factor(3);
phi= end_factor(4);
theta= end_factor(5);
psi= end_factor(6);

oTt_i = [
    cos(theta)*cos(psi) cos(psi)*sin(phi)*sin(theta)-cos(phi)*sin(psi) cos(phi)*cos(psi)*sin(theta)+sin(phi)*sin(psi) x;
    cos(theta)*sin(psi) cos(phi)*cos(psi)+sin(phi)*sin(theta)*sin(psi) -cos(psi)*sin(phi)+cos(phi)*sin(theta)*sin(psi) y;
    -sin(theta) cos(theta)*sin(phi) cos(phi)*cos(theta) z;
    0 0 0 1];

pw = [x;y;z] - LF*oTt_i(1:3,3);
pwx = pw(1); pwy=pw(2); pwz=pw(3);

%----------------------------------------------
%calculo theta1
theta1=atan2(pwy,pwx);

%calculo theta3
dp = (sqrt(pwx^2 + pwy^2) - LB)^2 + pwz^2;

k2 = 2*LC*LE;
k1 = 2*LC*LD;
k3 = dp - (LC^2 + LD^2 + LE^2);

theta3 = 2 * atan2(k2 - sqrt(k1^2 + k2^2 - k3^2), k1 + k3);

%calculo theta2
L1 = LC + LD*cos(theta3) + LE*sin(theta3);
L2 = LE*cos(theta3) - LD*sin(theta3);
C2 = (L2*(sqrt(pwx^2 + pwy^2)-LB) + L1*pwz)/(L1^2 + L2^2);
theta2 = asin((L1*C2 - pwz)/L2);

%     redundancia theta1 - inadmissivel
%     theta1 = theta1 + pi;
%     theta2 = pi - theta2;
%     theta3 = - theta3;

%-----------------------------------------------------
%calculos theta4,5,6

% Tabela de Denavit-Hartenberg
% param_eloN = [theta, alfa, l, d]
param_eloA = [theta1, -pi/2, LB,LA];
param_eloB = [theta2-pi/2, pi, LC, 0];
param_eloC = [theta3, -pi/2, LD, 0];
param_eloC1 = [0, 0, 0, -LE];

% Transformações de cada elo
OTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);
bTc = trans_elo(param_eloC);
cTc1 = trans_elo(param_eloC1);

oTw = OTa*aTb*bTc*cTc1;

wTt = oTw^-1 * oTt_i;

theta5 = atan2(+sqrt(wTt(1,3)^2 + wTt(2,3)^2),-wTt(3,3));

theta4 = atan2(wTt(2,3)*sin(theta5), wTt(1,3)*sin(theta5));

theta6 = atan2(wTt(3,2)*sin(theta5), wTt(3,1)*sin(theta5));

%redundancias

%     theta2 = theta2 - pi;
%     theta3 = theta3 - 2*pi;
%     theta4 = theta4 - pi;
%     theta5 = theta5 - pi;
%     theta6 = - theta6 + pi;

% confirmar
espaco_juntas = [
    rad2deg(theta1);
    rad2deg(theta2);
    rad2deg(theta3);
    rad2deg(theta4);
    rad2deg(theta5);
    rad2deg(theta6);
    ];

for i=1:size(espaco_juntas,1)
    if espaco_juntas(i)>180
        espaco_juntas(i) = espaco_juntas(i)-360;
    elseif espaco_juntas(i)<-180
        espaco_juntas(i) = espaco_juntas(i)+360;
    end
end
end

