clear all
close all
clc
%% Dados

LA = 4;
LB = 6;
LC = 5;
LD = 1;
LG = 1;

thetaB = 0;
thetaC = 0;
thetaC2 = 0;
thetaD = 0;

% Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
param_eloA = [0, 0, 0, LA];
param_eloB = [thetaB, pi/2, LB, 0];
param_eloC = [thetaC, 0, LC, 0];
param_eloC1 = [thetaC2+pi/2, pi/2, 0, 0];
param_eloD = [thetaD, 0, 0, LD];

% Transformações de cada elo
BTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);
bTc = trans_elo(param_eloC);
cTc1 = trans_elo(param_eloC1);
c1Td = trans_elo(param_eloD);

%% Ex2a --------------------------------------------------------------------

% Joints ------------------------------------------------------------------
% cube points
w = 0.2;
h = 0.2;

ruf = [w h]';
rub = [-w h]';
lub = [-w -h]';
luf = [w -h]';
rdf = [w h]';
rdb = [-w h]';
ldb = [-w -h]';
ldf = [w -h]';

pts_elo_A = [luf ldf rdf ruf rub rdb ldb lub;
    -LA 0 0 -LA -LA 0 0 -LA;
    ones(1,8)];
pts_elo_B = [-LB 0 0 -LB -LB 0 0 -LB;
    luf ldf rdf ruf rub rdb ldb lub;
    ones(1,8)];
pts_elo_C = [-LC 0 0 -LC -LC 0 0 -LC;
    luf ldf rdf ruf rub rdb ldb lub;
    ones(1,8)];
pts_elo_D = [luf ldf rdf ruf rub rdb ldb lub;
    LD 0 0 LD LD 0 0 LD;
    ones(1,8)];
pts_gripper = [luf ldf rdf ruf rub rdb ldb lub;
    LG 0 0 LG LG 0 0 LG;
    ones(1,8)];



eloA = BTa*pts_elo_A;
eloB = BTa*aTb*pts_elo_B;
eloC = BTa*aTb*bTc*pts_elo_C;
eloD = BTa*aTb*bTc*cTc1*pts_elo_D;
gripper = BTa*aTb*bTc*cTc1*c1Td*pts_gripper;

% Create figure
figure(1)
subplot(2,1,1)
title("Braço com Gripper")
hold on
axis equal
grid on
% axis([-5 15 -15 15 0 7])
xlabel('x')
ylabel('y')
zlabel('z')
view(30,10)

% Display initial joints
Af = fill3(eloA(1,1:4), eloA(2,1:4), eloA(3,1:4), 'r');
Ar = fill3(eloA(1,2:6), eloA(2,2:6), eloA(3,2:6), 'r');
Ab = fill3(eloA(1,4:8), eloA(2,4:8), eloA(3,4:8), 'r');
Al = fill3([eloA(1,1:2) eloA(1,7:8)] , [eloA(2,1:2) eloA(2,7:8)], [eloA(3,1:2) eloA(3,7:8)], 'r');

Bf = fill3(eloB(1,1:4), eloB(2,1:4), eloB(3,1:4), 'g');
Br = fill3(eloB(1,2:6), eloB(2,2:6), eloB(3,2:6), 'g');
Bb = fill3(eloB(1,4:8), eloB(2,4:8), eloB(3,4:8), 'g');
Bl = fill3([eloB(1,1:2) eloB(1,7:8)] , [eloB(2,1:2) eloB(2,7:8)], [eloB(3,1:2) eloB(3,7:8)], 'g');

Cf = fill3(eloC(1,1:4), eloC(2,1:4), eloC(3,1:4), 'b');
Cr = fill3(eloC(1,2:6), eloC(2,2:6), eloC(3,2:6), 'b');
Cb = fill3(eloC(1,4:8), eloC(2,4:8), eloC(3,4:8), 'b');
Cl = fill3([eloC(1,1:2) eloC(1,7:8)] , [eloC(2,1:2) eloC(2,7:8)], [eloC(3,1:2) eloC(3,7:8)], 'b');

Df = fill3(eloD(1,1:4), eloD(2,1:4), eloD(3,1:4), 'm');
Dr = fill3(eloD(1,2:6), eloD(2,2:6), eloD(3,2:6), 'm');
Db = fill3(eloD(1,4:8), eloD(2,4:8), eloD(3,4:8), 'm');
Dl = fill3([eloD(1,1:2) eloD(1,7:8)] , [eloD(2,1:2) eloD(2,7:8)], [eloD(3,1:2) eloD(3,7:8)], 'm');

tf = fill3(gripper(1,1:4), gripper(2,1:4), gripper(3,1:4), 'y');
tb = fill3(gripper(1,5:8), gripper(2,5:8), gripper(3,5:8), 'y');

hold off

% Axis --------------------------------------------------------------------
% Definição parcial de cada sub-objecto (eixo)
Xpart = [
        0  0.05   0.5   0.4  0.5  0.6   0.7  0.8  0.7   1     1    1.5 1   1     0.7  0.8  0.7  0.6  0.5  0.4  0.5  0.05
        0 -0.05  -0.05 -0.2 -0.2 -0.05 -0.2 -0.2 -0.05 -0.05 -0.2  0   0.2 0.05  0.05 0.2  0.2  0.05 0.2  0.2  0.05 0.05
        0  0      0     0    0    0     0     0   0     0      0   0   0   0     0      0    0    0   0    0    0    0 ];
Xpart = [Xpart; ones(1,size(Xpart, 2))];
Ypart = [
        0 0.05 0.05 0.2 0.2 0.05 0.05 0.2 0   -0.2 -0.05 -0.05 -0.2 -0.2 -0.05 -0.05
        0 0.05 0.6  0.7 0.8 0.7  1    1   1.5 1     1     0.7   0.8  0.7  0.6   0.05
        0 0    0    0   0   0    0    0   0   0     0     0     0    0    0     0  ];
Ypart = [Ypart; ones(1,size(Ypart, 2))];
Zpart = [
        0   0     0      0     0    0    0     0     0     0   0   0   0    0    0   0    0    0    0     0    0
        0  -0.05 -0.05  -0.2  -0.2 -0.1 -0.1  -0.05 -0.05 -0.2 0   0.2 0.05 0.05 0.2 0.2  0.1  0.1  0.05  0.05 0.05
        0   0.05  0.55   0.45  0.8  0.8  0.62  0.66  1     1   1.5 1   1    0.7  0.8 0.45 0.45 0.62 0.58  0.5  0.05 ]; 
Zpart = [Zpart; ones(1,size(Zpart, 2))];

XpartA = Xpart;
YpartA = Ypart;
ZpartA = Zpart;

XpartB = BTa *Xpart;
YpartB = BTa *Ypart;
ZpartB = BTa *Zpart;

XpartC = BTa*aTb*Xpart;
YpartC = BTa*aTb*Ypart;
ZpartC = BTa*aTb*Zpart;

XpartD = BTa*aTb*bTc*Xpart;
YpartD = BTa*aTb*bTc*Ypart;
ZpartD = BTa*aTb*bTc*Zpart;

XpartD1 = BTa*aTb*bTc*cTc1*Xpart;
YpartD1 = BTa*aTb*bTc*cTc1*Ypart;
ZpartD1 = BTa*aTb*bTc*cTc1*Zpart;

XpartGrip = BTa*aTb*bTc*cTc1*c1Td*Xpart;
YpartGrip = BTa*aTb*bTc*cTc1*c1Td*Ypart;
ZpartGrip = BTa*aTb*bTc*cTc1*c1Td*Zpart;

% Create figure to display axis
figure(1)
subplot(2,1,2)
title("Sistemas de coordenadas de cada elo")
hold on
axis equal
grid on
% axis([-5 15 -15 15 0 7])
xlabel('x')
ylabel('y')
zlabel('z')
view(30,10)

XA = [ XpartA(1,:) YpartA(1,:) ZpartA(1,:)];
YA = [ XpartA(2,:) YpartA(2,:) ZpartA(2,:)];
ZA = [ XpartA(3,:) YpartA(3,:) ZpartA(3,:)];
Aaxis = fill3(XA(1:38), YA(1:38), ZA(1:38), 'b', XA(39:end), YA(39:end), ZA(39:end), 'b');

XB = [ XpartB(1,:) YpartB(1,:) ZpartB(1,:)];
YB = [ XpartB(2,:) YpartB(2,:) ZpartB(2,:)];
ZB = [ XpartB(3,:) YpartB(3,:) ZpartB(3,:)];
Baxis = fill3(XB(1:38), YB(1:38), ZB(1:38), 'b', XB(39:end), YB(39:end), ZB(39:end), 'b');

XC = [ XpartC(1,:) YpartC(1,:) ZpartC(1,:)];
YC = [ XpartC(2,:) YpartC(2,:) ZpartC(2,:)];
ZC = [ XpartC(3,:) YpartC(3,:) ZpartC(3,:)];
Caxis = fill3(XC(1:38), YC(1:38), ZC(1:38), 'b', XC(39:end), YC(39:end), ZC(39:end), 'b');

XD1 = [ XpartD1(1,:) YpartD1(1,:) ZpartD1(1,:)];
YD1 = [ XpartD1(2,:) YpartD1(2,:) ZpartD1(2,:)];
ZD1 = [ XpartD1(3,:) YpartD1(3,:) ZpartD1(3,:)];
D1axis = fill3(XD1(1:38), YD1(1:38), ZD1(1:38), 'r', XD1(39:end), YD1(39:end), ZD1(39:end), 'r');

XD = [ XpartD(1,:) YpartD(1,:) ZpartD(1,:)];
YD = [ XpartD(2,:) YpartD(2,:) ZpartD(2,:)];
ZD = [ XpartD(3,:) YpartD(3,:) ZpartD(3,:)];
Daxis = fill3(XD(1:38), YD(1:38), ZD(1:38), 'b', XD(39:end), YD(39:end), ZD(39:end), 'b');

XGrip = [ XpartGrip(1,:) YpartGrip(1,:) ZpartGrip(1,:)];
YGrip = [ XpartGrip(2,:) YpartGrip(2,:) ZpartGrip(2,:)];
ZGrip = [ XpartGrip(3,:) YpartGrip(3,:) ZpartGrip(3,:)];
Gripaxis = fill3(XGrip(1:38), YGrip(1:38), ZGrip(1:38), 'b', XGrip(39:end), YGrip(39:end), ZGrip(39:end), 'b');



w = 0.001;
h = 0.001;

ruf = [w h]';
rub = [-w h]';
lub = [-w -h]';
luf = [w -h]';
rdf = [w h]';
rdb = [-w h]';
ldb = [-w -h]';
ldf = [w -h]';

pts_elo_A = [luf ldf rdf ruf rub rdb ldb lub;
    -LA 0 0 -LA -LA 0 0 -LA;
    ones(1,8)];
pts_elo_B = [-LB 0 0 -LB -LB 0 0 -LB;
    luf ldf rdf ruf rub rdb ldb lub;
    ones(1,8)];
pts_elo_C = [-LC 0 0 -LC -LC 0 0 -LC;
    luf ldf rdf ruf rub rdb ldb lub;
    ones(1,8)];
pts_elo_D = [luf ldf rdf ruf rub rdb ldb lub;
    LD 0 0 LD LD 0 0 LD;
    ones(1,8)];
pts_gripper = [luf ldf rdf ruf rub rdb ldb lub;
    LG 0 0 LG LG 0 0 LG;
    ones(1,8)];



eloA = BTa*pts_elo_A;
eloB = BTa*aTb*pts_elo_B;
eloC = BTa*aTb*bTc*pts_elo_C;
eloD = BTa*aTb*bTc*cTc1*pts_elo_D;
gripper = BTa*aTb*bTc*cTc1*c1Td*pts_gripper;

Af = fill3(eloA(1,1:4), eloA(2,1:4), eloA(3,1:4), 'r');
Ar = fill3(eloA(1,2:6), eloA(2,2:6), eloA(3,2:6), 'r');
Ab = fill3(eloA(1,4:8), eloA(2,4:8), eloA(3,4:8), 'r');
Al = fill3([eloA(1,1:2) eloA(1,7:8)] , [eloA(2,1:2) eloA(2,7:8)], [eloA(3,1:2) eloA(3,7:8)], 'r');

Bf = fill3(eloB(1,1:4), eloB(2,1:4), eloB(3,1:4), 'g');
Br = fill3(eloB(1,2:6), eloB(2,2:6), eloB(3,2:6), 'g');
Bb = fill3(eloB(1,4:8), eloB(2,4:8), eloB(3,4:8), 'g');
Bl = fill3([eloB(1,1:2) eloB(1,7:8)] , [eloB(2,1:2) eloB(2,7:8)], [eloB(3,1:2) eloB(3,7:8)], 'g');

Cf = fill3(eloC(1,1:4), eloC(2,1:4), eloC(3,1:4), 'b');
Cr = fill3(eloC(1,2:6), eloC(2,2:6), eloC(3,2:6), 'b');
Cb = fill3(eloC(1,4:8), eloC(2,4:8), eloC(3,4:8), 'b');
Cl = fill3([eloC(1,1:2) eloC(1,7:8)] , [eloC(2,1:2) eloC(2,7:8)], [eloC(3,1:2) eloC(3,7:8)], 'b');

Df = fill3(eloD(1,1:4), eloD(2,1:4), eloD(3,1:4), 'm');
Dr = fill3(eloD(1,2:6), eloD(2,2:6), eloD(3,2:6), 'm');
Db = fill3(eloD(1,4:8), eloD(2,4:8), eloD(3,4:8), 'm');
Dl = fill3([eloD(1,1:2) eloD(1,7:8)] , [eloD(2,1:2) eloD(2,7:8)], [eloD(3,1:2) eloD(3,7:8)], 'm');

tf = fill3(gripper(1,1:4), gripper(2,1:4), gripper(3,1:4), 'y');
tb = fill3(gripper(1,5:8), gripper(2,5:8), gripper(3,5:8), 'y');
hold off

%% Ex 2b
BTw = BTa*aTb*bTc*cTc1*c1Td
p = BTw(1:3,4);
theta = rad2deg(asin(-BTw(3,1)));
phi = rad2deg(atan2(BTw(3,2), BTw(3,3)));
psi = rad2deg(atan2(BTw(2,1), BTw(1,1)));

% End factor
r = [p; phi; theta; psi]