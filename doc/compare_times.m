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
ylim([0 10^-2])
title('A');
grid on
subplot(222);
semilogy(timeHK,'.-');
ylim([0 10^-2])
title('HK');
grid on;

subplot(2,2,3);
numPoints = numel(p);                % Number of points
newX = 1:numPoints;                  % Evenly spaced indices
barWidth = 0.4;                      % Adjust bar width
bar(newX - barWidth/2, mean(timeHK,2), barWidth, 'b'); % Shift left (HK)
hold on;
bar(newX + barWidth/2, mean(time3,2), barWidth, 'r');  % Shift right (A)
hold off;
xticks(newX);                         % Keep tick marks consistent
xticklabels(string(p));               % Use original p values as labels
xlabel('Data Points');
ylabel('Mean Time');
legend('HK', 'A', 'Location', 'northwest');
grid on;
title('Comparison of HK and A');

subplot(2,2,4);
numPoints = numel(D);                % Number of points
newX = 1:numPoints;                  % Evenly spaced indices
barWidth = 0.4;                      % Adjust bar width
bar(newX - barWidth/2, mean(timeHK), barWidth, 'b'); % Shift left (HK)
hold on;
bar(newX + barWidth/2, mean(time3), barWidth, 'r');  % Shift right (A)
hold off;
xticks(newX);                         % Keep tick marks consistent
xticklabels(string(D));               % Use original p values as labels
xlabel('Data Points');
ylabel('Mean Time');
legend('HK', 'A', 'Location', 'northwest');
grid on;
title('Comparison of HK and A');
