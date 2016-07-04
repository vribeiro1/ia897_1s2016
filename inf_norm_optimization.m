function [x, fval] = inf_norm_optimization(A, b)
    [m, n] = size(A);
    f = [zeros(n, 1); 1];
    
    Alinha = [A, -1 * ones(m, 1);
         -1 * A, -1 * ones(m, 1)];
    blinha = [b; -1 * b];
    Aeq = [];
    beq = [];
    
    [x, fval] = linprog(f, Alinha, blinha, Aeq, beq);
    x = x(1:n);
end

