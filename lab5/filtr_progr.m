global hAxes1 hAxes2 hAxes3 hEda c %объявление глобальных имен

str=get(hEda,'String');
da=str2num(str);

if c.Value==1
    x=load('W5_01.txt');
    Fs=250
    t=[0:1/Fs:0.996]
    axes(hAxes3)
    plot(t,x);

    axes(hAxes2)
    y=fs50(x,Fs,da);
    plot(t,y);
    for i=1:length(x)
        m(i)=y(i)-x(i)
    end
    axes(hAxes1)
    plot(t,m);
end
if c.Value==2
    Fs=500
    t=[0:1/Fs:0.5]
    x1=sin(2*pi*50*t)
    axes(hAxes3)
    plot(t,x1);

    axes(hAxes2)
    y=fs50(x1,Fs,da);
    plot(t,y);
    
    axes(hAxes1)
    plot(t,y-x1)
end