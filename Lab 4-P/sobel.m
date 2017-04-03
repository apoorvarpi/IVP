im=imread('image.jpg');
img=rgb2gray(im);

sob_im = edge(img,'sobel');
figure(2);
imagesc(sob_im);
axis('square');
colormap('gray');

imshow(sob_im);
