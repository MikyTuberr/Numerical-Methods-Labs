function plot_PageRank(r)
    figure;
    bar(r')
    xlabel('Numer strony')
    ylabel('Wartość PageRank')
    title('Ranking stron')
    grid on
    print -dpng zadanie7.png 
end