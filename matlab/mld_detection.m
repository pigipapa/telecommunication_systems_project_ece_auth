function nearestSymbol = mld_detection(recSym,symbols)
    nearestSymbol = complex(0, 0);
    minDistance = 100;
    for i = 1:length(symbols)
        distance = sqrt((real(symbols(i)) - real(recSym))^2 + (imag(symbols(i)) - imag(recSym))^2);
        if distance < minDistance
            minDistance = distance;
            nearestSymbol = symbols(i);
        end
    end
end

