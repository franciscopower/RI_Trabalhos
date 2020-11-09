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
aTb1 = trans3(0,0,3); 
bTc1 = trans3(0,0,3); 
cTt1 = trans3(0,0,3);

oTa1 = eye(4);
oTb1 = aTb1;
oTc1 = aTb1*bTc1;
oTt1 = aTb1*bTc1*cTt1;

jointA = joint;
jointB = oTb1*joint; %place arm B in initial position
jointC = oTc1*joint; %place arm C in initial position
toolT = oTt1*tool; %place toolT in initial position

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
Pt = oTt1*trans3(0,0,1)*[Pt';1];

title(sprintf('Coordinates of tool tip: (%0.1f, %0.1f, %0.1f)', Pt(1),Pt(2),Pt(3)))

a = {'z',0,'x',-90,'x',90,'x',0;
    'z',-90,'x',0,'x',-180,'x',0;
    'z',90,'x',0,'x',180,'x',0;
    'z',-135,'x',-45+90,'x',-90,'x',-45};

for n = 1:2

    %get input values
    axisA=a{n,1};
    aA_incr = linspace(0,deg2rad(a{n,2}),frames);
    axisB=a{n,3};
    aB_incr = linspace(0,deg2rad(a{n,4}),frames);
    axisC=a{n,5};
    aC_incr = linspace(0,deg2rad(a{n,6}),frames);
    axisT=a{n,7};
    aT_incr = linspace(0,deg2rad(a{n,8}),frames);

    %rotate joints
    for i = 1:frames
        
        % calculate transformation matrices
%         oTa2 = rot3('z',aA_incr(i))*oTa1; %rotate around original oz
        oTa2 = oTa1*rot3(axisA,aA_incr(i));
        aTb2 = aTb1*rot3(axisB,aB_incr(i));
        bTc2 = bTc1*rot3(axisC,aC_incr(i));
        cTt2 = cTt1*rot3(axisT,aT_incr(i));
        
        oTb2 = oTa2*aTb2;
        oTc2 = oTa2*aTb2*bTc2;
        oTt2 = oTa2*aTb2*bTc2*cTt2;
        
        %calculate new positions of all points
        jointA = oTa2*joint;    
        jointB = oTb2*joint;
        jointC = oTc2*joint;
        toolT = oTt2*tool;
               
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
        Pt = oTt2*trans3(0,0,1)*[Pt';1];
%         % show tool tip trajectory
%         plot3(Pt(1), Pt(2), Pt(3), 'r.')
        % update title
        title(sprintf('Coordinates of tool tip: (%0.1f, %0.1f, %0.1f)', Pt(1),Pt(2),Pt(3)))
        
        pause(pause_time)
    end
    
    %update initial matrices
    oTa1 = oTa2;
    aTb1 = aTb2;
    bTc1 = bTc2;
    cTt1 = cTt2;
    
    pause(0.5)
    
end

