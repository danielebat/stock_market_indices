% Train function script taken from nnstart tool

function results = train_function( matrix, ISE )

inputs = matrix';
targets = ISE';

% # hidden layers between 5 and 20
for i=5:20

    % Variables used for computing the mean square error
    performance = 0;
    perf=0;
    
    % Create a Fitting Network
    hiddenLayerSize = i;
    net = fitnet(hiddenLayerSize);

    
    % Setup Division of Data for Training, Validation, Testing
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;

    % Different train for statistical convergence
    for y=1:10
       
        % Train the Network
        [net,tr] = train(net,inputs,targets);

        % Test the Network
        outputs = net(inputs);
        % errors = gsubtract(targets,outputs);
        perf = perform(net,targets,outputs); 
        
        % In "performance" we sum all the results from different trains
        performance = performance + perf;
        
    end
    
    %Compute the mean value
    mean = performance/10;
    
    %Save results to compute the mean value
    %(i-4) because we start from 5 with the for cycle
    results(i-4) = mean;
    
end

end

