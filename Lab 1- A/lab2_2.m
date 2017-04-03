img = imread('books.jpg');
a = zeros(size(img, 1), size(img, 2));
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);
red = cat(3, r, a, a);
green = cat(3, a, g, a);
blue = cat(3, a, a, b);
figure;
subplot(2,2,1), imshow(img), title('Original image')
subplot(2,2,2), imshow(red), title('Red channel')
subplot(2,2,3), imshow(green), title('Green channel')
subplot(2,2,4), imshow(blue), title('Blue channel')
figure;
red_green = cat(3,r,g,a);
subplot(1,3,1), imshow(red_green), title('Red and Green')
blue_green = cat(3,a,g,b);
subplot(1,3,2), imshow(blue_green), title('Blue and Green')
red_blue = cat(3,r,a,b);
subplot(1,3,3), imshow(red_blue), title('Red and Blue')