%% 3D Robot arms

% Create figure
figure(1)
hold on
axis equal
grid on
axis([-10 10 -10 10 -10 10])
xlabel('x')
ylabel('y')
zlabel('z')
view(30,10)

% Animation settings
frames = 20;
pause_time = 0.05;

% cube points
ruf = [0.5 0.5 3]';
rub = [-0.5 0.5 3]';
lub = [-0.5 -0.5 3]';
luf = [0.5 -0.5 3]';
rdf = [0.5 0.5 0]';
rdb = [-0.5 0.5 0]';
ldb = [-0.5 -0.5 0]';
ldf = [0.5 -0.5 0]';

% Create joints
joint = [luf ldf rdf ruf rub rdb ldb lub;
        ones(1,8)];

% initial transformations
TB = trans3(0,0,3); 
TC = trans3(0,0,3); 

MA1 = eye(4);
MB1 = TB;
MC1 = TB*TC;

jointA = joint;
jointB = MB1*joint; %place arm B in initial position
jointC = MC1*joint; %place arm C in initial position

% Display initial joints
Af = fill3(jointA(1,1:4), jointA(2,1:4), jointA(3,1:4), 'r');
Ar = fill3(jointA(1,2:6), jointA(2,2:6), jointA(3,2:6), 'r');
Ab = fill3(jointA(1,4:8), jointA(2,4:8), jointA(3,4:8), 'r');
Al = fill3([jointA(1,1:2) jointA(1,7:8)] , [jointA(2,1:2) jointA(2,7:8)], [jointA(3,1:2) jointA(3,7:8)], 'r');

Bf = fill3(jointB(1,1:4), jointB(2,1:4), jointB(3,1:4), 'g');
Br = fill3(jointB(1,2:6), jointB(2,2:6), jointB(3,2:6), 'g');
Bb = fill3(jointB(1,4:8), jointB(2,4:8), jointB(3,4:8), 'g');
Bl = fill3([jointB(1,1:2) jointB(1,7:8)] , [jointB(2,1:2) jointB(2,7:8)], [jointB(3,1:2) jointB(3,7:8)], 'g');

Cf = fill3(jointC(1,1:4), jointC(2,1:4), jointC(3,1:4), 'b');
Cr = fill3(jointC(1,2:6), jointC(2,2:6), jointC(3,2:6), 'b');
Cb = fill3(jointC(1,4:8), jointC(2,4:8), jointC(3,4:8), 'b');
Cl = fill3([jointC(1,1:2) jointC(1,7:8)] , [jointC(2,1:2) jointC(2,7:8)], [jointC(3,1:2) jointC(3,7:8)], 'b');


while true
    
    % prompt user for rotation angles, in degrees
    prompt = {'Joint 1:','Axis 1:','Joint 2:','Axis 2:','Joint 3:','Axis 3:'};
    dlgtitle = 'Rotation Angles (º)';
    dims = [1 35];
    definput = {'0','x','0','x','0','x'};
    a = inputdlg(prompt,dlgtitle,dims,definput);
    
    %check if input is valid or canceled
    try
        aA = deg2rad(str2double(a{1}));
        axisA = a{2}(1);
        aB = deg2rad(str2double(a{3}));
        axisB = a{4}(1);
        aC = deg2rad(str2double(a{5}));
        axisC = a{6}(1);
        if isnan(aA) || isnan(aB) || isnan(aC)
            continue
        end
        
        if (axisA~='x' && axisA~='y' && axisA~='z') || (axisB~='x' && axisB~='y' && axisB~='z') || (axisC~='x' && axisC~='y' && axisC~='z')
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
        [MA2,MB2,MC2] = rotJoint(1,axisA,aA_incr(i),MA1,MB1,MC1);
        [MA2,MB2,MC2] = rotJoint(2,axisB,aB_incr(i),MA2,MB2,MC2);
        [MA2,MB2,MC2] = rotJoint(3,axisC,aC_incr(i),MA2,MB2,MC2);

        %calculate new positions of all points
        jointA = MA2*joint;    
        jointB = MB2*joint;
        jointC = MC2*joint;
               
        %display new positions
        set(Af, 'XData',jointA(1,1:4) , 'YData',jointA(2,1:4) , 'ZData',jointA(3,1:4) )
        set(Ar, 'XData',jointA(1,2:6) , 'YData',jointA(2,2:6) , 'ZData',jointA(3,2:6) )
        set(Ab, 'XData',jointA(1,4:8) , 'YData',jointA(2,4:8) , 'ZData',jointA(3,4:8) )
        set(Al, 'XData',[jointA(1,1:2) jointA(1,7:8)] , 'YData',[jointA(2,1:2) jointA(2,7:8)] , 'ZData',[jointA(3,1:2) jointA(3,7:8)] )
        
        set(Bf, 'XData',jointB(1,1:4) , 'YData',jointB(2,1:4) , 'ZData',jointB(3,1:4) )
        set(Br, 'XData',jointB(1,2:6) , 'YData',jointB(2,2:6) , 'ZData',jointB(3,2:6) )
        set(Bb, 'XData',jointB(1,4:8) , 'YData',jointB(2,4:8) , 'ZData',jointB(3,4:8) )
        set(Bl, 'XData',[jointB(1,1:2) jointB(1,7:8)] , 'YData',[jointB(2,1:2) jointB(2,7:8)] , 'ZData',[jointB(3,1:2) jointB(3,7:8)] )
        
        set(Cf, 'XData',jointC(1,1:4) , 'YData',jointC(2,1:4) , 'ZData',jointC(3,1:4) )
        set(Cr, 'XData',jointC(1,2:6) , 'YData',jointC(2,2:6) , 'ZData',jointC(3,2:6) )
        set(Cb, 'XData',jointC(1,4:8) , 'YData',jointC(2,4:8) , 'ZData',jointC(3,4:8) )
        set(Cl, 'XData',[jointC(1,1:2) jointC(1,7:8)] , 'YData',[jointC(2,1:2) jointC(2,7:8)] , 'ZData',[jointC(3,1:2) jointC(3,7:8)] )
        
        pause(pause_time)
    end
    
    %update initial matrices
    MA1 = MA2;
    MB1 = MB2;
    MC1 = MC2;
    
end

