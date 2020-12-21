clear all
close all
clc

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
theta3 = deg2rad(0) + theta2;
theta4 = deg2rad(0);
theta5 = deg2rad(0);
theta6 = deg2rad(0);

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

%eixos

 eixos
Xpart=eye(3)*100*Xpart;
Ypart=eye(3)*100*Ypart;
Zpart=eye(3)*100*Zpart;

Xpart = [Xpart; ones(1,size(Xpart, 2))];
Ypart = [Ypart; ones(1,size(Ypart, 2))];
Zpart = [Zpart; ones(1,size(Zpart, 2))];

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


%O
Xpart_O=trasO*Xpart;
Ypart_O=trasO*Ypart;
Zpart_O=trasO*Zpart;

X_O = [ Xpart_O(1,:) Ypart_O(1,:) Zpart_O(1,:)];
Y_O = [ Xpart_O(2,:) Ypart_O(2,:) Zpart_O(2,:)];
Z_O = [ Xpart_O(3,:) Ypart_O(3,:) Zpart_O(3,:)];

%A
Xpart_A=trasA*Xpart;
Ypart_A=trasA*Ypart;
Zpart_A=trasA*Zpart;

X_A = [ Xpart_A(1,:) Ypart_A(1,:) Zpart_A(1,:)];
Y_A = [ Xpart_A(2,:) Ypart_A(2,:) Zpart_A(2,:)];
Z_A = [ Xpart_A(3,:) Ypart_A(3,:) Zpart_A(3,:)];

%B
Xpart_B=trasB*Xpart;
Ypart_B=trasB*Ypart;
Zpart_B=trasB*Zpart;

X_B = [ Xpart_B(1,:) Ypart_B(1,:) Zpart_B(1,:)];
Y_B = [ Xpart_B(2,:) Ypart_B(2,:) Zpart_B(2,:)];
Z_B = [ Xpart_B(3,:) Ypart_B(3,:) Zpart_B(3,:)];

%C 

Xpart_C=trasC*Xpart;
Ypart_C=trasC*Ypart;
Zpart_C=trasC*Zpart;

X_C = [ Xpart_C(1,:) Ypart_C(1,:) Zpart_C(1,:)];
Y_C = [ Xpart_C(2,:) Ypart_C(2,:) Zpart_C(2,:)];
Z_C = [ Xpart_C(3,:) Ypart_C(3,:) Zpart_C(3,:)];

%C1
Xpart_C1=trasC1*Xpart;
Ypart_C1=trasC1*Ypart;
Zpart_C1=trasC1*Zpart;

X_C1 = [ Xpart_C1(1,:) Ypart_C1(1,:) Zpart_C1(1,:)];
Y_C1 = [ Xpart_C1(2,:) Ypart_C1(2,:) Zpart_C1(2,:)];
Z_C1 = [ Xpart_C1(3,:) Ypart_C1(3,:) Zpart_C1(3,:)];

%D
Xpart_D=trasD*Xpart;
Ypart_D=trasD*Ypart;
Zpart_D=trasD*Zpart;

X_D = [ Xpart_D(1,:) Ypart_D(1,:) Zpart_D(1,:)];
Y_D = [ Xpart_D(2,:) Ypart_D(2,:) Zpart_D(2,:)];
Z_D = [ Xpart_D(3,:) Ypart_D(3,:) Zpart_D(3,:)];

%E
Xpart_E=trasE*Xpart;
Ypart_E=trasE*Ypart;
Zpart_E=trasE*Zpart;

X_E = [ Xpart_E(1,:) Ypart_E(1,:) Zpart_E(1,:)];
Y_E = [ Xpart_E(2,:) Ypart_E(2,:) Zpart_E(2,:)];
Z_E = [ Xpart_E(3,:) Ypart_E(3,:) Zpart_E(3,:)];

%tool
Xpart_tool=trastool*Xpart;
Ypart_tool=trastool*Ypart;
Zpart_tool=trastool*Zpart;

X_tool = [ Xpart_tool(1,:) Ypart_tool(1,:) Zpart_tool(1,:)];
Y_tool = [ Xpart_tool(2,:) Ypart_tool(2,:) Zpart_tool(2,:)];
Z_tool = [ Xpart_tool(3,:) Ypart_tool(3,:) Zpart_tool(3,:)];

%tool1
Xpart_tool1=trastool1*Xpart;
Ypart_tool1=trastool1*Ypart;
Zpart_tool1=trastool1*Zpart;

X_tool1 = [ Xpart_tool1(1,:) Ypart_tool1(1,:) Zpart_tool1(1,:)];
Y_tool1 = [ Xpart_tool1(2,:) Ypart_tool1(2,:) Zpart_tool1(2,:)];
Z_tool1 = [ Xpart_tool1(3,:) Ypart_tool1(3,:) Zpart_tool1(3,:)];



%plot dos eixos

hold on
hO = fill3(X_O(1:38), Y_O(1:38), Z_O(1:38), 'b' );
hO1=fill3(X_O(39:end), Y_O(39:end), Z_O(39:end), 'b');

hA = fill3(X_A(1:38), Y_A(1:38), Z_A(1:38), 'b' );
hA1=fill3(X_A(39:end), Y_A(39:end), Z_A(39:end), 'b');

hB = fill3(X_B(1:38), Y_B(1:38), Z_B(1:38), 'b' );
hB1 = fill3(X_B(39:end), Y_B(39:end), Z_B(39:end), 'b');

hC = fill3(X_C(1:38), Y_C(1:38), Z_C(1:38), 'b' );
hC11=fill3(X_C(39:end), Y_C(39:end), Z_C(39:end), 'b');

hC1 = fill3(X_C1(1:38), Y_C1(1:38), Z_C1(1:38), 'b');
hC111=fill3( X_C1(39:end), Y_C1(39:end), Z_C1(39:end), 'b');

hD = fill3(X_D(1:38), Y_D(1:38), Z_D(1:38), 'b');
hD1=fill3(X_D(39:end), Y_D(39:end), Z_D(39:end), 'b');


hE = fill3(X_E(1:38), Y_E(1:38), Z_E(1:38), 'r');
hE1=fill3(X_E(39:end), Y_E(39:end), Z_E(39:end), 'r');

htool = fill3(X_tool(1:38), Y_tool(1:38), Z_tool(1:38), 'b');
htool11=fill3(X_tool(39:end), Y_tool(39:end), Z_tool(39:end), 'b');

htool1 = fill3(X_tool1(1:38), Y_tool1(1:38), Z_tool1(1:38), 'r');
htool111=fill3(X_tool1(39:end), Y_tool1(39:end), Z_tool1(39:end), 'r');

hold off
% lista de espaços de juntas
a = {0,0,0,0,0,0;
    35,0,-40,0,50,0;
    35,-40,0,0,50,0;
    105,60,-30,120,-20,40
    15,-30,-30,20,-20,165};

% calculo posicao para titulo
OTw = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf*fTt;
p = OTw(1:3,4);
theta = rad2deg(asin(-OTw(3,1)));
phi = rad2deg(atan2(OTw(3,2), OTw(3,3)));
psi = rad2deg(atan2(OTw(2,1), OTw(1,1)));

% End factor
r = [p; phi; theta; psi];

s1 = "End factor [x y z \phi \theta \psi]: ";
s2 = sprintf("[%1.1f %1.1f %1.1f %1.1f %1.1f %1.1f]", r(1), r(2), r(3), r(4), r(5), r(6));
s = strcat(s1, s2);
title(s)


% ciclo de movimentação dos elos

for i=2:5
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
        theta3 = theta3_incr(n) + theta2;
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
        
        %__________________eixos_____________________
        
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
            
        %O
        Xpart_O=trasO*Xpart;
        Ypart_O=trasO*Ypart;
        Zpart_O=trasO*Zpart;
        
        X_O = [ Xpart_O(1,:) Ypart_O(1,:) Zpart_O(1,:)];
        Y_O = [ Xpart_O(2,:) Ypart_O(2,:) Zpart_O(2,:)];
        Z_O = [ Xpart_O(3,:) Ypart_O(3,:) Zpart_O(3,:)];
        
        %A
        Xpart_A=trasA*Xpart;
        Ypart_A=trasA*Ypart;
        Zpart_A=trasA*Zpart;
        
        X_A = [ Xpart_A(1,:) Ypart_A(1,:) Zpart_A(1,:)];
        Y_A = [ Xpart_A(2,:) Ypart_A(2,:) Zpart_A(2,:)];
        Z_A = [ Xpart_A(3,:) Ypart_A(3,:) Zpart_A(3,:)];
        
        %B
        Xpart_B=trasB*Xpart;
        Ypart_B=trasB*Ypart;
        Zpart_B=trasB*Zpart;
        
        X_B = [ Xpart_B(1,:) Ypart_B(1,:) Zpart_B(1,:)];
        Y_B = [ Xpart_B(2,:) Ypart_B(2,:) Zpart_B(2,:)];
        Z_B = [ Xpart_B(3,:) Ypart_B(3,:) Zpart_B(3,:)];
        
        %C
        Xpart_C=trasC*Xpart;
        Ypart_C=trasC*Ypart;
        Zpart_C=trasC*Zpart;
        
        X_C = [ Xpart_C(1,:) Ypart_C(1,:) Zpart_C(1,:)];
        Y_C = [ Xpart_C(2,:) Ypart_C(2,:) Zpart_C(2,:)];
        Z_C = [ Xpart_C(3,:) Ypart_C(3,:) Zpart_C(3,:)];
        
        %C1
        Xpart_C1=trasC1*Xpart;
        Ypart_C1=trasC1*Ypart;
        Zpart_C1=trasC1*Zpart;
        
        X_C1 = [ Xpart_C1(1,:) Ypart_C1(1,:) Zpart_C1(1,:)];
        Y_C1 = [ Xpart_C1(2,:) Ypart_C1(2,:) Zpart_C1(2,:)];
        Z_C1 = [ Xpart_C1(3,:) Ypart_C1(3,:) Zpart_C1(3,:)];
        
        %D
        Xpart_D=trasD*Xpart;
        Ypart_D=trasD*Ypart;
        Zpart_D=trasD*Zpart;
        
        X_D = [ Xpart_D(1,:) Ypart_D(1,:) Zpart_D(1,:)];
        Y_D = [ Xpart_D(2,:) Ypart_D(2,:) Zpart_D(2,:)];
        Z_D = [ Xpart_D(3,:) Ypart_D(3,:) Zpart_D(3,:)];
        
        %E
        Xpart_E=trasE*Xpart;
        Ypart_E=trasE*Ypart;
        Zpart_E=trasE*Zpart;
        
        X_E = [ Xpart_E(1,:) Ypart_E(1,:) Zpart_E(1,:)];
        Y_E = [ Xpart_E(2,:) Ypart_E(2,:) Zpart_E(2,:)];
        Z_E = [ Xpart_E(3,:) Ypart_E(3,:) Zpart_E(3,:)];
        
        %tool
        Xpart_tool=trastool*Xpart;
        Ypart_tool=trastool*Ypart;
        Zpart_tool=trastool*Zpart;
        
        X_tool = [ Xpart_tool(1,:) Ypart_tool(1,:) Zpart_tool(1,:)];
        Y_tool = [ Xpart_tool(2,:) Ypart_tool(2,:) Zpart_tool(2,:)];
        Z_tool = [ Xpart_tool(3,:) Ypart_tool(3,:) Zpart_tool(3,:)];
        
        %tool1
        Xpart_tool1=trastool1*Xpart;
        Ypart_tool1=trastool1*Ypart;
        Zpart_tool1=trastool1*Zpart;
        
        X_tool1 = [ Xpart_tool1(1,:) Ypart_tool1(1,:) Zpart_tool1(1,:)];
        Y_tool1 = [ Xpart_tool1(2,:) Ypart_tool1(2,:) Zpart_tool1(2,:)];
        Z_tool1 = [ Xpart_tool1(3,:) Ypart_tool1(3,:) Zpart_tool1(3,:)];
        
        
        %plot dos eixos
        
        set(hO, 'XData', X_O(1:38), 'YData', Y_O(1:38), 'ZData', Z_O(1:38))
        set(hA, 'XData', X_A(1:38), 'YData', Y_A(1:38), 'ZData', Z_A(1:38))
        set(hB, 'XData', X_B(1:38), 'YData', Y_B(1:38), 'ZData', Z_B(1:38))
        set(hC, 'XData', X_C(1:38), 'YData', Y_C(1:38), 'ZData', Z_C(1:38))
        set(hC1, 'XData', X_C1(1:38), 'YData', Y_C1(1:38), 'ZData', Z_C1(1:38))
        set(hD, 'XData', X_D(1:38), 'YData',Y_D(1:38), 'ZData', Z_D(1:38))
        set(hE, 'XData', X_E(1:38), 'YData', Y_E(1:38), 'ZData', Z_E(1:38))
        set(htool, 'XData', X_tool(1:38), 'YData', Y_tool(1:38), 'ZData', Z_tool(1:38))
        set(htool1, 'XData', X_tool1(1:38), 'YData', Y_tool1(1:38), 'ZData', Z_tool1(1:38))
        
        
        set(hO1, 'XData',  X_O(39:end), 'YData', Y_O(39:end), 'ZData',  Z_O(39:end))
        set(hA1, 'XData', X_A(39:end), 'YData', Y_A(39:end), 'ZData', Z_A(39:end))
        set(hB1, 'XData',  X_B(39:end), 'YData', Y_B(39:end), 'ZData', Z_B(39:end))
        set(hC11, 'XData', X_C(39:end), 'YData', Y_C(39:end), 'ZData', Z_C(39:end))
        set(hC111, 'XData', X_C1(39:end), 'YData', Y_C1(39:end), 'ZData', Z_C1(39:end))
        set(hD1, 'XData',  X_D(39:end), 'YData',Y_D(39:end), 'ZData', Z_D(39:end))
        set(hE1, 'XData', X_E(39:end), 'YData', Y_E(39:end), 'ZData', Z_E(39:end))
        set(htool11, 'XData', X_tool(39:end), 'YData', Y_tool(39:end), 'ZData', Z_tool(39:end))
        set(htool111, 'XData', X_tool1(39:end), 'YData', Y_tool1(39:end), 'ZData', Z_tool1(39:end))
        

        %_________________/eixos______________________
        
     
        OTw = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf*fTt;
        p = OTw(1:3,4);
        theta = rad2deg(asin(-OTw(3,1)));
        phi = rad2deg(atan2(OTw(3,2), OTw(3,3)));
        psi = rad2deg(atan2(OTw(2,1), OTw(1,1)));
        
        % End factor
        r = [p; phi; theta; psi];
        
        s1 = "End factor [x y z \phi \theta \psi]: ";
        s2 = sprintf("[%1.1f %1.1f %1.1f %1.1f %1.1f %1.1f]", r(1), r(2), r(3), r(4), r(5), r(6));
        s = strcat(s1, s2);
        title(s)
        
        pause(pause_time)
        
    end
    
end


