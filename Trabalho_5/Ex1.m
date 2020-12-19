clear all
close all
clc

% Create figure
figure(1)
hold on
axis equal
grid on
% axis([-5 15 -15 15 0 15])
xlabel('x')
ylabel('y')
zlabel('z')
view(30,10)
% Animation settings
frames = 50;
pause_time = 0.05;

%% Ex1 --------------------------------------------------------------------

% Dados
LA = 0;
LB = 150;
LC = 360;
LD = 100;
LE = 430;
LEE = 150;
LEEE = 280;
LF = 100;


theta1 = deg2rad(0);
theta2 = deg2rad(0);
theta3 = deg2rad(0);
theta4 = deg2rad(0);
theta5 = deg2rad(0);
theta6 = deg2rad(0);

% Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
param_eloA = [theta1, -pi/2, LB,LA];
param_eloB = [theta2-pi/2, pi, LC, 0];
param_eloC = [theta3+theta2, -pi/2, LD, 0];
param_eloC1 = [0, 0, 0, -LEE];
param_eloD = [theta4, pi/2, 0, -LEEE];
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

% Criar Cilindros dos elos

% basic cylinder
eloO = createCylinder(50,-250,"xy");
[cxO, cyO, czO] = transfCylinder(eye(4),eloO);
eloA = createCylinder(50,-LB,"yz");
[cxA, cyA, czA] = transfCylinder(OTa,eloA);
eloB = createCylinder(50,-LC,"yz");
[cxB, cyB, czB] = transfCylinder(OTa*aTb,eloB);
eloC = createCylinder(50,-LD,"yz");
[cxC, cyC, czC] = transfCylinder(OTa*aTb*bTc,eloC);
eloC1 = createCylinder(50,LEE,"xy");
[cxC1, cyC1, czC1] = transfCylinder(OTa*aTb*bTc*cTc1,eloC1);
eloD = createCylinder(50,LEEE,"xz");
[cxD, cyD, czD] = transfCylinder(OTa*aTb*bTc*cTc1*c1Td,eloD);
eloE = createCylinder(50,-LF,"xy");
[cxE, cyE, czE] = transfCylinder(OTa*aTb*bTc*cTc1*c1Td*dTe,eloE);

O = surf(cxO, cyO, czO, 'FaceColor', 'r');
A = surf(cxA, cyA, czA, 'FaceColor', 'r');
B = surf(cxB, cyB, czB, 'FaceColor', 'g');
C = surf(cxC, cyC, czC, 'FaceColor', 'b');
C1 = surf(cxC1, cyC1, czC1, 'FaceColor', 'm');
D = surf(cxD, cyD, czD, 'FaceColor', 'c');
E = surf(cxE, cyE, czE, 'FaceColor', 'y');

% eloA
% eloB
% eloC
% eloC1
% eloD
% eloE
% tool


% Aplicar Transformações iniciais aos cilindros dos elos

% lista de espaços de juntas

% ciclo de movimentação dos elos













