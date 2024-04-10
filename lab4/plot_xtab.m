function plot_xtab(xtab_bisec, xtab_sec)
    subplot(2, 1, 1);
    plot(xtab_bisec, 'r');
    hold on;
    plot(xtab_sec, 'b');
    title('Przybliżenie rozwiązania w kolejnych iteracjach');
    xlabel('Iteracje');
    ylabel('Przybliżenie rozwiązania');
    legend('Metoda bisekcji', 'Metoda siecznych');
    hold off;
end