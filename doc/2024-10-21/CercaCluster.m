function res = CercaCluster(L, p)

res.matrice = rand(L) < p;

res.label = zeros(L);

labelC = 1;

for ii = 1 : (L * L)
    if (res.matrice(ii) && ~res.label(ii))
        % nuovo cluster, esploro i vicini

        pila = ii;
        j = 1;
        while (j <= length(pila))
            elemento = pila(j);
            res.label(elemento) = labelC;
            
            %aggiungo i vicini alla pila
            if (elemento )

            j = j + 1;
        end
        
        labelC = labelC + 1;
    end

end

end