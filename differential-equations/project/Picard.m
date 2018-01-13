% plots the first, third and fifth approximations by using Picard method
% for the Cauchy problem:
% xdy/dx = 5y + 3x, y(2) = 1
% in blue, green, red color for x in [1; 3]
% than solves numerically the given problem and plots the solution in black
function Picard
    % x for all plots is in the interval [1; 3]
    xmin = 1;
    xmax = 3;

    % from many runs and experiments for the given equation y in [-8; 17]
    % fits perfectly from the plots
    ymin = -8;
    ymax = 17;
    
    % the starting condition y(2) = 1 = y0 = y(x0)
    x0 = 2;
    y0 = 1;
    
    % draw x-axis for x in [xmin; xmax] and y-axis for y in [ymin; ymax]
    axis([xmin xmax ymin ymax]);
    % ensure all plots remain
    hold on;
    % draw grid
    grid on;
    % label the x-axis
    xlabel('x');
    % label the y-axis
    ylabel('y');
    
    % the number of intervals used for spliting the inteval for x-es left
    % to x0 and right to x0 (since both ode45 and the recursive integral
    % from Picard method starts from x0)
    count = 100;
    % intervals for x-es left to x0
    xleft = x0:((xmin - x0) / count):xmin;
    % intervals for x-es right to x0
    xright = x0:((xmax - x0) / count):xmax;
    
    % cumtrapz is used for approximating the recursice integral from Picard
    % method wich takes interval splitted at sub-intervals represented by a
    % single vector and returns as an output vector with partial sums 
    % this is why we will add y0 to each element of the partial sums vector
    % creating vector with all 1 multiplied by y0 is the same as creating
    % vector of all y0 with length equal to the length of points left to x0
    % and right to x0
    y0left = y0 * ones(1, length(xleft));
    y0right = y0 * ones(1, length(xright));
    
    % define variables to store the previous approximation in Picard method
    yleftPrev = y0left;
    yrightPrev = y0right;
    
    % the right hand side of the given equation
    % xdy/dx = 5y + 3x
    % rewritten as dy/dx = 5(y/x) + 3 when x /= 0
    % (0 is not in our interval so no point is missed) 
    f = @(x, y) (5 * (y / x) + 3);
    
    % colors for the first (blue), third (green) and fifth (red)
    % approximations
    colors = ['b' 'g' 'r'];
    % starting with the color for first approximation to plot
    c = 1;
    
    % since we want to plot only the first, third and fifth approximations
    % we can calculate only the first five approximations
    for k=1:5
        % approximate the k'th Picard approximation
        % for the given equation for x-es left to x0 
        yleftk = y0left + cumtrapz(xleft, arrayfun(f, xleft, yleftPrev));
        % approximate the k'th Picard approximation
        % for the given equation for x-es left to x0 
        yrightk = y0right + cumtrapz(xright, arrayfun(f, xright, yrightPrev));
        
        % if k is odd than k is either 1, 3 or 5 and that approximation
        % must be plotted with the proper color
        if mod(k, 2) == 1
            % plot-ing both the points left to x0 and right to x0 in the
            % same color
            plot(xleft, yleftk, colors(c), xright, yrightk, colors(c));
            % switch color for the next plot
            c = c + 1;
        end
        
        % set the prev y-es to the current for the next iteration
        yleftPrev = yleftk;
        yrightPrev = yrightk;
    end
    
    % solve the given equation numerically with ode45
    % (the given equation is, is nonstiff so it's OK)
    % ode45 solves dy/dx = f(x, y) from x0 to xmax and requires the
    % required number of initial conditions (in this case only one)
    % at the x0 this is why a split to left x-es and right x-es is required
    % solve numerically the given equation for x-es left to x0 
    [xleft, yleft] = ode45(f, [x0 xmin], y0);
    % solve numerically the given equation for x-es right to x0
    [xright, yright] = ode45(f, [x0 xmax], y0);
    % plot the numeric solution by ploting both the one
    % for x-es left to x0 and right to x0 in black
    plot(xleft, yleft, 'k', xright, yright, 'k');
end
