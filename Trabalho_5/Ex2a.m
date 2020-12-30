% valor pertendidos do ponto final 
close all
clear all
clc

LA = 0;
LB = 150;
LC = 360;
LD = 100;
LE = 430;
LEE = 150;
LEEE = 280;
LF = 100;

% ordem da lista x,y,z,phi,theta,psi
c = {680, 0,460,deg2rad(-135),deg2rad(-90),deg2rad(-45);
    526.03,368.32,177.6,deg2rad(0),deg2rad(-80),deg2rad(-145);
    338.21, 236.82,452.38,deg2rad(0),deg2rad(-40),deg2rad(-145);
    -223.5,948.6,19.4,deg2rad(147.7),deg2rad(67.6),deg2rad(-127.5);
    445.1,107.2,108.6,deg2rad(-170),deg2rad(40.6),deg2rad(-159.9);
    };

b=size(c);
a=cell(b(1),6);
a(1,1)={0};
a(1,2)={0};
a(1,3)={0};
a(1,4)={0};
a(1,5)={0};
a(1,6)={0};

for s=1:b(1)
    
    x=c{s,1};
    y=c{s,2};
    z=c{s,3};
    phi= c{s,4};
    theta= c{s,5};
    psi= c{s,6};
    
    oTt_i = [
        cos(theta)*cos(psi) cos(psi)*sin(phi)*sin(theta)-cos(phi)*sin(psi) cos(phi)*cos(psi)*sin(theta)+sin(phi)*sin(psi) x;
        cos(theta)*sin(psi) cos(phi)*cos(psi)+sin(phi)*sin(theta)*sin(psi) -cos(psi)*sin(phi)+cos(phi)*sin(theta)*sin(psi) y;
        -sin(theta) cos(theta)*sin(phi) cos(phi)*cos(theta) z;
        0 0 0 1];
    
    pw = [x;y;z] - LF*oTt_i(1:3,3);
    pwx = pw(1); pwy=pw(2); pwz=pw(3);
    
    %----------------------------------------------
    %calculo theta1
    theta1=atan2(pwy,pwx);
    
    %calculo theta3
    dp = (sqrt(pwx^2 + pwy^2) - LB)^2 + pwz^2;
    
    k2 = 2*LC*LE;
    k1 = 2*LC*LD;
    k3 = dp - (LC^2 + LD^2 + LE^2);
    
    theta3 = 2 * atan2(k2 - sqrt(k1^2 + k2^2 - k3^2), k1 + k3);
    
    %calculo theta2
    L1 = LC + LD*cos(theta3) + LE*sin(theta3);
    L2 = LE*cos(theta3) - LD*sin(theta3);
    C2 = (L2*(sqrt(pwx^2 + pwy^2)-LB) + L1*pwz)/(L1^2 + L2^2);
    theta2 = asin((L1*C2 - pwz)/L2);
%     theta2 = real(theta2);
    
    %-----------------------------------------------------
    %calculos theta4,5,6
    
    % Atribuição do sistema de coordenadas
    %eloN = [theta, alfa, l, d]
    param_eloA = [theta1, -pi/2, LB,LA];
    param_eloB = [theta2-pi/2, pi, LC, 0];
    param_eloC = [theta3, -pi/2, LD, 0];
    param_eloC1 = [0, 0, 0, -LE];
    % param_eloD = [theta4, pi/2, 0, 0];
    % param_eloE = [theta5, -pi/2, 0, 0];
    % param_eloF = [theta6, 0, 0, -LF];
    
    
    % Transformações de cada elo
    OTa = trans_elo(param_eloA);
    aTb = trans_elo(param_eloB);
    bTc = trans_elo(param_eloC);
    cTc1 = trans_elo(param_eloC1);
    % c1Td = trans_elo(param_eloD);
    % dTe = trans_elo(param_eloE);
    % eTf = trans_elo(param_eloF);
    % fTt= rot3("x",pi);
    
    oTw = OTa*aTb*bTc*cTc1;
    
    wTt = oTw^-1 * oTt_i;
    
    theta5 = atan2(sqrt(wTt(1,3)^2 + wTt(2,3)^2),wTt(3,3));
    theta5 = theta5 - pi; %nao sei se e correto
    
    theta4 = atan2(-wTt(2,3)*sin(theta5), -wTt(1,3)*sin(theta5));
    
    theta6 = - atan2(-wTt(3,2)*sin(theta5), +wTt(3,1)*sin(theta5));
    % nao sei se o - antes do theta6 e correto
    
    %redundancias
    
    % theta2 = theta2 - pi;
    % theta3 = theta3 - 2*pi;
    % theta4 = 2*pi - theta4;
%     theta5 = theta5 - pi;
    % theta6 = - theta6 + pi;
    
    % confirmar
    espaco_juntas = [
        rad2deg(theta1);
        rad2deg(theta2);
        rad2deg(theta3);
        rad2deg(theta4);
        rad2deg(theta5);
        rad2deg(theta6);
        ];
    
    for i=1:size(espaco_juntas,1)
        if espaco_juntas(i)>180
            espaco_juntas(i) = espaco_juntas(i)-360;
        end
    end
    
    espaco_juntas
    
    % cria o espaco de juntas que vai ser usado no movimento do robo
    a(s+1,1)={espaco_juntas(1)};
    a(s+1,2)={espaco_juntas(2)};
    a(s+1,3)={espaco_juntas(3)};
    a(s+1,4)={espaco_juntas(4)};
    a(s+1,5)={espaco_juntas(5)};
    a(s+1,6)={espaco_juntas(6)};
end

%%%___________________movimentacao do braco________________________________

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
% Animation settings
frames = 20;
pause_time = 0.05;
%__________________________________________________________________________

% dar os valores das juntas ao primeira posicao 
theta1=a{1,1};
theta2=a{1,2};
theta3=a{1,3};
theta4=a{1,4};
theta5=a{1,5};
theta6=a{1,6};

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

% Criar Cilindros dos elos
d = 50;
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
[cxE, cyE, czE] = transfCylinder(OTa*aTb*bTc*cTc1*c1Td*dTe,eloE);


% gripper
w = 50;
h = 50;
LG = -70;

ruf = [w h]';
rub = [-w h]';
lub = [-w -h]';
luf = [w -h]';
rdf = [w h]';
rdb = [-w h]';
ldb = [-w -h]';
ldf = [w -h]';

pts_gripper = [luf ldf rdf ruf rub rdb ldb lub;
    LG 0 0 LG LG 0 0 LG;
    ones(1,8)];
gripper = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf*pts_gripper;

%
O = surf(cxO, cyO, czO, 'FaceColor', 'r');
A = surf(cxA, cyA, czA, 'FaceColor', 'r');
B = surf(cxB, cyB, czB, 'FaceColor', 'g');
C = surf(cxC, cyC, czC, 'FaceColor', 'b');
C1 = surf(cxC1, cyC1, czC1, 'FaceColor', 'b');
D = surf(cxD, cyD, czD, 'FaceColor', 'c');
E = surf(cxE, cyE, czE, 'FaceColor', 'm');
td = fill3([gripper(1,2:3) gripper(1,6:7)], [gripper(2,2:3) gripper(2,6:7)], [gripper(3,2:3) gripper(3,6:7)], 'y');
tf = fill3(gripper(1,1:4), gripper(2,1:4), gripper(3,1:4), 'y');
tb = fill3(gripper(1,5:8), gripper(2,5:8), gripper(3,5:8), 'y');

%tranformações 
trasO=eye(4);
trasA=OTa;
trasB=OTa*aTb;
trasC=OTa*aTb*bTc;
trasC1=OTa*aTb*bTc*cTc1;
trasD=OTa*aTb*bTc*cTc1*c1Td;
trasE=OTa*aTb*bTc*cTc1*c1Td*dTe;
trastool=OTa*aTb*bTc*cTc1*c1Td*dTe*eTf;
trastool1=OTa*aTb*bTc*cTc1*c1Td*dTe*eTf*fTt;

% lista de espaços de juntas
% a = {theta1,theta2,theta3,theta4,theta5,theta6;
%     35,0,-40,0,50,0;
%     35,-40,0,0,50,0;
%     105,60,-30,120,-20,40
%     15,-30,-30,20,-20,165};

% calculo posicao para titulo
OTt = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf*fTt;
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

% ciclo de movimentação dos elos

for i=2:b(1)+1
    pause()
    
    theta1_incr = linspace(deg2rad(a{i-1,1}),deg2rad(a{i,1}),frames);
    theta2_incr = linspace(deg2rad(a{i-1,2}),deg2rad(a{i,2}),frames);
    theta3_incr = linspace(deg2rad(a{i-1,3}),deg2rad(a{i,3}),frames);
    theta4_incr = linspace(deg2rad(a{i-1,4}),deg2rad(a{i,4}),frames);
    theta5_incr = linspace(deg2rad(a{i-1,5}),deg2rad(a{i,5}),frames);
    theta6_incr = linspace(deg2rad(a{i-1,6}),deg2rad(a{i,6}),frames);
    
    for n=1:frames
        
        %nova angulo para cada angulo ate chegar ao angulo pertendido
        theta1 = theta1_incr(n);
        theta2 = theta2_incr(n);
        theta3 = theta3_incr(n);
        theta4 = theta4_incr(n);
        theta5 = theta5_incr(n);
        theta6 = theta6_incr(n);
        
        % matriz das tranformações % for i=2:5
        theta1_incr = linspace(deg2rad(a{i-1,1}),deg2rad(a{i,1}),frames);
        theta2_incr = linspace(deg2rad(a{i-1,2}),deg2rad(a{i,2}),frames);
        theta3_incr = linspace(deg2rad(a{i-1,3}),deg2rad(a{i,3}),frames);
        theta4_incr = linspace(deg2rad(a{i-1,4}),deg2rad(a{i,4}),frames);
        theta5_incr = linspace(deg2rad(a{i-1,5}),deg2rad(a{i,5}),frames);
        theta6_incr = linspace(deg2rad(a{i-1,6}),deg2rad(a{i,6}),frames);
        
        param_eloA = [theta1, -pi/2, LB,LA];
        param_eloB = [theta2-pi/2, pi, LC, 0];
        param_eloC = [theta3, -pi/2, LD, 0];
        param_eloC1 = [0, 0, 0, -LE];
        param_eloD = [theta4, pi/2, 0, 0]; 
        param_eloE = [theta5, -pi/2, 0, 0];
        param_eloF = [theta6, 0, 0, -LF];
        
        % tranformaçao no elo
        
        OTa = trans_elo(param_eloA);
        aTb = trans_elo(param_eloB);
        bTc = trans_elo(param_eloC);
        cTc1 = trans_elo(param_eloC1);
        c1Td = trans_elo(param_eloD);
        dTe = trans_elo(param_eloE);
        eTf = trans_elo(param_eloF);
        fTt= rot3("x",pi);
        
        [ncxA, ncyA, nczA] = transfCylinder(OTa,eloA);
        [ncxB, ncyB, nczB] = transfCylinder(OTa*aTb,eloB);
        [ncxC, ncyC, nczC] = transfCylinder(OTa*aTb*bTc,eloC);
        [ncxC1, ncyC1, nczC1] = transfCylinder(OTa*aTb*bTc,eloC1);
        [ncxD, ncyD, nczD] = transfCylinder(OTa*aTb*bTc*cTc1*c1Td,eloD);
        [ncxE, ncyE, nczE] = transfCylinder(OTa*aTb*bTc*cTc1*c1Td*dTe,eloE);
        gripper = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf*pts_gripper;
        
        set(A, 'XData', ncxA, 'YData', ncyA, 'ZData', nczA)
        set(B, 'XData', ncxB, 'YData', ncyB, 'ZData', nczB)
        set(C, 'XData', ncxC, 'YData', ncyC, 'ZData', nczC)
        set(C1, 'XData', ncxC1, 'YData', ncyC1, 'ZData', nczC1)
        set(D, 'XData', ncxD, 'YData', ncyD, 'ZData', nczD)
        set(E, 'XData', ncxE, 'YData', ncyE, 'ZData', nczE)
        
        set(td, 'XData',[gripper(1,2:3) gripper(1,6:7)] , 'YData', [gripper(2,2:3) gripper(2,6:7)], 'ZData',[gripper(3,2:3) gripper(3,6:7)] )
        set(tf, 'XData',gripper(1,1:4) , 'YData',gripper(2,1:4) , 'ZData',gripper(3,1:4) )
        set(tb, 'XData',gripper(1,5:8) , 'YData',gripper(2,5:8) , 'ZData',gripper(3,5:8) )
        

        OTt = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf*fTt;
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
        
        pause(pause_time)
        
    end
    
end
























