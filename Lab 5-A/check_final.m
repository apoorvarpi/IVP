A=rgb2gray(imread('grid_image.jpg')); % image size is 200 x 200
B=fftshift(fft2(A));
figure();
imshow(B);
mask=zeros(556,562);
mask(190:300,191:300)=1;
figure;
imshow((mask));
C=mask.*B;
D=abs(ifft2(ifftshift(C)));
D=uint8(D);
figure();
imshow(D);