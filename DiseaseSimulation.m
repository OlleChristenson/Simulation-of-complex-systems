clc;clear;close;
%Main program

%Assumptions:
%1) Short outbreak-time so that the population is constant
%2) All parameters are changable except for the lattice space,
%which is fixed at a 100x100 grid size. 

%-----------Parameters-----------
N = 1000; %Number of individuals
initialInfectionRate = 0.01;
diffusionRate = 0.7; % d - "walking around"-probability
infectionProb = 0.6; % Beta - Infection probability
removalProb = 0.01; % Gamma - Removal probability
%--------------------------------

%Initialize the agent states/locations
infectedAgents = fix(N*initialInfectionRate);
agentLocations = initializeLocations(N, infectedAgents);

%(Show initial positions a )
PlotSpace(agentLocations, 0)

t = 0;
while size(agentLocations.I, 1) > 0
    t = t+1;
    %Update locations with respect to diffusion
    agentLocations = updateLocations(agentLocations, diffusionRate);
    %Keep track of how many agents are at each space
    [Slist, Ilist] = updateList(agentLocations);
    %Check agents that are at the same space
    agentLocations = UpdateInfection(Slist, Ilist, agentLocations, infectionProb, removalProb);
    %Update plot
    PlotSpace(agentLocations, t)
    %Update amount of each category
    iAmount(t) = size(agentLocations.I,1);
    sAmount(t) = size(agentLocations.S,1);
    rAmount(t) = size(agentLocations.R,1)-1;

end
agentLocations.R(1,:) = [];
%Plot S, I and R as functions of time
figure(2)
plot(1:t, iAmount, '-r')
hold on
plot(1:t, sAmount, '-b')
plot(1:t, rAmount, '-g')
legend('I', 'S', 'R')
title("d = "+diffusionRate+", "+"β = "+infectionProb+", "+"γ = "+removalProb+", "+"N = "+N+", "+"I0 = "+initialInfectionRate*100+"%")
xlabel('Time Steps')
ylabel('Number of agents')

