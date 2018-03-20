SPT = Strategy.SPT;
GA = Strategy.GA;
LBGA = Strategy.LBGA;
ALBGA = Strategy.ALBGA;

g = 1:Const.MAX_GENERATION;

res = [g', SPT, GA, LBGA, ALBGA];

table = array2table(res, 'VariableNames', {...
    'Generation',...
    'SPT',...
    'GA_BF', 'GA_AF',...
    'LBGA_BF', 'LBGA_AF',...
    'ALBGA_BF', 'ALBGA_AF'
});
writetable(table, 'result.xlsx', 'WriteRowNames', true);

figure;
plot(res(:, 1), res(:, 2), ...
    res(:, 1), res(:, 3), '--',...
    res(:, 1), res(:, 4), ...
    res(:, 1), res(:, 5), '--',...
    res(:, 1), res(:, 6), ...
    res(:, 1), res(:, 7), '--',...
    res(:, 1), res(:, 8)  ...
);
title('GA (Genetic Algorithm)');
xlabel('Generation');
ylabel('Fitness');
legend('SPT', 'GA(best)', 'GA(average)', 'LBGA(best)', 'LBGA(average)', 'ALBGA(best)', 'ALBGA(average)');
saveas(gcf, 'result.png');