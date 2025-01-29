addpath('2024-10-28');

p = 0.025:0.025:0.5;
p = [p 0.5125:0.0125:0.7 0.725:0.025:1];

for i=1:5000
    for dim=[5 10 20 40 80]
        for j = 1:length(p)
            p_i=p(j);
            ret=rand(dim)<p_i;
            hk=CercaClusterHK(ret).cluSz;
            c3=CercaCluster3(ret).cluSz;
            if unique(c3)~=unique(hk)
                disp('errore');
                disp(p_i);
                disp(dim);
                %disp(c3)
                %disp(hk)
            end
        end
    end
end