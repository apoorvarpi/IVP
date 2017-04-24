I = imread('pic.jpg');
I = rgb2gray(I);
imshow(I)
title('Original Image')
seedpointR = 159;
seedpointC = 67;
W = graydiffweight(I, seedpointC, seedpointR,'GrayDifferenceCutoff',25);
figure, imshow(log(W),[])
thresh = 0.01;
BW = imsegfmm(W, seedpointC, seedpointR, thresh);
figure, imshow(BW)
title('Segmented Image')
