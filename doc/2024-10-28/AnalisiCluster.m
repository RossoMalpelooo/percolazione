clear
close all
clc

N = 5e3;
p = 0.025:0.025:0.5;
p = [p 0.5125:0.0125:0.7 0.725:0.025:1];


probPercTB = zeros(3,length(p));
probPercLR = zeros(3,length(p));
MYsz = zeros(3,N,length(p));
MYmaxSz = zeros(3,N,length(p));
MYnumCLU = zeros(3,N,length(p));

L = [20 40 60 80];

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

