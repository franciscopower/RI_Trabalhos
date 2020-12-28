clear all
clc
close all

% Ex1 --------------------------------------------------------------------

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

% calculo do pw
pw = [x;y;z] - LF*oTt_i(1:3,3);
pwx = pw(1); pwy=pw(2); pwz=pw(3);

% dp = (sqrt(pwx^2 + pwy^2) - LB)^2 + pwz^2 % !!! descomentar isto para
% correr o programa mesmo !!!

% calculo theta1
t1 = atan2(pwy,pwx)

% calculo theta3 (t3)
d1 = LC*sin(theta2) + LD*sin(theta2-theta3) + LE*cos(theta2-theta3);
d2 = LC*cos(theta2) + LD*cos(theta2-theta3) - LE*sin(theta2-theta3);
d = expand(d1^2) + expand(d2^2);
d = simplify(d)

k1 = 2*LC*LE;
k2 = 2*LC*LD;
k3 = dp - LC^2 - LD^2 - LE^2;

t3 = 2 * atan2(k2 + sqrt(k1^2 + k2^2 - k3^2), k1 + k3) %atenção ao +/- da raiz quadrada

% calculo theta2 (t2)
L1 = LC + LD*cos(theta3) - LE*sin(theta3);
L2 = LD*sin(theta3) + LE*cos(theta3);

t2 = acos((L2*sqrt(pwx^2 + pwy^2) + L1*pwz)/(L1^2 + L2^2)) %atenção ao +/- da raiz quadrada do d1


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

% calculo de (0R3)⁻1*0R6 para retirar os valores para de e substituir nos
% thetas
mult_matrix=inv_OTw*oTt_i;
mult_matrix= simplify(mult_matrix)

% para calculo de theta 5 temos que theta5=atan(sqtr(ax²+ay²)/az)=atan(S5 /c5)

t5=atan2(sqrt(mult_matrix(1,3)^2+mult_matrix(2,3)^2),mult_matrix(3,3))
% para calcular o theta 4 = atan( -ax/-ay)=atan(-c4*S5/-S4S5)
%  nao esquecer de ver o sinal por quasao do theta 5

t4= atan2(-mult_matrix(1,3)*sin(theta5),-mult_matrix(2,3)*sin(theta5))

%para i calcular o theta 6 = atan(-sz/nz)
%  nao esquecer de ver o sinal por quasao do theta 5

t6= atan2(-mult_matrix(3,2)*sin(theta5),mult_matrix(3,3)*sin(theta5))




%
%% valor pertendidos do ponto final 

% x=526.03;
% y=368.32;
% z=177.6;
% theta= deg2rad(-80);
% phi= deg2rad(0);
% psi= deg2rad(-145);

x=-223.5;
y=948.6;
z=19.4;
phi= deg2rad(147.7);
theta= deg2rad(67.6);
psi= deg2rad(-127.5);


% Dados
LA = 0;
LB = 150;
LC = 360;
LD = 100;
LE = 430;
LF = 100;

oTt_i = [
    cos(theta)*cos(psi) cos(psi)*sin(phi)*sin(theta)-cos(phi)*sin(psi) cos(phi)*cos(psi)*sin(theta)+sin(phi)*sin(psi) x;
    cos(theta)*sin(psi) cos(phi)*cos(psi)+sin(phi)*sin(theta)*sin(psi) -cos(psi)*sin(phi)+cos(phi)*sin(theta)*sin(psi) y;
    -sin(theta) cos(theta)*sin(phi) cos(phi)*cos(theta) z;
    0 0 0 1];

pw = [x;y;z] - LF*oTt_i(1:3,3);
pwx = pw(1); pwy=pw(2); pwz=pw(3);

%calculo t1
theta1=atan2(pwy,pwx);

%t3------------------------------------------------

dp = (sqrt(pwx^2 + pwy^2) - LB)^2 + pwz^2;

k2 = 2*LC*LE;
k1 = 2*LC*LD;
k3 = dp - (LC^2 + LD^2 + LE^2);

theta3 = 2 * atan2(k2 - sqrt(k1^2 + k2^2 - k3^2), k1 + k3);
% theta3 = theta3 - 2*pi

% theta3=-0.6981
%----------------------------------------------------
%t2
L1 = LC + LD*cos(theta3) + LE*sin(theta3);
L2 = LE*cos(theta3) - LD*sin(theta3);
theta2 = acos((L2*(sqrt(pwx^2 + pwy^2)-LB) + L1*pwz)/(L1^2 + L2^2))
theta2 = real(theta2);
% theta2 = deg2rad(60);
% theta2 = theta2 - pi;
%-----------------------------------------------------

theta5=atan2(((cos(psi)*cos(theta1)*sin(phi) + sin(psi)*sin(phi)*sin(theta1) + cos(psi)*cos(phi)*sin(theta)*sin(theta1) - sin(psi)*cos(phi)*cos(theta1)*sin(theta))^2 + (cos(theta2 - theta3)*cos(phi)*cos(theta) - sin(theta2 - theta3)*cos(psi)*sin(phi)*sin(theta1) + sin(theta2 - theta3)*sin(psi)*cos(theta1)*sin(phi) + sin(theta2 - theta3)*cos(psi)*cos(phi)*cos(theta1)*sin(theta) + sin(theta2 - theta3)*sin(psi)*cos(phi)*sin(theta)*sin(theta1))^2)^(1/2), sin(theta2 - theta3)*cos(phi)*cos(theta) + cos(theta2 - theta3)*cos(psi)*sin(phi)*sin(theta1) - cos(theta2 - theta3)*sin(psi)*cos(theta1)*sin(phi) - cos(theta2 - theta3)*cos(psi)*cos(phi)*cos(theta1)*sin(theta) - cos(theta2 - theta3)*sin(psi)*cos(phi)*sin(theta)*sin(theta1));
% theta5 = pi - theta5

theta4=atan2(-sin(theta5)*(cos(theta2 - theta3)*cos(phi)*cos(theta) - sin(theta2 - theta3)*cos(psi)*sin(phi)*sin(theta1) + sin(theta2 - theta3)*sin(psi)*cos(theta1)*sin(phi) + sin(theta2 - theta3)*cos(psi)*cos(phi)*cos(theta1)*sin(theta) + sin(theta2 - theta3)*sin(psi)*cos(phi)*sin(theta)*sin(theta1)), sin(theta5)*(cos(psi)*cos(theta1)*sin(phi) + sin(psi)*sin(phi)*sin(theta1) + cos(psi)*cos(phi)*sin(theta)*sin(theta1) - sin(psi)*cos(phi)*cos(theta1)*sin(theta)));
% theta4 = 2*pi - theta4
% % 
theta6=atan2(sin(theta5)*(cos(theta2 - theta3)*cos(psi)*cos(phi)*sin(theta1) - sin(theta2 - theta3)*cos(theta)*sin(phi) - cos(theta2 - theta3)*sin(psi)*cos(phi)*cos(theta1) + cos(theta2 - theta3)*cos(psi)*cos(theta1)*sin(phi)*sin(theta) + cos(theta2 - theta3)*sin(psi)*sin(phi)*sin(theta)*sin(theta1)), -sin(theta5)*(cos(theta2 - theta3)*sin(psi)*cos(theta1)*sin(phi) - cos(theta2 - theta3)*cos(psi)*sin(phi)*sin(theta1) - sin(theta2 - theta3)*cos(phi)*cos(theta) + cos(theta2 - theta3)*cos(psi)*cos(phi)*cos(theta1)*sin(theta) + cos(theta2 - theta3)*sin(psi)*cos(phi)*sin(theta)*sin(theta1)));
% theta6 = theta6 - pi


% theta5=atan2(((cos(psi)*cos(theta1)*sin(phi) + sin(psi)*sin(phi)*sin(theta1) + cos(psi)*cos(phi)*sin(theta)*sin(theta1) - sin(psi)*cos(phi)*cos(theta1)*sin(theta))^2 + (cos(theta2 - theta3)*cos(phi)*cos(theta) - sin(theta2 - theta3)*cos(psi)*sin(phi)*sin(theta1) + sin(theta2 - theta3)*sin(psi)*cos(theta1)*sin(phi) + sin(theta2 - theta3)*cos(psi)*cos(phi)*cos(theta1)*sin(theta) + sin(theta2 - theta3)*sin(psi)*cos(phi)*sin(theta)*sin(theta1))^2)^(1/2), sin(theta2 - theta3)*cos(phi)*cos(theta) + cos(theta2 - theta3)*cos(psi)*sin(phi)*sin(theta1) - cos(theta2 - theta3)*sin(psi)*cos(theta1)*sin(phi) - cos(theta2 - theta3)*cos(psi)*cos(phi)*cos(theta1)*sin(theta) - cos(theta2 - theta3)*sin(psi)*cos(phi)*sin(theta)*sin(theta1))
% theta4=atan2(-sin(theta5)*(cos(theta2 - theta3)*cos(phi)*cos(theta) - sin(theta2 - theta3)*cos(psi)*sin(phi)*sin(theta1) + sin(theta2 - theta3)*sin(psi)*cos(theta1)*sin(phi) + sin(theta2 - theta3)*cos(psi)*cos(phi)*cos(theta1)*sin(theta) + sin(theta2 - theta3)*sin(psi)*cos(phi)*sin(theta)*sin(theta1)), sin(theta5)*(cos(psi)*cos(theta1)*sin(phi) + sin(psi)*sin(phi)*sin(theta1) + cos(psi)*cos(phi)*sin(theta)*sin(theta1) - sin(psi)*cos(phi)*cos(theta1)*sin(theta)))
% theta6=atan2(sin(theta5)*(cos(theta2 - theta3)*cos(psi)*cos(phi)*sin(theta1) - sin(theta2 - theta3)*cos(theta)*sin(phi) - cos(theta2 - theta3)*sin(psi)*cos(phi)*cos(theta1) + cos(theta2 - theta3)*cos(psi)*cos(theta1)*sin(phi)*sin(theta) + cos(theta2 - theta3)*sin(psi)*sin(phi)*sin(theta)*sin(theta1)), -sin(theta5)*(cos(theta2 - theta3)*sin(psi)*cos(theta1)*sin(phi) - cos(theta2 - theta3)*cos(psi)*sin(phi)*sin(theta1) - sin(theta2 - theta3)*cos(phi)*cos(theta) + cos(theta2 - theta3)*cos(psi)*cos(phi)*cos(theta1)*sin(theta) + cos(theta2 - theta3)*sin(psi)*cos(phi)*sin(theta)*sin(theta1)))


% theta2 = theta2 - pi;
theta3 = theta3 - 2*pi;
% theta4 = 2*pi - theta4;
theta5 =theta5 - pi;
% theta6 = theta6 - pi;



% confirmar
espaco_juntas = [
    rad2deg(theta1);
	rad2deg(theta2);
	rad2deg(theta3);
	rad2deg(theta4);
	rad2deg(theta5);
	rad2deg(theta6);
    ]




% 
% % Atribuição do sistema de coordenadas
% %eloN = [theta, alfa, l, d]
% param_eloA = [theta1, -pi/2, LB,LA];
% param_eloB = [theta2-pi/2, pi, LC, 0];
% param_eloC = [theta3, -pi/2, LD, 0];
% param_eloC1 = [0, 0, 0, -LE];
% param_eloD = [theta4, pi/2, 0, 0];
% param_eloE = [theta5, -pi/2, 0, 0];
% param_eloF = [theta6, 0, 0, -LF];
% 
% 
% % Transformações de cada elo
% OTa = trans_elo(param_eloA);
% aTb = trans_elo(param_eloB);
% bTc = trans_elo(param_eloC);
% cTc1 = trans_elo(param_eloC1);
% c1Td = trans_elo(param_eloD);
% dTe = trans_elo(param_eloE);
% eTf = trans_elo(param_eloF);
% fTt= rot3("x",pi);


































