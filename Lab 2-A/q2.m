I = imread('img.png');
I = rgb2gray(I);
[I1, rect] = imcrop(I,[12.5 6.5 208 154]);
figure;
subplot(221)
imshow(I1);
subplot(222)
J1 = histeq(I1);
imshow(J1);
subplot(223)
imhist(I1);
subplot(224)
imhist(J1);

I = imread('img.png');
I = rgb2gray(I);
[I1, rect] = imcrop(I,[240.5 2.5 171 164]);
figure;
subplot(221)
imshow(I1);
subplot(222)
J1 = histeq(I1);
imshow(J1);
subplot(223)
imhist(I1);
subplot(224)
imhist(J1);

I = imread('img.png');
I = rgb2gray(I);
[I1, rect] = imcrop(I,[10.5 186.5 213 162]);
figure;
subplot(221)
imshow(I1);
subplot(222)
J1 = histeq(I1);
imshow(J1);
subplot(223)
imhist(I1);
subplot(224)
imhist(J1);

I = imread('img.png');
I = rgb2gray(I);
[I1, rect] = imcrop(I,[238.5 175.5 197 193]);
figure;
subplot(221)
imshow(I1);
subplot(222)
J1 = histeq(I1);
imshow(J1);
subplot(223)
imhist(I1);
subplot(224)
imhist(J1);
    

%[12.5 6.5 208 154][240.5 2.5 171 164][10.5 186.5 213 162][238.5 175.5 197 193]
