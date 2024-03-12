function plot_counts_mean(counts_mean)
    figure;
    plot(counts_mean);
    title('Counts Mean Plot');
    xlabel('Index');
    ylabel('Mean');
    grid on;
    print -dpng zadanie5.png 
end