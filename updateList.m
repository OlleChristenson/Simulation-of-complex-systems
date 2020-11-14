function [Slist, Ilist] = updateList(agentLocations)
    % Keep a matrix with how many agents are at each lattice
    Slist = zeros(100, 100);
    Ilist = zeros(100, 100);
    categories = fieldnames(agentLocations);
    
    for i = 1:2
        for j = 1:size(agentLocations.(categories{i}), 1) % Loop through S, I and R categories
                x = agentLocations.(categories{i})(j, 1);
                y = agentLocations.(categories{i})(j, 2);
                if i == 1
                    Slist(y, x) = Slist(y, x)+1;
                else
                    Ilist(y, x) = Ilist(y,x)+1;
                end

        end
    end
    
end

    