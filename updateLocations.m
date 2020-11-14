function updatedLocations = updateLocations(agentLocations, diffusionRate)
    categories = fieldnames(agentLocations);
    
    for i = 1:numel(categories)
        
    for j = 1:size(agentLocations.(categories{i}), 1) % Loop through S, I and R categories
        r1 = rand;
        if r1 > diffusionRate
            continue % If standing still, continue
        else
            direction = randi(2); % Choose either x- or y-movement
            upDown = 0;
            while upDown == 0
                upDown = randi([-1 1]); % Choose either up- or down-movement
            end
            if direction == 1 % X-movement
                agentLocations.(categories{i})(j, 1) = agentLocations.(categories{i})(j, 1)+upDown;
            else % Y-movement
                agentLocations.(categories{i})(j, 2) = agentLocations.(categories{i})(j, 2)+upDown;
            end
        end
        for k = 1:2 % Limit locations (border-case)
            if agentLocations.(categories{i})(j, k) > 100
                agentLocations.(categories{i})(j, k) = 100;
            elseif agentLocations.(categories{i})(j, k) < 1
                agentLocations.(categories{i})(j, k) = 1;
            end
        end
            
    end
    end
    updatedLocations = agentLocations;
end