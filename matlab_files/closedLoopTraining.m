function closed_loop_performances = closedLoopTraining( genetic_results )

disp('n-step-ahead Forecasting...');

% Loading data needed for the fitness function
load('usage.mat');
load('network.mat');
load('complete_data.mat');

neurons = [ best_indeces(4) best_indeces(5) best_indeces(6) ];
% Initialization of vector that will be used for computing the length of
% the window
delays = [ genetic_results(1) genetic_results(2) ];


disp('We are going to predict ISE100 value with steps from 1 to 9.');
    
% Preparing inputs and outputs data
input_data_indeces = [ matrix1( 269:536, best_indeces(1) ), matrix1( 269:536, best_indeces(2) ), matrix1( 269:536, best_indeces(3) ) ];
ise_data_index = ISE1(269:536);

for e=1:9
    
    steps = e;
    fprintf('Step:');
    disp(e);

    % Definition of number of evaluations for each step => # of windows
    % +1 for considering the correct number of windows
    evaluations = 268 - max(delays) - steps + 1;

    %inputDelays = 1:max(delays);
    %feedbackDelays = 1:max(delays);
    %hiddenLayerSize = max(neurons);

    performance = 0;
    ending_outputs = zeros(1,steps);
    ending_targets = zeros(1,steps);

    % Loop for computation on each window
    for i=1:evaluations
        
        % Creation of data and target index
        % Computation on these windows will return a vector containing the
        % forecasted values
        window_input_data_indeces = input_data_indeces(i:i+steps+max(delays) - 1,:);
        window_ise_data_index = ise_data_index(i:i+steps+max(delays) - 1);
    
        % Data preparation for the network
        close_input_Series = tonndata(window_input_data_indeces,false,false);
        close_target_Series = tonndata(window_ise_data_index,false,false);
    
        % Transform net into a closed loop
        netc = closeloop(net);
        [close_inputs,close_input_States,close_layer_States,close_targets] = preparets(netc,close_input_Series,{},close_target_Series);
    
        % Computation of forecasted values thanks to the closed-loop
        % network (netc)
        close_outputs = netc(close_inputs,close_input_States,close_layer_States);
        % MSE computation
        performance = performance + perform(netc,close_targets,close_outputs);
 
        % Using cell2mat function we convert the contents of a cell array 
        % into a single matrix
        a = cell2mat(close_outputs);
        b = cell2mat(close_targets);
    
        ending_outputs(i) = a(steps);
        ending_targets(i) = b(steps);
    
    end
    % Mean of  MSE 
    performance = performance/evaluations;

    % Calling of calculate_performances function
    closed_loop_performances(e,:) = calculate_performances( ending_outputs, ending_targets, performance);
end

disp('n-step-ahead Forecasting done.');
end