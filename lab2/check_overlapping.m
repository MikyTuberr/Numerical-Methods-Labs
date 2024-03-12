function isOverlapping = check_overlapping(r, x, y, circles)
    if ~isempty(circles)
        isOverlapping = false;
        for i = 1:size(circles, 1)
            circle_x = circles(i,1);
            circle_y = circles(i,2);
            circle_r = circles(i, 3);
            d = sqrt((circle_x - x).^2 + (circle_y - y).^2);
            if d <= circle_r + r
                isOverlapping = true;
                break;
            end
        end
    end
end