% Christian Allen
% A01253507
% Final Project

function [places, total] = GetPeakPlaces(greatPeaks, imhist)
% Finds the places of great peaks at the histogram level (which cooresponds
% to the value of the pixel) and determines the total distance between
% points that makes up the histogram. 
%
% INPUT
% greatPeaks -> the great peak points found in GetGreatPeaks
% imHist -> the original histogram of the image.
%
% OUTPUT
% places -> a list of points where each peak is located
% total -> the sum of the distances between each point

% Locates the indices of values greater than 0 (Peak places)
places = find(greatPeaks);
total = 0;

placesSize = size(places, 1);

% Loop for finding the total distance between each peak
for i = 1:placesSize

    if i >= placesSize
        break
    end

    % Gets index value
    currentIndex = places(i);
    nextIndex = places(i + 1);
    
    total = total + abs(currentIndex - nextIndex);
end

end