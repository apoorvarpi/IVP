I = imread('image.jpg');
figure;
imshow(I);
title('Original Image');
I = rgb2gray(I);

BW1 = edge(I,'sobel');
%subplot(221);
figure;
imshow(BW1);
title('Sobel Filter');

BW2 = edge(I,'prewitt');
%subplot(222);
figure;
imshow(BW2);
title('Prewitt Filter');

%w=fspecial('log',[3 3],0.5);
%BW3=imfilter(I,w);
%subplot(223);
%figure;
%imshow(BW3);
%title('Laplacian of Gaussian filter');
BW3 = edge(I,'log');
%subplot(223);
figure;
imshow(BW3);
title('LoG Filter');

BW4 = edge(I,'canny');
%subplot(224);
figure;
imshow(BW4);
title('Canny Filter');
8046915003