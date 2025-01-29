function res = CercaClusterHK(aux)
L=size(aux,1);
res.matrice=zeros(L+2);
% aux=rand(L)<p;
res.matrice(2:end-1,2:end-1)=aux;
res.percolazioneTB=0;
res.percolazioneLR=0;
%res.p=p;
res.label=zeros(L+2);
res.lofl=[];

countLabel=0;
valid=find(res.matrice);
%disp(res.matrice);
for iter=1:length(valid)
    ii=valid(iter);                          % indice sito
    leftLabel=res.label(ii-1);        
    upLabel=res.label(ii-L-2);  

    if(leftLabel+upLabel==0)                 % vicini non occupati
        countLabel=countLabel+1;
        currentLabel=countLabel;
        res.lofl(currentLabel)=-1;
    elseif(leftLabel*upLabel==0 || leftLabel-upLabel==0)
        currentLabel=max(leftLabel,upLabel);
        gLabel=findGoodLabel(currentLabel,res.lofl);
        res.lofl(gLabel)=res.lofl(gLabel)-1;
    else
        currentLabel=min(leftLabel,upLabel);       % due vicini occupati
        bLabel=max(leftLabel,upLabel);
        bLabel=findGoodLabel(bLabel,res.lofl);
        gLabel=findGoodLabel(currentLabel,res.lofl);
        if(bLabel~=gLabel)
            res.lofl(gLabel)=res.lofl(gLabel)+res.lofl(bLabel)-1;
            res.lofl(bLabel)=gLabel;
        else
            res.lofl(gLabel)=res.lofl(gLabel)-1;
        end
    end
    %disp(res.lofl); % debug
    res.label(ii)=currentLabel;
end
%disp(res.label)
res.cluSz=res.lofl(find(res.lofl<0))*-1;
end

function goodLabel=findGoodLabel(label,map)
    if(map(label)<0)
        goodLabel=label;
    else
        goodLabel=findGoodLabel(map(label),map);
    end
end