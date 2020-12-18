%% Ex1 --------------------------------------------------------------------

% Dados
LA = 250;
LB = 150;
LC = 360;
LD = 100;
LE = 430;
LEE=150;
LEEE=280;
LF=100;


theta1 = 0;
theta2 = 0;
theta3 = 0;
theta4 = 0;
theta5 = 0;
theta6 = 0;

% Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
param_eloA = [theta1, -pi/2, LB,LA];
param_eloB = [theta2, pi, LC, LC];
param_eloC = [theta3+theta2+pi/2, -pi/2, LD, 0];
param_eloC1 = [0, 0, 0, -LEE];
param_eloD = [theta4, pi/2, 0, LEEE];
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
fTt= rot3("y",pi/2);

% Transformação global
OTw = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf*fTt;

% 1d - Angulos de orientação e posição finais
p = OTw(1:3,4);
theta = rad2deg(asin(-OTw(3,1)));
phi = rad2deg(atan2(OTw(3,2), OTw(3,3)));
psi = rad2deg(atan2(OTw(2,1), OTw(1,1)));

% End factor
r = [p; phi; theta; psi]













