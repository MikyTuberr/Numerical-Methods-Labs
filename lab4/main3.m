a = 1;
b = 50;
ytolerance = 1e-12;
max_iterations = 100;
f = @(velocity) rocket_velocity(velocity);

[time_bisection,~,~,xtab_bisec,xdif_bisec] = bisection_method(a,b,max_iterations,ytolerance,f);

[time_secant,~,~,xtab_sec,xdif_sec] = secant_method(a,b,max_iterations,ytolerance,f);

figure('Name', 'Velocity Plots');
plot_xtab(xtab_bisec, xtab_sec);
plot_xdif(xdif_bisec, xdif_sec);
print -dpng zadanie6.png 