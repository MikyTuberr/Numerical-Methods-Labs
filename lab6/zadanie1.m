function [country, source, degrees, y_original, y_approximation, mse] = zadanie1(energy)
% Głównym celem tej funkcji jest wyznaczenie aproksymacji danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej dane wejściowe. y_approximation stanowi aproksymację stopnia degrees(i).
% mse - wektor o rozmiarze 4x1: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).

country = 'Poland';
source = 'Coal';
degrees = [1, 8, 15, 30];

% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    y_original = energy.(country).(source).EnergyProduction;
    dates = energy.(country).(source).Dates;

    x = linspace(-1,1,length(y_original))';
    
    y_approximation = cell(1, length(degrees));
    mse = zeros(1,length(degrees));

    % Pętla po wielomianach różnych stopni
    for i = 1:length(degrees)
        p = polyfit(x, y_original, degrees(i));
        y_approximation{i} = polyval(p, x);
        mse(i) = mean((y_approximation{i} - y_original).^2);
    end
    
    % Tworzenie wykresów
    figure;

    % Górny wykres - dane oryginalne i aproksymacje
    subplot(2, 1, 1);
    plot(dates, y_original, 'k','LineWidth', 2, 'DisplayName', 'Oryginalne dane'); hold on;
    colors = ['r', 'g', 'b', 'm'];
    for i = 1:length(degrees)
        plot(dates, y_approximation{i}, colors(i), 'LineWidth', 2, 'DisplayName', ['Stopień ' num2str(degrees(i))]);
    end
    hold off;
    xlabel('Czas');
    ylabel('Produkcja energii');
    title('Aproksymacja wielomianowa danych miesięcznych o silnej sezonowości');
    legend('show');

    % Dolny wykres - błędy średniokwadratowe
    subplot(2, 1, 2);
    bar(mse);
    set(gca, 'XTickLabel', degrees);
    xlabel('Stopień wielomianu');
    ylabel('Błąd średniokwadratowy');
    title('Błąd średniokwadratowy dla aproksymacji');

    % Zapis wykresu do pliku
    saveas(gcf, 'zadanie1.png');

else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end