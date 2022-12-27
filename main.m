% Christian Allen
% A01253507
% Final Project

close('all');
clearvars;

bwScore = displayResults('Images/BW');
disp('Average center difference, Matlab Set BW');
disp(bwScore);

% rgbScore = displayResults('Images/RGB');
% disp('Average center difference, Matlab Set RGB');
% disp(rgbScore);

% Sets how many rows to display per output and how many images to process.
% The Berkely data set is large. If you want to see the whole set
% processed, comment out berkIms.
berkRows = 4;
berkIms = 20;

bwBerkScore = displayResults('Images/BerkelySet', berkRows, berkIms, true);
disp('Average center difference, Berkely Set BW');
disp(bwBerkScore);

% rgbBerkScore = displayResults('Images/BerkelySet', berkRows, berkIms);
% disp('Average center difference, Berkely Set RGB');
% disp(rgbBerkScore);

close('all');
clearvars;








