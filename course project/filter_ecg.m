function y = filter_ecg(x,Fs, b)
%FILTER_ECG Summary of this function goes here
%   Detailed explanation goes here
T=1/Fs
N=length(x)
B=length(b)
y=zeros(N,1)

for i=1:N;
    for j=1:B;
        if i>j
            y(i)=y(i)+b(j)*x(i-j);
        end
    end
end

end

