function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie4(energy)
    % Głównym celem tej funkcji jest wyznaczenie danych na potrzeby analizy dokładności aproksymacji wielomianowej.
    % 
    % energy - struktura danych wczytana z pliku energy.mat
    % country - [String] nazwa kraju
    % source  - [String] źródło energii
    % x_coarse - wartości x danych aproksymowanych
    % x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej
    % y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
    % y_yearly - wektor danych rocznych
    % y_approximation - tablica komórkowa przechowująca wartości nmax funkcji aproksymujących dane roczne.
    %   - nmax = length(y_yearly)-1
    %   - y_approximation{1,i} stanowi aproksymację stopnia i
    %   - y_approximation{1,i} stanowi wartości funkcji aproksymującej w punktach x_fine
    % mse - wektor mający nmax wierszy: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia i.
    %   - mse liczony jest dla aproksymacji wyznaczonej dla wektora x_coarse
    % msek - wektor mający (nmax-1) wierszy: msek zawiera wartości błędów różnicowych zdefiniowanych w treści zadania 4
    %   - msek(i) porównuj aproksymacje wyznaczone dla i-tego oraz (i+1) stopnia wielomianu
    %   - msek liczony jest dla aproksymacji wyznaczonych dla wektora x_fine

    % Przykładowe wartości
    country = 'Poland';
    source = 'Coal';
    degrees = 1:4;

    % Sprawdzenie dostępności danych
    if isfield(energy, country) && isfield(energy.(country), source)
        % Przygotowanie danych do aproksymacji
        y_original = energy.(country).(source).EnergyProduction;

        % Obliczenie danych rocznych
        n_years = floor(length(y_original) / 12);
        y_cut = y_original(end-12*n_years+1:end);
        y4sum = reshape(y_cut, [12 n_years]);
        y_yearly = sum(y4sum, 1)';

        N = length(y_yearly);
        P = (N-1)*10 + 1;
        x_coarse = linspace(-1, 1, N)';
        x_fine = linspace(-1, 1, P)';

        y_approximation = cell(1, N-1);
        mse = zeros(N-1, 1);
        msek = zeros(N-2, 1);

        % Pętla po wielomianach różnych stopni
        for i = 1:N-1
            p = my_polyfit(x_coarse, y_yearly, i);
            y_approximation{i} = polyval(p, x_fine);
            y_coarse_approx = polyval(p, x_coarse);

            mse(i) = mean((y_yearly - y_coarse_approx).^2);

            if i < N-1
                next_p = my_polyfit(x_coarse, y_yearly, i+1);
                next_approx = polyval(next_p, x_fine);
                msek(i) = mean((y_approximation{i} - next_approx).^2);
            end
        end

        % Wykresy
        figure;

        % Wykres 1: Aproksymacje dla wybranych stopni
        subplot(3, 1, 1);
        plot(x_coarse, y_yearly, 'k', 'LineWidth', 2, 'DisplayName', 'Dane roczne');
        hold on;
        for i = 1:length(degrees)
            d = degrees(i);
            plot(x_fine, y_approximation{d}, 'LineWidth', 2, 'DisplayName', ['Stopień ' num2str(d)]);
        end
        title('Analiza dokładności aproksymacji wielomianowej');
        xlabel('Rok');
        ylabel('Produkcja energii');
        legend show;

        % Wykres 2: Błąd średniokwadratowy
        subplot(3, 1, 2);
        semilogy(1:N-1, mse, 'LineWidth', 2);
        title('Błąd średniokwadratowy (MSE) w funkcji stopnia wielomianu');
        xlabel('Stopień wielomianu');
        ylabel('MSE');

        % Wykres 3: Błąd różnicowy
        subplot(3, 1, 3);
        semilogy(1:N-2, msek, 'LineWidth', 2);
        title('Błąd różnicowy (msek) w funkcji stopnia wielomianu');
        xlabel('Stopień wielomianu');
        ylabel('Błąd różnicowy');

        % Zapis wykresów do pliku
        saveas(gcf, 'zadanie4.png');

    else
        disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
    end
end

function p = my_polyfit(x, y, degree)
    % Funkcja wyznacza współczynniki wielomianu aproksymującego metodą najmniejszych kwadratów
    % x - wektor danych wejściowych (wartości x)
    % y - wektor danych wyjściowych (wartości y)
    % degree - stopień wielomianu
    % p - współczynniki wielomianu aproksymującego
    
    % Utworzenie macierzy Vandermonde'a
    X = zeros(length(x), degree + 1);
    for i = 0:degree
        X(:, degree + 1 - i) = x.^i;
    end
    
    % Rozwiązanie równania normalnego (X' * X) * p = X' * y
    p = (X' * X) \ (X' * y);
end
