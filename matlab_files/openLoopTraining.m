function open_loop_performances = openLoopTraining(genetic_results)

disp('one-step-ahead Forecasting...');

% Loading data needed for the fitness function
load('usage.mat');
load('complete_data.mat');

% Preparing inputs and outputs data
input_data_indeces = [ matrix1( 1:178, best_indeces(1) ), matrix1( 1:178, best_indeces(2) ), matrix1( 1:178, best_indeces(3) ) ];
ise_data_index = ISE1(1:178);


inputSeries = tonndata(input_data_indeces,false,false);
targetSeries = tonndata(ise_data_index,false,false);
neurons = [ best_indeces(4) best_indeces(5) best_indeces(6) ];

% Create a Nonlinear Autoregressive Network with External Input
inputDelays = 1:genetic_results(1);
feedbackDelays = 1:genetic_results(2);
hiddenLayerSize = max(neurons);
net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize);

% Prepare the Data for Training and Simulation
% The function PREPARETS prepares timeseries data for a particular network,
% shifting time by the minimum amount to fill input states and layer states.
% Using PREPARETS allows you to keep your original time series data unchanged, while
% easily customizing it for networks with differing numbers of delays, with
% open loop or closed loop feedback modes.
[inputs,inputStates,layerStates,targets] = preparets(net,inputSeries,{},targetSeries);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Value needed to compute mean value
performance = 0;

for t=1:10

    % Train the Network
    [net,tr] = train(net,inputs,targets,inputStates,layerStates);

    % Test the Network
    outputs = net(inputs,inputStates,layerStates);
    % errors = gsubtract(targets,outputs);
    performance = performance + perform(net,targets,outputs);
    
end

performance = performance/10;

% Using cell2mat function we convert the contents of a cell array into a 
% single matrix
perc_outputs = cell2mat(outputs);
perc_targets = cell2mat(targets);

%Saving results
open_loop_performances = calculate_performances(perc_outputs, perc_targets, performance);

% Save the net in "network.mat"
save('network.mat','net');

% View the Network
view(net)

disp('one-step-ahead Forecasting done.');
end

