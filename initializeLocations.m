function initialLocations = initializeLocations(N, infectedAgents)
    % Initialize N random agents on the lattice space
    % Where N-I are the amount of S
    initialLocations = struct;
    for i = 1:(N-infectedAgents)
        for j = 1:2
            initialLocations.S(i, j) = randi(100);
        end
    end
    for k = 1:infectedAgents
        for l = 1:2
            initialLocations.I(k,l) = randi(100);
        end
    end
    
    %No removed agents at initialization
    initialLocations.R = [NaN NaN];
end