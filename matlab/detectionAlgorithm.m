function nearestSymbol = detectionAlgorithm(recSym, symbols)
    nearestSymbol = complex(0,0);
    minDistance = 20;
    x1 = real(recSym) - 2; %min x
    x2 = real(recSym) + 2; %max x
    y1 = imag(recSym) - 2; %min y
    y2 = imag(recSym) + 2; %max y
    candSym = [];
    A=[];
    
    %create Sx array. All possible real values Xi of the constellation
    Sx = real(symbols(1));
    for i = 2:length(symbols)
        count = 0;
        for k = 1:length(Sx)
            if real(symbols(i)) == Sx(k)
                count = count + 1;
            end
        end
        if count == 0
                    Sx(length(Sx) + 1) = real(symbols(i));
        end
    end    
    
    Sx = sort(Sx);
    
    %create xi matrix. The values of x between x1 and x2
    count = 0;
    x = [];
    for i = 1:length(Sx)
        if Sx(i) >= x1 && Sx(i) <= x2
            count = count + 1;
            x(count) = Sx(i);
        end
    end
    
    if ~isempty(x)
        %find candidate symbols
        %use every xi separately and create its own A array    
        counter = 0;
        for i = 1:length(x)
            %create an temporary sorted array sym
            count = 0;
            for j = 1:length(symbols)
                if real(symbols(j)) == x(i)
                    count = count + 1;
                    sym(count) = symbols(j);
                end
            end

            %sort sym array based on imaginary values
            for k = 1:length(sym)-1
                for p = k+1:length(sym)
                    if imag(sym(p)) < imag(sym(k))
                        temp = sym(p);
                        sym(p) = sym(k);
                        sym(k) = temp;
                    end
                end
            end
            
            %create A array
            A = [complex(real(sym),-imag(sym)) ; imag(sym)]';
            [numRows,numCols] = size(A);
            
            %find the candidate symbols
            if ~isempty(A)
                for j = 1:numRows
                    if A(j,2) > y1 && A(j,2) < y2
                        counter = counter + 1;
                        candSym(counter) = A(j,1); 
                    end
                end
            end
            
        end
    end
    
    %checks if there symbols close enough for algorithm's 'min distance'
    %and finds the quadrant of the received symbol 
    if isempty(candSym)
        if real(recSym) >= 0 && imag(recSym) >= 0
            i = 1;
        elseif real(recSym) < 0 && imag(recSym) > 0
            i = 2;
        elseif real(recSym) <= 0 && imag(recSym) <= 0
            i = 3;
        elseif real(recSym) > 0 && imag(recSym) < 0
            i = 4;
        end
        
        %creates Qi matrix
        Qi = qmat(symbols, i);
        
        %find the nearest symbol between the received symbol and the
        %outer symbols of the constalletions
        for i = 1:length(Qi)
            distance = sqrt((real(Qi(i)) - real(recSym))^2 + (imag(Qi(i)) - imag(recSym))^2);
            if distance < minDistance
                minDistance = distance;
                nearestSymbol = Qi(i);
            end
        end
        
        
    else
        %find the nearest symbol when the symbol is inner
        for i = 1:length(candSym)
            distance = sqrt((real(candSym(i)) - real(recSym))^2 + (imag(candSym(i)) - imag(recSym))^2);
            if distance < minDistance
                minDistance = distance;
                nearestSymbol = candSym(i);
            end
        end
    end
end