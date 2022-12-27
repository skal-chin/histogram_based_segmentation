function [centerResults] = displayResults(filePath, numRows, displayedImages, convert2bw)
% Displays the results of the KPredict algorithm in a tiled layout as such:
% |ORIGINAL IMAGE|HISTOGRAM|GREAT PEAKS|CENTER K|
%
% Input
% filePath -> the relative path to a folder of images
% numRows -> desired number of results to display at once
%               default = 4
% displayedImages -> number of images to be processed.
%               default = 0, (this means every image will be processed)
% convert2bw -> logical value to convert RGB images to bw
%
% Output
% centerResults -> N X 2 array of results where N is equal to the number of
%                   images in the folder. First column records the mean
%                   difference score and the second column records the
%                   number of k used in the k-means algorithm

% Checks the argument specs
arguments
    filePath (1, 1) string
    numRows (1, 1) int8 = 4
    displayedImages int8 = 0
    convert2bw logical = false
end

% Creates the datastore for the folder
imageDS = imageDatastore(fullfile(filePath));

numImages = size(imageDS.Files, 1);

% Sets the number of display images to the desired number
if displayedImages ~= 0
    numImages = displayedImages;
end

% Sets the display size to default if the input was greater than the number
% of images
if numRows > numImages
    numRows = 4;
end

t = tiledlayout(numRows, 5, 'TileSpacing','compact');

% Counter to know when to pause the display
count = 0;

% Stores the results and determines which index to store it
centerResults = cell(numImages, 3);
currentIndex = 1;

for i = 1:numImages

    % Datastore parsing
    file = cell2mat(imageDS.Files(i));
    filePath = split(file, '\');
    filePathSize = size(filePath, 1);
    fileName = cell2mat(filePath(filePathSize));

    image = imread(file);

    % Converts RGB to BW if associated parameter is true
    if convert2bw
        image = rgb2gray(image);
    end

    % K predict algorithm and the segmentation
    [k, centers, imHist, greatPeaksHist, centerHist] = KPredict(image);
    [labels, segCenters] = imsegkmeans(image, k);

    % Storing the results
    centerResults(currentIndex, 1:3) = {fileName, MeanDiffScore(sort(segCenters.'), centers), k};
    currentIndex = currentIndex + 1;

    % Overlays the segmentation labels for display
    segIm = labeloverlay(image, labels);
    count = count + 1;
    
    % Display
    nexttile;
    imshow(image);
    title(fileName);


    nexttile;
    plot(imHist);
    if count == 1
        title('Image Histograms');
    end

    nexttile;
    plot(greatPeaksHist);
    if count == 1
        title('Great Peaks');
    end

    nexttile;
    plot(centerHist);
    if count == 1
        title('Center Values');
    end

    nexttile;
    imshow(segIm);
    if count == 1
        title('Segmented Images');
    end

    % Pauses at desired display size
    if count == numRows
        count = 0;
        pause;
        t = tiledlayout(numRows, 5, 'TileSpacing','compact');
    end

end

end