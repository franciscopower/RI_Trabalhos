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

% Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
param_eloA = [0, 0, 0, LA];
param_eloB = [thetaA, pi/2, LB, 0];
param_eloC = [thetaB, 0, LC, 0];
param_eloC1 = [thetaC+pi/2, pi/2, 0, 0];
param_eloD = [thetaD, 0, 0, LD];

% Transformações de cada elo
BTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);
bTc = trans_elo(param_eloC);
cTc1 = trans_elo(param_eloC1);
c1Td = trans_elo(param_eloD);

% Transformação global
BTw = BTa*aTb*bTc*cTc1*c1Td

% 1d - Angulos de orientação e posição finais
p = BTw(1:3,4);
theta = rad2deg(asin(-BTw(3,1)));
phi = rad2deg(atan2(BTw(3,2), BTw(3,3)));
psi = rad2deg(atan2(BTw(2,1), BTw(1,1)));

% End factor
r = [p; phi; theta; psi]