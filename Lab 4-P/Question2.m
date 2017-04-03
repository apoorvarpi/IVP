newImg = imread('image.jpg');
figure(1);
grayImage= rgb2gray(newImg);
imshow(grayImage);
figure(2);
afterFilter = edge(grayImage,'prewitt')
imshow(afterFilter);