clear all
close all

y=load('W4_01.txt');

Fs=100;
A1=1.5;
F1=5.0;
A2=0.8;
F2=13.0;
C=0.2;
tmax=1.0;


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



%{
----Расчет тестового сигнала----
%}
T=1/Fs;     %Расчет интервала дискретизации
t=0:T:tmax; %Вектор значений по оси абсцисс


s1=A1*sin(2*pi*F1*t);
s2=A2*sin(2*pi*F2*t);
s3=s1+s2+C;

axes(hAxes7);
plot(t, s3);
grid on

ft_3=fft(s3)  %Расчет БПФ для сигнала 's3'


N=tmax*Fs;
as_3=magnitude_spektrum(ft_3,tmax,Fs);
f3=plot_magnitude(Fs,N,as_3,hAxes8);

psd3=spectral_density(f3,ft_3,Fs,N,hAxes9);


m=mean(s3); % Вычисление среднего для сигнала "s3"
s0=s3-m;    % Удаление из сигнала среднего значения

axes(hAxes4)
plot(t, s0)
grid on
ft_0=fft(s0)
as_mean_0=magnitude_spektrum(ft_0,tmax,Fs);
f_0=plot_magnitude(Fs,N,as_mean_0,hAxes5);
psd=spectral_density(f_0,ft_0,Fs,N,hAxes6);


w=hamming(N+1); % Создание массива значений оконной функции 'w'
for j=1:N+1
    sw(j)=s0(j)*w(j);
end

axes(hAxes1)
plot(t, sw)
hold on
plot(t, s3)
grid on
ft_w=fft(sw)
as_mean_w=magnitude_spektrum(ft_w,tmax,Fs);
f_w=plot_magnitude(Fs,N,as_mean_w,hAxes2);
psd=spectral_density(f_w,ft_0,Fs,N,hAxes3);


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
end
