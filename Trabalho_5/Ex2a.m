clear all
clc
close all

%% Ex1 --------------------------------------------------------------------

% Dados
syms LA LB LC LD LE LEE LEEE LF

syms theta1 theta2 theta3 theta4 theta5 theta6

syms pwx pwy pwz

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

% calculo theta3



% p = OTw(1:3,4);
% theta = rad2deg(asin(-OTw(3,1)));
% phi = rad2deg(atan2(OTw(3,2), OTw(3,3)));
% psi = rad2deg(atan2(OTw(2,1), OTw(1,1)));
% 
% % End factor
% r = [p; phi; theta; psi];




% segundo sistema de cordenadas
c1Td
dTe
eTf
wTt = c1Td*dTe*eTf;
wTt = simplify(wTt)
wTf=wTt*fTt
wTt = simplify(wTt)


den=sqrt(wTt(1,3)^2+wTt(2,3))
t5=atan2(wTt(3,3),den)
simplify(t5)

t4=atan2(-wTt(1,3),wTt(2,3))
simplify(t4)

t6=atan2(wTt(3,2),-wTt(3,1))
simplify(t6)













