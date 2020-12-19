% basic cylinder
[cx, cy, cz] = cylinder(2)
cz = -cz* 8;
cyl = zeros(4, size(cx, 2), 2);
cyl(:,:,1) = [cz(1,:); cy(1,:); cx(1,:); ones(1,size(cx,2))];
cyl(:,:,2) = [cz(2,:); cy(2,:); cx(2,:); ones(1,size(cx,2))];

h = surf(cx, cy, cz, 'FaceColor', 'r');

axis equal
axis([-10 10 -10 10 -10 10])
xlabel('x')
ylabel('y')
zlabel('z')

for a = linspace(0,pi,20)
    
[ncx, ncy, ncz] = transfCylinder(rot3('y',a),cyl);
set(h, 'XData', ncx, 'YData', ncy, 'ZData', ncz)

pause(0.1)
end