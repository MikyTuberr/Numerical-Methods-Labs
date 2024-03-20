N = 1000:1000:8000;
n = length(N);
vtime_direct = ones(1,n);
time_Jacobi = ones(1, n);
time_Gauss_Seidel = ones(1, n);
iterations_Jacobi = 40*ones(1,n);
iterations_Gauss_Seidel = 40*ones(1,n);
for i =1:n
    [~,~,~,time_direct,~,~, ~] = solve_direct(N(i), [], []);
    vtime_direct(i) = time_direct;
    [~,~,~,~,~,~,time,iterations,~, ~] = solve_Jacobi(N(i), [], []);
    iterations_Jacobi(i) = iterations;
    time_Jacobi(i) = time;
    [~,~,~,~,~,time,iterations,~, ~] = solve_Gauss_Seidel(N(i), [], []);
    iterations_Gauss_Seidel(i) = iterations;
    time_Gauss_Seidel(i) = time;
end
plot_direct(N,vtime_direct);
plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel);
N = 100;
