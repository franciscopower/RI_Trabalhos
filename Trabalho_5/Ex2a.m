clear all
clc

%% Ex1 --------------------------------------------------------------------

% Dados
syms LA LB LC LD LE LEE LEEE LF

syms theta1 theta2 theta3 theta4 theta5 theta6

syms pwx pwy pwz

syms dp

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

% calculo posicao
OTw = OTa*aTb*bTc*cTc1;
OTw = simplify(OTw)

pwx1 = OTw(1,4);
pwy1 = OTw(2,4);
pwz1 = OTw(3,4);

% dp = (sqrt(pwx^2 + pwy^2) - LB)^2 + pwz^2

% calculo theta3 (t3)
d1 = LC*sin(theta2) + LD*sin(theta2+theta3) + LE*cos(theta2+theta3);
d2 = LC*cos(theta2) + LD*cos(theta2+theta3) - LE*sin(theta2+theta3);
d = expand(d1^2) + expand(d2^2);
d = simplify(d)

k1 = -2*LC*LE;
k2 = 2*LC*LD;
k3 = dp - LC^2 - LD^2 - LE^2;

t3 = 2 * atan2(k2 + sqrt(k1^2 + k2^2 - k3^2), k1 + k3) %atenção ao +/- da raiz quadrada

% calculo theta2 (t2)



% p = OTw(1:3,4);
% theta = rad2deg(asin(-OTw(3,1)));
% phi = rad2deg(atan2(OTw(3,2), OTw(3,3)));
% psi = rad2deg(atan2(OTw(2,1), OTw(1,1)));
% 
% % End factor
% r = [p; phi; theta; psi];




