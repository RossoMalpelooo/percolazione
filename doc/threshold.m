clear
close all
clc

addpath('2024-10-28');

N = 1000;
% p = 0.025:0.025:0.5;
% p = [p 0.5125:0.0125:0.7 0.725:0.025:1];
% L = [20 40 60 80];
L=80;
p = 0.5125:0.0125:0.7;

probPercTB3 = zeros(length(L),length(p));
probPercLR3 = zeros(length(L),length(p));
probPercTBHK = zeros(length(L),length(p));
probPercLRHK = zeros(length(L),length(p));
erroreTB = zeros(length(L),length(p));
erroreLR = zeros(length(L),length(p));
MYsz = zeros(length(L),N,length(p));
MYmaxSz = zeros(length(L),N,length(p));
MYnumCLU = zeros(length(L),N,length(p));
MYnumCol = zeros(length(L),N,length(p));

for ij = 1:length(L)
    
    for ii = 1:length(p)
        pp = p(ii);
    
        s3TB = 0;
        s3LR = 0;

        espTB = zeros(N,1);
        espLR = zeros(N,1);

        for j = 1:N
            ret = rand(L(ij))<pp;
            %res3 = CercaCluster3(ret);
            resHK = CercaClusterHK(ret);
    
            %s3TB = s3TB + res3.percolazioneTB;
            %s3LR = s3LR + res3.percolazioneLR;
            espTB(j) = resHK.percolazioneTB;
            espLR(j) = resHK.percolazioneLR;

            MYsz(ij,j,ii) = mean(resHK.cluSz);
            MYmaxSz(ij,j,ii) = max(resHK.cluSz);
            MYnumCLU(ij,j,ii) = length(resHK.cluSz);
            MYnumCol(ij,j,ii) = sum(resHK.cluSz);
        end
   
        %probPercTB3(ij,ii) = s3TB / N;
        %probPercLR3(ij,ii) = s3LR / N;
        probPercTBHK(ij,ii) = mean(espTB);
        probPercLRHK(ij,ii) = mean(espLR);
        erroreTB(ij,ii) = std(espTB) / sqrt(N);
        erroreLR(ij,ii) = std(espLR) / sqrt(N);
    
    end
    % subplot(221)
    % hold on
    % plot(p, probPercTB3(ij,:),'.-')
    % title('Algoritmo $A$: Top-Down', 'Interpreter','latex','FontSize',20)
    % xlabel('$p_{col}$','Interpreter','latex','FontSize',18);
    % ylabel('$p_{perc}$','Interpreter','latex','FontSize',18);
    % subplot(222)
    % hold on
    % plot(p, probPercLR3(ij,:),'.-')
    % title('Algoritmo $A$: Left-Right','Interpreter','latex','FontSize',20)
    % xlabel('$p_{col}$','Interpreter','latex','FontSize',18);
    % ylabel('$p_{perc}$','Interpreter','latex','FontSize',18);
    % subplot(121)
    % axis([0.5 0.7 0.03 0.97])
    % cla;
    % hold on
    % grid on
    % errorbar(p, probPercTBHK(ij,:), erroreTB,'d','LineWidth',1,'MarkerSize',3)
    % title('Algoritmo HK: Top-Down','Interpreter','latex','FontSize',15)
    % xlabel('$p_{col}$','Interpreter','latex','FontSize',18);
    % ylabel('$p_{perc}$','Interpreter','latex','FontSize',18);
    % legend('TB');
    % subplot(122)
    % axis([0.5 0.7 0.03 0.97])
    % cla;
    % hold on
    % grid on
    % errorbar(p, probPercLRHK(ij,:), erroreLR,'d','LineWidth',1,'MarkerSize',3)
    % title('Algoritmo HK: Left-Right','Interpreter','latex','FontSize',15)
    % xlabel('$p_{col}$','Interpreter','latex','FontSize',18);
    % ylabel('$p_{perc}$','Interpreter','latex','FontSize',18);
    % legend('LR');

    subplot(221)
    hold on
    sMax=squeeze(MYmaxSz(ij,:,:));
    P1=sMax./L(ij)^2;
    media1=mean(P1);
    errore1=std(P1)./sqrt(length(P1));
    P1=media1;
    plot(p, errore1,'x', 'LineWidth',2,'MarkerSize',3,'Color','red');
    title('$P_1=\frac{s_{max}}{L^2}$', 'Interpreter','latex','FontSize',20)
    xlabel('$p$','Interpreter','latex','FontSize',18);
    ylabel('$P_1$','Interpreter','latex','FontSize',18);

    subplot(222)
    hold on
    P2=sMax./(p*L(ij)^2);
    media2=mean(P2);
    errore2=std(P2)./sqrt(length(P2));
    P2=media2;
    plot(p, errore2,'x', 'LineWidth',2,'MarkerSize',3,'Color','red')
    title('$P_2=\frac{s_{max}}{pL^2}$','Interpreter','latex','FontSize',20)
    xlabel('$p$','Interpreter','latex','FontSize',18);
    ylabel('$P_2$','Interpreter','latex','FontSize',18);

    subplot(223)
    hold on
    occupied=squeeze(MYnumCol(ij,:,:));
    P3=sMax./occupied;
    P3=squeeze(P3);
    media3=mean(P3);
    errore3=std(P3)./sqrt(size(P3,2));
    P3=media3;
    plot(p, errore3,'x', 'LineWidth',2,'MarkerSize',3,'Color','red')
    title('$P_3 = \frac{s_{max}}{\sum_s s \cdot n_s}$','Interpreter','latex','FontSize',20)
    xlabel('$p$','Interpreter','latex','FontSize',18);
    ylabel('$P_3$','Interpreter','latex','FontSize',18);

    subplot(224)
    hold on
    occupiedReduced=squeeze(MYnumCol(ij,:,:)-MYmaxSz(ij,:,:));
    racs=occupiedReduced./occupied;
    mediaRacs=mean(racs);
    erroreRacs=std(racs)/sqrt(length(racs));
    racs=mediaRacs; % 
    plot(p, erroreRacs,'x', 'LineWidth',2,'MarkerSize',3,'Color','red')
    title('$RACS = \frac{\sum_{s\neq s_{max}} s \cdot n_s}{\sum_t t \cdot n_t}$','Interpreter','latex','FontSize',20)
    xlabel('$p$','Interpreter','latex','FontSize',18);
    ylabel('$RACS$','Interpreter','latex','FontSize',18);

    for pl=[221 222 223 224]
        subplot(pl)
        grid on
        % axis([0 1 0 0.05]);
    end

    %Distribuzione del parametro p_perc (TLC)
    % hold on
    % grid on 
    % media = probPercTBHK(4,28);
    % dev = erroreTB(4,28);
    % g = pdf('Normal', 0.4:0.01:0.9, media, dev);
    % plot(0.4:0.01:0.9, g./sum(g), '.-', 'Color','blue', 'LineWidth', 2);
    % xline(media+3*dev, 'LineWidth', 2);
    % xline(media-3*dev, 'LineWidth', 2);
    % xline(media, '--','LineWidth', 2, 'Color','red');
    % legend('pdf','$\mu+3\sigma$','$\mu-3\sigma$','$\mu$','Interpreter', 'latex');
end

