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
% fTt= rot3("y",pi);
fTt = eye(4);
% fTt = trans_elo([pi/2,pi/2,0,0])*trans_elo([-pi/2,0,0,0]);

% Criar Cilindros dos elos

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

% lista de espaços de juntas
a = {0,0,0,0,0,0;
    35,0,-40,0,50,0;
    35,-40,0,0,50,0;
    105,60,-30,120,-20,40
    15,-30,-30,20,-20,165};

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
        theta3 = theta3_incr(n);
        theta4 = theta4_incr(n);
        theta5 = theta5_incr(n);
        theta6 = theta6_incr(n);


        % matriz das tranformações 
        param_eloA = [theta1, -pi/2, LB,LA];
        param_eloB = [theta2-pi/2, pi, LC, 0];
        param_eloC = [theta3+theta2, -pi/2, LD, 0];
        param_eloC1 = [0, 0, 0, -LEE];
        param_eloD = [theta4, pi/2, 0, -LEEE];
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
%         fTt = trans_elo([pi/2,pi/2,0,0])*trans_elo([-pi/2,0,0,0]);.
%         fTt = eye(4);


        %[ncx, ncy, ncz] = transfCylinder(OTa,eloO);
        [ncxA, ncyA, nczA] = transfCylinder(OTa,eloA);
        [ncxB, ncyB, nczB] = transfCylinder(OTa*aTb,eloB);
        [ncxC, ncyC, nczC] = transfCylinder(OTa*aTb*bTc,eloC);
        [ncxC1, ncyC1, nczC1] = transfCylinder(OTa*aTb*bTc*cTc1,eloC1);
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
        
        pause(pause_time)

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
    end

end












