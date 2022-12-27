% Christian Allen
% A01253507
% Final Project

function[k, centers, imHist, greatPeaksHist, centerHist] = KPredict(im, TCOptions)
% Replication of the histogram-based automatic segmentation algorithm
% proposed by Kucukkulahli, Erdogmus, and Polat in their 2016 paper on
% autosegmentation
%
% USES
% GetPeaksPitsHist, GetGreatPeaks, GetPeakPlaces, GetCenters
%
% INPUT
% im -> a grayscale image (experimentation on colored images later)
% TCOptions -> string determining if the image is RGB or HSV
%
% OUTPUT
% k -> the number of clusters
% centers -> starting centers
% imHist -> histogram of the image
% greatPeaksHist -> histogram of the great peaks
% centerHist -> histogram of the centers

arguments
    im {mustBeInDimension(im, [2, 3])}
    TCOptions string {mustBeRGB(TCOptions, im), mustBeMember(TCOptions, {'RGB', 'HSV'})} = 'RGB';

end

if ndims(im) == 2

    imHist = imhist(im);

elseif ndims(im) == 3

    % do color hist

end

peaksPitsHist = GetPeaksPitsHist(imHist);

greatPeaksHist = GetGreatPeaks(peaksPitsHist, imHist);

[places, total] = GetPeakPlaces(greatPeaksHist, imHist);

[centers, centerHist] = GetCenters(places, total, imHist);

k = size(centers, 2);

end

% CUSTOM VALIDATOR FUNCTIONS

    % Checks the dimensions of valIm are within r range
    function mustBeInDimension(valIm, r)
        dims = ndims(valIm);
        
        if ~ismember(dims, r)
            eid = 'Dimensions:notInRange';
            msg = 'The dimension of the matrix is not within range.';
            throwAsCaller(MException(eid, msg));
        end
    end

    % Checks that the image is a colored image
    function mustBeRGB(options, image)

        if ~ndims(image) == 3
            eid = 'Image:notThreeChanneled';
            msg = 'The image is not a three channeled image';
            throwAsCaller(MException(eid, msg));
        end
    end
