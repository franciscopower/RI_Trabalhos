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
frames = 20;

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

MA1 = eye(4);
MB1 = TB;
MC1 = TB*TC;

eloA = elo;
eloB = MB1*elo; %place arm B in initial position
eloC = MC1*elo; %place arm 3 in initial position

% Display initial rectangles
A = fill3(eloA(1,:), eloA(2,:), eloA(3,:), 'r');
B = fill3(eloB(1,:), eloB(2,:), eloB(3,:), 'g');
C = fill3(eloC(1,:), eloC(2,:), eloC(3,:), 'b');



while 1 == 1
    prompt = {'Joint 1:','Joint 2:','Joint 3:'};
    dlgtitle = 'Rotation Angles';
    dims = [1 35];
    definput = {'0','0','0'};
    a = inputdlg(prompt,dlgtitle,dims,definput);

    try
        aA = deg2rad(str2double(a{1}));
        aB = deg2rad(str2double(a{2}));
        aC = deg2rad(str2double(a{3}));
        if isnan(aA) || isnan(aB) || isnan(aC)
            continue
        end
    catch
        break
    end

    aA_incr = linspace(0,aA,frames);
    aB_incr = linspace(0,aB,frames);
    aC_incr = linspace(0,aC,frames);

    %rotate on A ref
    for i = 1:frames

        [MA2,MB2,MC2] = rotElo(1,"z",aA_incr(i),MA1,MB1,MC1);
        [MA2,MB2,MC2] = rotElo(2,"z",aB_incr(i),MA2,MB2,MC2);
        [MA2,MB2,MC2] = rotElo(3,"z",aC_incr(i),MA2,MB2,MC2);

        eloA = MA2*elo;    
        eloB = MB2*elo;
        eloC = MC2*elo;

        set(A, 'XData', eloA(1,:), 'YData', eloA(2,:), 'ZData', eloA(3,:))
        set(B, 'XData', eloB(1,:), 'YData', eloB(2,:), 'ZData', eloB(3,:))
        set(C, 'XData', eloC(1,:), 'YData', eloC(2,:), 'ZData', eloC(3,:))

        pause(0.05)
    end
    MA1 = MA2;
    MB1 = MB2;
    MC1 = MC2;
    
end

