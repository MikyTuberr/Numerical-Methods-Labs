load('filtr_dielektryczny.mat');

N = 20000;
[~,~,x,~,err_norm,~] = solve_direct(N, A, b);
%direct = x;
residual_norm_direct = err_norm;

[~,~,~,~,x,err_norm,~,iterations,~, residuals] = solve_Gauss_Seidel(N, A, b);
%gauss = x;
residual_norm_gauss = err_norm;
iter_gaus = iterations;

plot_residuals_iterations(residuals, iterations, 'błąd w iteracjach (Gauss)')
print -dpng zadanie6-gauss.png 

[~,~,~,~, x,err_norm,~,iterations,~,residuals] = solve_Jacobi(N, A, b);
%jacobi = x;
valid_values = residuals(~isnan(residuals) & ~isinf(residuals));
residual_norm_jacobi = max(valid_values);
iter_jacobi = find(residuals == residual_norm_jacobi);

plot_residuals_iterations(residuals, iterations, 'błąd w iteracjach (Jacobi)')
print -dpng zadanie6-jacobi.png 

% Zapisanie wyników do pliku tekstowego
fid = fopen('zadanie6.txt', 'w');
fprintf(fid, 'Metoda bezposrednia:\n');
fprintf(fid, 'Norma błędu rezydualnego:\n');
fprintf(fid, '%.18f\n\n', residual_norm_direct);

fprintf(fid, 'Metoda Jacobiego:\n');
fprintf(fid, 'Norma błędu rezydualnego:\n');
fprintf(fid, '%f\n\n', residual_norm_jacobi);
fprintf(fid, 'Liczba iteracji: %d\n\n', iter_jacobi);

fprintf(fid, 'Metoda Gaussa-Seidela:\n');
fprintf(fid, 'Norma błędu rezydualnego:\n');
fprintf(fid, '%f\n\n', residual_norm_gauss);
fprintf(fid, 'Liczba iteracji: %d\n\n', iter_gaus);

fprintf(fid, "Na podstawie uzyskanych danych wynika, że metody iteracyjne (Jacobiego i Gaussa-Seidela) nie osiągnęły zbieżności dla dostarczonych danych wejściowych.\n" + ...
    "Na wykresach (zadanie6-gauss.png, zadanie6-jacobi.png) możemy zaobserować, jak rośnie błąd rezydualny po przekroczeniu granicznej liczby iteracji.\n" + ...
    "W przeciwieństwie do tego, metoda bezpośrednia osiągnęła normę błędu rezydualnego rzędu 10^-13, co świadczy o jej skuteczności w rozwiązaniu problemu.\n" + ...
    "Pomimo potencjalnych zalet metod iteracyjnych, ich niepowodzenie w tym konkretnym przypadku wskazuje na ich ograniczenia w radzeniu sobie z danymi o określonych właściwościach.\n" + ...
    "Wybór odpowiedniej metody rozwiązania równań macierzowych powinien być dokonywany na podstawie analizy charakterystyki macierzy oraz innych czynników specyficznych dla danego problemu.\n");

fclose(fid);
