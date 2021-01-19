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
% oTt_i = [
%     cos(theta)*cos(psi) cos(psi)*sin(phi)*sin(theta)-cos(phi)*sin(psi) cos(phi)*cos(psi)*sin(theta)+sin(phi)*sin(psi) x;
%     cos(theta)*sin(psi) cos(phi)*cos(psi)+sin(phi)*sin(theta)*sin(psi) -cos(psi)*sin(phi)+cos(phi)*sin(theta)*sin(psi) y;
%     -sin(theta) cos(theta)*sin(phi) cos(phi)*cos(theta) z;
%     0 0 0 1]

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
OTT = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf;
OTT = simplify(OTT)

% PX Py PZ

Px=OTT(1,4)
Py=OTT(2,4)
Pz=OTT(3,4)

% jacobiano 

J=[diff(Px,theta1) diff(Px,theta2) diff(Px,theta3) diff(Px,theta4) diff(Px,theta5) diff(Px,theta6) ;
    diff(Py,theta1) diff(Py,theta2) diff(Py,theta3) diff(Py,theta4) diff(Py,theta5), diff(Py,theta6);
    diff(Pz,theta1) diff(Pz,theta2) diff(Pz,theta3) diff(Pz,theta4) diff(Pz,theta5) diff(Pz,theta6)]



