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
    ii=valid(iter);                                         % indice
    leftLabel=res.label(ii-1);        
    upLabel=res.label(ii-L-2);  

    if(leftLabel+upLabel==0)                                % new
        countLabel=countLabel+1;
        currentLabel=countLabel;
        res.lofl(currentLabel)=-1;
    elseif(leftLabel*upLabel==0 || leftLabel-upLabel==0)    % find
        currentLabel=max(leftLabel,upLabel);
        gLabel=findGL(currentLabel,res.lofl);
        res.lofl(gLabel)=res.lofl(gLabel)-1;
    else                                                    % union-find
        currentLabel=min(leftLabel,upLabel);                
        bLabel=max(leftLabel,upLabel);
        % bLabel=find(bLabel,res.lofl);
        % gLabel=find(currentLabel,res.lofl);
        % if(bLabel~=gLabel)
        %     res.lofl(gLabel)=res.lofl(gLabel)+res.lofl(bLabel)-1;
        %     res.lofl(bLabel)=gLabel;
        % else
        %     res.lofl(gLabel)=res.lofl(gLabel)-1;
        % end
        res.lofl=union(bLabel,currentLabel,res.lofl);
    end
    %disp(res.lofl); % debug
    res.label(ii)=currentLabel;
end
%disp(res.label)
res.cluSz=res.lofl(find(res.lofl<0))*-1;
end

function goodLabel=findGL(x,Lofl)
    if(Lofl(x)<0)
        goodLabel=x;
    else
        goodLabel=findGL(Lofl(x),Lofl);
    end
end

function Lofl=union(x,y,Lofl)
    xRoot=findGL(x,Lofl);
    yRoot=findGL(y,Lofl);
    if(yRoot==xRoot)
        Lofl(yRoot)=Lofl(yRoot)-1;
    else
        Lofl(yRoot)=Lofl(yRoot)+Lofl(xRoot)-1;
        Lofl(xRoot)=yRoot;
    end
end
