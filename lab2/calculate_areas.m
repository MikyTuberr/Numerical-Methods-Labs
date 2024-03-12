function [circle_areas] = calculate_areas(n_max, circles)
    areas = zeros(n_max, 1);
    for i = 1:n_max
        areas(i) = pi * circles(i, 3).^2;
    end
    circle_areas = cumsum(areas);
end