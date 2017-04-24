I = imread('pic.jpg');
I = rgb2gray(I);
imshow(I)
background = imopen(I,strel('disk',15));

% Display the Background Approximation as a Surface
figure
surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
ax = gca;
ax.YDir = 'reverse';
I2 = I - background;
imshow(I2)
I3 = imadjust(I2);
imshow(I3);
bw = imbinarize(I3);
bw = bwareaopen(bw, 50);
imshow(bw)
cc = bwconncomp(bw, 4)
grain = false(size(bw));
grain(cc.PixelIdxList{50}) = true;
imshow(grain);
labeled = labelmatrix(cc);
whos labeled
RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
imshow(RGB_label)
graindata = regionprops(cc,'basic')

graindata(50).Area
