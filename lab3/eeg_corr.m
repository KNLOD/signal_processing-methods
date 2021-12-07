clear all
close all

S=load('W3_01.txt')
N=length(S);
s1=S(1:N,1);
s2=S(1:N,2);
s3=S(1:N,3);

Amax(1)=max(s1); Amin(1)=min(s1);
Amax(2)=max(s2); Amin(2)=min(s2);
Amax(3)=max(s3); Amin(3)=min(s3);

Fs=250;
tmax=N/Fs;


%{
----Создание графического интерфейса----
%}
X0=100;     % Координата 'x' (на экране) нижнего левого угла окна
Y0=100;     % Координата 'y' (на экране) нижнего левого угла окна
W0=1650;     % Ширина окна
H0=900;     % Высота окна
figure('Position', [X0, Y0, W0, H0]);


x1=30;     % Координата 'x' (на экране) нижнего левого угла окна
dx=50;     % Расстояние по 'x' между 1-м и 2-м полями 
y1=30;     % Координата 'y' (на экране) нижнего левого угла окна
dy=50;     % Расстояние по 'y' между 1-м и 2-м полями 
w=300;    % Ширина 1-го и 2-го полей вывода графиков
h=250;    % Высота 1-го и 2-го полей вывода графиков 

%Создание 1-го поля
hAxes1=axes('Units', 'pixels', 'Position', [x1, y1, w, h]);
%Создание 2-го поля
hAxes2=axes('Units', 'pixels', 'Position', [x1+dx+w, y1, 2*w, h]);
%Создание 3-го поля
hAxes3=axes('Units', 'pixels', 'Position', [x1+2*dx+3*w, y1, 2*w, h]);
%Создание 4-го поля
hAxes4=axes('Units', 'pixels', 'Position', [x1, y1+dy+h, w, h]);
%Создание 5-го поля
hAxes5=axes('Units', 'pixels', 'Position', [x1+dx+w, y1+dy+h, 2*w, h]);
%Создание 6-го поля
hAxes6=axes('Units', 'pixels', 'Position', [x1+2*dx+3*w, y1+dy+h, 2*w, h]);
%Создание 7-го поля
hAxes7=axes('Units', 'pixels', 'Position', [x1, y1+2*dy+2*h, w, h]);
%Создание 8-го поля
hAxes8=axes('Units', 'pixels', 'Position', [x1+dx+w, y1+2*dy+2*h, 2*w, h]);
%Создание 9-го поля
hAxes9=axes('Units', 'pixels', 'Position', [x1+2*dx+3*w, y1+2*dy+2*h, 2*w, h]);





axes(hAxes7);        % Активизация 7-го поля окна для вывода графика     


T=1/Fs;              %Расчет интервала дискретизации
t=0:T:tmax-T;        %Расчет вектора значений аргумента
plot(t, s1);          %График с правильным масштабом по времени



set(hAxes7, 'YLim', [min(Amin)  max(Amax)], 'XLim', [0 tmax]); % Установка пределов +-Asum
hold on  

axes(hAxes4);
plot(t, s2);          %График с правильным масштабом по времени
set(hAxes4, 'YLim', [min(Amin)  max(Amax)], 'XLim', [0 tmax]); % Установка пределов +-Asum
hold on      

axes(hAxes1);

plot(t, s3);
set(hAxes1, 'YLim',  [min(Amin)  max(Amax)], 'XLim', [0 tmax]); % Установка пределов +-Asum
hold on  
           

tcf=-tmax+T:T:tmax-T;      % Вектор аргумента для АКФ и ВКФ

acf1=xcorr(s1, 'coeff');   % Расчет АКФ сигнала 's1'
axes(hAxes8);
set(hAxes8, 'YLim', [-1 +1], 'XLim', [-tmax+T tmax-T]);
hold on
plot(tcf, acf1);           % График АКФ сигнала 's1'

acf2=xcorr(s2, 'coeff');   % Расчет АКФ сигнала 's2'
axes(hAxes5);
set(hAxes5, 'YLim', [-1 +1], 'XLim', [-tmax+T tmax-T]);
hold on
plot(tcf, acf2);           % График АКФ сигнала 's2'

acf3=xcorr(s3, 'coeff');   % Расчет АКФ сигнала 's2'
axes(hAxes2);
set(hAxes2, 'YLim', [-1 +1], 'XLim', [-tmax+T tmax-T]);
hold on
plot(tcf, acf3);           % График АКФ сигнала 's2'




axes(hAxes9)
set(hAxes9, 'XLim', [-tmax+T tmax-T]);
hold on
ccf13=xcorr(s1,s3, 'coeff'); % ВКФ для сигналов 's1' и 's3'
plot(tcf, ccf13)


axes(hAxes6)
set(hAxes6, 'XLim', [-tmax+T tmax-T]);
hold on
ccf23=xcorr(s2,s3, 'coeff'); % ВКФ для сигналов 's2' и 's3'
plot(tcf, ccf23)

axes(hAxes3)
set(hAxes3, 'XLim', [-tmax+T tmax-T]);
hold on
ccf31=xcorr(s1,s2, 'coeff'); % ВКФ для сигналов 's1' и 's2'
plot(tcf, ccf31)


