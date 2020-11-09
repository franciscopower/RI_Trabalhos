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
aTb1 = trans3(3,0,0); 
bTc1 = trans3(3,0,0); 

oTa1 = eye(4);
oTb1 = aTb1;
oTc1 = aTb1*bTc1;

jointA = joint;
jointB = oTb1*joint; %place arm B in initial position
jointC = oTc1*joint; %place arm C in initial position

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
    % end prompt ---------------------------------------------------------
    
    %get input values
    aA_incr = linspace(0,aA,frames);
    aB_incr = linspace(0,aB,frames);
    aC_incr = linspace(0,aC,frames);

    %rotate joints
    for i = 1:frames
        
        % calculate transformation matrices
        oTa2 = oTa1*rot3('z',aA_incr(i));
        aTb2 = aTb1*rot3('z',aB_incr(i));
        bTc2 = bTc1*rot3('z',aC_incr(i));
        
        oTb2 = oTa2*aTb2;
        oTc2 = oTa2*aTb2*bTc2;
        
        %calculate new positions of all points
        jointA = oTa2*joint;    
        jointB = oTb2*joint;
        jointC = oTc2*joint;
               
        %display new positions
        set(A, 'XData', jointA(1,:), 'YData', jointA(2,:), 'ZData', jointA(3,:))
        set(B, 'XData', jointB(1,:), 'YData', jointB(2,:), 'ZData', jointB(3,:))
        set(C, 'XData', jointC(1,:), 'YData', jointC(2,:), 'ZData', jointC(3,:))
        
        pause(pause_time)
    end
    
    %update initial matrices
    oTa1 = oTa2;
    aTb1 = aTb2;
    bTc1 = bTc2;    
end

