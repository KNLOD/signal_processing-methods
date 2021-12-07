clear all
close all

ECG=load('W4_01.txt');

Fs=250;
tmax=4;
T=1/Fs;
t=0:T:tmax-T;
Norma=ECG(:,1);
VTach=ECG(:,2);
VFibr=ECG(:,3);

subplot(3,1,1)
plot(t,Norma)
subplot(3,1,2)
plot(t, VTach)
subplot(3,1,3)
plot(t,VFibr)

%{
----Создание графического интерфейса----
%}
X0=100;     % Координата 'x' (на экране) нижнего левого угла окна
Y0=100;     % Координата 'y' (на экране) нижнего левого угла окна
W0=1350;     % Ширина окна
H0=900;     % Высота окна
figure('Position', [X0, Y0, W0, H0]);


x1=30;     % Координата 'x' (на экране) нижнего левого угла окна
dx=50;     % Расстояние по 'x' между 1-м и 2-м полями 
y1=30;     % Координата 'y' (на экране) нижнего левого угла окна
dy=50;     % Расстояние по 'y' между 1-м и 2-м полями 
w=300;    % Ширина 1-го и 2-го полей вывода графиков
h=250;    % Высота 1-го и 2-го полей вывода графиков 

%Создание 1-го поля
hAxes1=axes('Units', 'pixels', 'Position', [x1, y1, 2*w, h]);
%Создание 2-го поля
hAxes2=axes('Units', 'pixels', 'Position', [x1+dx+2*w, y1, w, h]);
%Создание 3-го поля
hAxes3=axes('Units', 'pixels', 'Position', [x1+2*dx+3*w, y1, w, h]);
%Создание 4-го поля
hAxes4=axes('Units', 'pixels', 'Position', [x1, y1+dy+h, 2*w, h]);
%Создание 5-го поля
hAxes5=axes('Units', 'pixels', 'Position', [x1+dx+2*w, y1+dy+h, w, h]);
%Создание 6-го поля
hAxes6=axes('Units', 'pixels', 'Position', [x1+2*dx+3*w, y1+dy+h, w, h]);
%Создание 7-го поля
hAxes7=axes('Units', 'pixels', 'Position', [x1, y1+2*dy+2*h, 2*w, h]);
%Создание 8-го поля
hAxes8=axes('Units', 'pixels', 'Position', [x1+dx+2*w, y1+2*dy+2*h, w, h]);
%Создание 9-го поля
hAxes9=axes('Units', 'pixels', 'Position', [x1+2*dx+3*w, y1+2*dy+2*h, w, h]);


spectral_analysis(Norma, t, tmax, Fs, hAxes7, hAxes8, hAxes9)
spectral_analysis(VTach, t, tmax, Fs, hAxes4, hAxes5, hAxes6)
spectral_analysis(VFibr, t, tmax, Fs, hAxes1, hAxes2, hAxes3)






function as=magnitude_spektrum(ft,tmax,Fs);
%{
----Расчет амплитудного спектра----
%}

N=tmax*Fs;
for j=1:N
    if (j==1)
        as(j)=(sqrt(real(ft(j)))^2+imag(ft(j))^2)/N;
    else
        as(j)=(sqrt(real(ft(j)))^2+imag(ft(j))^2)/N*2;
    end
end
end

function f=plot_magnitude(Fs,N,as,hAxes)
%{
----Построение амплитудного спектра----
%}

df=Fs/N;    % шаг по оси частот
for j=1:(N/2)
    f(j)=df*(j-1);   % Расчет аргумента для построения графика
end
axes(hAxes)
stem(f,as(1:N/2), '.') %График амплитудного спектра
set(hAxes, 'XLim', [0 20])
hold on
end

function psd=spectral_density(f,ft,Fs,N,hAxes)
%{
----Расчет СПМ----
%}
for j=1:N      % Цикл для перебора всех элементов разложения
    if (j==1)
        psd(j)=1/N*(real(ft(j)))^2+imag(ft(j))^2/Fs;
    else
        psd(j)=2/N*(real(ft(j))^2+imag(ft(j))^2)/Fs;
    end;
end;
axes(hAxes)
plot(f,psd(1:(N/2))) % График СПМ
set(hAxes, 'XLim', [0 20])
hold on
end
function sw=window_function(s0, t, tmax, N, Fs, ft_0, hAxes1, hAxes2, hAxes3)

    w=hamming(N); % Создание массива значений оконной функции 'w'
    for j=1:N
        sw(j)=s0(j)*w(j);
    end

    axes(hAxes1)
    plot(t, sw)
    hold on
    ft_w=fft(sw)
    as_mean_w=magnitude_spektrum(ft_w,tmax,Fs);
    f_w=plot_magnitude(Fs,N,as_mean_w,hAxes2);
    psd=spectral_density(f_w,ft_0,Fs,N,hAxes3);


end
function [ft,N,as,psd,s0,ft_0]=spectral_analysis(Signal, t, tmax, Fs, hAxes1, hAxes2, hAxes3);
    axes(hAxes1);
    plot(t, Signal);
    grid on
    hold on
    ft=fft(Signal)  %Расчет БПФ для сигнала 's3'
    N=tmax*Fs;
    as=magnitude_spektrum(ft,tmax,Fs);
    f=plot_magnitude(Fs,N,as,hAxes2);
    psd=spectral_density(f,ft,Fs,N,hAxes3);
    m=mean(Signal); % Вычисление среднего для сигнала "s3"
    s0=Signal-m;    % Удаление из сигнала среднего значения
    axes(hAxes1)
    plot(t, s0)
    grid on
    ft_0=fft(s0)
    as_mean_0=magnitude_spektrum(ft_0,tmax,Fs);
    f_0=plot_magnitude(Fs,N,as_mean_0,hAxes2);
    psd=spectral_density(f_0,ft_0,Fs,N,hAxes3);
    sw=window_function(s0, t, tmax, N, Fs, ft_0, hAxes1, hAxes2, hAxes3)

end
