clear all
clc
close all

%% Ex1 --------------------------------------------------------------------

% Dados

syms x y z theta phi psi

syms LA LB LC LD LE LEE LEEE LF

syms theta1 theta2 theta3 theta4 theta5 theta6

syms pwx pwy pwz

syms dp dp1 dp2

% matriz de transformação global
oTt_i = [
    cos(theta)*cos(psi) cos(psi)*sin(phi)*sin(theta)-cos(phi)*sin(psi) cos(phi)*cos(psi)*sin(theta)+sin(phi)*sin(psi) x;
    cos(theta)*sin(psi) cos(phi)*cos(psi)+sin(phi)*sin(theta)*sin(psi) -cos(psi)*sin(phi)+cos(phi)*sin(theta)*sin(psi) y;
    -sin(theta) cos(theta)*sin(phi) cos(phi)*cos(theta) z;
    0 0 0 1]

% Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
param_eloA = [theta1, -pi/2, LB,LA];
param_eloB = [theta2-pi/2, pi, LC, 0];
param_eloC = [theta3, -pi/2, LD, 0];
param_eloC1 = [0, 0, 0, -LE];
param_eloD = [theta4, pi/2, 0, 0];
param_eloE = [theta5, -pi/2, 0, 0];
param_eloF = [theta6, 0, 0, -LF];

% Transformações de cada elo
OTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);
bTc = trans_elo(param_eloC);
cTc1 = trans_elo(param_eloC1);
c1Td = trans_elo(param_eloD);
dTe = trans_elo(param_eloE);
eTf = trans_elo(param_eloF);
fTt= rot3("x",pi);

% matriz de transformação para pw
OTw = OTa*aTb*bTc*cTc1;
OTw = simplify(OTw)

pwx1 = OTw(1,4);
pwy1 = OTw(2,4);
pwz1 = OTw(3,4);

% dp = (sqrt(pwx^2 + pwy^2) - LB)^2 + pwz^2

% calculo theta1
t1 = atan2(pwy,pwx)

% calculo theta3 (t3)
d1 = LC*sin(theta2) + LD*sin(theta2+theta3) + LE*cos(theta2+theta3);
d2 = LC*cos(theta2) + LD*cos(theta2+theta3) - LE*sin(theta2+theta3);
d = expand(d1^2) + expand(d2^2);
d = simplify(d);

k1 = -2*LC*LE;
k2 = 2*LC*LD;
k3 = dp - LC^2 - LD^2 - LE^2;

t3 = 2 * atan2(k2 + sqrt(k1^2 + k2^2 - k3^2), k1 + k3) %atenção ao +/- da raiz quadrada

% calculo theta2 (t2)
L1 = LC + LD*cos(theta3) - LE*sin(theta3);
L2 = LD*sin(theta3) + LE*cos(theta3);

t2 = acos((L2*d1 + L1*d2)/(L1^2 + L2^2)) %atenção ao +/- da raiz quadrada do d1


% p = OTw(1:3,4);
% theta = rad2deg(asin(-OTw(3,1)));
% phi = rad2deg(atan2(OTw(3,2), OTw(3,3)));
% psi = rad2deg(atan2(OTw(2,1), OTw(1,1)));
% 
% % End factor
% r = [p; phi; theta; psi];




% segundo sistema de cordenadas

%(0R3)⁻1*0R6=4R6

% matriz de [OR3]⁻¹
inv_OTw=inv(OTw);

% matriz 4R6
wTt = c1Td*dTe*eTf;
wTt = simplify(wTt);
wTf=wTt*fTt;
wTt = simplify(wTt)












den=sqrt(wTt(1,3)^2+wTt(2,3))
t5=atan2(wTt(3,3),den)
simplify(t5)

t4=atan2(-wTt(1,3),wTt(2,3))
simplify(t4)

t6=atan2(wTt(3,2),-wTt(3,1))
simplify(t6)















