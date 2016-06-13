function [c, ceq] = non_linear_constraints(y)
    c = (1/3) * exp(-2 * y(1) - 2 * y(2)) + ...
        (4/3) * exp(0.5 * y(2) - y(3)) - 1;
    ceq = [];
end