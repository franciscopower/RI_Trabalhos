% valor pertendidos do ponto final 
close all
clear all
% clc


%___________________________________
LA = 0;
LB = 150;
LC = 360;
LD = 100;
LE = 430;
LEE = 150;
LEEE = 280;
LF = 100;

% ordem da lista x,y,z,phi,theta,psi
c = {700, 0,-90,deg2rad(90),deg2rad(0),deg2rad(90);
    790, 0,-90,deg2rad(90),deg2rad(0),deg2rad(90);
    500,0,-90,deg2rad(90),deg2rad(0),deg2rad(90); % possiçao que manda o projetil
    500,0,400,deg2rad(90),deg2rad(0),deg2rad(90);
    156,-0,816, deg2rad(30),deg2rad(-0),deg2rad(90);
    356,-400,500, deg2rad(30),deg2rad(-0),deg2rad(90);
    -356,-500,300, deg2rad(30),deg2rad(-0),deg2rad(-90)
    400,25,400,deg2rad(90),deg2rad(0),deg2rad(90);
    500,0,-90,deg2rad(90),deg2rad(0),deg2rad(90);
    790, 200,-90,deg2rad(90),deg2rad(0),deg2rad(90);
    500, 200,-90,deg2rad(90),deg2rad(0),deg2rad(90);
    700, 0,-90,deg2rad(90),deg2rad(0),deg2rad(90);
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
    
    espaco_juntas = cinematicaInversa([x,y,z,phi,theta,psi],[LA,LB,LC,LD,LE,LF],[1,-1,1])
    
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
axis([-600 1000 -1000 1000 -250 1600])
xlabel('x')
ylabel('y')
zlabel('z')
view(30,10)
% Animation settings
frames = 10;
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
param_eloF = [theta6, pi, 0, -LF];

% Transformações de cada elo
OTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);
bTc = trans_elo(param_eloC);
cTc1 = trans_elo(param_eloC1);
c1Td = trans_elo(param_eloD);
dTe = trans_elo(param_eloE);
eTf = trans_elo(param_eloF);

%Tranfomacoes objto
OTobjt=trans3(800,-25,-90);
OTobjr=rot3('y',pi/2);

%tranformaçoes mesa
OTmesa=trans3(800,-200,-250)

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


% pontos do objeto
w = 50;
h = 75;
l = 60;

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

% pontos da mesa
w = 500;
h = 100;
l = 90;

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


% gripper
w = 50;
h = 50;
LG = 70;

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

%coordenadas do objcto 
objeto = OTobjt*OTobjr*pts_objeto;

%coordenadas objeto
mesa = OTmesa*pts_mesa;

% display object
objetof = fill3(objeto(1,1:4), objeto(2,1:4), objeto(3,1:4), 'c');
objetor = fill3(objeto(1,3:6), objeto(2,3:6), objeto(3,3:6), 'c');
objetob = fill3(objeto(1,5:8), objeto(2,5:8), objeto(3,5:8), 'c');
objetol = fill3([objeto(1,1:2) objeto(1,7:8)] , [objeto(2,1:2) objeto(2,7:8)], [objeto(3,1:2) objeto(3,7:8)], 'c');
objetou = fill3([objeto(1,1) objeto(1,4:5) objeto(1,8)] , [objeto(2,1) objeto(2,4:5) objeto(2,8)], [objeto(3,1) objeto(3,4:5) objeto(3,8)], 'c');
objetod = fill3([objeto(1,2:3) objeto(1,6:7)] , [objeto(2,2:3) objeto(2,6:7)], [objeto(3,2:3) objeto(3,6:7)], 'c');

% Display table
mesaf = fill3(mesa(1,1:4), mesa(2,1:4), mesa(3,1:4), 'r');
mesar = fill3(mesa(1,3:6), mesa(2,3:6), mesa(3,3:6), 'r');
mesab = fill3(mesa(1,5:8), mesa(2,5:8), mesa(3,5:8), 'r');
mesal = fill3([mesa(1,1:2) mesa(1,7:8)] , [mesa(2,1:2) mesa(2,7:8)], [mesa(3,1:2) mesa(3,7:8)], 'r');
mesau = fill3([mesa(1,1) mesa(1,4:5) mesa(1,8)] , [mesa(2,1) mesa(2,4:5) mesa(2,8)], [mesa(3,1) mesa(3,4:5) mesa(3,8)], 'r');
mesad = fill3([mesa(1,2:3) mesa(1,6:7)] , [mesa(2,2:3) mesa(2,6:7)], [mesa(3,2:3) mesa(3,6:7)], 'r');


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
% a = {theta1,theta2,theta3,theta4,theta5,theta6;
%     35,0,-40,0,50,0;
%     35,-40,0,0,50,0;
%     105,60,-30,120,-20,40
%     15,-30,-30,20,-20,165};

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

% ciclo de movimentação dos elos



y = [0,0,0,0;
    0,0,0,0;
    0,0,0,0;
    500,0,400,pi/2;
    500,0,400,pi/2;
    500,0,1100,pi/2;
    500,0,1400,pi;
    500,0,1100,pi+pi/2;
    500,0,400,pi/2+pi;
    0,0,0,0;
    0,0,0,0;
    0,0,0,0;
    0,0,0,0;
    0,0,0,0;
    0,0,0,0;
    ];


pickup = 0;
for i=2:b(1)+1
    pause(0.01)
    
     if c{i-1,1}==500 && c{i-1,2}==0 && c{i-1,3}==-90
       pickup = 1;
    elseif c{i-1,1}==156 && c{i-1,2}==0 && c{i-1,3}==816
        pickup = 2;
    elseif c{i-1,1}==400 && c{i-1,2}==0 && c{i-1,3}==400
        pickup = 1;
    elseif c{i-1,1}==500 && c{i-1,2}==200 && c{i-1,3}==-90
        pickup = 0;
    end
    
    theta1_incr = linspace(deg2rad(a{i-1,1}),deg2rad(a{i,1}),frames);
    theta2_incr = linspace(deg2rad(a{i-1,2}),deg2rad(a{i,2}),frames);
    theta3_incr = linspace(deg2rad(a{i-1,3}),deg2rad(a{i,3}),frames);
    theta4_incr = linspace(deg2rad(a{i-1,4}),deg2rad(a{i,4}),frames);
    theta5_incr = linspace(deg2rad(a{i-1,5}),deg2rad(a{i,5}),frames);
    theta6_incr = linspace(deg2rad(a{i-1,6}),deg2rad(a{i,6}),frames);
    
    if pickup==2
      x_incr = linspace(y(i-1,1),y(i,1),frames);
           y_incr = linspace(y(i-1,2),y(i,2),frames);
           z_incr = linspace(y(i-1,3),y(i,3),frames);
           ang_incr = linspace(y(i-1,4),y(i,4),frames);
    end
    for n=1:frames
        
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
        
        
         
         
         
        if pickup==1
            objeto = OTa*aTb*bTc*cTc1*c1Td*dTe*eTf*rot3('z',pi/2)*trans3(0,-25,10)*pts_objeto;
        end
        
        if pickup==2  
           objeto = trans3(x_incr(n),y_incr(n),z_incr(n))*rot3('y',ang_incr(n))*pts_objeto; 
        end
        
        set(objetof, 'XData',objeto(1,1:4) , 'YData',objeto(2,1:4) , 'ZData', objeto(3,1:4))
        set(objetor, 'XData',objeto(1,3:6) , 'YData',objeto(2,3:6) , 'ZData', objeto(3,3:6))
        set(objetob, 'XData',objeto(1,5:8) , 'YData', objeto(2,5:8), 'ZData',objeto(3,5:8) )
        set(objetol, 'XData',[objeto(1,1:2) objeto(1,7:8)] , 'YData', [objeto(2,1:2) objeto(2,7:8)], 'ZData',[objeto(3,1:2) objeto(3,7:8)] )
        set(objetou, 'XData',[objeto(1,1) objeto(1,4:5) objeto(1,8)] , 'YData',  [objeto(2,1) objeto(2,4:5) objeto(2,8)], 'ZData',[objeto(3,1) objeto(3,4:5) objeto(3,8)] )
        set( objetod, 'XData',[objeto(1,2:3) objeto(1,6:7)] , 'YData', [objeto(2,2:3) objeto(2,6:7)], 'ZData',[objeto(3,2:3) objeto(3,6:7)] )
        
        
        

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
        
        pause(pause_time)
        
    end
    
end












































