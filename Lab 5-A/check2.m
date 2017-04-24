clc

clear

A=imread('Image_4.bmp'); % image size is 200 x 200

B=fftshift(fft2(A));

mask=zeros(193,195);

mask(80:120,80:120)=1;

C=mask.*B;

D=ifft2(C);

D=uint8(D);

imshow(D)