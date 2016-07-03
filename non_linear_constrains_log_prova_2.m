function [c, ceq] = non_linear_constrains_log_prova_2(y)
    CDA0 = 0.0306;
    SwetS = 2.05;
    k = 1.2;
    e = 0.96;
    W0 = 4940;
    Nult = 2.5;
    tal = 0.12;
    ks = 45.42;
    kl = 8.71 * 10^-5;
    
    c = [log(CDA0 * exp(y(3) - y(2)) + (k * SwetS) * exp(y(4) - y(2)) + (1 / (e * pi)) * exp(2 * y(6) - y(2) - y(8)));
         log(ks * exp(y(3) - y(9)) + (kl * Nult * sqrt(W0) / tal) * exp((3/2) * y(8) + (1/2) * y(7) + (1/2) * y(3) - y(9)));
         log(W0 * exp(-y(7)) + exp(y(9) - y(7)))];
    ceq = [];
end

