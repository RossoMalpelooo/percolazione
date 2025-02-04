clc;
close all;
clear;

addpath('2024-10-28');

p = 0.025:0.025:0.5;
p = [p 0.5125:0.0125:0.7 0.725:0.025:1];
D=[5 10 20 40 80];
N=100;
time3=zeros(length(p),length(D));
timeHK=zeros(length(p),length(D));

for j=1:length(p)
    p_j=p(j);
    for dim=1:length(D)
        tic
        for i=1:N
            ret=rand(D(dim))<p_j;
            resHK=CercaClusterHK(ret);
        end
        timeHK(j,dim)=toc/N;
    
        tic
        for i=1:N
            ret=rand(D(dim))<p_j;
            res3=CercaCluster3(ret);
        end
        time3(j,dim)=toc/N;
    end
end

subplot(221);
semilogy(time3,'.-');
title('A');
grid on
subplot(222);
semilogy(timeHK,'.-');
title('HK');
grid on;

subplot(2,2,[3 4]);
plot(mean(timeHK,2),'.-');
hold on;
plot(mean(time3,2),'.-');
legend('HK', 'A')
grid on;
