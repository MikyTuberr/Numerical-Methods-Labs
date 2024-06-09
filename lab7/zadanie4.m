function [integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4()
    % Numeryczne całkowanie metodą Monte Carlo.
    %
    %   integration_error - wektor wierszowy. Każdy element integration_error(1,i)
    %       zawiera błąd całkowania obliczony dla liczby losowań równej Nt(1,i).
    %       Zakładając, że obliczona wartość całki dla Nt(1,i) próbek wynosi
    %       integration_result, błąd jest definiowany jako:
    %       integration_error(1,i) = abs(integration_result - reference_value),
    %       gdzie reference_value to wartość referencyjna całki.
    %
    %   Nt - wektor wierszowy zawierający liczby losowań, dla których obliczano
    %       wektor błędów całkowania integration_error.
    %
    %   ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    %
    %   [xr, yr] - tablice komórkowe zawierające informacje o wylosowanych punktach.
    %       Tablice te mają rozmiar [1, length(Nt)]. W komórkach xr{1,i} oraz yr{1,i}
    %       zawarte są współrzędne x oraz y wszystkich punktów zastosowanych
    %       do obliczenia całki przy losowaniu Nt(1,i) punktów.
    %
    %   yrmax - maksymalna dopuszczalna wartość współrzędnej y losowanych punktów

    % Wartość referencyjna całki
    reference_value = 0.0473612919396179;

    % Definicja funkcji gęstości prawdopodobieństwa
    sigma = 3;
    mu = 10;
    f = @(t) (1/(sigma*sqrt(2*pi))) * exp(-((t - mu).^2)/(2*sigma^2));

    % Wyznaczenie wartości f(t) dla t=5
    ft_5 = f(5);

    % Definicja zakresu losowania punktów
    yrmax = ft_5 * 1.9; 
    
    % Inicjalizacja wektorów i tablic
    Nt = 5:50:10^4;
    integration_error = zeros(size(Nt));
    xr = cell(1, length(Nt));
    yr = cell(1, length(Nt));

    % Funkcja obliczająca całkę metodą Monte Carlo
    function [integral, xr, yr] = monte_carlo_integration(f, a, b, N)
        % Losowanie punktów
        xr = (b - a) * rand(1, N) + a;
        yr = yrmax * rand(1, N);

        % Obliczanie wartości funkcji w punktach
        fx = f(xr);

        % Liczenie punktów spełniających warunek
        points_under_curve = sum(yr <= fx);

        % Obliczanie całki
        integral = (points_under_curve / N) * ((b - a) * yrmax);
    end

    for i = 1:length(Nt)
        N = Nt(i);
        [integral_result, xr{1,i}, yr{1,i}] = monte_carlo_integration(f, 0, 5, N);
        integration_error(i) = abs(integral_result - reference_value);
    end
    % Wykres błędu całkowania
    figure;
    loglog(Nt, integration_error, 'LineWidth', 2);
    xlabel('Liczba losowań');
    ylabel('Błąd całkowania');
    title('Błąd całkowania metodą Monte Carlo');
    grid on;

    % Zapis wykresu do pliku
    saveas(gcf, 'zadanie4.png');
end