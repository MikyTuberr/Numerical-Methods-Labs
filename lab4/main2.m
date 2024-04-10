a = 1;
b = 50;
ytolerance = 1e-12;
max_iterations = 100;
f = @(omega) impedance_magnitude(omega);

[omega_bisection,~,~,xtab_bisec,xdif_bisec] = bisection_method(a,b,max_iterations,ytolerance,f);

[omega_secant,~,~,xtab_sec,xdif_sec] = secant_method(a,b,max_iterations,ytolerance,f);

figure('Name', 'Omega Plots');
plot_xtab(xtab_bisec, xtab_sec);
plot_xdif(xdif_bisec, xdif_sec);
print -dpng zadanie4.png 


