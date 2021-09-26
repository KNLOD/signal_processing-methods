clear all
close all

F=13;
A=2;
tmax=0.5;
Fs1=200;
Fs2=45;
F2=Fs2+F;
T1=1/Fs1;
t1=0:T1:tmax;
T2=1/Fs2


subplot(3,1,1);
t2=0:T2:tmax;
Y1=A*cos(2*pi*(F)*t1);
plot(t1,Y1)

hold on
Y2=A*cos(2*pi*(F)*t2)
plot(t2,Y2,'r')
title('F')
hold off

subplot(3,1,2);
t2=0:T2:tmax;
Y1=A*cos(2*pi*(Fs2+F)*t1);
plot(t1,Y1)

hold on
Y2=A*cos(2*pi*(Fs2+F)*t2)
plot(t2,Y2,'r')
title('Fs2+F')
hold off


subplot(3,1,3);
t2=0:T2:tmax;
Y1=A*cos(2*pi*(Fs2-F)*t1);
plot(t1,Y1)


hold on
Y2=A*cos(2*pi*(Fs2-F)*t2)
plot(t2,Y2,'r')
title('Fs2-F')
hold off

figure
Y=load('Сигналы_1-6\R-01\W1_01.txt');
LY=length(Y);
Fs=1200;
T=1/Fs;
tmax=LY*T;
t=0:T:tmax-T;

for i=1:LY
    Y0(i)=Y((i-1)+1);
end

subplot(3,1,1);
plot(t,Y0)
set(gca, 'YLim', [-1000 500])
title('Исходные данные')



K1=3;
Fs_1=Fs/K1;
T_1=1/Fs_1
t_1=0:T_1:tmax-T_1;
LY1=LY/K1;
for i=1:LY1
    Y1(i)=Y((i-1)*K1+1);
end
subplot(3,1,2);
plot(t_1,Y1)
set(gca, 'YLim', [-1000 500])
title('k=3')

tmax=LY*T;
K2=10;
Fs_2=Fs/K2;
T_2= 1/Fs_2;
t_2=0:T_2:tmax-T_2;
LY2=LY/K2;
for i=1:LY2
    Y2(i)=Y((i-1)*K2+1);
end
subplot(3,1,3);
plot(t_2,Y2, 'r')
set(gca, 'YLim', [-1000 500])

title('k=10')


