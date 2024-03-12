function plot_circles(a, circles, index_number)
    axis equal;
    axis([0 a 0 a]);
    hold on;
    for i = 1:index_number
        plot_circle(circles(i, 3), circles(i, 2), circles(i, 1));
        pause(0.1);
    end
    hold off;
end