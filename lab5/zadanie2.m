function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
% nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
% V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
% V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
% interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
%       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    N = 16;
    x_fine = linspace(-1, 1, 1000);

    nodes_Chebyshev = get_Chebyshev_nodes(N);
    x = linspace(-1,1,N);
    x_coarse = x;

    V = vandermonde_matrix(x_coarse);
    V2 = vandermonde_matrix(nodes_Chebyshev);
    
    original_Runge = 1 ./ (1 + 25*x_fine.^2);
    
    y_coarse = 1 ./ (1 + 25*x_coarse.^2);
    c_runge = V \ y_coarse';
    interpolated_Runge = polyval(flipud(c_runge), x_fine);

    y_coarse = 1 ./ (1 + 25*nodes_Chebyshev.^2);
    c_runge = V2 \ y_coarse';
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge), x_fine);

    figure;
    subplot(2,1,1);
    plot(x_fine, original_Runge,'LineWidth', 2);
    hold on;
    plot(x_fine, interpolated_Runge, 'LineWidth', 2);
    plot(x, 1 ./ (1 + 25 * x.^2), 'go', "MarkerSize", 5, 'MarkerFaceColor', 'g');
    hold off;
    xlabel('x');
    ylabel('f(x)');
    title('Interpolacja dla równomiernie rozmieszczonych węzłów');
    legend('Funkcja Runge', 'Interpolacja funkcji Runge', 'Węzły interpolacji');

    subplot(2,1,2);
    plot(x_fine, original_Runge, 'LineWidth', 2);
    hold on;
    plot(x_fine, interpolated_Runge_Chebyshev, 'LineWidth', 2);
    plot(nodes_Chebyshev, 1 ./ (1 + 25 * nodes_Chebyshev.^2), 'go', "MarkerSize", 5, 'MarkerFaceColor', 'g');
    hold off;
    xlabel('x');
    ylabel('f(x)');
    title('Interpolacja dla węzłów Chebysheva drugiego rodzaju');
    legend('Funkcja Runge', 'Interpolacja funkcji Runge', 'Węzły interpolacji');

    saveas(gcf, 'zadanie2.png');
end

function nodes = get_Chebyshev_nodes(N)
    % oblicza N węzłów Czebyszewa drugiego rodzaju
    for k=0:N-1
        nodes(k+1) = cos(k*pi/(N-1));
    end
end

function V = vandermonde_matrix(x_coarse)
    % Generuje macierz Vandermonde dla wektorów równomiernie rozmieszczonych węzłów interpolacji x_coarse
    n = length(x_coarse);
    V = zeros(n, n);
    for j = 1:n
        V(:, j) = x_coarse'.^(j-1);
    end
end
