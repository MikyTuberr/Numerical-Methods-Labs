function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
    % Rozmiar tablic komórkowych (cell arrays) V, interpolated_Runge, interpolated_sine: [1,4].
    % V{i} zawiera macierz Vandermonde wyznaczoną dla liczby węzłów interpolacji równej N(i)
    % original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
    % original_sine - wektor wierszowy zawierający wartości funkcji sinus dla wektora x_fine
    % interpolated_Runge{i} stanowi wierszowy wektor wartości funkcji interpolującej 
    %       wyznaczonej dla funkcji Runge (wielomian stopnia N(i)-1) w punktach x_fine
    % interpolated_sine{i} stanowi wierszowy wektor wartości funkcji interpolującej
    %       wyznaczonej dla funkcji sinus (wielomian stopnia N(i)-1) w punktach x_fine
    N = 4:4:16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = 1 ./ (1 + 25*x_fine.^2); % Wartości funkcji Runge
    original_sine = sin(2 * pi * x_fine); % Wartości funkcji sinus
    V = cell(1, length(N));

    subplot(2,1,1);
    plot(x_fine, original_Runge, 'LineWidth', 1.5);
    xlabel('x');
    ylabel('f(x)');
    hold on;
    interpolated_Runge = cell(1, length(N));
    for i = 1:length(N)
        x_coarse = linspace(-1, 1, N(i)); % Węzły interpolacji
        y_coarse = 1 ./ (1 + 25*x_coarse.^2); % Wartości funkcji Runge w węzłach
        V{i} = vandermonde_matrix(x_coarse); % Macierz Vandermonde
        c_runge = V{i} \ y_coarse'; % Współczynniki wielomianu interpolującego
        interpolated_Runge{i} = polyval(flipud(c_runge), x_fine); % Interpolacja
        plot(x_fine, interpolated_Runge{i});
    end
    hold off;
    legend('Original Runge', 'N = 4', 'N = 8', 'N = 12', 'N = 16');
    title('Interpolacja funkcji Rungego');

    subplot(2,1,2);
    plot(x_fine, original_sine, 'LineWidth', 1.5);
    xlabel('x');
    ylabel('f(x)');
    hold on;
    interpolated_sine = cell(1, length(N));
    for i = 1:length(N)
        x_coarse_sine = linspace(-1, 1, N(i)); % Węzły interpolacji
        y_coarse_sine = sin(2 * pi * x_coarse_sine); % Wartości funkcji sinus w węzłach
        V_sine = vandermonde_matrix(x_coarse_sine); % Macierz Vandermonde dla sinus
        c_sine = V_sine \ y_coarse_sine'; % Współczynniki wielomianu interpolującego
        interpolated_sine{i} = polyval(flipud(c_sine), x_fine); % Interpolacja
        plot(x_fine, interpolated_sine{i});
    end
    hold off;
    legend('Original Sinus', 'N = 4', 'N = 8', 'N = 12', 'N = 16');
    title('Interpolacja funkcji sin(2\pi x)');

    % Zapisz wykresy do pliku
    saveas(gcf, 'zadanie1.png');

end

function V = vandermonde_matrix(x_coarse)
    % Generuje macierz Vandermonde dla wektorów równomiernie rozmieszczonych węzłów interpolacji x_coarse
    n = length(x_coarse);
    V = zeros(n, n);
    for j = 1:n
        V(:, j) = x_coarse'.^(j-1);
    end
end
