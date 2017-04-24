clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
% Read in demo image.
% folder = fullfile(matlabroot, '\toolbox\images\imdemos');
% Get the full filename, with path prepended.
fullFileName = 'Image_4.bmp';
% Check if file exists.
if ~exist(fullFileName, 'file')
	% File doesn't exist -- didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
[rows columns numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
	grayImage = rgb2gray(grayImage);
end
subplot(2,2, 1);
imshow(grayImage, [0 255]);
set(gcf, 'Name', ['Results for ' fullFileName]);
title('Original Image', 'FontSize', fontSize);
set(gcf, 'units','normalized','outerposition',[0 0 1 1]); % Maximize figure.
grayImage = double(grayImage);
frequencyImage = fftshift(fft2(grayImage));
subplot(2,2, 2);
amplitudeImage = log(abs(frequencyImage));
minValue = min(min(amplitudeImage))
maxValue = max(max(amplitudeImage))
imshow(amplitudeImage, []);
title('Notice the two spikes perpendicular to periodic frequencies', 'FontSize', fontSize);
% zoom(10)
[midpointX, midpointY] = find(amplitudeImage == maxValue)
filterWindowHalfWidth = 1;
for row = midpointY-filterWindowHalfWidth:midpointY+filterWindowHalfWidth
	for column = midpointX-filterWindowHalfWidth:midpointX+filterWindowHalfWidth
		frequencyImage(row-4, column+7) = 0;
		frequencyImage(row+4, column-7) = 0;
	end
end
amplitudeImage2 = log(abs(frequencyImage));
minValue = min(min(amplitudeImage2))
maxValue = max(max(amplitudeImage2))
subplot(2,2, 3);
imshow(amplitudeImage2, [minValue maxValue]);
title('Two dots zeroed out', 'FontSize', fontSize);
% zoom(10)
filteredImage = ifft2(fftshift(frequencyImage));
amplitudeImage3 = abs(filteredImage);
minValue = min(min(amplitudeImage3))
maxValue = max(max(amplitudeImage3))
subplot(2,2, 4);
imshow(amplitudeImage3, [minValue maxValue]);
title('Filtered Image', 'FontSize', fontSize);
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]); % Maximize figure.
% % 