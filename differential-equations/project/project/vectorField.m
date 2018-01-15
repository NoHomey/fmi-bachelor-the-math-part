xmin = -8;
xmax = 6;

ymin = -4;
ymax = 2;

x = xmin:0.3:xmax;
y = ymin:0.2:ymax;
    
offset = 0.5;
axis([xmin - offset xmax + offset ymin - offset ymax + offset]);
hold on;
xlabel('x');
ylabel('y');
    
plot(0, 0, 'Marker', '*', 'MarkerSize', 11, 'Color', [1, 0.2, 0.1]);
plot(-4, -2, 'Marker', '*', 'MarkerSize', 11, 'Color', [1, 0.2, 0.1]);
    
f1 = @(x, y) (-2 * x + 4 * y);
f2 = @(x, y) (x.^2 + 4 * x);
    
[X, Y] = meshgrid(x, y);
P = f1(X, Y);
Q = f2(X, Y);
Length = sqrt(P.^2 + Q.^2);
quiver(X, Y, P ./ Length, Q ./ Length, 0.42, 'Color', [0, 0.5, 1]);