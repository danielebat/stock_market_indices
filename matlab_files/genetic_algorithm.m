function genetic_results = genetic_algorithm()

%Assigning the fitness function
Fitfunction = @FitnessFunction;

% Number of considered variables to optimize
numVar = 2;

% Two variables, one in input and one in output
% We are considering delays from 1 to 25

LOWER_BOUND = [1 1];
UPPER_BOUND = [25 25];

%Setting parameters for the genetic algotithms
options = gaoptimset('PopulationSize',30, 'CrossoverFraction', 0.8, 'Generations', 70, 'CrossoverFcn', @crossoversinglepoint);

[result_delays,fval,exitFlag,output]=ga(Fitfunction,numVar,[],[],[],[],LOWER_BOUND,UPPER_BOUND,[],[],options);

%Saving results
genetic_results = [round(result_delays(1)) round(result_delays(2)) fval];

% Displaying of obtained results
fprintf('The value returned by GA is:');
disp('fval');

a=round(result_delays(1));
fprintf('The value returned for input delay is:');
disp('a');

b=round(result_delays(2));
fprintf('The value returned for output delay is:');
disp('b');

end