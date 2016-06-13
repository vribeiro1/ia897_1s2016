function [alpha, c, error] = adjustable_margin_classifier(X, s, lambda)
    [m, n] = size(X);
    
    H = [2 * lambda * eye(n) zeros(n, m + 1); zeros(m + 1, n + m + 1)];
    f = [zeros(n, 1); (1/m) * ones(m, 1); 0];
    A_1 = zeros(m, n);
    for i = 1:m
        A_1(i, :) = -s(i) .* X(i, :);
    end
    A_2 = -eye(m);
    A_3 = s;
    A = [A_1 A_2 A_3];
    b = -ones(m, 1);
    Aeq = zeros(1, n + m + 1);
    beq = 0;
    lb = [-inf * ones(1, n) zeros(1, m) 0];
    ub = [];
    
    optimum = quadprog(H, f, A, b, Aeq, beq, lb, ub);
    
    c = optimum(1 : n);
    alpha = optimum(m + n + 1);
    error = sum(optimum(n + 1 : n + m));
end