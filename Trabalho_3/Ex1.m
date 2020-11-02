%% 2D Robot arms

% Create figure
figure(1)
hold on
axis square
grid on
axis([-15 15 -15 15 0 15])
xlabel('x')
ylabel('y')
zlabel('z')

% Rectangle points
p1 = [0 -0.5 0]';
p2 = [3 -0.5 0]';
p3 = [3 0.5 0]';
p4 = [0 0.5 0]';

% Create rectangles
elo = [p1 p2 p3 p4
    ones(1,4)];

% initial transformations
TB = trans3(3,0,0); 
TC = trans3(3,0,0); 

eloA = elo;
eloB = TB*elo; %place arm B in initial position
eloC = TB*TC*elo; %place arm 3 in initial position

% Display initial rectangles
A = fill3(eloA(1,:), eloA(2,:), eloA(3,:), 'r');
B = fill3(eloB(1,:), eloB(2,:), eloB(3,:), 'g');
C = fill3(eloC(1,:), eloC(2,:), eloC(3,:), 'b');

MA1 = eye(4);
MA2 = eye(4);
MB1 = TB;
MB2 = eye(4);
MC1 = TB*TC;
MC2 = eye(4);

%rotate on A ref
for a = linspace(0,pi/2,20)
    MA2 = rot3("z",a)*MA1;
    eloA = MA2*elo;
    
    MB2 = MA2*MA1^-1*MB1;
    eloB = MB2*elo;
    
    MC2 = MB2*MB1^-1*MC1;
    eloC = MC2*elo;
    
    set(A, 'XData', eloA(1,:), 'YData', eloA(2,:), 'ZData', eloA(3,:))
    set(B, 'XData', eloB(1,:), 'YData', eloB(2,:), 'ZData', eloB(3,:))
    set(C, 'XData', eloC(1,:), 'YData', eloC(2,:), 'ZData', eloC(3,:))

    pause(0.05)
end
MA1 = MA2;
MB1 = MB2;
MC1 = MC2;

%rotate on B ref
for a = linspace(0,pi/2,20)
    MB2 = MB1*rot3("z",a);
    eloB = MB2*elo;
    
    MC2 = MB2*MB1^-1*MC1;
    eloC = MC2*elo;
    
    set(A, 'XData', eloA(1,:), 'YData', eloA(2,:), 'ZData', eloA(3,:))
    set(B, 'XData', eloB(1,:), 'YData', eloB(2,:), 'ZData', eloB(3,:))
    set(C, 'XData', eloC(1,:), 'YData', eloC(2,:), 'ZData', eloC(3,:))

    pause(0.05)
end
MA1 = MA2;
MB1 = MB2;
MC1 = MC2;

%rotate on C ref
for a = linspace(0,-pi/2,20)
    MC2 = MC1*rot3("z",a);
    eloC = MC2*elo;
    
    set(A, 'XData', eloA(1,:), 'YData', eloA(2,:), 'ZData', eloA(3,:))
    set(B, 'XData', eloB(1,:), 'YData', eloB(2,:), 'ZData', eloB(3,:))
    set(C, 'XData', eloC(1,:), 'YData', eloC(2,:), 'ZData', eloC(3,:))

    pause(0.05)
end
MA1 = MA2;
MB1 = MB2;
MC1 = MC2;
