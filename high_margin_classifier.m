function [alpha, c] = high_margin_classifier(X, s)
    [m, n] = size(X);
    
    H = [2 * eye(n) zeros(n, 1); zeros(1, n + 1)];
    f = zeros(n + 1, 1);
    A_1 = zeros(m, n);
    for i = 1:m
        A_1(i, :) = -s(i) .* X(i, :);
    end
    A_2 = s;
    A = [A_1 A_2];
    b = -ones(m, 1);
    
    optimum = quadprog(H, f, A, b);
    
    c = optimum(1 : n);
    alpha = optimum(n + 1);
end

