I = rgb2gray(imread('batman2.jpg'));

I_bin = imbinarize(I);

I_bin = 1-I_bin;

edges = edge(I_bin);

edges_top = edges(1:end/2,:);
edges_bottom = edges(end/2+1:end,:);

[xt, yt] = find(edges_top);
[xb, yb] = find(edges_bottom);

y = -[xt;size(edges,1)/2+flipud(xb)];
x = [yt;flipud(yb)];



% figure(1)
% axis equal
% axis([0 size(edges,2) 0 size(edges,1)])
% 
% for i=1:size(x,1)
%    plot(x(i),y(i),'b.')
%    hold on
%    pause(0.0001)
% end
% hold off