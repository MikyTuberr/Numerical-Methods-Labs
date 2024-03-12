function plot_square(a, X, Y)
    x = [X, X+a, X+a, X, X];
    y = [Y, Y, Y+a, Y+a, Y];
    plot(x,y,LineWidth=2);
    axis equal;
end
