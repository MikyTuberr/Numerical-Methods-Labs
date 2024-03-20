function plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)
% Opis wektorów stanowiących parametry wejściowe:
% N - rozmiary analizowanych macierzy
% time_Jacobi - czasy wyznaczenia rozwiązania metodą Jacobiego
% time_Gauss_Seidel - czasy wyznaczenia rozwiązania metodą Gaussa-Seidla
% iterations_Jacobi - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Jacobiego
% iterations_Gauss_Seide - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Gauss-Seidla

figure;

 % Pierwszy wykres
subplot(2, 1, 1);
plot(N, time_Jacobi, '-o', N, time_Gauss_Seidel, '-s', 'LineWidth', 2);
xlabel("rozmiar macierzy");
ylabel("czas [s]");
title("czas obliczeń vs rozmiar macierzy");
legend("Metoda Jacobiego", "Metoda Gaussa-Seidela", 'Location', 'eastoutside');
grid on;

% Drugi wykres
subplot(2, 1, 2);
bar_data = [iterations_Jacobi', iterations_Gauss_Seidel'];
bar(N, bar_data);
xlabel("rozmiar macierzy");
ylabel("liczba iteracji");
title("liczba iteracji vs rozmiar macierzy");
legend("Metoda Jacobiego", "Metoda Gaussa-Seidela", 'Location', 'eastoutside');
grid on;
print -dpng zadanie5.png 
end