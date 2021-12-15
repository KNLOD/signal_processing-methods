clear all
close all
global hAxes1 hAxes2 hAxes3 hEda c%объявление глобальных имен

Fs=250;


X0=100;
Y0=100;
W0=500;
H0=600;
f=figure('Position', [X0,Y0,W0,H0]);

X1=30;
Y1=30;
Dy=20;
W1=400;
H1=200;

hAxes1=axes('Units','Pixels','Position',[X1,Y1,W1,H1]);
hAxes2=axes('Units','Pixels', 'Position',[X1,Y1+Dy+H1,W1,H1]);
hAxes3=axes('Units','Pixels', 'Position',[X1,Y1+2*Dy+2*H1,W1,H1]);


%Текстовый элемент с надписью "da=":
x1=450;
y1=300;

w1=50;
h1=50;


hTxta=uicontrol('Style', 'text', 'String', 'da=',...
      'Position',[x1,y1,w1,h1], 'Backgroundcolor', [1 1 1]);

%Поле редактирования для ввода значения шага адаптации "da":

x2=450;
y2=300;
w2=50;
h2=25;
hEda=uicontrol('Style', 'edit', 'Position', [x2, y2, w2, h2],...
     'Backgroundcolor', [1 1 1], 'HorizontalAlignment', 'left');
 x3=450;
 y3=150;
 w3=50;
 h3=50;
 %Кнопка с надписью 'Filter' для запуска процедуры фильтрации:
 hBtn=uicontrol('Style', 'pushbutton', 'String', 'Filter', ...
      'Position', [x3, y3, w3, h3], 'Callback', 'filtr_progr');

c=mytemps(f,x3,y1+100,50,20)
c.Value
function c=mytemps(f,x,y,w,h)

c = uicontrol(f,'Style','popupmenu');
c.Position = [x y w h];
c.String = {'ECG','Sin'};
c.Callback = @selection;

    function selection(src,event)
        val = c.Value;
        str = c.String;
        str{val};
        disp(['Selection: ' str{val}]);
    end

end

