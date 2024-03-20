function plot_residuals_iterations(residuals, iterations, plot_title)
    figure;
    plot(1:iterations, residuals, '-o', 'LineWidth', 2);
    xlabel('Liczba iteracji');
    ylabel('Błąd rezydualny');
    title(plot_title);
    grid on;
end