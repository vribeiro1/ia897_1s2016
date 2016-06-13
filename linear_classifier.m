function [alpha, c] = linear_classifier(X, s)

    [m, n] = size(X);

    C_1 = ones(1, m);
    C_2 = zeros(1, n);
    C_3 = 0;
    C = [C_1 C_2 C_3];

    A_1 = -eye(m);
    A_2 = zeros(m, n);
    for i = 1:m
        A_2(i, :) = -s(i) .* X(i, :);
    end
    A_3 = s;
    A = [A_1 A_2 A_3];

    b = -ones(m, 1);

    optimum = linprog(C, A, b);
    c = optimum(m + 1 : m + n);
    alpha = optimum(m + n + 1);

end