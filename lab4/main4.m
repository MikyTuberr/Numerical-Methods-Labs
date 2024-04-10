a = 1;
b = 60000;
ytolerance = 1e-12;
max_iterations = 100;
f = @(N) estimate_execution_time(N);

[n_bisection,~,~,xtab_bisec,xdif_bisec] = bisection_method(a,b,max_iterations,ytolerance,f);

[n_secant,~,~,xtab_sec,xdif_sec] = secant_method(a,b,max_iterations,ytolerance,f);

figure('Name', 'Execution Times Plots');
plot_xtab(xtab_bisec, xtab_sec);
plot_xdif(xdif_bisec, xdif_sec);
print -dpng zadanie8.png 