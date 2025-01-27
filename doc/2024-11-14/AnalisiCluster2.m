clear
close all
clc

N = 5e3;
p = 0.025:0.025:0.5;
p = [p 0.5125:0.0125:0.7 0.725:0.025:1];

L = [20 40 60 80];

probPercTB = zeros(length(L),length(p));
probPercLR = zeros(length(L),length(p));
MYsz = zeros(length(L),N,length(p));
MYmaxSz = zeros(length(L),N,length(p));
MYnumCLU = zeros(length(L),N,length(p));
MYvcTB = zeros(length(L),N,length(p));
MYVCLR = zeros(length(L),N,length(p));

for ij = 1:length(L)
    
    for ii = 1:length(p)
        pp = p(ii);
    
        sTB = 0;
        sLR = 0;
        for j = 1:N
            res = CercaCluster2(L(ij), pp);
    
            sTB = sTB + res.percolazioneTB;
            sLR = sLR + res.percolazioneLR;
            MYsz(ij,j,ii) = mean(res.cluSz);
            MYmaxSz(ij,j,ii) = max(res.cluSz);
            MYnumCLU(ij,j,ii) = length(res.cluSz);
            MYvcTB(ij,j,ii) = res.percolazioneTB;
            MYvcLR(ij,j,ii) = res.percolazioneLR;
        end
   
        probPercTB(ij,ii) = sTB / N;
        probPercLR(ij,ii) = sLR / N;
    
    end
    subplot(211)
    hold on
    plot(p, probPercTB(ij,:),'.-')
    subplot(212)
    hold on
    plot(p, probPercLR(ij,:),'.-')

end

