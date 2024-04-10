function plot_xdif(xdif_bisec, xdif_sec) 
    subplot(2, 1, 2);
    semilogy(xdif_bisec, 'r');
    hold on;
    semilogy(xdif_sec, 'b');
    title('Róznice pomiędzy przybliżeniami rozwiązania w kolejnych iteracjach');
    xlabel('Iteracje');
    ylabel('Różnica');
    legend('Metoda bisekcji', 'Metoda siecznych');
    hold off;
end