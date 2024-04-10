function time_delta = estimate_execution_time(N)
% time_delta - różnica pomiędzy estymowanym czasem wykonania algorytmu dla zadanej wartości N a zadanym czasem M
% N - liczba parametrów wejściowych

if N <= 0
    error('time must be positive: time = %f', t);
end

t = (N ^ (16/11) + N ^ (pi^2/8)) / 1000;
M = 5000; % [s]

time_delta = t - M;

end