clear all
close all

x=load('Signal_15_2.txt');
b=load('filter_parameters.fcf');

figure
plot(x)
hold on

y=filter_ecg(x, 250, b)
plot(y)