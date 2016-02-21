function [ranking, best_indeces] = get_ranking( errors_matrix )

% Putting the best mean error values into a vector of 7 elements.
neurons_ranking = zeros(1,7);
% Temporary vector used for computations
ranking_2 = zeros(1,7);

% Watching for the minimum mean error of SP index and putting:
% - the minimum value in "ranking" vector (the one that will be returned by
% the funcution)
% - # of neurons related with the minimum error in "neuron_ranking" vector
% (this info can be found by considering the column)

min_SP = min(errors_matrix(1,:));                                          % watching for the minimum value
[rowSP,colSP] = find(errors_matrix(1,:) == min_SP);
ranking(1,1) = min_SP;
neurons_ranking(1,1) = colSP + 4;                                          
% column +4 (for obtaining the right # of hidden layers)

% Watching for the minimum mean error of DAX index
min_DAX = min(errors_matrix(2,:));
[rowDAX,colDAX] = find(errors_matrix(2,:) == min_DAX);
ranking(1,2) = min_DAX;
neurons_ranking(1,2) = colDAX + 4;

% Watching for the minimum mean error of FTSE index
min_FTSE = min(errors_matrix(3,:));
[rowFTSE,colFTSE] = find(errors_matrix(3,:) == min_FTSE);
ranking(1,3) = min_FTSE;
neurons_ranking(1,3) = colFTSE + 4;

% Watching for the minimum mean error of NIKKEI index
min_NIKKEI = min(errors_matrix(4,:));
[rowNIKKEI,colNIKKEI] = find(errors_matrix(4,:) == min_NIKKEI);
ranking(1,4) = min_NIKKEI;
neurons_ranking(1,4) = colNIKKEI + 4;

% Watching for the minimum mean error of BOVESPA index
min_BOVESPA = min(errors_matrix(5,:));
[rowBOVESPA,colBOVESPA] = find(errors_matrix(5,:) == min_BOVESPA);
ranking(1,5) = min_BOVESPA;
neurons_ranking(1,5) = colBOVESPA + 4;

% Watching for the minimum mean error of EU index
min_EU = min(errors_matrix(6,:));
[rowEU,colEU] = find(errors_matrix(6,:) == min_EU);
ranking(1,6) = min_EU;
neurons_ranking(1,6) = colEU + 4;

% Watching for the minimum mean error of EM index
min_EM = min(errors_matrix(7,:));
[rowEM,colEM] = find(errors_matrix(7,:) == min_EM);
ranking(1,7) = min_EM;
neurons_ranking(1,7) = colEM + 4;

%Saving in "best_indeces" the values related to our best
%indexes and neurons
ranking_2 = ranking;                                                       % copy into "ranking_2"
best = find(ranking_2 == min(ranking_2));                                  % find for min value into "ranking_2" and putting into "best" variable
ranking_2(1,best) = 1;                                                     % putting best value = 1 (no more considered)
best_indeces(1) = best;                                                    % "best" into "best_indeces" vector (index)
best_indeces(4) = neurons_ranking(1,best);                                 % related # hidden layer

% Same operations for 2nd and 3rd best indexes
best = find(ranking_2 == min(ranking_2));
ranking_2(1,best) = 1;
best_indeces(2) = best;
best_indeces(5) = neurons_ranking(1,best);

best = find(ranking_2 == min(ranking_2));
ranking_2(1,best) = 1;
best_indeces(3) = best;
best_indeces(6) = neurons_ranking(1,best);

%saving these results to use them after
save('usage.mat','best_indeces');

end