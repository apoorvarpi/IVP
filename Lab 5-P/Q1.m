I = imread('Image_1.bmp');
figure;
subplot(131);
imshow(I);
title('orignal image');
se = strel('disk',1);
J = I;
for i = 1:6
    J = imerode(J,se);
end
subplot(132);
imshow(J);
title('eroded image');
J = (I-J);
K = I;
for i = 1:6
    K = imdilate(K,se);
end
subplot(133);
imshow(K);
title('dialated image');
K = (K-I);
figure;
subplot(131);
imshow(I);
title('original image');
subplot(132);
imshow(J);
title('original-erroded image');
subplot(133);
imshow(K);
title('dialated-original image');
