function plot_circle_areas(circle_areas)
    figure;
    plot(circle_areas);
    title('Circle Areas Plot');
    xlabel('Index');
    ylabel('Area');
    grid on;
    print -dpng zadanie3.png 
end