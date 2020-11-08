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

% toolT cube points
ruft = [0.25 0.25 1]';
rubt = [-0.25 0.25 1]';
lubt = [-0.25 -0.25 1]';
luft = [0.25 -0.25 1]';
rdft = [0.25 0.25 0]';
rdbt = [-0.25 0.25 0]';
ldbt = [-0.25 -0.25 0]';
ldft = [0.25 -0.25 0]';

% Create joints
joint = [luf ldf rdf ruf rub rdb ldb lub;
        ones(1,8)];
% Create toolT
tool = [luft ldft rdft ruft rubt rdbt ldbt lubt;
        ones(1,8)];

% initial transformations
TB = trans3(0,0,3); 
TC = trans3(0,0,3); 
Tt = trans3(0,0,3);

MA1 = eye(4);
MB1 = TB;
MC1 = TB*TC;
Mt1 = TB*TC*Tt;

jointA = joint;
jointB = MB1*joint; %place arm B in initial position
jointC = MC1*joint; %place arm C in initial position
toolT = Mt1*tool; %place toolT in initial position

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

tf = fill3(toolT(1,1:4), toolT(2,1:4), toolT(3,1:4), 'y');
tr = fill3(toolT(1,2:6), toolT(2,2:6), toolT(3,2:6), 'y');
tb = fill3(toolT(1,4:8), toolT(2,4:8), toolT(3,4:8), 'y');
tl = fill3([toolT(1,1:2) toolT(1,7:8)] , [toolT(2,1:2) toolT(2,7:8)], [toolT(3,1:2) toolT(3,7:8)], 'y');

Pt = [0,0,0];
Pt = Mt1*trans3(0,0,1)*[Pt';1];

title(sprintf('Coordinates of tool tip: (%0.1f, %0.1f, %0.1f)', Pt(1),Pt(2),Pt(3)))

[a1z,a1x,a2x,a3x] = posToAngle(pos,3,1);

% a = {0,'x',-90,'x',90,'x',0,'x';
%     -135,'z',-45,'x',0,'x',-45,'x'};

for n = 1:2
    %get input values
    aA = deg2rad(a{n,1});
    axisA = a{n,2};
    aB = deg2rad(a{n,3});
    axisB = a{n,4};
    aC = deg2rad(a{n,5});
    axisC = a{n,6};
    aT = deg2rad(a{n,7});
    axisT = a{n,8};
    
    aA_incr = linspace(0,aA,frames);
    aB_incr = linspace(0,aB,frames);
    aC_incr = linspace(0,aC,frames);
    aT_incr = linspace(0,aT,frames);    

    %rotate joints
    for i = 1:frames
        % calculate transformation matrices
        [MA2,MB2,MC2,Mt2] = rotJoint(1,axisA,aA_incr(i),MA1,MB1,MC1,Mt1);
        [MA2,MB2,MC2,Mt2] = rotJoint(2,axisB,aB_incr(i),MA2,MB2,MC2,Mt2);
        [MA2,MB2,MC2,Mt2] = rotJoint(3,axisC,aC_incr(i),MA2,MB2,MC2,Mt2);
        [MA2,MB2,MC2,Mt2] = rotJoint(4,axisT,aT_incr(i),MA2,MB2,MC2,Mt2);
        
        %calculate new positions of all points
        jointA = MA2*joint;    
        jointB = MB2*joint;
        jointC = MC2*joint;
        toolT = Mt2*tool;
               
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
        
        set(tf, 'XData',toolT(1,1:4) , 'YData',toolT(2,1:4) , 'ZData',toolT(3,1:4) )
        set(tr, 'XData',toolT(1,2:6) , 'YData',toolT(2,2:6) , 'ZData',toolT(3,2:6) )
        set(tb, 'XData',toolT(1,4:8) , 'YData',toolT(2,4:8) , 'ZData',toolT(3,4:8) )
        set(tl, 'XData',[toolT(1,1:2) toolT(1,7:8)] , 'YData',[toolT(2,1:2) toolT(2,7:8)] , 'ZData',[toolT(3,1:2) toolT(3,7:8)] )
        
        % calculate coordinates of tool tip
        Pt = [0,0,0];
        Pt = Mt2*trans3(0,0,1)*[Pt';1];
%         % show tool tip trajectory
%         plot3(Pt(1), Pt(2), Pt(3), 'r.')
        % update title
        title(sprintf('Coordinates of tool tip: (%0.1f, %0.1f, %0.1f)', Pt(1),Pt(2),Pt(3)))
        
        pause(pause_time)
    end
    
    %update initial matrices
    MA1 = MA2;
    MB1 = MB2;
    MC1 = MC2;
    Mt1 = Mt2;
    
end
