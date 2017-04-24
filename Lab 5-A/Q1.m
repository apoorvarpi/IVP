A=rgb2gray(imread('grid_image.jpg')); % image size is 200 x 200
figure;
subplot(221);
imshow(A);
title('Original');
B=fftshift(fft2(A));
subplot(222);
imshow(B);
title('Frequency Response');
mask=zeros(556,562);
mask(190:300,191:300)=1;
subplot(223);
imshow((mask));
title('Mask');
C=mask.*B;
D=abs(ifft2(ifftshift(C)));
D=uint8(D);
subplot(224);
imshow(D);
title('Final Image');