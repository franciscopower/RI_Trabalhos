%% 3D Robot arms

clear all
clc
close all

% Create figure
figure(1)
hold on
axis equal
grid on
axis([-10 20 -10 20 -10 10])
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
oTb1 = oTa1*aTb1;
oTc1 = oTa1*aTb1*bTc1;
oTt1 = oTa1*aTb1*bTc1*cTt1;

jointA = joint;
jointB = oTb1*joint; %place arm B in initial position
jointC = oTc1*joint; %place arm C in initial position
toolT = oTt1*tool; %place toolT in initial position

% contruçao do robot 2

% initial transformations of robot 2
aTb1_2 = trans3(0,0,3); 
bTc1_2 = trans3(0,0,3); 
cTt1_2 = trans3(0,0,3);

oTa1_2 = trans3(12.3,0,0);
oTb1_2 = oTa1_2*aTb1_2;
oTc1_2 = oTa1_2*aTb1_2*bTc1_2;
oTt1_2 = oTa1_2*aTb1_2*bTc1_2*cTt1_2;

jointA_2 = oTa1_2*joint;
jointB_2 = oTb1_2*joint; %place arm B in initial position
jointC_2 = oTc1_2*joint; %place arm C in initial position
toolT_2 = oTt1_2*tool; %place toolT in initial position




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


% Display initial joints 2 
Af_2 = fill3(jointA_2(1,1:4), jointA_2(2,1:4), jointA_2(3,1:4), 'r');
Ar_2 = fill3(jointA_2(1,2:6), jointA_2(2,2:6), jointA_2(3,2:6), 'r');
Ab_2 = fill3(jointA_2(1,4:8), jointA_2(2,4:8), jointA_2(3,4:8), 'r');
Al_2 = fill3([jointA_2(1,1:2) jointA_2(1,7:8)] , [jointA_2(2,1:2) jointA_2(2,7:8)], [jointA_2(3,1:2) jointA_2(3,7:8)], 'r');

Bf_2 = fill3(jointB_2(1,1:4), jointB_2(2,1:4), jointB_2(3,1:4), 'g');
Br_2 = fill3(jointB_2(1,2:6), jointB_2(2,2:6), jointB_2(3,2:6), 'g');
Bb_2 = fill3(jointB_2(1,4:8), jointB_2(2,4:8), jointB_2(3,4:8), 'g');
Bl_2 = fill3([jointB_2(1,1:2) jointB_2(1,7:8)] , [jointB_2(2,1:2) jointB_2(2,7:8)], [jointB_2(3,1:2) jointB_2(3,7:8)], 'g');

Cf_2 = fill3(jointC_2(1,1:4), jointC_2(2,1:4), jointC_2(3,1:4), 'b');
Cr_2 = fill3(jointC_2(1,2:6), jointC_2(2,2:6), jointC_2(3,2:6), 'b');
Cb_2 = fill3(jointC_2(1,4:8), jointC_2(2,4:8), jointC_2(3,4:8), 'b');
Cl_2 = fill3([jointC_2(1,1:2) jointC_2(1,7:8)] , [jointC_2(2,1:2) jointC_2(2,7:8)], [jointC_2(3,1:2) jointC_2(3,7:8)], 'b');

tf_2 = fill3(toolT_2(1,1:4), toolT_2(2,1:4), toolT_2(3,1:4), 'y');
tr_2 = fill3(toolT_2(1,2:6), toolT_2(2,2:6), toolT_2(3,2:6), 'y');
tb_2 = fill3(toolT_2(1,4:8), toolT_2(2,4:8), toolT_2(3,4:8), 'y');
tl_2 = fill3([toolT_2(1,1:2) toolT_2(1,7:8)] , [toolT_2(2,1:2) toolT_2(2,7:8)], [toolT_2(3,1:2) toolT_2(3,7:8)], 'y');

Pt_2 = [0,0,0];
Pt_2 = oTt1_2*trans3(0,0,1)*[Pt_2';1];


%title(sprintf('Coordinates of tool tip: (%0.1f, %0.1f, %0.1f)', Pt_2(1),Pt_2(2),Pt_2(3)))


% movimentos a executar para o robot1 
a = {'z',-45,'x',100,'x',20,'x',20;
    'z',0,'x',-45,'x',0,'x',0;
    'z',135,'x',0,'x',0,'x',0;
    'z',0,'x',45,'x',0,'x',0;
    'z',0,'x',-100,'x',0,'x',0;
    'z',0,'x',0,'x',-20,'x',-20;
    'z',0,'x',0,'x',0,'x',0;
    'z',0,'x',0,'x',0,'x',0;
    'z',0,'x',0,'x',0,'x',0;
    };

% movimentos a executar para o robot2 
b = {'z',-45,'x',-100,'x',-20,'x',-20;
    'z',0,'x',0,'x',0,'x',0;
    'z',0,'x',0,'x',0,'x',0;
    'z',0,'x',0,'x',0,'x',0;
    'z',135,'x',0,'x',0,'x',0;
    'z',90,'x',45,'x',-20,'x',20;
     'z',0,'x',0,'x',0,'z',-360;
     'z',90,'x',-45,'x',-20,'z',-20;
     'z',-90,'x',100,'x',60,'z',20;
    };


for n = 1:9

    %get input values of Robot 1
    axisA=a{n,1};
    aA_incr = linspace(0,deg2rad(a{n,2}),frames);
    axisB=a{n,3};
    aB_incr = linspace(0,deg2rad(a{n,4}),frames);
    axisC=a{n,5};
    aC_incr = linspace(0,deg2rad(a{n,6}),frames);
    axisT=a{n,7};
    aT_incr = linspace(0,deg2rad(a{n,8}),frames);
    
    %get input values of Robot 2
    axisA_2=b{n,1};
    aA_incr_2 = linspace(0,deg2rad(b{n,2}),frames);
    axisB_2=b{n,3};
    aB_incr_2 = linspace(0,deg2rad(b{n,4}),frames);
    axisC_2=b{n,5};
    aC_incr_2 = linspace(0,deg2rad(b{n,6}),frames);
    axisT_2=b{n,7};
    aT_incr_2 = linspace(0,deg2rad(b{n,8}),frames);

    %rotate joints
    for i = 1:frames
        
        
        % calculos par ao robot 1
        
        % calculate transformation matrices 
        %oTa2 = rot3('z',aA_incr(i))*oTa1; %rotate around original oz
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
        
        
        
        % calculos par ao robot 2
 
        % calculate transformation matrices 
        %oTa2 = rot3('z',aA_incr(i))*oTa1; %rotate around original oz
        oTa2_2 = oTa1_2*rot3(axisA_2,aA_incr_2(i));
        aTb2_2 = aTb1_2*rot3(axisB_2,aB_incr_2(i));
        bTc2_2 = bTc1_2*rot3(axisC_2,aC_incr_2(i));
        cTt2_2 = cTt1_2*rot3(axisT_2,aT_incr_2(i));
        
        oTb2_2 = oTa2_2*aTb2_2;
        oTc2_2 = oTa2_2*aTb2_2*bTc2_2;
        oTt2_2 = oTa2_2*aTb2_2*bTc2_2*cTt2_2;
        
        %calculate new positions of all points
        jointA_2 = oTa2_2*joint;    
        jointB_2 = oTb2_2*joint;
        jointC_2 = oTc2_2*joint;
        toolT_2 = oTt2_2*tool;
        
        
        
        
               
        %display new positions for robot 1
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
        
        
        %display new positions for robot 
        
         set(Af_2, 'XData',jointA_2(1,1:4) , 'YData',jointA_2(2,1:4) , 'ZData',jointA_2(3,1:4) )
        set(Ar_2, 'XData',jointA_2(1,2:6) , 'YData',jointA_2(2,2:6) , 'ZData',jointA_2(3,2:6) )
        set(Ab_2, 'XData',jointA_2(1,4:8) , 'YData',jointA_2(2,4:8) , 'ZData',jointA_2(3,4:8) )
        set(Al_2, 'XData',[jointA_2(1,1:2) jointA_2(1,7:8)] , 'YData',[jointA_2(2,1:2) jointA_2(2,7:8)] , 'ZData',[jointA_2(3,1:2) jointA_2(3,7:8)] )
        
        set(Bf_2, 'XData',jointB_2(1,1:4) , 'YData',jointB_2(2,1:4) , 'ZData',jointB_2(3,1:4) )
        set(Br_2, 'XData',jointB_2(1,2:6) , 'YData',jointB_2(2,2:6) , 'ZData',jointB_2(3,2:6) )
        set(Bb_2, 'XData',jointB_2(1,4:8) , 'YData',jointB_2(2,4:8) , 'ZData',jointB_2(3,4:8) )
        set(Bl_2, 'XData',[jointB_2(1,1:2) jointB_2(1,7:8)] , 'YData',[jointB_2(2,1:2) jointB_2(2,7:8)] , 'ZData',[jointB_2(3,1:2) jointB_2(3,7:8)] )
        
        set(Cf_2, 'XData',jointC_2(1,1:4) , 'YData',jointC_2(2,1:4) , 'ZData',jointC_2(3,1:4) )
        set(Cr_2, 'XData',jointC_2(1,2:6) , 'YData',jointC_2(2,2:6) , 'ZData',jointC_2(3,2:6) )
        set(Cb_2, 'XData',jointC_2(1,4:8) , 'YData',jointC_2(2,4:8) , 'ZData',jointC_2(3,4:8) )
        set(Cl_2, 'XData',[jointC_2(1,1:2) jointC_2(1,7:8)] , 'YData',[jointC_2(2,1:2) jointC_2(2,7:8)] , 'ZData',[jointC_2(3,1:2) jointC_2(3,7:8)] )
        
        set(tf_2, 'XData',toolT_2(1,1:4) , 'YData',toolT_2(2,1:4) , 'ZData',toolT_2(3,1:4) )
        set(tr_2, 'XData',toolT_2(1,2:6) , 'YData',toolT_2(2,2:6) , 'ZData',toolT_2(3,2:6) )
        set(tb_2, 'XData',toolT_2(1,4:8) , 'YData',toolT_2(2,4:8) , 'ZData',toolT_2(3,4:8) )
        set(tl_2, 'XData',[toolT_2(1,1:2) toolT_2(1,7:8)] , 'YData',[toolT_2(2,1:2) toolT_2(2,7:8)] , 'ZData',[toolT_2(3,1:2) toolT_2(3,7:8)] )
        
        
        
        
        
        
        
        
        
        
        % calculate coordinates of tool tip of robot 1
        %Pt = [0,0,0];
        %Pt = oTt2*trans3(0,0,1)*[Pt';1];
%         % show tool tip trajectory
       % plot3(Pt(1), Pt(2), Pt(3), 'r.')
        % update title
        title("workspace")
        
        pause(pause_time)
    end
    
    %update initial matrices
    oTa1 = oTa2;
    aTb1 = aTb2;
    bTc1 = bTc2;
    cTt1 = cTt2;
    
    oTa1_2 = oTa2_2;
    aTb1_2 = aTb2_2;
    bTc1_2 = bTc2_2;
    cTt1_2 = cTt2_2;
    
    pause(0.5)
    
end

