function [integration_error, Nt, ft_5, integral_1000] = zadanie1()
    % Numeryczne całkowanie metodą prostokątów.
    % Nt - wektor zawierający liczby podprzedziałów całkowania
    % integration_error - integration_error(1,i) zawiera błąd całkowania wyznaczony
    %   dla liczby podprzedziałów równej Nt(i). Zakładając, że obliczona wartość całki
    %   dla Nt(i) liczby podprzedziałów całkowania wyniosła integration_result,
    %   to integration_error(1,i) = abs(integration_result - reference_value),
    %   gdzie reference_value jest wartością referencyjną całki.
    % ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    % integral_1000 - całka od 0 do 5 funkcji gęstości prawdopodobieństwa
    %   dla 1000 podprzedziałów całkowania

    % Wartość referencyjna całki
    reference_value = 0.0473612919396179;

    % Definiowanie wektora liczby podprzedziałów całkowania
    Nt = 5:50:10^4;
    
    % Wektor do przechowywania błędów całkowania
    integration_error = zeros(size(Nt));

    % Definiowanie funkcji gęstości prawdopodobieństwa
    sigma = 3;
    mu = 10;
    f = @(t) (1/(sigma*sqrt(2*pi))) * exp(-((t - mu)^2)/(2*sigma^2));

    % Wyznaczenie wartości f(t) dla t=5
    ft_5 = f(5);

    % Całkowanie metodą prostokątów środkowych
    function integral = rectangle_integration(f, a, b, k)
        delta = (b - a) / k;
        integral = 0;
        for i = 1:k
            x = a + (i - 1) * delta;
            next_x = a + i * delta;
            integral = integral + f((x + next_x) / 2) * delta;
        end
    end

    % Wyznaczenie wartości całki dla N=1000
    integral_1000 = rectangle_integration(f, 0, 5, 1000);
    
    % Pętla po różnych liczbach podprzedziałów całkowania
    for z = 1:length(Nt)
        N = Nt(z);
        integration_result = rectangle_integration(f, 0, 5, N);
        integration_error(z) = abs(integration_result - reference_value);
    end
    
    % Wykres błędu całkowania
    figure;
    loglog(Nt, integration_error, 'LineWidth', 2);
    xlabel('Liczba podprzedziałów całkowania');
    ylabel('Błąd całkowania');
    title('Błąd całkowania metodą prostokątów środkowych');
    grid on;
    
    % Zapis wykresu do pliku
    saveas(gcf, 'zadanie1.png');
end
