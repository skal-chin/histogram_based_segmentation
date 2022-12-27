% Christian Allen
% A01253507
% Final Project

function [centers, centerHist] = GetCenters(places, totalDist, imHist)
% Finds the values to be used/compared as centers for the k-means algorithm
%
% INPUT
% places -> the places of each peak value
% totalDist -> the sum of the distances between each value
%
% centers -> an array of values to be used as centers
% centerHist -> histogram representation of the centers

placesSize = size(places, 1);

centers = [];
centerHist = zeros(size(imHist));

% Calculates mean distance between great peaks using totalDist
meanDist = totalDist / (placesSize - 1);

% Loop to find great peaks
for i = 1:placesSize
    if i > placesSize
        break;

    elseif i == placesSize
        
        currentIndex = places(i);
        nextIndex = places(1);

    else

        currentIndex = places(i);
        nextIndex = places(i + 1);
 
    end

    currentVal = imHist(currentIndex);
    nextVal = imHist(nextIndex);

    currentDist = abs(currentIndex - nextIndex);

    if currentDist >= meanDist
        centerHist(currentIndex) = 1;
        centers = [centers, currentIndex];

    end

end

end