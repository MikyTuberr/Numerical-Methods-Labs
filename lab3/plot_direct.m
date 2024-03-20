function plot_direct(N, vtime_direct)
    % N - wektor zawierający rozmiary macierzy dla których zmierzono czas obliczeń metody bezpośredniej
    % vtime_direct - czas obliczeń metody bezpośredniej dla kolejnych wartości N
    
    hold on;
    plot(N, vtime_direct, 'o-', 'LineWidth', 2); 
    xlabel("rozmiar macierzy");
    ylabel("czas");
    title("czas obliczeń vs rozmiar macierzy");
    grid on;
    hold off;
    print -dpng zadanie2.png 
end