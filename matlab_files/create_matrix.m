% Function for creating the matrix for the "train_function"
% Given input = matrix (created by data)

function index_matrix = create_matrix( index )
    
    % Loop on the 529 values of different indexes
    for i=1:529
        
        % We work on a row, by putting the different values on the i-th row
        index_matrix(i,1) = index(i);
        index_matrix(i,2) = index(i+1);
        index_matrix(i,3) = index(i+2);
        index_matrix(i,4) = index(i+3);
        index_matrix(i,5) = index(i+4);
        index_matrix(i,6) = index(i+5);
        index_matrix(i,7) = index(i+6);
        
        % At the end we obtain a matrix of <535x7 double>
    
    end
end

