function velocity_delta = rocket_velocity(t)
% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety
if t <= 0
    error('time must be positive: time = %f', t);
end

m0 = 150000;
u = 2000;
q = 2700;
g = 1.622;

V = u * log(m0 / (m0 - q*t)) - g*t; % [m/s]
M = 750;

velocity_delta = V - M;

end