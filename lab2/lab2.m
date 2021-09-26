clear all
close all

B1 = [1/8, 1/4, 1/4, 1/4, 1/8];%Вектор коэффициентов фильтра 1
M1 = length(B1);                %число коффииентов
B2 = [1/3, 1/6, 0, -1/6, -1/3]; %Вектор коэффициентов фильтра 2
M2 = length(B2);                %число коффииентов 

Fs = 250;                        %Частота дискретизации (Гц)
T = 1/Fs;                        %Интервал дискретизации(с)
f=0:Fs/2;                        %Диапазон изменения частоты для АЧХ
                                 %(от 0 Гц до Fs/2 Гц с шагом 1Гц)

                               


figure 
subplot(4,2,1)
stem(B1) 
title('Filter 1')

subplot(4,2,2)
stem(B1) 
title('Filter 2')

[Y1_imp, X1_imp] = impulse_response(20, M1,B1)

subplot(4, 2, 3) 
stem(X1_imp, '.')     %График входной последовательности
hold on
stem(Y1_imp, 'r')     %График выходной последовательности
  
[Y2_imp, X2_imp] = impulse_response(20, M2,B2)

subplot(4, 2, 4) 
stem(X2_imp, '.')     %График входной последовательности
hold on
stem(Y2_imp, 'r')     %График выходной последовательности

[Y1_step, X1_step] = step_response(20, M1,B1)

subplot(4, 2, 5) 
stem(X1_step, '.')     %График входной последовательности
hold on
stem(Y1_step, 'r')     %График выходной последовательности

[Y2_step, X2_step] = step_response(20, M2,B2)

subplot(4, 2, 6) 
stem(X2_step, '.')     %График входной последовательности
hold on
stem(Y2_step, 'r')     %График выходной последовательности


X_ECG = load('W2_01.txt');
N_1 = length(X_ECG)
Y_ECG_1 = response(X_ECG, N_1, M1, B1)

subplot(4, 2, 7) 
stem(X_ECG, '.')     %График входной последовательности
hold on
stem(Y_ECG_1, 'r')     %График выходной последовательности

Y_ECG_2 = response(X_ECG, N_1, M2, B2)
subplot(4, 2, 8) 
stem(X_ECG, '.')     %График входной последовательности
hold on
stem(Y_ECG_2, 'r')     %График выходной последовательности

function Y = response(X, N, M, B)
    Y = zeros(N, 1);
    for n=M:N                        %программный цикл в котором
        j = 0                         %создается выходной массив,
        for i = 1:M;          
            Y(n) = Y(n) + B(i)*X(n - j)
            j = j + 1
        end

    end
end
function [Y, X] = impulse_response(N, M, B)
                    %Число значений во входной последовательности
    for n=1:N;         %Программный цикл в котором создается входной
        X(n) = 0;      %массив, содержащий "N" нулевых значений
    end
    X(10) = 1;
    Y = zeros(1,N);
    for n=M:N                        %программный цикл в котором
        j = 0                         %создается выходной массив,
        for i = 1:M;          
            Y(n) = Y(n) + B(i)*X(n - j)
            j = j + 1

        end

    end
end
    
function [Y, X] = step_response(N, M, B)
                    %Число значений во входной последовательности
    for n=1:(N/2-1);         %Программный цикл в котором создается входной
        X(n) = 0;      %массив, содержащий "N/2 - 1" нулевых значений
    end
    for n=N/2:N;         %Программный цикл в котором создается входной
        X(n) = 1;      %массив, содержащий "N/2" равных 1 
    end
    X(10) = 1;
    Y = zeros(1,N);
    for n=M:N                        %программный цикл в котором
        j = 0                         %создается выходной массив,
        for i = 1:M;          
            Y(n) = Y(n) + B(i)*X(n - j)
            j = j + 1

        end

    end
end

