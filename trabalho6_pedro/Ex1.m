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
pause_time = 0.001;


%Ex1 --------------------------------------------------------------------

% Dados
LA = 15;
LB = 15;


theta1 = deg2rad(0);
theta2 = deg2rad(0);


% Atribuição do sistema de coordenadas
%eloN = [theta, alfa, l, d]
param_eloA = [theta1, 0, LA,0];
param_eloB = [theta2, 0, LB, 0];

% Transformações de cada elo
OTa = trans_elo(param_eloA);
aTb = trans_elo(param_eloB);


% Criar Cilindros dos elos
d = 2;
eloO = createCylinder(d,-LA,"yz");
[cxO, cyO, czO] = transfCylinder(eye(4),eloO);

eloA = createCylinder(d,-LB,"yz");
[cxA, cyA, czA] = transfCylinder(OTa,eloA);



%
O = surf(cxO, cyO, czO, 'FaceColor', 'r');
A = surf(cxA, cyA, czA, 'FaceColor', 'r');



%tranformações 

trasA=OTa;
trasB=OTa*aTb;



% calculo posicao para titulo
OTt = OTa*aTb;
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

raio=8;
r=[pi/4,pi/4 ];
numero_iteracoes=500;
    
    % calcular os novos angulos 
    
t=linspace(0,2*pi,numero_iteracoes);

qt1=ones(1,numero_iteracoes+1);
qt2=ones(1,numero_iteracoes+1);
for i=1:numero_iteracoes
    
    dr=[-raio*sin(t(i))*(2*pi/numero_iteracoes);
        raio*cos(t(i))*(2*pi/numero_iteracoes)];
    
    dq=(1/(LA*sin(qt2(i))))*[cos(qt1(i)+qt2(i)),sin(qt1(i)+qt2(i));(-LA*cos(qt1(i))-LB*cos(qt1(i)-qt2(i)))/LB (-LA*sin(qt1(i))-LB*sin(qt1(i)+qt2(i)))/LB]*dr;
    
    
    qt1(i+1)=qt1(i)+dq(1);
    qt2(i+1)=qt2(i)+dq(2);
    

end

%     angulostheta1=
%     angulostheta2=
    
       
    for n=1:numero_iteracoes
        
        %nova angulo para cada angulo ate chegar ao angulo pertendido
        theta1 = qt1(n);
        theta2 = qt2(n);
        
  param_eloA = [theta1, 0, LA,0];
param_eloB = [theta2, 0, LB, 0];
       
        
        % tranformaçao no elo
        
        OTa = trans_elo(param_eloA);
        aTb = trans_elo(param_eloB);
        

         d = 3;
  
    [cxO, cyO, czO] = transfCylinder(eye(4),eloO);

    [cxA, cyA, czA] = transfCylinder(OTa,eloA);
        
        set(O, 'XData',cxO , 'YData', cyO, 'ZData', czO)
        set(A, 'XData', cxA, 'YData', cyA, 'ZData', czA)
        
        
        
        
        
     
     
        OTt = OTa*aTb;
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
    



