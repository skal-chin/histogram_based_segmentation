% Christian Allen
% A01253507
% Final Project

function [largestPeaks] = GetGreatPeaks(pnpHist, imHist)
% Finds the greatest peaks by finding the average distance between each
% element throughout pnpHist. Then it compares each element to its
% following neighbor element and if the distance is greater than the
% average, it is marked.
%
% INPUT
% pnpHist -> the peaks and pits histogram found in GetPeaksPitsHist
%
% OUTPUT
% largestPeaks -> a 1-D matrix equal to the size of pnpHist that marks the
%                   peaks as a 1

pnpSize = size(pnpHist);
largestPeaks = zeros(pnpSize);

% Finds the indices for the recorded peaks and pits
ppIndices = find(pnpHist);
indicesSize = size(ppIndices, 1);

% Calculates the mean distances between peaks and pits
distances = diff(imHist(ppIndices));

histMean = sumabs(distances) / (size(distances, 1) - 1);

% Loop to find the peaks with a distance larger than the mean
for i = 1:indicesSize
    
    % Breaks if the index is >= the size of the imHist array
    if i >= indicesSize
        break;
    end

    currentIndex = ppIndices(i);
    nextIndex = ppIndices(i + 1);


    currentVal = imHist(currentIndex);
    nextVal = imHist(nextIndex);

    % Checks to see if that absolute difference is greater than the mean
    if abs(currentVal - nextVal) > histMean

        % Figures out which value is the peak value to be recorded
        if currentVal > nextVal
            largestPeaks(currentIndex) = 1;
        else
            largestPeaks(nextIndex) = 1;
        end

    end

end




end