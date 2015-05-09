X = 1:size(my_VAR_1(1,:),2);

figure

for i = 1 : 12
    subplot(12, 1, i)
    plot(X,my_VAR_1(i,:))
end


