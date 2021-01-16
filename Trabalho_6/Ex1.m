clear all
close all
clc

% Create figure
figure(1)
hold on
axis equal
grid on
axis([-40 40 -40 40 -5 5])
xlabel('x')
ylabel('y')
zlabel('z')
% view(30,10)
view(0,90)
% Animation settings
frames = 20;
pause_time = 0.05;


%% Ex1 --------------------------------------------------------------------

% Dados
LA = 10;
LB = 15;

theta1 = deg2rad(0);
theta2 = deg2rad(0);


% Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
param_eloA = [theta1, 0, LA, 0];
param_eloB = [theta2, 0, LB, 0];

% Transformações de cada elo
OTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);

% Criar Cilindros dos elos
d = 2;

eloA = createCylinder(d,-LA,"yz");
[cxA, cyA, czA] = transfCylinder(OTa,eloA);

eloB = createCylinder(d,-LB,"yz");
[cxB, cyB, czB] = transfCylinder(OTa*aTb,eloB);

%
A = surf(cxA, cyA, czA, 'FaceColor', 'r');
B = surf(cxB, cyB, czB, 'FaceColor', 'g');

%tranformações 
trasA=OTa;
trasB=OTa*aTb;

% lista de espaços de juntas
a = [0,0;
    10,10];


% calculo posicao para titulo
OTt = OTa*aTb;
p = OTt(1:3,4);
s1 = "End factor [x y z]: ";
s2 = sprintf("[%1.1f %1.1f %1.1f]", p(1), p(2), p(3));
s = strcat(s1, s2);
title(s)

% ciclo de movimentação dos elos

aA_0 = 0;
aB_0 = 0;
for i=2:size(a,1)
    pause(1)
    
    x = a(i,1);
    y = a(i,2);
    espaco_juntas = cinematicaInversa([x,y],[LA,LB],-1);
    aA = espaco_juntas(1);
    aB = espaco_juntas(2);
    
    theta1_incr = linspace(aA_0,aA,frames);
    theta2_incr = linspace(aB_0,aB,frames);
    
    for n=1:frames
        
        %nova angulo para cada angulo ate chegar ao angulo pertendido
        theta1 = deg2rad(theta1_incr(n));
        theta2 = deg2rad(theta2_incr(n));
        
        param_eloA = [theta1, 0, LA, 0];
        param_eloB = [theta2, 0, LB, 0];
        
        % tranformaçao no elo
        
        OTa = trans_elo(param_eloA);
        aTb = trans_elo(param_eloB);
        
        [ncxA, ncyA, nczA] = transfCylinder(OTa,eloA);
        [ncxB, ncyB, nczB] = transfCylinder(OTa*aTb,eloB);
        
        set(A, 'XData', ncxA, 'YData', ncyA, 'ZData', nczA)
        set(B, 'XData', ncxB, 'YData', ncyB, 'ZData', nczB)

        % calculate endfactor -----------------------------------------
        OTt = OTa*aTb;
        p = OTt(1:3,4);
        s1 = "End factor [x y z]: ";
        s2 = sprintf("[%1.1f %1.1f %1.1f]", p(1), p(2), p(3));
        s = strcat(s1, s2);
        title(s)
        
        plot3(p(1),p(2),p(3),'.b')
        
        pause(pause_time)
    end
    
    aA_0 = aA;
    aB_0 = aB;
    
end