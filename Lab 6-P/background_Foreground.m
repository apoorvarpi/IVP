I = imread('pic.jpg');
I = rgb2gray(I);
imshow(I)
title('Original Image')
figure;
x = 421;
for i = 1:4
    mask = zeros(size(I));
    mask((25*i):end-25,(25*i):end-25) = 1;
    subplot(x)
    x = x+1;
    imshow(mask)
    title('Initial Contour Location')
    bw = activecontour(I,mask,500);
    subplot(x)
    x =x+1;
    imshow(bw)
    title('Segmented Image')
end