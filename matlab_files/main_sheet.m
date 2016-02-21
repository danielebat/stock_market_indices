% Load data from the ones assigned by the project
%load('complete_data.mat');
% Same data but focusing on the seven indeces (no last row values) for input
% and on ISE from 8° to last value for target
%load('dati_progetto.mat');

% First part

% Variables initialization
%errors_matrix = zeros(7,16);
%ranking = zeros(1,7);
%best_indeces = zeros(1,6);
%genetic_results = zeros(1,3);
%open_loop_performances = zeros(1,4);
%closed_loop_performances = zeros(9,3);

% Create matrices useful to work based on "create_matrix" function
% The function work on the row based on values taken from different indexes
% 1st column = SP, etc..
%disp('Creating Matrixes...');
%SP_matrix = create_matrix( matrix(:,1) );
%DAX_matrix = create_matrix( matrix(:,2) );
%FTSE_matrix = create_matrix( matrix(:,3) );
%NIKKEI_matrix = create_matrix( matrix(:,4) );
%BOVESPA_matrix = create_matrix( matrix(:,5) );
%EU_matrix = create_matrix( matrix(:,6) );
%EM_matrix = create_matrix( matrix(:,7) );
%disp('Matrixes Created.');

% Preparing matrix with error values
% Call the train_function that work on indexes based matrices
%disp('Analyzing Indexes...');
%errors_matrix(1,:) = train_function(SP_matrix,ISE);
%errors_matrix(2,:) = train_function(DAX_matrix,ISE);
%errors_matrix(3,:) = train_function(FTSE_matrix,ISE);
%errors_matrix(4,:) = train_function(NIKKEI_matrix,ISE);
%errors_matrix(5,:) = train_function(BOVESPA_matrix,ISE);
%errors_matrix(6,:) = train_function(EU_matrix,ISE);
%errors_matrix(7,:) = train_function(EM_matrix,ISE);

%Get the ranking and best indeces calling the "get_ranking" function
%[ranking, best_indeces] = get_ranking(errors_matrix);
%disp('Indexes Analyzed and Classified.');

%bar(errors_matrix',1.2);
%exp = legend('SP','DAX','FTSE','NIKKEI','BOVESPA','EU','EM','Location','NorthEastOutside');
%grid on;
%set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]);
%set(gca,'xticklabel',{'5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'});
%xlabel('# Neurons'); ylabel('Error');

%bar(ranking,0.5);
%grid on;
%set(gca,'xtick',[1 2 3 4 5 6 7]);
%set(gca,'xticklabel',{'SP','DAX','FTSE','NIKKEI','BOVESPA','EU','EM'});
%xlabel('Indexes'); ylabel('Error');

%Second part

%genetic_results = genetic_algorithm();

open_loop_performances = openLoopTraining(genetic_results);

closed_loop_performances = closedLoopTraining(genetic_results);

%Third Pard

%Creating Data for Anfis System

%training = [matrix1(1:178,best_indeces(1)) matrix1(1:178,best_indeces(2)) matrix1(1:178,best_indeces(3)) ISE1(1:178) ];
%testing = [matrix1(179:356,best_indeces(1)) matrix1(179:356,best_indeces(2)) matrix1(179:356,best_indeces(3)) ISE1(179:356) ];
%checking = [matrix1(356:534,best_indeces(1)) matrix1(356:534,best_indeces(2)) matrix1(356:534,best_indeces(3)) ISE1(356:534) ];

% plot(closed_loop_performances(:,3));
% grid on;
% set(gca,'xtick',[1 2 3 4 5 6 7 8 9]);
% set(gca,'xticklabel',{'1','2','3','4','5','6','7','8','9'});
% xlabel('Steps'); ylabel('Percentage');


