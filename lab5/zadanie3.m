function [matrix_condition_numbers, max_coefficients_difference_1, max_coefficients_difference_2] = zadanie3()
% Zwracane są trzy wektory wierszowe:
% matrix_condition_numbers - współczynniki uwarunkowania badanych macierzy Vandermonde
% max_coefficients_difference_1 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
%       gdy b zawiera wartości funkcji liniowej
% max_coefficients_difference_2 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
%       gdy b zawiera zaburzone wartości funkcji liniowej

N = 5:40;

%% chart 1
matrix_condition_numbers = zeros(1, length(N));


%% chart 2
a1 = randi([20,30]);
for i = 1:length(N)
    ni = N(i);
    V = vandermonde_matrix(linspace(-1,1,ni));
    matrix_condition_numbers(1, i) = cond(V);
    
    % Niech wektor b zawiera wartości funkcji liniowej
    b = linspace(0,a1,ni)';
    reference_coefficients = [ 0; a1; zeros(ni-2,1) ]; % tylko a1 jest niezerowy
    
    % Wyznacznie współczynników wielomianu interpolującego
    calculated_coefficients = V \ b;

    max_coefficients_difference_1(i) = max(abs(calculated_coefficients-reference_coefficients));
end

figure;
subplot(3,1,1);
semilogy(N,matrix_condition_numbers,'LineWidth', 2);
title('Wspłczynnik uwarunkowania w zależności od rozmiaru macierzy');
xlabel('Rozmiar macierzy');
ylabel('Współczynnik');

subplot(3,1,2);
semilogy(N, max_coefficients_difference_1);
title('Błąd wyznaczenia wartości współczynników dla funkcji liniowej');
xlabel('Rozmiar macierzy');
ylabel('Różnica')

%% chart 3
for i = 1:length(N)
    ni = N(i);
    V = vandermonde_matrix(linspace(-1,1,ni));
    
    % Niech wektor b zawiera wartości funkcji liniowej nieznacznie zaburzone
    b = linspace(0,a1,ni)' + rand(ni,1)*1e-10;
    reference_coefficients = [ 0; a1; zeros(ni-2,1) ]; % tylko a1 jest niezerowy
    
    % Wyznacznie współczynników wielomianu interpolującego
    calculated_coefficients = V \ b;
    
    max_coefficients_difference_2(i) = max(abs(calculated_coefficients-reference_coefficients));
end

subplot(3,1,3);
semilogy(N, max_coefficients_difference_2);
title('Błąd wyznaczenia wartości współczynników dla zaburzonych wartości');
xlabel('Rozmiar macierzy');
ylabel('Różnica')

saveas(gcf, 'zadanie3.png');
end


function V = vandermonde_matrix(x_coarse)
    % Generuje macierz Vandermonde dla wektorów równomiernie rozmieszczonych węzłów interpolacji x_coarse
    n = length(x_coarse);
    V = zeros(n, n);
    for j = 1:n
        V(:, j) = x_coarse'.^(j-1);
    end
end