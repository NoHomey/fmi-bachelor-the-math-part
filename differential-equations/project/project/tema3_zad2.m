% plots the fixed points of the system of ODEs:
% dx/dt = -2x + 4y, dy/dt = x^2 + 4x
% plays animation of point moving in the phase plane
% at the curve starting at (x(0), y(0)) = (x0, y0),
% which are inputed via mouse click
% the curve ends at (x(8), y(8)) (t is in [0, 8])
% the curve is actually the solution of the given system
% with inital conditions (x(0), y(0)) = (x0, y0)
% the system is time independent (Autonomous system) and it's solved
% numerically with ode15s
function tema3_zad2
    % maximum t, t is in [0, 8];
    tmax = 8;
    
    % fixed points are (0, 0) and (-4, -2)
    % D = [-8, 6] x [-4, 2] seems like the perfect rectangle
    % x in [-8, 6]
    xmin = -8;
    xmax = 6;
    % y in [-4, 2]
    ymin = -4;
    ymax = 2;
    
    % x in [xmin, xmax] with step 0.3
    x = xmin:0.3:xmax;
    % y in [ymin, ymax] with step 0.2
    y = ymin:0.2:ymax;
    
    % axis offset for beauty
    offset = 0.5;
    % draw x-axis and y-axis
    axis([xmin - offset xmax + offset ymin - offset ymax + offset]);
    % ensure all plots remain
    hold on;
    % label the x-axis
    xlabel('x');
    % label the y-axis
    ylabel('y');
    
    % plot the fixed point (0, 0) with * (Asterisk) as marker in red
    plot(0, 0, 'Marker', '*', 'MarkerSize', 11, 'Color', [1, 0.2, 0.1]);
    % plot the fixed point (-4, -2) with * (Asterisk) as marker in red
    plot(-4, -2, 'Marker', '*', 'MarkerSize', 11, 'Color', [1, 0.2, 0.1]);
    
    % dx/dt = f1(x, y) = -2x + 4y
    f1 = @(x, y) (-2 * x + 4 * y);
    % dy/dt = f2(x, y) = x^2 + 4x
    f2 = @(x, y) (x.^2 + 4 * x);
    
    % Create 2-D grid coordinates
    % with x-coordinates defined by the vector x
    % and y-coordinates defined by the vector y.
    [X, Y] = meshgrid(x, y);
    % calcualte the velocity vectors x ends (or dx/dt for each X)
    P = f1(X, Y);
    % calcualte the velocity vectors y ends (or dy/dt for each Y)
    Q = f2(X, Y);
    % calculate each velocity vector length (threat them as radius vectors)
    Length = sqrt(P.^2 + Q.^2);
    % plot each normalizate velocity vector using quiver and scale them
    % each radius vector (P(k), Q(k)) is transition at (X(k), Y(k))
    quiver(X, Y, P ./ Length, Q ./ Length, 0.42, 'Color', [0, 0.5, 1]);
    
    % clear varaibles that are no longer needed (only array ones)
    clear x;
    clear y;
    clear X;
    clear Y;
    clear P;
    clear Q;
    clear Length;
    
    % get initial conditions via mouse click
    [x0, y0] = ginput(1);
    % solve the given system of ODEs wich is time independent (Autonomous
    % system) wich turns out to be stiff so ode15s solver was choosen
    % dsolve dose not even solve the system ...
    % solving for t in [0, tmax] with initial conditions
    % x(0) = x0 and y(0) = y0
    [T, S] = ode15s(@(t, s) [f1(s(1), s(2)); f2(s(1), s(2))], [0, tmax], [x0; y0]);
    % save the length of solution vectors lengths wich are the same as T
    timeLength = length(T);
    % release memory for T
    clear T;
    
    for k=1:timeLength
        % plot each point of the point movement curve starting at (x0, y0)
        % and ending at (x(tmax), y(tmax)) with (x, y) beeing the solution
        % also style the plot with color and thicker line width
        plot(S(1:k,1), S(1:k,2), 'Color', [1, 0.2, 0.1], 'LineWidth', 1.2);
        % capture the current axes as a movie frame
        getframe;
    end
end