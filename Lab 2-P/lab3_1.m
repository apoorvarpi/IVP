I = imread('books.jpg');
I = rgb2gray(I);
%gaussian
figure;
subplot(1,3,1);
imshow(I);
title('Original');
J = imnoise(I, 'gaussian');
J = imnoise(J, 'salt & pepper');
subplot(1,3,2);
imshow(J);
title('Noisy');
K = filter2(fspecial('average',10),J)/255;
K = imsharpen(K);
subplot(1,3,3);
imshow(K);
title('Denoised');