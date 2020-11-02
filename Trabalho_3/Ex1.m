%% 2D Robot arms

% Create figure
figure(1)
hold on
axis square
grid on
axis([-15 15 -15 15])
xlabel('x')
ylabel('y')

% Rectangle points
p1 = [0 -0.5]';
p2 = [3 -0.5]';
p3 = [3 0.5]';
p4 = [0 0.5]';

% Create rectangles
elo = [p1 p2 p3 p4
    ones(1,4)];

% initial transformations
TB = trans(3,0); 
TC = trans(3,0); 

eloA = elo;
eloB = TB*elo; %place arm B in initial position
eloC = TB*TC*elo; %place arm 3 in initial position

% Display initial rectangles
A = fill(eloA(1,:), eloA(2,:), 'r');
B = fill(eloB(1,:), eloB(2,:), 'g');
C = fill(eloC(1,:), eloC(2,:), 'b');

MA1 = eye(3);
MA2 = eye(3);
MB1 = TB;
MB2 = eye(3);
MC1 = TB*TC;
MC2 = eye(3);

%rotate on A ref
for a = linspace(0,pi/2,20)
    MA2 = rot(a)*MA1;
    eloA = MA2*elo;
    
    MB2 = MA2*MA1^-1*MB1;
    eloB = MB2*elo;
    
    MC2 = MB2*MB1^-1*MC1;
    eloC = MC2*elo;
    
    set(A, 'XData', eloA(1,:), 'YData', eloA(2,:))
    set(B, 'XData', eloB(1,:), 'YData', eloB(2,:))
    set(C, 'XData', eloC(1,:), 'YData', eloC(2,:))

    pause(0.05)
end
MA1 = MA2;
MB1 = MB2;
MC1 = MC2;

%rotate on B ref
for a = linspace(0,pi/2,20)
    MB2 = MB1*rot(a);
    eloB = MB2*elo;
    
    MC2 = MB2*MB1^-1*MC1;
    eloC = MC2*elo;
    
    set(B, 'XData', eloB(1,:), 'YData', eloB(2,:))
    set(C, 'XData', eloC(1,:), 'YData', eloC(2,:))

    pause(0.05)
end
MA1 = MA2;
MB1 = MB2;
MC1 = MC2;

%rotate on C ref
for a = linspace(0,-pi/2,20)
    MC2 = MC1*rot(a);
    eloC = MC2*elo;
    
    set(B, 'XData', eloB(1,:), 'YData', eloB(2,:))
    set(C, 'XData', eloC(1,:), 'YData', eloC(2,:))

    pause(0.05)
end
MA1 = MA2;
MB1 = MB2;
MC1 = MC2;
