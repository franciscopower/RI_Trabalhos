% Ex1a,c

p1 = [0 0]';
p2 = [3 0]';

M0 = [p1 p2];

M_90 = rot_2D(M0, pi/2);
M_45 = rot_2D(M0, pi/4);

figure(1)
line(M0(1,:), M0(2,:))
hold on
line(M_90(1,:), M_90(2,:))
line(M_45(1,:), M_45(2,:))
hold off

%% Ex1d -------------------------

p1 = [0 0]';
p2 = [3 0]';

M0 = [p1 p2];

figure(2)

h = line(M0(1,:), M0(2,:));

axis([-4 4 -4 4])
hold on
grid on
axis square

plot(M0(1,2), M0(2,2),'.r');
plot(0,0,'og')


for t = 0:pi/180:2*pi 
    M_c = rot_2D(M0, t);
    set(h,"XData",M_c(1,:),"YData", M_c(2,:))  
    plot(M_c(1,2), M_c(2,2),'.r');
    pause(0.01)
end

hold off

hold off