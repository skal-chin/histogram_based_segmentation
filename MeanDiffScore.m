function [score] = MeanDiffScore(trueVal, predVal)
% Finds the absolute mean difference between trueVal and predVal. trueVal
% and predVal must be 1 X N array
%
% Input
% truePred -> array of observations (true)
% predVal -> array of predictions
% 
% Output
% score -> the mean difference


% Checks the argument sizes are equal
if size(trueVal, 2) ~= size(predVal, 2)
    disp('Two matrices are not of equal size');
    return;
end

n = size(trueVal, 2);

score = (sumabs( double(predVal) - double(trueVal) ) ) / n ;

end