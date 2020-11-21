%% Dados
syms L1 L2 L3 L4
syms theta1 theta2 theta3 theta4

%% Ex1 --------------------------------------------------------------------

% 1a - Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
param_eloA = [0, 0, 0, L1];
param_eloB = [theta1, pi/2, L2, 0];
param_eloC = [theta2, 0, L3, 0];
param_eloC1 = [theta3+pi/2, pi/2, 0, 0];
param_eloD = [theta4, 0, 0, L4];

% 1b - Transformações de cada elo
BTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);
bTc = trans_elo(param_eloC);
cTc1 = trans_elo(param_eloC1);
c1Td = trans_elo(param_eloD);

% 1c Transformação global
BTw = BTa*aTb*bTc*cTc1*c1Td

BTw_simplified = simplify(BTw)

%% Ex1 --------------------------------------------------------------------

% Dados
LA = 4;
LB = 6;
LC = 5;
LD = 1;
LG = 1;

thetaA = 0;
thetaB = 0;
thetaC = 0;
thetaD = 0;

% 1a - Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
param_eloA = [0, 0, 0, LA];
param_eloB = [thetaA, pi/2, LB, 0];
param_eloC = [thetaB, 0, LC, 0];
param_eloC1 = [thetaC+pi/2, pi/2, 0, 0];
param_eloD = [thetaD, 0, 0, LD];

% 1b - Transformações de cada elo
BTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);
bTc = trans_elo(param_eloC);
cTc1 = trans_elo(param_eloC1);
c1Td = trans_elo(param_eloD);

% 1c Transformação global
BTw = BTa*aTb*bTc*cTc1*c1Td

% 1d Angulos de orientação e posição finais
p = BTw(1:3,4);
theta = rad2deg(asin(-BTw(3,1)));
phi = rad2deg(atan2(BTw(3,2), BTw(3,3)));
psi = rad2deg(atan2(BTw(2,1), BTw(1,1)));

% End factor
r = [p; phi; theta; psi]

% 1e BTs
BTs = trans3(10,0,0)*rot3('z', -pi/2)

% 1f sTg
sTg = trans3(0,0.5,1.5)

% 1g wTg
wTg = BTw^-1 * BTs * sTg




























