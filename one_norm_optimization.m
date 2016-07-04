function [x, fval] = one_norm_optimization(A, b)
    [m, n] = size(A);
    f = [ones(n, 1); zeros(n, 1)];
    
    Alinha = [-1 * eye(n), -1 * eye(n);
                   eye(n), -1 * eye(n)];
    blinha = zeros(2 * n, 1);
    Aeq = [A, zeros(m, n)];
    beq = b;
    
    [x, fval] = linprog(f, Alinha, blinha, Aeq, beq);
    x = x(1:n);
end

