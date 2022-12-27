% Christian Allen
% A01253507
% Final Project

function [peaksPitsHist] = GetPeaksPitsHist(imHist)
% Finds the peaks and pits of a histogram by looking at the ascension/descention 
% direction change
%
% INPUT
% imHist -> image histogram
%
% OUTPUT
% peaksPitsHist -> 1-D matrix the same size of imHist with the values found
%                   at peaks and pits marked

histSize = size(imHist);
peaksPitsHist = zeros(histSize);

for i = 1:histSize(1)

    % First index
    if i == 1
        currentVal = imHist(i);
        nextVal = imHist(i + 1);

        % Checks if the first value is a peak or a pit
        if currentVal < nextVal || currentVal > nextVal
            peaksPitsHist(i) = 1;

        end
        
        continue;

    end

    % Last index
    if i == histSize(1)
        currentVal = imHist(i);
        prevVal = imHist(i - 1);

        % Checks if last value is a peak or pit
        if currentVal < prevVal || currentVal > prevVal
            peaksPitsHist(i) = 1;
        end

        continue;
    end

    prevVal = imHist(i - 1);
    currentVal = imHist(i);
    nextVal = imHist(i + 1);

    % Checks for peaks
    if currentVal > prevVal && currentVal > nextVal
        peaksPitsHist(i) = 1;

    % Checks for pits
    elseif currentVal < prevVal && currentVal < nextVal
        peaksPitsHist(i) = 1;

    % Neither a peak nor a pit
    else
        continue;

    end

end

end