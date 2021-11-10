clear all
close all
global hAxes1 hAxes2 hAxes3 hEda %объявление глобальных имен

X0=100;
Y0=100;
W0=300;
H0=200;
figure('Position', [X0,Y0,W0,H0]);

X1=10;
Y1=10;
Dy=20;
W1=100;
H1=50;

hAxes1=axes('Units','Pixels','Position',[X1,Y1,W1,H1]);
hAxes2=axes('Units','Pixels', 'Position',[X1,Y1+Dy+H1,W1,H1]);
hAxes3=axes('Units','Pixels', 'Position',[X1,Y1+2*Dy+2*H1,W1,H1]);


%Текстовый элемент с надписью "da=":
x1=100;
y1=30;
w1=50;
h1=50;


hTxta=uicontrol('Style', 'text', 'String', 'da=',...
      'Position',[x1,y1,w1,h1], 'Backgroundcolor', [1 1 1]);

%Поле редактирования для ввода значения шага адаптации "da":

x2=100;
y2=100;
w2=50;
h2=50;
hEda=uicontrol('Style', 'edit', 'Position', [x2, y2, w2, h2],...
     'Backgroundcolor', [1 1 1], 'HorizontalAlignment', 'left');
 x3=100;
 y3=200;
 w3=50;
 h3=50;
 %Кнопка с надписью 'Filter' для запуска процедуры фильтрации:
 hBtn=uicontrol('Style', 'pushbutton', 'String', 'Filter', ...
      'Position', [x3, y3, w3, h3], 'Callback', 'filt_progr');
 
  
