clear all
close all
clc

% Create figure
figure(1)
hold on
axis equal
grid on
axis([-5 15 -15 15 0 15])
xlabel('x')
ylabel('y')
zlabel('z')
view(30,10)
% Animation settings
frames = 50;
pause_time = 0.05;


%% Dados

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

%Transformações de cada elo
BTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);
bTc = trans_elo(param_eloC);
cTc1 = trans_elo(param_eloC1);
c1Td = trans_elo(param_eloD);
dTg2= rot3('y',pi)*rot3('z', pi/2)*trans3(0,-0.5,-1.5);


% % Transformação global
% BTw = BTa*aTb*bTc*cTc1*c1Td;
% 
% % Angulos de orientação e posição finais
% p = BTw(1:3,4);
% theta = rad2deg(asin(-BTw(3,1)));
% phi = rad2deg(atan2(BTw(3,2), BTw(3,3)));
% psi = rad2deg(atan2(BTw(2,1), BTw(1,1)));
% 
% % End factor
% r = [p; phi; theta; psi];
% BTs
BTs = trans3(10,0,0)*rot3('z', -pi/2);

% 1f sTg
sTg = trans3(0,0.5,1.5);

%% Ex2 --------------------------------------------------------------------

% Joints ------------------------------------------------------------------
% pontos dos elos
w = 0.4;
h = 0.4;

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

escalaGrip=1.6;
pts_gripper = [luf*escalaGrip ldf*escalaGrip rdf*escalaGrip ruf*escalaGrip rub*escalaGrip rdb*escalaGrip ldb*escalaGrip lub*escalaGrip;
    LG 0 0 LG LG 0 0 LG;
    ones(1,8)];


% pontos da mesa
w = 2;
h = 1.5;
l = 8;

ruf = [l w h]';
rub = [-l w h]';
lub = [-l 0 h]';
luf = [l 0 h]';
rdf = [l w 0]';
rdb = [-l w 0]';
ldb = [-l 0 0]';
ldf = [l 0 0]';

pts_mesa = [luf ldf rdf ruf rub rdb ldb lub;
    ones(1,8)];

% pontos do objeto
w = 1;
h = 1.5;
l = 2;

ruf = [l w h]';
rub = [-l w h]';
lub = [-l 0 h]';
luf = [l 0 h]';
rdf = [l w 0]';
rdb = [-l w 0]';
ldb = [-l 0 0]';
ldf = [l 0 0]';

pts_objeto = [luf ldf rdf ruf rub rdb ldb lub;
    ones(1,8)];

% -------------------------------------------------------------------------
% calculate position of table and object
mesa = BTs*pts_mesa;
objeto = BTs*sTg*pts_objeto;

% Display table and object
mesaf = fill3(mesa(1,1:4), mesa(2,1:4), mesa(3,1:4), 'r');
mesar = fill3(mesa(1,3:6), mesa(2,3:6), mesa(3,3:6), 'r');
mesab = fill3(mesa(1,5:8), mesa(2,5:8), mesa(3,5:8), 'r');
mesal = fill3([mesa(1,1:2) mesa(1,7:8)] , [mesa(2,1:2) mesa(2,7:8)], [mesa(3,1:2) mesa(3,7:8)], 'r');
mesau = fill3([mesa(1,1) mesa(1,4:5) mesa(1,8)] , [mesa(2,1) mesa(2,4:5) mesa(2,8)], [mesa(3,1) mesa(3,4:5) mesa(3,8)], 'r');
mesad = fill3([mesa(1,2:3) mesa(1,6:7)] , [mesa(2,2:3) mesa(2,6:7)], [mesa(3,2:3) mesa(3,6:7)], 'r');


objetof = fill3(objeto(1,1:4), objeto(2,1:4), objeto(3,1:4), 'c');
objetor = fill3(objeto(1,3:6), objeto(2,3:6), objeto(3,3:6), 'c');
objetob = fill3(objeto(1,5:8), objeto(2,5:8), objeto(3,5:8), 'c');
objetol = fill3([objeto(1,1:2) objeto(1,7:8)] , [objeto(2,1:2) objeto(2,7:8)], [objeto(3,1:2) objeto(3,7:8)], 'c');
objetou = fill3([objeto(1,1) objeto(1,4:5) objeto(1,8)] , [objeto(2,1) objeto(2,4:5) objeto(2,8)], [objeto(3,1) objeto(3,4:5) objeto(3,8)], 'c');
objetod = fill3([objeto(1,2:3) objeto(1,6:7)] , [objeto(2,2:3) objeto(2,6:7)], [objeto(3,2:3) objeto(3,6:7)], 'c');

% calculate position of joints
eloA = BTa*pts_elo_A;
eloB = BTa*aTb*pts_elo_B;
eloC = BTa*aTb*bTc*pts_elo_C;
eloD = BTa*aTb*bTc*cTc1*pts_elo_D;
gripper = BTa*aTb*bTc*cTc1*c1Td*pts_gripper;

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

td = fill3([gripper(1,2:3) gripper(1,6:7)], [gripper(2,2:3) gripper(2,6:7)], [gripper(3,2:3) gripper(3,6:7)], 'y');
tf = fill3(gripper(1,1:4), gripper(2,1:4), gripper(3,1:4), 'y');
tb = fill3(gripper(1,5:8), gripper(2,5:8), gripper(3,5:8), 'y');


a = {0,0,0,0;
    45,45,0,90;
    0,0,-90,0;
    45,45,45,180;
    };

BTw = BTa*aTb*bTc*cTc1*c1Td;
p = BTw(1:3,4);
theta = rad2deg(asin(-BTw(3,1)));
phi = rad2deg(atan2(BTw(3,2), BTw(3,3)));
psi = rad2deg(atan2(BTw(2,1), BTw(1,1)));
% End factor
r = [p; phi; theta; psi];

s1 = "End factor [x y z \phi \theta \psi]: ";
s2 = sprintf("[%1.0f %1.0f %1.0f %1.0f %1.0f %1.0f]", r(1), r(2), r(3), r(4), r(5), r(6));
s = strcat(s1, s2);
title(s)


for i = 2:size(a,1)
    %get input values
    thetaA_incr = linspace(deg2rad(a{i-1,1}),deg2rad(a{i,1}),frames);
    thetaB_incr = linspace(deg2rad(a{i-1,2}),deg2rad(a{i,2}),frames);
    thetaC_incr = linspace(deg2rad(a{i-1,3}),deg2rad(a{i,3}),frames);
    thetaD_incr = linspace(deg2rad(a{i-1,4}),deg2rad(a{i,4}),frames);
    
    pos = [round(r(1)) round(r(2)) round(r(3))];
    
    if pos(1)==11 && pos(2)==0 && pos(3)==3
       pickup = true; 
    else
        pickup = false;
    end

    for n=1:frames

        thetaA = thetaA_incr(n);
        thetaB = thetaB_incr(n);
        thetaC = thetaC_incr(n);
        thetaD = thetaD_incr(n);

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

        eloA = BTa*pts_elo_A;
        eloB = BTa*aTb*pts_elo_B;
        eloC = BTa*aTb*bTc*pts_elo_C;
        eloD = BTa*aTb*bTc*cTc1*pts_elo_D;
        gripper = BTa*aTb*bTc*cTc1*c1Td*pts_gripper;
        
        
        if pickup
            objeto = BTa*aTb*bTc*cTc1*c1Td*dTg2*pts_objeto;
        end

         %display new positions
        set(Af, 'XData',eloA(1,1:4) , 'YData',eloA(2,1:4) , 'ZData',eloA(3,1:4) )
        set(Ar, 'XData',eloA(1,2:6) , 'YData',eloA(2,2:6) , 'ZData',eloA(3,2:6) )
        set(Ab, 'XData',eloA(1,4:8) , 'YData',eloA(2,4:8) , 'ZData',eloA(3,4:8) )
        set(Al, 'XData',[eloA(1,1:2) eloA(1,7:8)] , 'YData',[eloA(2,1:2) eloA(2,7:8)] , 'ZData',[eloA(3,1:2) eloA(3,7:8)] )

        set(Bf, 'XData',eloB(1,1:4) , 'YData',eloB(2,1:4) , 'ZData',eloB(3,1:4) )
        set(Br, 'XData',eloB(1,2:6) , 'YData',eloB(2,2:6) , 'ZData',eloB(3,2:6) )
        set(Bb, 'XData',eloB(1,4:8) , 'YData',eloB(2,4:8) , 'ZData',eloB(3,4:8) )
        set(Bl, 'XData',[eloB(1,1:2) eloB(1,7:8)] , 'YData',[eloB(2,1:2) eloB(2,7:8)] , 'ZData',[eloB(3,1:2) eloB(3,7:8)] )

        set(Cf, 'XData',eloC(1,1:4) , 'YData',eloC(2,1:4) , 'ZData',eloC(3,1:4) )
        set(Cr, 'XData',eloC(1,2:6) , 'YData',eloC(2,2:6) , 'ZData',eloC(3,2:6) )
        set(Cb, 'XData',eloC(1,4:8) , 'YData',eloC(2,4:8) , 'ZData',eloC(3,4:8) )
        set(Cl, 'XData',[eloC(1,1:2) eloC(1,7:8)] , 'YData',[eloC(2,1:2) eloC(2,7:8)] , 'ZData',[eloC(3,1:2) eloC(3,7:8)] )

        set(Df, 'XData',eloD(1,1:4) , 'YData',eloD(2,1:4) , 'ZData',eloD(3,1:4) )
        set(Dr, 'XData',eloD(1,2:6) , 'YData',eloD(2,2:6) , 'ZData',eloD(3,2:6) )
        set(Db, 'XData',eloD(1,4:8) , 'YData',eloD(2,4:8) , 'ZData',eloD(3,4:8) )
        set(Dl, 'XData',[eloD(1,1:2) eloD(1,7:8)] , 'YData',[eloD(2,1:2) eloD(2,7:8)] , 'ZData',[eloD(3,1:2) eloD(3,7:8)] )
        
        
        set(td, 'XData',[gripper(1,2:3) gripper(1,6:7)] , 'YData', [gripper(2,2:3) gripper(2,6:7)], 'ZData',[gripper(3,2:3) gripper(3,6:7)] )
        set(tf, 'XData',gripper(1,1:4) , 'YData',gripper(2,1:4) , 'ZData',gripper(3,1:4) )
        set(tb, 'XData',gripper(1,5:8) , 'YData',gripper(2,5:8) , 'ZData',gripper(3,5:8) )

        
        set(objetof, 'XData',objeto(1,1:4) , 'YData',objeto(2,1:4) , 'ZData', objeto(3,1:4))
        set(objetor, 'XData',objeto(1,3:6) , 'YData',objeto(2,3:6) , 'ZData', objeto(3,3:6))
        set(objetob, 'XData',objeto(1,5:8) , 'YData', objeto(2,5:8), 'ZData',objeto(3,5:8) )
        set(objetol, 'XData',[objeto(1,1:2) objeto(1,7:8)] , 'YData', [objeto(2,1:2) objeto(2,7:8)], 'ZData',[objeto(3,1:2) objeto(3,7:8)] )
        set(objetou, 'XData',[objeto(1,1) objeto(1,4:5) objeto(1,8)] , 'YData',  [objeto(2,1) objeto(2,4:5) objeto(2,8)], 'ZData',[objeto(3,1) objeto(3,4:5) objeto(3,8)] )
        set( objetod, 'XData',[objeto(1,2:3) objeto(1,6:7)] , 'YData', [objeto(2,2:3) objeto(2,6:7)], 'ZData',[objeto(3,2:3) objeto(3,6:7)] )
        
        
        BTw = BTa*aTb*bTc*cTc1*c1Td;
        p = BTw(1:3,4);
        theta = rad2deg(asin(-BTw(3,1)));
        phi = rad2deg(atan2(BTw(3,2), BTw(3,3)));
        psi = rad2deg(atan2(BTw(2,1), BTw(1,1)));
        % End factor
        r = [p; phi; theta; psi];

        s1 = "End factor [x y z \phi \theta \psi]: ";
        s2 = sprintf("[%1.0f %1.0f %1.0f %1.0f %1.0f %1.0f]", r(1), r(2), r(3), r(4), r(5), r(6));
        s = strcat(s1, s2);
        title(s)
        
        pause(pause_time)
    end
   
    pause(0.5)
end