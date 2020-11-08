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

% Animation settings
frames = 20;
pause_time = 0.05;

% Rectangle points
p1 = [0 -0.5 0]';
p2 = [3 -0.5 0]';
p3 = [3 0.5 0]';
p4 = [0 0.5 0]';

% Create rectangles
joint = [p1 p2 p3 p4;
        ones(1,4)];

% initial transformations
TB = trans3(3,0,0); 
TC = trans3(3,0,0); 

MA1 = eye(4);
MB1 = TB;
MC1 = TB*TC;

jointA = joint;
jointB = MB1*joint; %place arm B in initial position
jointC = MC1*joint; %place arm C in initial position

% Display initial rectangles
A = fill3(jointA(1,:), jointA(2,:), jointA(3,:), 'r');
B = fill3(jointB(1,:), jointB(2,:), jointB(3,:), 'g');
C = fill3(jointC(1,:), jointC(2,:), jointC(3,:), 'b');

while true
    
    % prompt user for rotation angles, in degrees
    prompt = {'Joint 1:','Joint 2:','Joint 3:'};
    dlgtitle = 'Rotation Angles (º)';
    dims = [1 35];
    definput = {'0','0','0'};
    a = inputdlg(prompt,dlgtitle,dims,definput);
    
    %check if input is valid or canceled
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
    
    %get input values
    aA_incr = linspace(0,aA,frames);
    aB_incr = linspace(0,aB,frames);
    aC_incr = linspace(0,aC,frames);

    %rotate joints
    for i = 1:frames
        % calculate transformation matrices
        [MA2,MB2,MC2,~] = rotJoint(1,"z",aA_incr(i),MA1,MB1,MC1,eye(4));
        [MA2,MB2,MC2,~] = rotJoint(2,"z",aB_incr(i),MA2,MB2,MC2,eye(4));
        [MA2,MB2,MC2,~] = rotJoint(3,"z",aC_incr(i),MA2,MB2,MC2,eye(4));

        %calculate new positions of all points
        jointA = MA2*joint;    
        jointB = MB2*joint;
        jointC = MC2*joint;
        
        %display new positions
        set(A, 'XData', jointA(1,:), 'YData', jointA(2,:), 'ZData', jointA(3,:))
        set(B, 'XData', jointB(1,:), 'YData', jointB(2,:), 'ZData', jointB(3,:))
        set(C, 'XData', jointC(1,:), 'YData', jointC(2,:), 'ZData', jointC(3,:))

        pause(pause_time)
    end
    
    %update initial matrices
    MA1 = MA2;
    MB1 = MB2;
    MC1 = MC2;
    
end

