function loop_performances = calculate_performances( outputs, targets, performance )

%Calculating MSE
MSE = performance;

% MSE value just computed into the calling script
fprintf('MSE   ')
disp(MSE);

%Calculating MAPE
l = length(targets);
mape_sums = 0;

for i=1:l
   
    %implementation of MAPE formula
    mape_sums = mape_sums + abs((targets(i) - outputs(i))/targets(i));

end

mape_sums = mape_sums*(100/l);

MAPE = mape_sums;

fprintf('MAPE   ')
disp(MAPE);

% Calculating Percantage of correctly forecasted days
% With "correctly forecasted" we refers to the fact that the forecasted
% days follow the trend of the ISE values
% The estimation is made by considering the sign of the difference of two
% subsequent target values and the sign of the difference of the two
% forecasted values
% If the value is increasing the sign function will return "1", whereas "-1"
% By comparing the sign we are able to understand if the two trend have
% the same direction



% There are two different situations to consider:
% - the first forecasted value
% - from the second forecasted value on

final_perc= 0;

    % For the first forecasted value we do not have an output(1) value
    % because we start forecasting from the second day on
    % We consider the difference between the first forecasted value and the
    % first available target value
    if (sign(targets(2) - targets(1)) == sign(outputs(2) - targets(1) ) )
       
        final_perc = final_perc + 1;
   
    end

% From the second forecasted value on we will consider the difference
% between subsequent forecasted values
for x=2:(l-1)
   
    if (sign(targets(x+1) - targets(x)) == sign(outputs(x+1) - outputs(x) ) )
       
        final_perc = final_perc + 1;
    
    end
    
end

% Formula for computing the percentage of correctly forecasted values
final_perc = (final_perc / (l-1))*100;

fprintf('PERCENTAGE   ')
disp(final_perc);

% The function returns a vector "open_loop_performances" that contains:
% MSE - computed in the "openLoopTraining" function
% MAPE - computed with the standard formula
% Percentage of right forecasted delays
loop_performances = [ MSE MAPE final_perc];

end

