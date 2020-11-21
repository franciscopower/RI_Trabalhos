% Objecto único para representar os 3 eixos. 

%% Definição parcial de cada sub-objecto (eixo)
Xpart = [
        0  0.05   0.5   0.4  0.5  0.6   0.7  0.8  0.7   1     1    1.5 1   1     0.7  0.8  0.7  0.6  0.5  0.4  0.5  0.05
        0 -0.05  -0.05 -0.2 -0.2 -0.05 -0.2 -0.2 -0.05 -0.05 -0.2  0   0.2 0.05  0.05 0.2  0.2  0.05 0.2  0.2  0.05 0.05
        0  0      0     0    0    0     0     0   0     0      0   0   0   0     0      0    0    0   0    0    0    0 ];

Ypart = [
        0 0.05 0.05 0.2 0.2 0.05 0.05 0.2 0   -0.2 -0.05 -0.05 -0.2 -0.2 -0.05 -0.05
        0 0.05 0.6  0.7 0.8 0.7  1    1   1.5 1     1     0.7   0.8  0.7  0.6   0.05
        0 0    0    0   0   0    0    0   0   0     0     0     0    0    0     0  ];

Zpart = [
        0   0     0      0     0    0    0     0     0     0   0   0   0    0    0   0    0    0    0     0    0
        0  -0.05 -0.05  -0.2  -0.2 -0.1 -0.1  -0.05 -0.05 -0.2 0   0.2 0.05 0.05 0.2 0.2  0.1  0.1  0.05  0.05 0.05
        0   0.05  0.55   0.45  0.8  0.8  0.62  0.66  1     1   1.5 1   1    0.7  0.8 0.45 0.45 0.62 0.58  0.5  0.05 ]; 
 
%% Concatenação dos três objectos num só.
X = [ Xpart(1,:) Ypart(1,:) Zpart(1,:)];
Y = [ Xpart(2,:) Ypart(2,:) Zpart(2,:)];
Z = [ Xpart(3,:) Ypart(3,:) Zpart(3,:)];

%% Ilustração do desenho do objecto


h = fill3(X(1:38), Y(1:38), Z(1:38), 'b', X(39:end), Y(39:end), Z(39:end), 'b');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on; hold on

%% Posição inicial

Pi = [X;Y;Z; ones(1,size(X,2))];



