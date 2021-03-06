a%% Ex2a

p1 = [-1 0]';
p2 = [1 0]';
p3 = [1 0.75]';
p4 = [0.5 0.75]';
p5 = [0.1 3]';
p6 = [-0.1 3]';
p7 = [-0.5 0.75]';
p8 = [-1 0.75]';

polPts = [p1 p2 p3 p4 p5 p6 p7 p8];

figure(1)

fill(polPts(1,:), polPts(2,:),'r');

axis square
hold on
axis([-10 10 -10 10])
grid on

hold off

%% Ex2b
figure(2)

h = fill(polPts(1,:), polPts(2,:),'r');

axis square
hold on
axis([-10 10 -10 10])
grid on

P = [polPts; ones(1,8)];

for a = linspace(0,3,20)
   P2 = trans(a,0)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05)
end


for t = linspace(0,pi/2,20)
   P2 = rot(t)*trans(3,0)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05)
end

hold off

%% Ex2c

figure(3)

h = fill(polPts(1,:), polPts(2,:),'r');

axis square
hold on
axis([-10 10 -10 10])
grid on

P = [polPts; ones(1,8)];

for t = 0:pi/180:pi/2
   P2 = rot(t)*trans(3,0)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.01)
end

for t = 0:pi/180:pi/2
   P2 = rot(t)*rot(pi/2)*trans(3,0)*rot(-2*t)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.01)
end

hold off

%% Ex2d

figure(4)

h = fill(polPts(1,:), polPts(2,:),'r');

axis square
hold on

axis([-10 10 -10 10])
grid on

P = [polPts; ones(1,8)];
P = P;

for a = linspace(0,3,20)
   P2 = trans(0,a)*trans(3,0)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05) 
end

for a = linspace(0,pi/2,20)
   P2 = trans(0,3)*trans(3,0)*rot(a)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05) 
end

for a = linspace(0,6,20)
   P2 = trans(-a,0)*trans(0,3)*trans(3,0)*rot(pi/2)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05) 
end

for a = linspace(0,pi/2,20)
   P2 = trans(-6,0)*trans(0,3)*trans(3,0)*rot(pi/2)*rot(a)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05) 
end

for a = linspace(0,6,20)
   P2 = trans(0,-a)*trans(-6,0)*trans(0,3)*trans(3,0)*rot(pi/2)*rot(pi/2)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05) 
end

for a = linspace(0,pi/2,20)
   P2 = trans(0,-6)*trans(-6,0)*trans(0,3)*trans(3,0)*rot(pi/2)*rot(pi/2)*rot(a)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05) 
end
% 
for a = linspace(0,6,20)
   P2 = trans(a,0)*trans(0,-6)*trans(-6,0)*trans(0,3)*trans(3,0)*rot(pi/2)*rot(pi/2)*rot(pi/2)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05) 
end

for a = linspace(0,pi/2,20)
   P2 = trans(6,0)*trans(0,-6)*trans(-6,0)*trans(0,3)*trans(3,0)*rot(pi/2)*rot(pi/2)*rot(pi/2)*rot(a)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05) 
end

for a = linspace(0,3,20)
   P2 = trans(0,a)*trans(6,0)*trans(0,-6)*trans(-6,0)*trans(0,3)*trans(3,0)*rot(pi/2)*rot(pi/2)*rot(pi/2)*rot(pi/2)*P;
   set(h, 'XData', P2(1,:), 'YData', P2(2,:))
   pause(0.05) 
end

hold off





















