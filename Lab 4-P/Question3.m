f=imread('image.jpg');
w=fspecial('log',[3 3],0.5);
filtered_img=imfilter(f,w);
figure;
subplot(121);
imshow(f);
title('Original Image');
subplot(222);
imshow(filtered_img);