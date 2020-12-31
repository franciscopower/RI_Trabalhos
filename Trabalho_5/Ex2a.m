clear all
clc
close all

% Ex2a --------------------------------------------------------------------

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

% Tabela de Denavit-Hartenberg
% param_eloN = [theta, alfa, l, d]
param_eloA = [theta1, -pi/2, LB,LA];
param_eloB = [theta2-pi/2, pi, LC, 0];
param_eloC = [theta3, -pi/2, LD, 0];
param_eloC1 = [0, 0, 0, -LE];
param_eloD = [theta4, pi/2, 0, 0];
param_eloE = [theta5, -pi/2, 0, 0];
param_eloF = [theta6, pi, 0, -LF];

% Transformações de cada elo
OTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);
bTc = trans_elo(param_eloC);
cTc1 = trans_elo(param_eloC1);
c1Td = trans_elo(param_eloD);
dTe = trans_elo(param_eloE);
eTf = trans_elo(param_eloF);

% matriz de transformação para pw
OTw = OTa*aTb*bTc*cTc1;
OTw = simplify(OTw)

% calculo do pw
pw = [x;y;z] - LF*oTt_i(1:3,3)
pwx = pw(1); pwy=pw(2); pwz=pw(3);

% __________________Calculos thetas_____________________________________

% POSICIONAMENTO DO PUNHO

% calculo theta1
t1 = atan2(pwy,pwx)

% calculo theta3 (t3)
d1 = LC*sin(theta2) + LD*sin(theta2-theta3) + LE*cos(theta2-theta3);
d2 = LC*cos(theta2) + LD*cos(theta2-theta3) - LE*sin(theta2-theta3);
d = expand(d1^2) + expand(d2^2);
d = simplify(d)

% dp = (sqrt(pwx^2 + pwy^2) - LB)^2 + pwz^2 = d

k2 = 2*LC*LE;
k1 = 2*LC*LD;
k3 = dp - LC^2 - LD^2 - LE^2;

t3 = 2 * atan2(k2 - sqrt(k1^2 + k2^2 - k3^2), k1 + k3)

% calculo theta2 (t2)
L1 = LC + LD*cos(theta3) + LE*sin(theta3);
L2 = LE*cos(theta3) - LD*sin(theta3);
C2 = (L2*(sqrt(pwx^2 + pwy^2)-LB) + L1*pwz)/(L1^2 + L2^2);
theta2 = asin((L1*C2 - pwz)/L2);

%redundancia do ombro - inadmissivel
%theta1 = theta1 + pi;
%theta2 = pi - theta2;
%theta3 = - theta3;

% ORIENTACAO DO PUNHO

% matriz wTt para dedução das formulas do theta5,4 e 6
wTt = c1Td*dTe*eTf;
wTt = simplify(wTt)

% matriz oTw em função do endfactor e theta1,2 e 3
oTw = OTa*aTb*bTc*cTc1;

% matriz wTt com os valores a usar no calculo de theta5,4 e 6
wTt = oTw^-1 * oTt_i;

% calculo theta5
theta5 = atan2(+sqrt(wTt(1,3)^2 + wTt(2,3)^2),-wTt(3,3));
% redundancia do punho: sinal da raiz quadrada no calculo do theta5

% calculo theta4
theta4 = atan2(wTt(2,3)*sin(theta5), wTt(1,3)*sin(theta5));
% calculo theta6
theta6 = atan2(wTt(3,2)*sin(theta5), wTt(3,1)*sin(theta5));
