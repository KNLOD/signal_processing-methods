global hAxes1 hAxes2 hAxes3 hEda %объявление глобальных имен

str=get(hEda,'String');
da=str2num(str);


x=load('W5_01.txt');

axes(hAxes1)
plot(x);

axes(hAxes2)
y=fs50(x,Fs,da);
plot(y);

