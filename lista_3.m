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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Geração de dados para os exercícios 2, 7, 8 e 10
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all

m = 100;                                                                % número de exemplos de teste
S = [-1 1];                                                             % labels {-1, 1}
X_2 = [10 * rand(m / 2, 2); -10 * rand(m / 2, 2)];                      % vetor x para n = 2
X_3 = [10 * rand(m / 2, 3); -10 * rand(m / 2, 3)];                      % vetor x para n = 3
s_perf = [ones(m / 2, 1); -ones(m / 2, 1)];                             % vetor de labels {-1, 1} (perfeita)
s_unperf = [ones(m / 2 + 0.05 * m, 1); -ones(m / 2 - 0.05 * m, 1)];     % vetor de labels {-1, 1} (unperfeita)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Exercício 2 - Classificação Linear
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% Classificação perfeita %%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n = 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[alpha, c] = linear_classifier(X_2, s_perf);

figure(1)
hold on
grid on
axis equal

for i = 1:m
	if s_perf(i) == 1
        plot(X_2(i, 1), X_2(i, 2), 'ko');
	else
        plot(X_2(i, 1), X_2(i, 2), 'k+');
	end
end

plot([0 c(1) / max(c)],[0 c(2) / max(c)]);
t = -15:0.01:15;
y = -c(1)/c(2) * t + alpha/c(2);
plot(t, y, 'r');

saveas(figure(1), 'images/exercise_2_n_2_perfect.fig');
saveas(figure(1), 'images/exercise_2_n_2_perfect.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n = 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[alpha, c] = linear_classifier(X_3, s_perf);

figure(2)
hold on
grid on
axis equal

for i = 1:m
    if s_perf(i) == 1
        plot(X_3(i, 1), X_3(i, 2), 'ko');
    else
        plot(X_3(i, 1), X_3(i, 2), 'k+');
    end
end

plot3([0 c(1) / max(c)],[0 c(2) / max(c)], [0 c(3)/max(c)]);
t = -15:0.01:15;
[x_plot, y_plot] = meshgrid(t);
mesh(x_plot, y_plot, (alpha - x_plot * c(1) - y_plot * c(2)) / c(3));
view(40,15)

saveas(figure(2), 'images/exercise_2_n_3_perfect.fig');
saveas(figure(2), 'images/exercise_2_n_3_perfect.png');

%%%%%%%%%%%%%%%%%%%%%%%% Classificação imperfeita %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n = 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[alpha, c] = linear_classifier(X_2, s_unperf);

figure(3)
hold on
grid on
axis equal

for i = 1:m
	if s_unperf(i) == 1
        plot(X_2(i, 1), X_2(i, 2), 'ko');
	else
        plot(X_2(i, 1), X_2(i, 2), 'k+');
	end
end

plot([0 c(1) / max(c)],[0 c(2) / max(c)]);
t = -15:0.01:15;
y = -c(1)/c(2) * t + alpha/c(2);
plot(t, y, 'r');

saveas(figure(3), 'images/exercise_2_n_2_unperfect.fig');
saveas(figure(3), 'images/exercise_2_n_2_unperfect.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n = 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[alpha, c] = linear_classifier(X_3, s_unperf);

figure(4)
hold on
grid on
axis equal

for i = 1:m
    if s_unperf(i) == 1
        plot(X_3(i, 1), X_3(i, 2), 'ko');
    else
        plot(X_3(i, 1), X_3(i, 2), 'k+');
    end
end

plot3([0 c(1) / max(c)],[0 c(2) / max(c)], [0 c(3)/max(c)]);
t = -15:0.01:15;
[x_plot, y_plot] = meshgrid(t);
mesh(x_plot, y_plot, (alpha - x_plot * c(1) - y_plot * c(2)) / c(3));
view(40,15)

saveas(figure(4), 'images/exercise_2_n_3_unperfect.fig');
saveas(figure(4), 'images/exercise_2_n_3_unperfect.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Exercício 4 - Geração do gráfico - p*(theta) x theta
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

theta = 0:0.01:10;
p_theta = zeros(1, 1001);

for i = 1:length(theta)
    if theta(i) <= 2/3
        p_theta(i) = inf;
    elseif theta(i) <= 3
        p_theta(i) = 0;
    else
        p_theta(i) = (5/2) * (theta(i) - 3);
    end
end

figure(5)
hold on
grid on
axis equal

plot(theta, p_theta, 'r');

xlabel('theta');
ylabel('p*(theta)');

saveas(figure(5), 'images/exercise_4_p_theta_vs_theta.fig');
saveas(figure(5), 'images/exercise_4_p_theta_vs_theta.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Exercício 7 - Classificação de Margem Máxima
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n = 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[alpha, c] = high_margin_classifier(X_2, s_perf);

figure(6)
hold on
grid on
axis equal

for i = 1:m
    if s_unperf(i) == 1
        plot(X_2(i, 1), X_2(i, 2), 'ko');
    else
        plot(X_2(i, 1), X_2(i, 2), 'k+');
    end
end

plot([0 c(1) / max(c)],[0 c(2) / max(c)]);
t = -15:0.01:15;
y = -c(1)/c(2) * t + alpha/c(2);
plot(t, y, 'r');

saveas(figure(6), 'images/exercise_7_n_2_perfect.fig');
saveas(figure(6), 'images/exercise_7_n_2_perfect.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n = 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[alpha, c] = high_margin_classifier(X_3, s_perf);

figure(7)
hold on
grid on
axis equal

for i = 1:m
    if s_unperf(i) == 1
        plot(X_3(i, 1), X_3(i, 2), 'ko');
    else
        plot(X_3(i, 1), X_3(i, 2), 'k+');
    end
end

plot3([0 c(1) / max(c)],[0 c(2) / max(c)], [0 c(3)/max(c)]);
t = -15:0.01:15;
[x_plot, y_plot] = meshgrid(t);
mesh(x_plot, y_plot, (alpha - x_plot * c(1) - y_plot * c(2)) / c(3));
view(40,15)

saveas(figure(7), 'images/exercise_7_n_3_perfect.fig');
saveas(figure(7), 'images/exercise_7_n_3_perfect.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Exercício 8 - Classificação de Margem Ajustável
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n = 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lambda = 0:0.1:5;
class_error = zeros(1, length(lambda));

figure(8)
hold on
grid on
axis equal

for j = 1:length(lambda)
    [alpha, c, error] = adjustable_margin_classifier(X_2, s_unperf, lambda(j));
    class_error(j) = error;

    for i = 1:m
        if s_unperf(i) == 1
            plot(X_2(i, 1), X_2(i, 2), 'ko');
        else
            plot(X_2(i, 1), X_2(i, 2), 'k+');
        end
    end

    plot([0 c(1) / max(c)],[0 c(2) / max(c)]);
    t = -15:0.01:15;
    y = -c(1)/c(2) * t + alpha/c(2);
    plot(t, y, 'r');
end

saveas(figure(8), 'images/exercise_8_n_2_unperfect.fig');
saveas(figure(8), 'images/exercise_8_n_2_unperfect.png');

figure(9)
hold on
grid on
axis equal

plot(lambda, class_error)
xlabel('Margem de separação (lambda)');
ylabel('Erro de classificação');

saveas(figure(9), 'images/exercise_8_n_2_error_vs_lambda.fig');
saveas(figure(9), 'images/exercise_8_n_2_error_vs_lambda.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n = 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class_error = zeros(1, length(lambda));

figure(10)
hold on
grid on
axis equal

for j = 1:length(lambda)
    [alpha, c, error] = adjustable_margin_classifier(X_3, s_unperf, lambda(j));
    class_error(j) = error;

    for i = 1:m
        if s_unperf(i) == 1
            plot(X_3(i, 1), X_3(i, 2), 'ko');
        else
            plot(X_3(i, 1), X_3(i, 2), 'k+');
        end
    end

    plot3([0 c(1) / max(c)],[0 c(2) / max(c)], [0 c(3)/max(c)]);
    t = -15:0.01:15;
    [x_plot, y_plot] = meshgrid(t);
    mesh(x_plot, y_plot, (alpha - x_plot * c(1) - y_plot * c(2)) / c(3));
    view(40,15)
end

saveas(figure(10), 'images/exercise_8_n_3_unperfect.fig');
saveas(figure(10), 'images/exercise_8_n_3_unperfect.png');

figure(11)
hold on
grid on
axis equal

plot(lambda, class_error)
xlabel('Margem de separação (lambda)');
ylabel('Erro de classificação');

saveas(figure(11), 'images/exercise_8_n_3_error_vs_lambda.fig');
saveas(figure(11), 'images/exercise_8_n_3_error_vs_lambda.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Exercício 10 - Otimização Geométrica Numérica
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [];
b =[];
Aeq = [];
beq = [];
lb = [];
ub = [];
x_0 = [0.1 0.1 0.1];
options = optimoptions('fmincon','Display','iter');

f_1 = @(y) ...
      40 * exp(-y(1) - 0.5 * y(2) - y(3)) + ...
      20 * exp(y(1) + y(3)) + ...
      20 * exp(y(1) + y(2) + y(3));
non_lin_con = @non_linear_constraints;

         
[y_a, fval1] = fmincon(f_1, x_0, A, b, Aeq, beq, lb, ub, non_lin_con, options);
x_a = exp(y_a);

f_2 = @(y) ...
      log(40 * exp(-y(1) - 0.5 * y(2) - y(3)) + ...
          20 * exp(y(1) + y(3)) + ...
          20 * exp(y(1) + y(2) + y(3)));
non_lin_con = @non_linear_constraints_log;
lb = [0.1 0.1 0.1];
         
[y_b, fval2] = fmincon(f_2, x_0, A, b, Aeq, beq, lb, ub, non_lin_con, options);
x_b = exp(y_b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

