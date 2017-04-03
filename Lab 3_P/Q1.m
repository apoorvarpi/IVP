I = imread('Earth.jpg');
H = fspecial('average',20);
T = imfilter(I,H);
F = I - T;
L = 0.5*I + 0.5*F;
K = I + F;
imshow(K);
figure;
subplot(221);
imshow(I);
title('Original');
subplot(222);
imshow(T);
title('Blurred');
subplot(223);
imshow(F);
title('Mask');
subplot(224);
imshow(L);
title('Final');