clear all
close all
global hAxes1 hAxes2 hAxes3 hEda %объявление глобальных имен

%Текстовый элемент с надписью "da=":

hTxta=uicontrol('Style', 'text', 'String', 'da=',...
      'Position',[x1,y1,w1,h1], 'Backgroundcolor', [1 1 1]);

%Поле редактирования для ввода значения шага адаптации "da":

hEda=uicontrol('Style', 'edit', 'Position', [x2, y2, w2, h2],...
     'Backgroundcolor', [1 1 1], 'HorizantalAlignment', 'left');
 
 %Кнопка с надписью 'Filter' для запуска процедуры фильтрации:
 hBtn=uicontrol('Style', 'pushbutton', 'String', 'Filter', ...
      'Positoin', [x3, y3, w3, h3], 'Callback', 'filt_progr');
 
  