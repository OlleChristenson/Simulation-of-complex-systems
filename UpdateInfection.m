function checkInfection = UpdateInfection(Slist, Ilist,agentLocations, infectionProb, removalProb)
% If an I and an S-agent land on the same lattice square, there's a 
%probability that S will be infected. Furthermore, I has a probability to
%be "removed" (R).

for rows = 1:100
    for columns = 1:100
        if Slist(rows, columns) > 0 && Ilist(rows, columns) > 0 % Find locations where I and S both exist
            infectedAtSpace = Ilist(rows, columns); % Count how many infected there are at that space
            location = find(all(agentLocations.S == [columns rows], 2)); % Check what indices the S-group on that space has
            for i=length(location) % All S have a risk of getting infected
                for j = 1:infectedAtSpace % From each of the infected agents
                    rTmp1 = rand;
                    if rTmp1 < infectionProb
                        % If they're infected, they're moved to the I
                        % category
                        place = agentLocations.S(location(i),:);
                        agentLocations.I(end+1, :) = place;
                        agentLocations.S(location(i),:) = [];
                        break;
                    end                
                end
            end
        end
    end
end

%Each infected agent has a probability to be moved to the R category
k = 0;
criteria = size(agentLocations.I, 1);
while k < criteria
    k = k+1;
    rTmp2 = rand;
    if rTmp2 < removalProb
        agentLocations.R(end+1,:) = agentLocations.I(k,:);
        agentLocations.I(k,:) = [];
        criteria = criteria-1;
    end
end


checkInfection = agentLocations;
        
        
        

end