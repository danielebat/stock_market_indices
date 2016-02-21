function performance = FitnessFunction( result_delays )

% Loading data needed for the fitness function
load('complete_data.mat');
load('usage.mat');

% Preparing inputs and outputs data
input_data_indeces = [ matrix1( 1:268, best_indeces(1) ), matrix1( 1:268, best_indeces(2) ), matrix1( 1:268, best_indeces(3) ) ];
ise_data_index = ISE1(1:268);


% tonndata - convert data to standard neural network cell array form
% matrix will be transposed
% time will now be represented as columns of a cell array
inputSeries = tonndata(input_data_indeces,false,false);
targetSeries = tonndata(ise_data_index,false,false);

% vector that is made by the # of hidden layers of three best indexes
neurons = [best_indeces(4) best_indeces(5) best_indeces(6)];

% Create a Nonlinear Autoregressive Network with External Input
inputDelays = 1 : result_delays(1);
feedbackDelays = 1 : result_delays(2);
hiddenLayerSize = max(neurons);

net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize);

% Prepare the Data for Training and Simulation
[inputs,inputStates,layerStates,targets] = preparets(net,inputSeries,{},targetSeries);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Value needed to compute mean value
perf = 0;

% Loop used for statistical convergence
for i=1:10
    
    % Train the Network
    [net,tr] = train(net,inputs,targets,inputStates,layerStates);
    
    % Test the Network
    outputs = net(inputs,inputStates,layerStates);
    % errors = gsubtract(targets,outputs);
    perf = perf + perform(net,targets,outputs);
    
end

% Computing the mean value
performance = perf/10;

end