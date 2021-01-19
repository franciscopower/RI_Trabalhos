syms x

f = 1.5*sqrt(-abs(abs(x) - 1)*abs(3 - abs(x)) / ((abs(x) - 1)*(3 - abs(x))))*(1 + abs(abs(x) - 3) / (abs(x) - 3))*sqrt(1 - (x / 7)^2) + (4.5 + 0.75*(abs(x - 0.5) + abs(x + 0.5)) - 2.75*(abs(x - 0.75) + abs(x + 0.75)))*(1 + abs(1 - abs(x)) / (1 - abs(x)));
