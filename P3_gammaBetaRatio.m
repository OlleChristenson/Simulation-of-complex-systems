clc;clear;close;
%Side program - to find thresholds for values (part 3)
tic;
%Assumptions:
%1) Short outbreak-time so that the population is constant
%2) All parameters are changable except for the lattice space,
%which is fixed at a 100x100 grid size. 

%-----------Parameters-----------
N = 1000; %Number of individuals
initialInfectionRate = 0.01;
diffusionRate = 0.8; % d - "walking around"-probability
infectionProb = 0.9; % Beta - Infection probability
%removalProb = 0.01; % Gamma - Removal probability
%--------------------------------
dataPoints = 40;
nRuns = 15;
totalData = zeros(1, dataPoints);
K = linspace(1,170, dataPoints);
for multipleRuns = 1:nRuns
    disp(multipleRuns)
for i = 1:dataPoints
removalProb = infectionProb/K(i);
%Initialize the agent states/locations
clear agentLocations
infectedAgents = fix(N*initialInfectionRate);
agentLocations = initializeLocations(N, infectedAgents);

%(Show initial positions a few seconds)
%PlotSpace(agentLocations, 0)


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
    %PlotSpace(agentLocations, t)
    %Update amount of each category
    iAmount = size(agentLocations.I,1);
    sAmount = size(agentLocations.S,1);
    rAmount = size(agentLocations.R,1)-1;
    if sAmount == 0
        rAmount = 1000;
        break
    end
end
totalData(i) = totalData(i)+rAmount;
end
end
totalData = totalData./nRuns;
%Plot S, I and R as functions of time
figure(3)
plot(K, totalData/1000)
hold on
title("d = "+diffusionRate+", "+"β = "+infectionProb+", "+"γ = 0.0035 to 0.6"+", "+"N = "+N+", "+"I0 = "+initialInfectionRate*100+"%")
xlabel('K (= β/γ)')
ylabel('Final removed agents (%)')

toc;

figure(16)
surf(beta, beta./gamma, totalTotal'./10000)
title('3D phase diagram')
xlabel('beta')
ylabel('K (=beta/gamma)')
zlabel('% recovered')
