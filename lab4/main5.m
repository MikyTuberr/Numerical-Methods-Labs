options = optimset('Display','iter');

% Dla punktu startowego 6.0
start_point = 6.0;
solution_6 = fzero(@tan, start_point, options);

% Dla punktu startowego 4.5
start_point = 4.5;
solution_45 = fzero(@tan, start_point, options);
