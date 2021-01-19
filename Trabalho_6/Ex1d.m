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

%% Dados --------------------------------------------------------------------

% Comprimentos dos elos
LA = 15;
LB = 15;
%diametro dos elos
d = 2; 
%ponto inicial
Pi = [15,15];
redundancia = -1;
% raio do circulo
r=10; 
sentido_rot = -1;
% Animation settings
pause_time = 0.01;
n_iter = 500;

%% Ex1 --------------------------------------------------------------------

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

eloA = createCylinder(d,-LA,"yz");
[cxA, cyA, czA] = transfCylinder(OTa,eloA);
eloB = createCylinder(d,-LB,"yz");
[cxB, cyB, czB] = transfCylinder(OTa*aTb,eloB);
A = surf(cxA, cyA, czA, 'FaceColor', 'r');
B = surf(cxB, cyB, czB, 'FaceColor', 'g');

% calculo posicao para titulo
OTt = OTa*aTb;
p = OTt(1:3,4);
s1 = "End factor [x y z]: ";
s2 = sprintf("[%1.1f %1.1f %1.1f]", p(1), p(2), p(3));
s = strcat(s1, s2);
title(s)

% cálculo cinematica diferencial inversa
t = linspace(0,2*pi,n_iter);
Qi = cinematicaInversa_RR(Pi,[LA,LB],redundancia);
Q(:,1) = [deg2rad(Qi(1));deg2rad(Qi(2))];

for i=1:n_iter
   
    dr = [sentido_rot*r*sin(t(i))*(2*pi/n_iter);
        r*cos(t(i))*(2*pi/n_iter)];
    
    th1 = Q(1,end);
    th2 = Q(2,end);    
    jacob_inv = [cos(th1+th2), sin(th1+th2); (-LA*cos(th1)-LB*cos(th1+th2))/LB, (-LA*sin(th1)-LB*sin(th1+th2))/LB];
    jacob_inv = (1/(LA*sin(th2))) * jacob_inv;    
    dq = jacob_inv * dr;
    
    q = [th1; th2];
    Q = [Q q+dq];
    
end

theta1_incr = Q(1,:);
theta2_incr = Q(2,:);

% movimentacao
for n=1:size(Q,2)
    
    %nova angulo para cada angulo ate chegar ao angulo pertendido
    theta1 = theta1_incr(n);
    theta2 = theta2_incr(n);
    
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
    % ------------------------------------------------------------
    
    %plot path
    plot3(p(1),p(2),p(3),'.b')
    
    pause(pause_time)
end


