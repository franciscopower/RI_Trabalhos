% ROTATING CUBE FRAME
% This program requires the created funcions rot3 and trans3

% Creating the cube lines
n= 100;
L1 = [linspace(-3,3,n);
    (ones(1,n)*-3);
    (ones(1,n)*-3)];
L2 = [(ones(1,n)*-3);
    linspace(-3,3,n);
    (ones(1,n)*-3)];
L3 = [linspace(-3,3,n);
    (ones(1,n)*3);
    (ones(1,n)*-3)];
L4 = [(ones(1,n)*3);
    linspace(-3,3,n);
    (ones(1,n)*-3)];
L5 = [linspace(-3,3,n);
    (ones(1,n)*-3);
    (ones(1,n)*3)];
L6 = [(ones(1,n)*-3);
    linspace(-3,3,n);
    (ones(1,n)*3)];
L7 = [linspace(-3,3,n);
    (ones(1,n)*3);
    (ones(1,n)*3)];
L8 = [(ones(1,n)*3);
    linspace(-3,3,n);
    (ones(1,n)*3)];
L9 = [(ones(1,n)*-3);
    (ones(1,n)*-3);
    linspace(-3,3,n)];
L10 = [(ones(1,n)*3);
    (ones(1,n)*-3);
    linspace(-3,3,n)];
L11 = [(ones(1,n)*-3);
    (ones(1,n)*3);
    linspace(-3,3,n)];
L12 = [(ones(1,n)*3);
    (ones(1,n)*3);
    linspace(-3,3,n)];

% Creating entire cube
cube = [L1 L2 L3 L4 L5 L6 L7 L8 L9 L10 L11 L12];
cube = [cube; ones(1,12*n)];

% Plot cube
scatter3(cube(1,:), cube(2,:), cube(3,:), '.r')
hold on
axis equal
axis([-5 15 -5 5 -5 5])

pause(1)

% Create copy of cube and display
r_cube = cube;
h=scatter3(r_cube(1,:), r_cube(2,:), r_cube(3,:), '.g')

% Animate cube
n_frames = 50;
r = linspace(0,pi/2,n_frames);
t = linspace(0,10,n_frames);

for a = 1:n_frames
    r_cube = trans3(t(a),0,0)*rot3("z", r(a))*rot3("x", r(a))*cube;
    set(h, "XData", r_cube(1,:), "YData", r_cube(2,:), "ZData",  r_cube(3,:))
    pause(0.05)
end

hold off

