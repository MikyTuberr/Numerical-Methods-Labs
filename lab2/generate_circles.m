function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
    index_number = 193630; 
    L1 = 0;
    circles = zeros(n_max, 3);
    rand_count = 0;
    rand_counts = zeros(n_max, 1);  
    counts_mean = zeros(n_max, 1);   
    for i = 1:n_max
        rand_count = 0;
        r = r_max + 1;
        x = -1;
        y = -1;
        while or(or(or(x - r <= 0, x + r >= a), ...
                or(y + r >= a, y - r <= 0)), ...
                check_overlapping(r, x, y, circles)) || ...
                 r >= r_max || r <=0
            x = a*rand;
            y = a*rand;
            r = r_max*rand;
            rand_count = rand_count + 1;
        end 
        rand_counts(i) = rand_count;  
        counts_mean(i) = mean(rand_counts(1:i)); 
        circles(i, :)= [x, y, r];
    end
    [circle_areas] = calculate_areas(n_max, circles);
end