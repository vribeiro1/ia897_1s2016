function optimum = mean_variance_optimization(E, r_mean, mi)
    [m, n] = size(E);
    H = 2 * E;
    f = zeros(n, 1);
    
    A_1 = -1 * r_mean';
    A_2 = -1 * eye(length(r_mean));
    A = [A_1; A_2];
    
    b_1 = -1 * mi;
    b_2 = zeros(length(r_mean), 1);
    b = [b_1; b_2];
    
    Aeq = ones(m, 1)';
    beq = 1;
    
    optimum = quadprog(H, f, A, b, Aeq, beq);
end