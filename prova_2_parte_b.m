%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Universidade Estadual de Campinas
% Faculdade de Engenharia Elétrica e de Computação
%
% IA879 - Introdução à Otimização Matemática
% Prof. Paulo Valente
%
% Vinicius de Paulo Souza Ribeiro RA: 118906
% 
% Disponível em https://github.com/vribeiro1/ia897_1s2016
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
warning('off', 'all');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Exercício 1 - Regressão pelas normas 1 e infinito
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A = rand(1000, 100);
% b = rand(100, 1);
% 
% r_1 = A * x_1 - b;
% r_inf = A * x_inf - b;
% 
% figure(1);
% hold on
% grid on
% axis equal
% 
% hist(r_1);
% 
% saveas(figure(1), 'images/exercise_1_histogram_norm_1.fig');
% saveas(figure(1), 'images/exercise_1_histogram_norm_1.png');
% 
% figure(2);
% hold on
% grid on
% axis equal
% 
% hist(r_inf);
% 
% saveas(figure(2), 'images/exercise_1_histogram_norm_inf.fig');
% saveas(figure(2), 'images/exercise_1_histogram_norm_inf.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Exercício 2 - Otimização Média-Variância
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start = 3.54 * 10^-4;
stop = 7.37 * 10^-4;
step = (stop - start) / 19;

r_mean = [5.996; 4.584; 6.202; 7.374; 3.397; 1.667; 3.789] * 10^-4;

E = [0.5177 0.5960 0.2712 0.5516 0.9104 -0.3859 0.2032;
     0.5960 1.2200 0.3602 0.7661 1.0950 -0.4363 0.2469;
     0.2712 0.3602 0.3602 0.2866 0.4754 -0.1721 0.1048;
     0.5516 0.7661 0.2866 0.8499 1.0730 -0.4363 0.2303;
     0.9104 1.0950 0.4754 1.0730 2.5630 -0.8142 0.4063;
    -0.3859 -0.4363 -0.1721 -0.4363 -0.8142 0.7479 -0.1681;
     0.2032 0.2469 0.1048 0.2303 0.4063 -0.1681 0.1478] * 10^-4;
 
mi = start:step:stop;

invest = zeros(length(mi), length(r_mean));
mean_var = zeros(length(mi), 2);

for i = 1:length(mi)
    x = mean_variance_optimization(E, r_mean, mi(i));
    mean_var(i, :) = [r_mean' * x, x' * E * x];
    invest(i, :) = x';
end

figure(1)
hold on
grid on

plot(mean_var(:, 1)', mean_var(:, 2)', 'r', 'LineWidth', 2);
title('Prova 2B - Exercício 2 - Fronteira Eficiente');
xlabel('Rendimento total médio');
ylabel('Variância total');

saveas(figure(1), 'images/prova_2_parte_b_exercise_2.fig');
saveas(figure(1), 'images/prova_2_parte_b_exercise_2.png');

display([mi' (invest * 100)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Exercício 3 - Projeto Estrutural por Otimização Geométrica
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CDA0 = 0.0306;
ro = 1.23;
mi = 1.78 * 10^-5;
SwetS = 2.05;
k = 1.2;
e = 0.96;
W0 = 4940;
Nult = 2.5;
tal = 0.12;
Vmin = 22;
Clmax = 2;
ks = 45.42;
kl = 8.71 * 10^-5;

options = optimoptions('fmincon','Display','iter');

f = @(y) ...
    log((ro/2) * exp(2 * y(1) + y(2) + y(3)));

A = [0 0 -1 0 0 0 1 0 0];
b = log((ro * Vmin^2 * Clmax) / 2);

Aeq = [0 0 0 1 2 0 0 0 0;
       -2 0 -1 0 0 -1 1 0 0;
       1 0 (1/2) 0 -1 0 0 (-1/2) 0];
beq = [log(0.074);
       log(ro / 2);
       log(mi / ro)];
   
lb = [];
ub = [];
x_0 = [0 0 0 0 0 0 0 0 0];

non_lin_con = @non_linear_constrains_log_prova_2;

[y, fval2] = fmincon(f, x_0, A, b, Aeq, beq, lb, ub, non_lin_con, options);
x = exp(y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%