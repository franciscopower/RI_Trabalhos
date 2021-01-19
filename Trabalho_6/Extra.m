% valor pertendidos do ponto final 
close all
clear all
clc

%% Dados

% Create figure
figure(1)
hold on
axis equal
grid on
axis([-300 1000 -1000 1000 -250 600])
xlabel('x')
ylabel('y')
zlabel('z')
view(30,10)

% Comprimentos dos elos
LA = 0;
LB = 150;
LC = 360;
LD = 100;
LE = 430;
LEE = 150;
LEEE = 280;
LF = 100;
%diametro dos elos
d = 50;
%ponto inicial
Pi = [680, 0,200,deg2rad(-135),deg2rad(-90),deg2rad(-45)];
espaco_redundancias = [1,-1,1];
% raio do circulo
R=200; 
sentido_rot = -1;
% Animation settings
pause_time = 0.001;
n_iter = 500;

%%

% dar os valores das juntas ao primeira posicao 
Qi = cinematicaInversa(Pi,[LA,LB,LC,LD,LE,LF],espaco_redundancias);

theta1=deg2rad(Qi(1));
theta2=deg2rad(Qi(2));
theta3=deg2rad(Qi(3));
theta4=deg2rad(Qi(4));
theta5=deg2rad(Qi(5));
theta6=deg2rad(Qi(6));

% Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
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

% Criar Cilindros dos elos

eloO = createCylinder(d,-250,"xy");
[cxO, cyO, czO] = transfCylinder(eye(4),eloO);

eloA = createCylinder(d,-LB,"yz");
[cxA, cyA, czA] = transfCylinder(OTa,eloA);

eloB = createCylinder(d,-LC,"yz");
[cxB, cyB, czB] = transfCylinder(OTa*aTb,eloB);

eloC = createCylinder(d,-LD,"yz");
[cxC, cyC, czC] = transfCylinder(OTa*aTb*bTc,eloC);

eloC1 = createCylinder(d,-LEE,"xy");
[cxC1, cyC1, czC1] = transfCylinder(OTa*aTb*bTc,eloC1);

eloD = createCylinder(d,LEEE,"xz");
[cxD, cyD, czD] = transfCylinder(OTa*aTb*bTc*cTc1*c1Td,eloD);

eloE = createCylinder(d,-LF,"xy");
eloE(2,:,2) = eloE(2,:,2)*0;
eloE(1,:,2) = eloE(1,:,2)*0;
[cxE, cyE, czE] = transfCylinder(OTa*aTb*bTc*cTc1*c1Td*dTe,eloE);


%
O = surf(cxO, cyO, czO, 'FaceColor', 'r');
A = surf(cxA, cyA, czA, 'FaceColor', 'r');
B = surf(cxB, cyB, czB, 'FaceColor', 'g');
C = surf(cxC, cyC, czC, 'FaceColor', 'b');
C1 = surf(cxC1, cyC1, czC1, 'FaceColor', 'b');
D = surf(cxD, cyD, czD, 'FaceColor', 'c');
E = surf(cxE, cyE, czE, 'FaceColor', 'm');

% calculo posicao para titulo
OTt = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf;
p = OTt(1:3,4);
theta = rad2deg(asin(-OTt(3,1)));
phi = rad2deg(atan2(OTt(3,2), OTt(3,3)));
psi = rad2deg(atan2(OTt(2,1), OTt(1,1)));

% End factor
r = [p; phi; theta; psi];

s1 = "End factor [x y z \phi \theta \psi]: ";
s2 = sprintf("[%1.1f %1.1f %1.1f %1.1f %1.1f %1.1f]", r(1), r(2), r(3), r(4), r(5), r(6));
s = strcat(s1, s2);
title(s)

% calculo das posicoes

% cálculo cinematica diferencial inversa
t = linspace(0,2*pi,n_iter);
Q(:,1) = [deg2rad(Qi(1));deg2rad(Qi(2));deg2rad(Qi(3));deg2rad(Qi(4));deg2rad(Qi(5));deg2rad(Qi(6))];

for i=1:n_iter
   
    dr = [0;sentido_rot*R*sin(t(i))*(2*pi/n_iter);
        R*cos(t(i))*(2*pi/n_iter)];
    
    theta1 = Q(1,end);
    theta2 = Q(2,end);
    theta3 = Q(3,end);
    theta4 = Q(4,end);
    theta5 = Q(5,end);
    theta6 = Q(6,end);
    
    jacob = [LD*cos(theta2)*sin(theta1)*sin(theta3) - LC*sin(theta1)*sin(theta2) - LE*cos(theta2)*cos(theta3)*sin(theta1) - LB*sin(theta1) - LD*cos(theta3)*sin(theta1)*sin(theta2) - LF*cos(theta1)*sin(theta4)*sin(theta5) - LE*sin(theta1)*sin(theta2)*sin(theta3) - LF*cos(theta2)*cos(theta3)*cos(theta5)*sin(theta1) - LF*cos(theta5)*sin(theta1)*sin(theta2)*sin(theta3) + LF*cos(theta2)*cos(theta4)*sin(theta1)*sin(theta3)*sin(theta5) - LF*cos(theta3)*cos(theta4)*sin(theta1)*sin(theta2)*sin(theta5), LC*cos(theta1)*cos(theta2) + LD*cos(theta1)*cos(theta2)*cos(theta3) + LE*cos(theta1)*cos(theta2)*sin(theta3) - LE*cos(theta1)*cos(theta3)*sin(theta2) + LD*cos(theta1)*sin(theta2)*sin(theta3) + LF*cos(theta1)*cos(theta2)*cos(theta5)*sin(theta3) - LF*cos(theta1)*cos(theta3)*cos(theta5)*sin(theta2) + LF*cos(theta1)*cos(theta4)*sin(theta2)*sin(theta3)*sin(theta5) + LF*cos(theta1)*cos(theta2)*cos(theta3)*cos(theta4)*sin(theta5), LE*cos(theta1)*cos(theta3)*sin(theta2) - LE*cos(theta1)*cos(theta2)*sin(theta3) - LD*cos(theta1)*cos(theta2)*cos(theta3) - LD*cos(theta1)*sin(theta2)*sin(theta3) - LF*cos(theta1)*cos(theta2)*cos(theta5)*sin(theta3) + LF*cos(theta1)*cos(theta3)*cos(theta5)*sin(theta2) - LF*cos(theta1)*cos(theta4)*sin(theta2)*sin(theta3)*sin(theta5) - LF*cos(theta1)*cos(theta2)*cos(theta3)*cos(theta4)*sin(theta5), LF*cos(theta1)*cos(theta2)*sin(theta3)*sin(theta4)*sin(theta5) - LF*cos(theta4)*sin(theta1)*sin(theta5) - LF*cos(theta1)*cos(theta3)*sin(theta2)*sin(theta4)*sin(theta5), LF*cos(theta1)*cos(theta3)*cos(theta4)*cos(theta5)*sin(theta2) - LF*cos(theta1)*cos(theta2)*cos(theta3)*sin(theta5) - LF*cos(theta1)*sin(theta2)*sin(theta3)*sin(theta5) - LF*cos(theta1)*cos(theta2)*cos(theta4)*cos(theta5)*sin(theta3) - LF*cos(theta5)*sin(theta1)*sin(theta4), 0;
            LB*cos(theta1) + LC*cos(theta1)*sin(theta2) + LE*cos(theta1)*cos(theta2)*cos(theta3) - LD*cos(theta1)*cos(theta2)*sin(theta3) + LD*cos(theta1)*cos(theta3)*sin(theta2) + LE*cos(theta1)*sin(theta2)*sin(theta3) - LF*sin(theta1)*sin(theta4)*sin(theta5) + LF*cos(theta1)*cos(theta2)*cos(theta3)*cos(theta5) + LF*cos(theta1)*cos(theta5)*sin(theta2)*sin(theta3) - LF*cos(theta1)*cos(theta2)*cos(theta4)*sin(theta3)*sin(theta5) + LF*cos(theta1)*cos(theta3)*cos(theta4)*sin(theta2)*sin(theta5), LC*cos(theta2)*sin(theta1) + LD*cos(theta2)*cos(theta3)*sin(theta1) + LE*cos(theta2)*sin(theta1)*sin(theta3) - LE*cos(theta3)*sin(theta1)*sin(theta2) + LD*sin(theta1)*sin(theta2)*sin(theta3) + LF*cos(theta2)*cos(theta5)*sin(theta1)*sin(theta3) - LF*cos(theta3)*cos(theta5)*sin(theta1)*sin(theta2) + LF*cos(theta2)*cos(theta3)*cos(theta4)*sin(theta1)*sin(theta5) + LF*cos(theta4)*sin(theta1)*sin(theta2)*sin(theta3)*sin(theta5), LE*cos(theta3)*sin(theta1)*sin(theta2) - LE*cos(theta2)*sin(theta1)*sin(theta3) - LD*cos(theta2)*cos(theta3)*sin(theta1) - LD*sin(theta1)*sin(theta2)*sin(theta3) - LF*cos(theta2)*cos(theta5)*sin(theta1)*sin(theta3) + LF*cos(theta3)*cos(theta5)*sin(theta1)*sin(theta2) - LF*cos(theta2)*cos(theta3)*cos(theta4)*sin(theta1)*sin(theta5) - LF*cos(theta4)*sin(theta1)*sin(theta2)*sin(theta3)*sin(theta5), LF*cos(theta1)*cos(theta4)*sin(theta5) + LF*cos(theta2)*sin(theta1)*sin(theta3)*sin(theta4)*sin(theta5) - LF*cos(theta3)*sin(theta1)*sin(theta2)*sin(theta4)*sin(theta5), LF*cos(theta1)*cos(theta5)*sin(theta4) - LF*cos(theta2)*cos(theta3)*sin(theta1)*sin(theta5) - LF*sin(theta1)*sin(theta2)*sin(theta3)*sin(theta5) - LF*cos(theta2)*cos(theta4)*cos(theta5)*sin(theta1)*sin(theta3) + LF*cos(theta3)*cos(theta4)*cos(theta5)*sin(theta1)*sin(theta2), 0;
             0,                                                                                                             LD*cos(theta2)*sin(theta3) - LE*cos(theta2)*cos(theta3) - LC*sin(theta2) - LD*cos(theta3)*sin(theta2) - LE*sin(theta2)*sin(theta3) - LF*cos(theta2)*cos(theta3)*cos(theta5) - LF*cos(theta5)*sin(theta2)*sin(theta3) + LF*cos(theta2)*cos(theta4)*sin(theta3)*sin(theta5) - LF*cos(theta3)*cos(theta4)*sin(theta2)*sin(theta5),                                                                                                 LE*cos(theta2)*cos(theta3) - LD*cos(theta2)*sin(theta3) + LD*cos(theta3)*sin(theta2) + LE*sin(theta2)*sin(theta3) + LF*cos(theta2)*cos(theta3)*cos(theta5) + LF*cos(theta5)*sin(theta2)*sin(theta3) - LF*cos(theta2)*cos(theta4)*sin(theta3)*sin(theta5) + LF*cos(theta3)*cos(theta4)*sin(theta2)*sin(theta5),                                                                - LF*cos(theta2)*cos(theta3)*sin(theta4)*sin(theta5) - LF*sin(theta2)*sin(theta3)*sin(theta4)*sin(theta5),                                                                                          LF*cos(theta3)*sin(theta2)*sin(theta5) - LF*cos(theta2)*sin(theta3)*sin(theta5) + LF*cos(theta2)*cos(theta3)*cos(theta4)*cos(theta5) + LF*cos(theta4)*cos(theta5)*sin(theta2)*sin(theta3), 0];

   
    jacob_inv = pinv(jacob);
    dq = jacob_inv * dr;
    
    q = [theta1; theta2; theta3; theta4; theta5; theta6];
    Q = [Q q+dq];
    
end

% ciclo de movimentação dos elos

for i=1:1
    pause(1)
    
    theta1_incr = Q(1,:);
    theta2_incr = Q(2,:);
    theta3_incr = Q(3,:);
    theta4_incr = Q(4,:);
    theta5_incr = Q(5,:);
    theta6_incr = Q(6,:);
    
    for n=1:size(Q,2)
        
        %nova angulo para cada angulo ate chegar ao angulo pertendido
        theta1 = theta1_incr(n);
        theta2 = theta2_incr(n);
        theta3 = theta3_incr(n);
        theta4 = theta4_incr(n);
        theta5 = theta5_incr(n);
        theta6 = theta6_incr(n);
        
        param_eloA = [theta1, -pi/2, LB,LA];
        param_eloB = [theta2-pi/2, pi, LC, 0];
        param_eloC = [theta3, -pi/2, LD, 0];
        param_eloC1 = [0, 0, 0, -LE];
        param_eloD = [theta4, pi/2, 0, 0]; 
        param_eloE = [theta5, -pi/2, 0, 0];
        param_eloF = [theta6, pi, 0, -LF];
        
        % tranformaçao no elo
        
        OTa = trans_elo(param_eloA);
        aTb = trans_elo(param_eloB);
        bTc = trans_elo(param_eloC);
        cTc1 = trans_elo(param_eloC1);
        c1Td = trans_elo(param_eloD);
        dTe = trans_elo(param_eloE);
        eTf = trans_elo(param_eloF);
        
        [ncxA, ncyA, nczA] = transfCylinder(OTa,eloA);
        [ncxB, ncyB, nczB] = transfCylinder(OTa*aTb,eloB);
        [ncxC, ncyC, nczC] = transfCylinder(OTa*aTb*bTc,eloC);
        [ncxC1, ncyC1, nczC1] = transfCylinder(OTa*aTb*bTc,eloC1);
        [ncxD, ncyD, nczD] = transfCylinder(OTa*aTb*bTc*cTc1*c1Td,eloD);
        [ncxE, ncyE, nczE] = transfCylinder(OTa*aTb*bTc*cTc1*c1Td*dTe,eloE);
        
        set(A, 'XData', ncxA, 'YData', ncyA, 'ZData', nczA)
        set(B, 'XData', ncxB, 'YData', ncyB, 'ZData', nczB)
        set(C, 'XData', ncxC, 'YData', ncyC, 'ZData', nczC)
        set(C1, 'XData', ncxC1, 'YData', ncyC1, 'ZData', nczC1)
        set(D, 'XData', ncxD, 'YData', ncyD, 'ZData', nczD)
        set(E, 'XData', ncxE, 'YData', ncyE, 'ZData', nczE)

        OTt = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf;
        p = OTt(1:3,4);
        theta = rad2deg(asin(-OTt(3,1)));
        phi = rad2deg(atan2(OTt(3,2), OTt(3,3)));
        psi = rad2deg(atan2(OTt(2,1), OTt(1,1)));
        
        % End factor
        r = [p; phi; theta; psi];
        
        s1 = "End factor [x y z \phi \theta \psi]: ";
        s2 = sprintf("[%1.1f %1.1f %1.1f %1.1f %1.1f %1.1f]", r(1), r(2), r(3), r(4), r(5), r(6));
        s = strcat(s1, s2);
        title(s)
        
        plot3(p(1),p(2),p(3),'.b')
        
        pause(pause_time)
        
    end
    
end
























